DEFINE CLASS UnidadMedidaDAODBFImpl AS DAOBaseDBFImpl

    * Inicialización de propiedades.
    cTabla = 'unidades_medida'
    cClaseModelo = 'UnidadMedidaVO'

    **/
    * Verifica si un símbolo existe.
    *
    * @field
    * simbolo C(5) not null unique
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
    * Verifica si la unidad de medida es divisible.
    *
    * @field
    * divisible L(1) not null
    *
    * @param integer tnCodigo
    * Código a ser verificado.
    *
    * @return boolean
    * true si es divisible y false si no lo es u ocurre un error.
    */
    FUNCTION EsDivisible
        LPARAMETERS tnCodigo

        * inicio { validación del parámetro }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        LOCAL llEsDivisible, loExcepcion
        llEsDivisible = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT (THIS.cTabla)
                SET ORDER TO TAG 'indice1'    && codigo.
                IF SEEK(tnCodigo) THEN
                    llEsDivisible = divisible
                ENDIF
            CATCH TO loExcepcion
                llEsDivisible = .F.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN llEsDivisible
    ENDFUNC

    **/
    * Realiza una búsqueda por símbolo.
    *
    * @field
    * simbolo C(5) not null unique
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
              lnCodigo, lcNombre, lcSimbolo, llDivisible, llVigente

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
                    llDivisible = .EsDivisible()
                    llVigente = .EstaVigente()
                ENDWITH

                INSERT INTO (THIS.cTabla) ( ;
                    codigo, ;
                    nombre, ;
                    simbolo, ;
                    divisible, ;
                    vigente ;
                ) VALUES ( ;
                    lnCodigo, ;
                    lcNombre, ;
                    lcSimbolo, ;
                    llDivisible, ;
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
              lnCodigo, lcNombre, lcSimbolo, llDivisible, llVigente

        llModificado = .F.

        IF THIS.oConexion.Conectar() THEN
            TRY
                WITH toModelo
                    lnCodigo = .ObtenerCodigo()
                    lcNombre = .ObtenerNombre()
                    lcSimbolo = .ObtenerSimbolo()
                    llDivisible = .EsDivisible()
                    llVigente = .EstaVigente()
                ENDWITH

                SELECT (THIS.cTabla)
                SET ORDER TO TAG 'indice1'    && codigo.
                IF SEEK(lnCodigo) THEN
                    REPLACE nombre WITH lcNombre, ;
                            simbolo WITH lcSimbolo, ;
                            divisible WITH llDivisible, ;
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
                SELECT articulos
                SET ORDER TO 0
                LOCATE FOR unidad == tnCodigo
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
                .EstablecerDivisible(divisible)
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
    * simbolo C(5) not null unique
    *
    * @param string tcSimbolo
    * Símbolo a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarParamSimbolo
        LPARAMETERS tcSimbolo
        RETURN THIS.oUtiles.ValidarTexto(tcSimbolo, 1, 5)
    ENDFUNC

ENDDEFINE