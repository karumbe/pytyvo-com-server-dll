DEFINE CLASS EstadoOtDAODBFImpl AS DAOBaseDBFImpl

    * Inicializaci�n de propiedades.
    cTabla = 'estados_ot'
    cClaseModelo = 'EstadoOtVO'

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
                SELECT ordenes_trabajo
                SET ORDER TO TAG 'indice8'    && estadoot.
                IF !SEEK(tnCodigo) THEN
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
    * Valida el par�metro tnCodigo.
    *
    * @field
    * codigo N(3) not null unique
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
        RETURN THIS.oUtiles.ValidarNumero(tnCodigo, 1, 999)
    ENDFUNC

ENDDEFINE
