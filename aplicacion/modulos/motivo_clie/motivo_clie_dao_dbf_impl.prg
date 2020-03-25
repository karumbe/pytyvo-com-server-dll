DEFINE CLASS MotivoClieDAODBFImpl AS DAOBaseDBFImpl

    * Inicialización de propiedades.
    cTabla = 'motivos_clientes'
    cClaseModelo = 'MotivoClieVO'

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
                SELECT clientes
                SET ORDER TO 0
                LOCATE FOR motivoclie == tnCodigo
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

ENDDEFINE