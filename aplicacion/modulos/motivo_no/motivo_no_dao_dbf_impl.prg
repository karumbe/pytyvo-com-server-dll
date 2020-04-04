DEFINE CLASS MotivoNoDAODBFImpl AS DAOBaseDBFImpl

    * Inicialización de propiedades.
    cTabla = 'motivos_notas'
    cClaseModelo = 'MotivoNoVO'

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
                SELECT devoluciones_clientes
                SET ORDER TO 0
                LOCATE FOR motivonota == tnCodigo
                IF !FOUND() THEN
                    SELECT devoluciones_proveedores
                    SET ORDER TO 0
                    LOCATE FOR motivonota == tnCodigo
                    IF !FOUND() THEN
                        llRelacionado = .F.
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
