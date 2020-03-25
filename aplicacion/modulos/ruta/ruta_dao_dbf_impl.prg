DEFINE CLASS RutaDAODBFImpl AS DAOBaseDBFImpl

    * Inicializaci�n de propiedades.
    cTabla = 'rutas'
    cClaseModelo = 'RutaVO'

    **/
    * Verifica si un c�digo existe.
    *
    * @field
    * id_ruta N(5) not null unique
    *
    * @param integer tnCodigo
    * C�digo a ser verificado.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    * @Override
    FUNCTION CodigoExiste
        LPARAMETERS tnCodigo

        * inicio { validaci�n del par�metro }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            RETURN .T.
        ENDIF
        * fin { validaci�n del par�metro }

        LOCAL llExiste, loExcepcion
        llExiste = .T.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO 0
                LOCATE FOR id_ruta == tnCodigo
                IF !FOUND() THEN
                    llExiste = .F.
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
    * Verifica si un nombre existe.
    *
    * @field
    * nombre C(50) not null unique
    *
    * @param string tcNombre
    * Nombre a ser verificado.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    * @Override
    FUNCTION NombreExiste
        LPARAMETERS tcNombre

        * inicio { validaci�n del par�metro }
        IF !THIS.ValidarParamNombre(tcNombre) THEN
            RETURN .T.
        ENDIF

        tcNombre = ALLTRIM(UPPER(tcNombre))
        * fin { validaci�n del par�metro }

        LOCAL llExiste, loExcepcion
        llExiste = .T.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO 0
                LOCATE FOR ALLTRIM(UPPER(nombre)) == tcNombre
                IF !FOUND() THEN
                    llExiste = .F.
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
    * Verifica si el registro est� vigente.
    *
    * @field
    * vigente L(1) not null
    *
    * @param integer tnCodigo
    * C�digo a ser verificado.
    *
    * @return boolean
    * true si �sta vigente y false si no lo est� u ocurre un error.
    */
    * @Override
    FUNCTION EstaVigente
        RETURN .F.
    ENDFUNC

    **/
    * Genera un nuevo c�digo para el registro.
    *
    * @field
    * id_ruta N(5) not null unique
    *
    * @return integer
    */
    * @Override
    FUNCTION NuevoCodigo
        LOCAL lnNuevoCodigo, loExcepcion
        lnNuevoCodigo = 1

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO 0
                LOCATE FOR id_ruta == lnNuevoCodigo
                DO WHILE FOUND()
                    lnNuevoCodigo = lnNuevoCodigo + 1
                    LOCATE FOR id_ruta == lnNuevoCodigo
                ENDDO
            CATCH TO loExcepcion
                lnNuevoCodigo = 0
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN lnNuevoCodigo
    ENDFUNC

    **/
    * Realiza una b�squeda por c�digo.
    *
    * @field
    * id_ruta N(5) not null unique
    *
    * @param integer tnCodigo
    * C�digo a buscar.
    *
    * @return object|boolean
    * object si tiene �xito y false en caso contrario.
    */
    * @Override
    FUNCTION ObtenerPorCodigo
        LPARAMETERS tnCodigo

        * inicio { validaci�n del par�metro }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            RETURN .F.
        ENDIF
        * fin { validaci�n del par�metro }

        LOCAL loModelo, loExcepcion
        loModelo = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO 0
                LOCATE FOR id_ruta == tnCodigo
                IF FOUND() THEN
                    loModelo = THIS.CargarDatos(CREATEOBJECT(THIS.cClaseModelo))
                ENDIF
            CATCH TO loExcepcion
                loModelo = .F.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN loModelo
    ENDFUNC

    **/
    * Realiza una b�squeda por nombre.
    *
    * @field
    * nombre C(50) not null unique
    *
    * @param string tcNombre
    * Nombre a buscar.
    *
    * @return object|boolean
    * object si tiene �xito y false en caso contrario.
    */
    * @Override
    FUNCTION ObtenerPorNombre
        LPARAMETERS tcNombre

        * inicio { validaci�n del par�metro }
        IF !THIS.ValidarParamNombre(tcNombre) THEN
            RETURN .F.
        ENDIF

        tcNombre = ALLTRIM(UPPER(tcNombre))
        * fin { validaci�n del par�metro }

        LOCAL loModelo, loExcepcion
        loModelo = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO 0
                LOCATE FOR ALLTRIM(UPPER(nombre)) == tcNombre
                IF FOUND() THEN
                    loModelo = THIS.CargarDatos(CREATEOBJECT(THIS.cClaseModelo))
                ENDIF
            CATCH TO loExcepcion
                loModelo = .F.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN loModelo
    ENDFUNC

    **/
    * Realiza una b�squeda por codigo, nombre.
    *
    * @field
    * id_ruta N(5) not null unique
    * nombre C(50) not null unique
    *
    * @param string tcExpresion
    * Expresi�n a buscar.
    *
    * @param string tcCursor
    * Cursor en el cual se guardar� el resultado de la b�squeda.
    *
    * @param string tcCondicionFiltrado (opcional)
    * Condici�n de filtrado de registros.
    *
    * @return cursor|boolean
    * cursor|true si tiene �xito y false en caso contrario.
    */
    * @Override
    FUNCTION Obtener
        LPARAMETERS tcExpresion, tcCursor, tcCondicionFiltrado

        * inicio { validaciones de par�metros }
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
        * fin { validaciones de par�metros }

        LOCAL lnCodigo, loExcepcion
        lnCodigo = INT(VAL(STRTRAN(tcExpresion, '%', '')))

        IF THIS.oConexion.Conectar() THEN
            TRY
                IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
                    SELECT ;
                        id_ruta AS codigo, ;
                        nombre, ;
                        sitios ;
                    FROM ;
                        (THIS.cTabla) ;
                    WHERE ;
                        (id_ruta == lnCodigo OR ;
                        nombre LIKE tcExpresion) AND ;
                        &tcCondicionFiltrado ;
                    ORDER BY ;
                        nombre ;
                    INTO CURSOR ;
                        tm_resultado
                ELSE
                    SELECT ;
                        id_ruta AS codigo, ;
                        nombre, ;
                        sitios ;
                    FROM ;
                        (THIS.cTabla) ;
                    WHERE ;
                        id_ruta == lnCodigo OR ;
                        nombre LIKE tcExpresion ;
                    ORDER BY ;
                        nombre ;
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
    * Cursor en el cual se guardar� el resultado de la b�squeda.
    *
    * @param string tcCondicionFiltrado (opcional)
    * Condici�n de filtrado de registros.
    *
    * @return cursor|boolean
    * cursor|true si tiene �xito y false en caso contrario.
    */
    * @Override
    FUNCTION ObtenerTodos
        LPARAMETERS tcCursor, tcCondicionFiltrado

        * inicio { validaciones de par�metros }
        IF !THIS.oUtiles.ValidarTexto(tcCursor, 8, 8) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
            IF !THIS.oUtiles.ValidarTexto(tcCondicionFiltrado, 6, 50) THEN
                RETURN .F.
            ENDIF
        ENDIF
        * fin { validaciones de par�metros }

        LOCAL loExcepcion

        IF THIS.oConexion.Conectar() THEN
            TRY
                IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
                    SELECT ;
                        id_ruta AS codigo, ;
                        nombre, ;
                        sitios ;
                    FROM ;
                        (THIS.cTabla) ;
                    WHERE ;
                        &tcCondicionFiltrado ;
                    ORDER BY ;
                        nombre ;
                    INTO CURSOR ;
                        tm_resultado
                ELSE
                    SELECT ;
                        id_ruta AS codigo, ;
                        nombre, ;
                        sitios ;
                    FROM ;
                        (THIS.cTabla) ;
                    ORDER BY ;
                        nombre ;
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
    * @param object modelo
    * Objeto a ser agregado.
    *
    * @return boolean
    * true si tiene �xito y false en caso contrario.
    */
    * @Override
    FUNCTION Agregar
        LPARAMETERS toModelo

        * inicio { validaci�n del par�metro }
        IF !THIS.EsObjeto(toModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validaci�n del par�metro }

        LOCAL llAgregado, loExcepcion, ;
              lnCodigo, lcNombre, lcSitios

        llAgregado = .F.
        lnCodigo = THIS.NuevoCodigo()

        IF THIS.CodigoExiste(lnCodigo) THEN
            RETURN .F.
        ENDIF

        IF THIS.oConexion.Conectar() THEN
            TRY
                WITH toModelo
                    lcNombre = .ObtenerNombre()
                    lcSitios = .ObtenerSitios()
                ENDWITH

                INSERT INTO (THIS.cTabla) ( ;
                    id_ruta, ;
                    nombre, ;
                    sitios ;
                ) VALUES ( ;
                    lnCodigo, ;
                    lcNombre, ;
                    lcSitios ;
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
    * @param object modelo
    * Objeto a ser modificado.
    *
    * @return boolean
    * true si tiene �xito y false en caso contrario.
    */
    * @Override
    FUNCTION Modificar
        LPARAMETERS toModelo

        * inicio { validaci�n del par�metro }
        IF !THIS.EsObjeto(toModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validaci�n del par�metro }

        LOCAL llModificado, loExcepcion, ;
              lnCodigo, lcNombre, lcSitios

        llModificado = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                WITH toModelo
                    lnCodigo = .ObtenerCodigo()
                    lcNombre = .ObtenerNombre()
                    lcSitios = .ObtenerSitios()
                ENDWITH

                SELECT (THIS.cTabla)
                SET ORDER TO 0
                LOCATE FOR id_ruta == lnCodigo
                IF FOUND() THEN
                    REPLACE nombre WITH lcNombre, ;
                            sitios WITH lcSitios
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
    * Borra un registro existente.
    *
    * @param integer tnCodigo
    * C�digo a ser borrado.
    *
    * @return boolean
    * true si tiene �xito y false en caso contrario.
    */
    * @Override
    FUNCTION Borrar
        LPARAMETERS tnCodigo

        * inicio { validaciones del par�metro }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            RETURN .F.
        ENDIF

        IF THIS.EstaRelacionado(tnCodigo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del par�metro }

        LOCAL llBorrado, loExcepcion
        llBorrado = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO 0
                LOCATE FOR id_ruta == lnCodigo
                IF FOUND() THEN
                    DELETE
                    llBorrado = .T.
                ENDIF
            CATCH TO loExcepcion
                llBorrado = .F.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN llBorrado
    ENDFUNC

    **/
    * Verifica la integridad referencial de un registro.
    *
    * @param integer tnCodigo
    * C�digo a ser verificado.
    *
    * @return boolean
    * true si est� relacionado u ocurre un error y false en caso contrario.
    */
    * @Override
    FUNCTION EstaRelacionado
        LPARAMETERS tnCodigo

        * inicio { validaci�n del par�metro }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            RETURN .T.
        ENDIF
        * fin { validaci�n del par�metro }

        LOCAL llRelacionado, loExcepcion
        llRelacionado = .T.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT clientes
                SET ORDER TO 0
                LOCATE FOR ruta == tnCodigo
                IF !FOUND() THEN
                    llRelacionado = .F.
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
    * @param object toModelo
    * Objeto a ser cargado.
    *
    * @return object
    * object si tiene �xito y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION CargarDatos
        LPARAMETERS toModelo

        * inicio { validaciones del par�metro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toModelo) != 'O' THEN
            RETURN .F.
        ENDIF

        IF LOWER(toModelo.Class) != LOWER(THIS.cClaseModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del par�metro }

        TRY
            WITH toModelo
                .EstablecerCodigo(id_ruta)
                .EstablecerNombre(nombre)
                .EstablecerSitios(sitios)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

    **/
    * Valida el par�metro tnCodigo.
    *
    * @field
    * codigo N(5) not null unique
    *
    * @param integer tnCodigo
    * C�digo a ser validado.
    *
    * @return boolean
    * true si es v�lido y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION ValidarParamCodigo
        LPARAMETERS tnCodigo
        RETURN THIS.oUtiles.ValidarNumero(tnCodigo, 1, 99999)
    ENDFUNC

    **/
    * Valida el par�metro tcNombre.
    *
    * @field
    * nombre C(50) not null unique
    *
    * @param string tcNombre
    * Nombre a ser validado.
    *
    * @return boolean
    * true si es v�lido y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION ValidarParamNombre
        LPARAMETERS tcNombre
        RETURN THIS.oUtiles.ValidarTexto(tcNombre, 6, 50)
    ENDFUNC

ENDDEFINE