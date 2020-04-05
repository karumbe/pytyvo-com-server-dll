DEFINE CLASS MonedaDAODBFImpl AS DAOBaseDBFImpl

    * Inicialización de propiedades.
    cTabla = 'monedas'
    cClaseModelo = 'MonedaVO'

    **/
    * Verifica si un símbolo existe.
    *
    * @field
    * simbolo C(4) not null unique
    *
    * @param string tcSimbolo
    * Símbolo a ser verificado.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    FUNCTION SimboloExiste
        LPARAMETERS tcSimbolo

        * inicio { validación del parámetro }
        IF !THIS.ValidarParamSimbolo(tcSimbolo) THEN
            RETURN .T.
        ENDIF

        tcSimbolo = ALLTRIM(UPPER(tcSimbolo))
        * fin { validación del parámetro }

        LOCAL llExiste, loExcepcion
        llExiste = .T.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO 0
                LOCATE FOR ALLTRIM(UPPER(simbolo)) == tcSimbolo
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
    * Verifica si la moneda utiliza decimales.
    *
    * @field
    * decimales L(1) not null
    *
    * @param integer tnCodigo
    * Código a ser verificado.
    *
    * @return boolean
    * true si utiliza decimales y false si no lo utiliza u ocurre un error.
    */
    FUNCTION UtilizaDecimales
        LPARAMETERS tnCodigo

        * inicio { validación del parámetro }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        LOCAL llUtilizaDecimales, loExcepcion
        llUtilizaDecimales = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO TAG 'indice1'    && codigo.
                IF SEEK(tnCodigo) THEN
                    llUtilizaDecimales = IIF(VAL(decimales) != 0, .T., .F.)
                ENDIF
            CATCH TO loExcepcion
                llUtilizaDecimales = .F.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN llUtilizaDecimales
    ENDFUNC

    **/
    * Realiza una búsqueda por símbolo.
    *
    * @field
    * simbolo C(4) not null unique
    *
    * @param string tcSimbolo
    * Símbolo a buscar.
    *
    * @return object|boolean
    * object si tiene éxito y false en caso contrario.
    */
    FUNCTION ObtenerPorSimbolo
        LPARAMETERS tcSimbolo

        * inicio { validación del parámetro }
        IF !THIS.ValidarParamSimbolo(tcSimbolo) THEN
            RETURN .F.
        ENDIF

        tcSimbolo = ALLTRIM(UPPER(tcSimbolo))
        * fin { validación del parámetro }

        LOCAL loModelo, loExcepcion
        loModelo = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO 0
                LOCATE FOR ALLTRIM(UPPER(simbolo)) == tcSimbolo
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
    * Realiza una búsqueda por codigo, nombre o símbolo.
    *
    * @field
    * codigo N(4) not null unique
    * nombre C(30) not null unique
    * simbolo C(4) not null unique
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
                        codigo, ;
                        nombre, ;
                        simbolo, ;
                        IIF(VAL(decimales) != 0, .T., .F.) AS decimales, ;
                        vigente ;
                    FROM ;
                        (THIS.cTabla) ;
                    WHERE ;
                        (codigo == lnCodigo OR ;
                        nombre LIKE tcExpresion OR ;
                        UPPER(simbolo) LIKE tcExpresion) AND ;
                        (tcCondicionFiltrado) ;
                    ORDER BY ;
                        nombre ;
                    INTO CURSOR ;
                        tm_resultado
                ELSE
                    SELECT ;
                        codigo, ;
                        nombre, ;
                        simbolo, ;
                        IIF(VAL(decimales) != 0, .T., .F.) AS decimales, ;
                        vigente ;
                    FROM ;
                        (THIS.cTabla) ;
                    WHERE ;
                        codigo == lnCodigo OR ;
                        nombre LIKE tcExpresion OR ;
                        UPPER(simbolo) LIKE tcExpresion ;
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
                        codigo, ;
                        nombre, ;
                        simbolo, ;
                        IIF(VAL(decimales) != 0, .T., .F.) AS decimales, ;
                        vigente ;
                    FROM ;
                        (THIS.cTabla) ;
                    WHERE ;
                        (tcCondicionFiltrado) ;
                    ORDER BY ;
                        nombre ;
                    INTO CURSOR ;
                        tm_resultado
                ELSE
                    SELECT ;
                        codigo, ;
                        nombre, ;
                        simbolo, ;
                        IIF(VAL(decimales) != 0, .T., .F.) AS decimales, ;
                        vigente ;
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
    * true si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION Agregar
        LPARAMETERS toModelo

        * inicio { validación del parámetro }
        IF !THIS.EsObjeto(toModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        LOCAL llAgregado, loExcepcion, ;
              lnCodigo, lcNombre, lcSimbolo, llDecimales, llVigente

        llAgregado = .F.
        lnCodigo = THIS.NuevoCodigo()

        IF THIS.CodigoExiste(lnCodigo) THEN
            RETURN .F.
        ENDIF

        IF THIS.oConexion.Conectar() THEN
            TRY
                WITH toModelo
                    lcNombre = .ObtenerNombre()
                    lcSimbolo = .ObtenerSimbolo()
                    llDecimales = IIF(.UtilizaDecimales(), '1', '0')
                    llVigente = .EstaVigente()
                ENDWITH

                INSERT INTO (THIS.cTabla) ( ;
                    codigo, ;
                    nombre, ;
                    simbolo, ;
                    decimales, ;
                    vigente ;
                ) VALUES ( ;
                    lnCodigo, ;
                    lcNombre, ;
                    lcSimbolo, ;
                    llDecimales, ;
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
    * @param object modelo
    * Objeto a ser modificado.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION Modificar
        LPARAMETERS toModelo

        * inicio { validación del parámetro }
        IF !THIS.EsObjeto(toModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        LOCAL llModificado, loExcepcion, ;
              lnCodigo, lcNombre, lcSimbolo, llDecimales, llVigente

        llModificado = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                WITH toModelo
                    lnCodigo = .ObtenerCodigo()
                    lcNombre = .ObtenerNombre()
                    lcSimbolo = .ObtenerSimbolo()
                    llDecimales =  IIF(.UtilizaDecimales(), '1', '0')
                    llVigente = .EstaVigente()
                ENDWITH

                SELECT (THIS.cTabla)
                SET ORDER TO TAG 'indice1'    && codigo.
                IF SEEK(lnCodigo) THEN
                    REPLACE nombre WITH lcNombre, ;
                            simbolo WITH lcSimbolo, ;
                            decimales WITH llDecimales, ;
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
                SELECT cobros
                SET ORDER TO 0
                LOCATE FOR moneda == tnCodigo
                IF !FOUND() THEN
                    SELECT compras
                    SET ORDER TO 0
                    LOCATE FOR moneda == tnCodigo
                    IF !FOUND() THEN
                        SELECT pagos
                        SET ORDER TO 0
                        LOCATE FOR moneda == tnCodigo
                        IF !FOUND() THEN
                            SELECT presupuestos
                            SET ORDER TO 0
                            LOCATE FOR moneda == tnCodigo
                            IF !FOUND() THEN
                                SELECT presupuestos_ot
                                SET ORDER TO 0
                                LOCATE FOR moneda == tnCodigo
                                IF !FOUND() THEN
                                    SELECT reparaciones_ot
                                    SET ORDER TO 0
                                    LOCATE FOR moneda == tnCodigo
                                    IF !FOUND() THEN
                                        SELECT tipos_cambios_set
                                        SET ORDER TO 0
                                        LOCATE FOR moneda == tnCodigo
                                        IF !FOUND() THEN
                                            SELECT ventas
                                            SET ORDER TO 0
                                            LOCATE FOR moneda == tnCodigo
                                            IF !FOUND() THEN
                                                llRelacionado = .F.
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
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
    * @param object toModelo
    * Objeto a ser cargado.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION CargarDatos
        LPARAMETERS toModelo

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toModelo) != 'O' THEN
            RETURN .F.
        ENDIF

        IF LOWER(toModelo.Class) != LOWER(THIS.cClaseModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        TRY
            WITH toModelo
                .EstablecerCodigo(codigo)
                .EstablecerNombre(nombre)
                .EstablecerSimbolo(simbolo)
                .EstablecerDecimales(IIF(VAL(decimales) != 0, .T., .F.))
                .EstablecerVigente(vigente)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

    **/
    * Valida el parámetro tcSimbolo.
    *
    * @field
    * simbolo C(4) not null unique
    *
    * @param string tcSimbolo
    * Símbolo a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarParamSimbolo
        LPARAMETERS tcSimbolo
        RETURN THIS.oUtiles.ValidarTexto(tcSimbolo, 1, 4)
    ENDFUNC

ENDDEFINE
