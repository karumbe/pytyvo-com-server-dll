DEFINE CLASS CiudadDAODBFImpl AS DAOBaseDBFImpl

    * Inicializaci�n de propiedades.
    cTabla = 'ciudades'
    cClaseModelo = 'CiudadVO'

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
                .EstablecerCodigo(codigo)
                .EstablecerNombre(nombre)
                .EstablecerDepartamen(departamen)
                .EstablecerVigente(vigente)
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

ENDDEFINE