DEFINE CLASS VendedorDAODBFImpl AS DAOBaseDBFImpl

    * Inicialización de propiedades.
    cTabla = 'vendedores'
    cClaseModelo = 'VendedorVO'

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
                LOCATE FOR vendedor == tnCodigo
                IF !FOUND() THEN
                    SELECT pedidos_clientes
                    SET ORDER TO 0
                    LOCATE FOR vendedor == tnCodigo
                    IF !FOUND() THEN
                        SELECT pedidos_clientes_usd
                        SET ORDER TO 0
                        LOCATE FOR vendedor == tnCodigo
                        IF !FOUND() THEN
                            SELECT presupuestos_clientes
                            SET ORDER TO 0
                            LOCATE FOR vendedor == tnCodigo
                            IF !FOUND() THEN
                                SELECT presupuestos_ot
                                SET ORDER TO 0
                                LOCATE FOR vendedor == tnCodigo
                                IF !FOUND() THEN
                                    SELECT reparaciones_ot
                                    SET ORDER TO 0
                                    LOCATE FOR vendedor == tnCodigo
                                    IF !FOUND() THEN
                                        SELECT ventas
                                        SET ORDER TO 0
                                        LOCATE FOR vendedor == tnCodigo
                                        IF !FOUND() THEN
                                            llRelacionado = .F.
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

    **/
    * Valida el parámetro tcNombre.
    *
    * @field
    * nombre C(30) not null unique
    *
    * @param string tcNombre
    * Nombre a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION ValidarParamNombre
        LPARAMETERS tcNombre
        RETURN THIS.oUtiles.ValidarTexto(tcNombre, 4, 30)
    ENDFUNC

ENDDEFINE