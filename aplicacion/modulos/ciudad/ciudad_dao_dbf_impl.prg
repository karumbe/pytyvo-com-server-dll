DEFINE CLASS CiudadDAODBFImpl AS DAOBaseDBFImpl

    * Inicialización de propiedades.
    cTabla = 'ciudades'
    cClaseModelo = 'CiudadVO'

    **/
    * Devuelve el nombre completo de una ciudad.
    *
    * @field
    * codigo N(5) not null unique
    *
    * @param integer tnCodigo
    * Código a buscar.
    *
    * @return string|boolean
    * not empty string si tiene éxito, empty string en caso contrario y
    * false si hay un error.
    */
    FUNCTION ObtenerNombreCompleto
        LPARAMETERS tnCodigo

        * inicio { validación del parámetro }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        LOCAL lnDepartamen, lcNombreCompleto, loExcepcion
        lnDepartamen = 0
        lcNombreCompleto = ''

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO TAG 'indice1'    && codigo.
                IF SEEK(tnCodigo) THEN
                    lnDepartamen = departamen
                    lcNombreCompleto = ALLTRIM(nombre)

                    SELECT departamentos
                    SET ORDER TO TAG 'indice1'    && codigo.
                    IF SEEK(lnDepartamen) THEN
                        lcNombreCompleto = ALLTRIM(nombre) + ' > ' + ;
                            lcNombreCompleto
                    ENDIF
                ENDIF
            CATCH TO loExcepcion
                lcNombreCompleto = ''
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN lcNombreCompleto
    ENDFUNC

    **/
    * Verifica si un nombre existe.
    *
    * @field
    * nombre C(30) not null
    * departamen N(3) not null
    *
    * @unique_index
    * departamen + nombre
    *
    * @param string tcNombre
    * Nombre a ser verificado.
    *
    * @param integer tnDepartamen
    * Código de departamento.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    * @Override
    FUNCTION NombreExiste
        LPARAMETERS tcNombre, tnDepartamen

        * inicio { validaciones de parámetros }
        IF !THIS.ValidarParamNombre(tcNombre) THEN
            RETURN .T.
        ENDIF

        IF !THIS.oUtiles.ValidarNumero(tnDepartamen, 1, 999) THEN
            RETURN .T.
        ENDIF

        tcNombre = ALLTRIM(UPPER(tcNombre))
        * fin { validaciones de parámetros }

        LOCAL llExiste, loExcepcion
        llExiste = .T.

        IF THIS.oConexion.Conectar() THEN
            TRY
                llExiste = .F.

                SELECT (THIS.cTabla)
                SET ORDER TO TAG 'indice2'    && nombre.
                IF SEEK(tcNombre) THEN
                    SCAN WHILE ALLTRIM(UPPER(nombre)) == tcNombre
                        IF departamen == tnDepartamen THEN
                            llExiste = .T.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
            CATCH TO loExcepcion
                llExiste = .T.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN llExiste
    ENDFUNC

    **/
    * Realiza una búsqueda por código.
    *
    * @field
    * codigo N(5) not null unique
    *
    * @param integer tnCodigo
    * Código a buscar.
    *
    * @return object|boolean
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION ObtenerPorCodigo
        LPARAMETERS tnCodigo

        LOCAL loCiudad

        loCiudad = DAOBaseDBFImpl::ObtenerPorCodigo(tnCodigo)

        * Obtiene el nombre completo de la ciudad.
        IF VARTYPE(loCiudad) == 'O' THEN
            loCiudad.EstablecerNombreCompleto( ;
                THIS.ObtenerNombreCompleto( ;
                    loCiudad.ObtenerCodigo() ;
                ) ;
            )
        ENDIF

        RETURN loCiudad
    ENDFUNC

    **/
    * Realiza una búsqueda por nombre.
    *
    * @field
    * nombre C(30) not null
    * departamen N(3) not null
    *
    * @unique_index
    * departamen + nombre
    *
    * @param string tcNombre
    * Nombre a buscar.
    *
    * @param integer tnDepartamen
    * Código de departamento.
    *
    * @return object|boolean
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION ObtenerPorNombre
        LPARAMETERS tcNombre, tnDepartamen

        * inicio { validaciones de parámetros }
        IF !THIS.ValidarParamNombre(tcNombre) THEN
            RETURN .F.
        ENDIF

        IF !THIS.oUtiles.ValidarNumero(tnDepartamen, 1, 999) THEN
            RETURN .F.
        ENDIF

        tcNombre = ALLTRIM(UPPER(tcNombre))
        * fin { validaciones de parámetros }

        LOCAL loCiudad, loExcepcion
        loCiudad = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO TAG 'indice2'    && nombre.
                IF SEEK(tcNombre) THEN
                    SCAN WHILE ALLTRIM(UPPER(nombre)) == tcNombre
                        IF departamen == tnDepartamen THEN
                            loCiudad = THIS.CargarDatos( ;
                                CREATEOBJECT(THIS.cClaseModelo))
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
            CATCH TO loExcepcion
                loCiudad = .F.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        * Obtiene el nombre completo de la ciudad.
        IF VARTYPE(loCiudad) == 'O' THEN
            loCiudad.EstablecerNombreCompleto( ;
                THIS.ObtenerNombreCompleto( ;
                    loCiudad.ObtenerCodigo() ;
                ) ;
            )
        ENDIF

        RETURN loCiudad
    ENDFUNC

    **/
    * Realiza una búsqueda por codigo, nombre.
    *
    * @field
    * codigo N(5) not null unique
    * nombre C(30) not null unique
    *
    * @param string tcExpresion
    * Expresión a buscar.
    *
    * @param string tcCursor
    * Cursor en el cual se guardará el resultado de la búsqueda.
    *
    * @param string tcCondicionFiltrado (opcional)
    * Condición de filtrado de registros.
    *
    * @return cursor|boolean
    * cursor|true si tiene éxito y false en caso contrario.
    */
    FUNCTION Obtener
        LPARAMETERS tcExpresion, tcCursor, tcCondicionFiltrado

        * inicio { validaciones de parámetros }
        IF VARTYPE(tcExpresion) == 'C' THEN
            tcExpresion = '%' + ALLTRIM(UPPER(tcExpresion)) + '%'
            tcExpresion = THIS.oUtiles.SanitizarValor(tcExpresion)
        ENDIF

        IF !THIS.oUtiles.ValidarTexto(tcExpresion, 2, 50) THEN
            RETURN .F.
        ENDIF

        IF !THIS.oUtiles.ValidarTexto(tcCursor, 8, 8) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
            IF !THIS.oUtiles.ValidarTexto(tcCondicionFiltrado, 6, 50) THEN
                RETURN .F.
            ENDIF
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnCodigo, loExcepcion
        lnCodigo = INT(VAL(STRTRAN(tcExpresion, '%', '')))

        IF THIS.oConexion.Conectar() THEN
            TRY
                IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
                    SELECT ;
                        a.codigo, ;
                        a.nombre, ;
                        a.departamen, ;
                        a.vigente, ;
                        ALLTRIM(b.nombre) + ' > ' + ALLTRIM(a.nombre) ;
                            AS nombre_completo ;
                    FROM ;
                        (THIS.cTabla) a ;
                        INNER JOIN departamentos b ;
                            ON a.departamen == b.codigo ;
                    WHERE ;
                        (a.codigo == lnCodigo OR ;
                        ALLTRIM(b.nombre) + ' > ' + ALLTRIM(a.nombre) ;
                            LIKE tcExpresion) AND ;
                        (tcCondicionFiltrado) ;
                    ORDER BY ;
                        nombre_completo ;
                    INTO CURSOR ;
                        tm_resultado
                ELSE
                    SELECT ;
                        a.codigo, ;
                        a.nombre, ;
                        a.departamen, ;
                        a.vigente, ;
                        ALLTRIM(b.nombre) + ' > ' + ALLTRIM(a.nombre) ;
                            AS nombre_completo ;
                    FROM ;
                        (THIS.cTabla) a ;
                        INNER JOIN departamentos b ;
                            ON a.departamen == b.codigo ;
                    WHERE ;
                        a.codigo == lnCodigo OR ;
                        ALLTRIM(b.nombre) + ' > ' + ALLTRIM(a.nombre) ;
                            LIKE tcExpresion ;
                    ORDER BY ;
                        nombre_completo ;
                    INTO CURSOR ;
                        tm_resultado
                ENDIF

                IF RECCOUNT('tm_resultado') > 0 THEN
                    SELECT * FROM tm_resultado INTO CURSOR (tcCursor)
                ENDIF

                SELECT tm_resultado
                USE
            CATCH TO loExcepcion
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF
    ENDFUNC

    **/
    * Recupera todos los registros.
    *
    * @param string tcCursor
    * Cursor en el cual se guardará el resultado de la búsqueda.
    *
    * @param string tcCondicionFiltrado (opcional)
    * Condición de filtrado de registros.
    *
    * @return cursor|boolean
    * cursor|true si tiene éxito y false en caso contrario.
    */
    FUNCTION ObtenerTodos
        LPARAMETERS tcCursor, tcCondicionFiltrado

        * inicio { validaciones de parámetros }
        IF !THIS.oUtiles.ValidarTexto(tcCursor, 8, 8) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
            IF !THIS.oUtiles.ValidarTexto(tcCondicionFiltrado, 6, 50) THEN
                RETURN .F.
            ENDIF
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL loExcepcion

        IF THIS.oConexion.Conectar() THEN
            TRY
                IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
                    SELECT ;
                        a.codigo, ;
                        a.nombre, ;
                        a.departamen, ;
                        a.vigente, ;
                        ALLTRIM(b.nombre) + ' > ' + ALLTRIM(a.nombre) ;
                            AS nombre_completo ;
                    FROM ;
                        (THIS.cTabla) a ;
                        INNER JOIN departamentos b ;
                            ON a.departamen == b.codigo ;
                    WHERE ;
                        &tcCondicionFiltrado ;
                    ORDER BY ;
                        nombre_completo ;
                    INTO CURSOR ;
                        tm_resultado
                ELSE
                    SELECT ;
                        a.codigo, ;
                        a.nombre, ;
                        a.departamen, ;
                        a.vigente, ;
                        ALLTRIM(b.nombre) + ' > ' + ALLTRIM(a.nombre) ;
                            AS nombre_completo ;
                    FROM ;
                        (THIS.cTabla) a ;
                        INNER JOIN departamentos b ;
                            ON a.departamen == b.codigo ;
                    ORDER BY ;
                        nombre_completo ;
                    INTO CURSOR ;
                        tm_resultado
                ENDIF

                IF RECCOUNT('tm_resultado') > 0 THEN
                    SELECT * FROM tm_resultado INTO CURSOR (tcCursor)
                ENDIF

                SELECT tm_resultado
                USE
            CATCH TO loExcepcion
            FINALLY
                THIS.oConexion.Desconectar()
                WAIT CLEAR
            ENDTRY
        ENDIF
    ENDFUNC

    **/
    * Agrega un nuevo registro.
    *
    * @param object toCiudad
    * Objeto a ser agregado.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION Agregar
        LPARAMETERS toCiudad

        * inicio { validación del parámetro }
        IF !THIS.EsObjeto(toCiudad) THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        LOCAL llAgregado, loExcepcion, ;
              lnCodigo, lcNombre, lnDepartamen, llVigente

        llAgregado = .F.
        lnCodigo = THIS.NuevoCodigo()

        IF THIS.CodigoExiste(lnCodigo) THEN
            RETURN .F.
        ENDIF

        IF THIS.oConexion.Conectar() THEN
            TRY
                WITH toCiudad
                    lcNombre = .ObtenerNombre()
                    lnDepartamen = .ObtenerDepartamen()
                    llVigente = .EstaVigente()
                ENDWITH

                INSERT INTO (THIS.cTabla) ( ;
                    codigo, ;
                    nombre, ;
                    departamen, ;
                    vigente ;
                ) VALUES ( ;
                    lnCodigo, ;
                    lcNombre, ;
                    lnDepartamen, ;
                    llVigente ;
                )
                llAgregado = .T.
            CATCH TO loExcepcion
                llAgregado = .F.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN llAgregado
    ENDFUNC

    **/
    * Modifica un registro existente.
    *
    * @param object toCiudad
    * Objeto a ser modificado.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION Modificar
        LPARAMETERS toCiudad

        * inicio { validación del parámetro }
        IF !THIS.EsObjeto(toCiudad) THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        LOCAL llModificado, loExcepcion, ;
              lnCodigo, lcNombre, lnDepartamen, llVigente

        llModificado = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                WITH toCiudad
                    lnCodigo = .ObtenerCodigo()
                    lcNombre = .ObtenerNombre()
                    lnDepartamen = .ObtenerDepartamen()
                    llVigente = .EstaVigente()
                ENDWITH

                SELECT (THIS.cTabla)
                SET ORDER TO TAG 'indice1'    && codigo.
                IF SEEK(lnCodigo) THEN
                    REPLACE nombre WITH lcNombre, ;
                            departamen WITH lnDepartamen, ;
                            vigente WITH llVigente
                    llModificado = .T.
                ENDIF
            CATCH TO loExcepcion
                llModificado = .F.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN llModificado
    ENDFUNC

    **/
    * Verifica la integridad referencial de un registro.
    *
    * @param integer tnCodigo
    * Código a ser verificado.
    *
    * @return boolean
    * true si está relacionado u ocurre un error y false en caso contrario.
    */
    * @Override
    FUNCTION EstaRelacionado
        LPARAMETERS tnCodigo

        * inicio { validación del parámetro }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            RETURN .T.
        ENDIF
        * fin { validación del parámetro }

        LOCAL llRelacionado, loExcepcion
        llRelacionado = .T.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT barrios
                SET ORDER TO 0
                LOCATE FOR ciudad == tnCodigo
                IF !FOUND() THEN
                    SELECT clientes
                    SET ORDER TO 0
                    LOCATE FOR ciudad == tnCodigo
                    IF !FOUND() THEN
                        SELECT ordenes_trabajo
                        SET ORDER TO 0
                        LOCATE FOR ciudad == tnCodigo
                        IF !FOUND() THEN
                            llRelacionado = .F.
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loExcepcion
                llRelacionado = .T.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN llRelacionado
    ENDFUNC

    **/
    * Carga los datos de la tabla a un objeto.
    *
    * @param object toCiudad
    * Objeto a ser cargado.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION CargarDatos
        LPARAMETERS toCiudad

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toCiudad) != 'O' THEN
            RETURN .F.
        ENDIF

        IF LOWER(toCiudad.Class) != LOWER(THIS.cClaseModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        TRY
            WITH toCiudad
                .EstablecerCodigo(codigo)
                .EstablecerNombre(nombre)
                .EstablecerDepartamen(departamen)
                .EstablecerVigente(vigente)
            ENDWITH
        CATCH TO loExcepcion
            toCiudad = .F.
        ENDTRY

        RETURN toCiudad
    ENDFUNC

    **/
    * Valida el parámetro tnCodigo.
    *
    * @field
    * codigo N(5) not null unique
    *
    * @param integer tnCodigo
    * Código a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION ValidarParamCodigo
        LPARAMETERS tnCodigo
        RETURN THIS.oUtiles.ValidarNumero(tnCodigo, 1, 99999)
    ENDFUNC

ENDDEFINE
