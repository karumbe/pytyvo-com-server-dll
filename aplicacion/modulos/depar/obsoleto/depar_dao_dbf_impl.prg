DEFINE CLASS DeparDAODBFImpl AS DAOBaseDBFImpl

    * Inicialización de propiedades.
    cTabla = 'departamentos'
    cClaseModelo = 'DeparVO'

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
                LOCATE FOR departamen == tnCodigo
                IF !FOUND() THEN
                    SELECT ciudades
                    SET ORDER TO 0
                    LOCATE FOR departamen == tnCodigo
                    IF !FOUND() THEN
                        SELECT clientes
                        SET ORDER TO 0
                        LOCATE FOR departamen == tnCodigo
                        IF !FOUND() THEN
                            SELECT ordenes_trabajo
                            SET ORDER TO 0
                            LOCATE FOR departamen == tnCodigo
                            IF !FOUND() THEN
                                llRelacionado = .F.
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
                .EstablecerVigente(vigente)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

    **/
    * Valida el parámetro tnCodigo.
    *
    * @field
    * codigo N(3) not null unique
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
        RETURN THIS.oUtiles.ValidarNumero(tnCodigo, 1, 999)
    ENDFUNC

ENDDEFINE