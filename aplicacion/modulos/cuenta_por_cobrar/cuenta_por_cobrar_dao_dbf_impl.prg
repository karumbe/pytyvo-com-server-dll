DEFINE CLASS CuentaPorCobrarDAODBFImpl AS DAOBaseDBFImpl

    **/
    * Realiza una búsqueda por código de cliente.
    *
    * @param integer tnCodigo
    * Código a buscar.
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
    * @Override
    FUNCTION ObtenerPorCodigo
        LPARAMETERS tnCodigo, tcCursor, tcCondicionFiltrado

        * inicio { validaciones de parámetros }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
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

        LOCAL loExcepcion

        IF THIS.oConexion.Conectar() THEN
            TRY
                IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
                    SELECT ;
                        a.tipodocu, ;
                        a.nrodocu, ;
                        TRANSFORM(a.nrocuota, '@L 99') + '/' + ;
                            TRANSFORM(b.qty_cuotas, '@L 99') AS cuota, ;
                        b.fechadocu AS fecha_emi, ;
                        a.fecha AS fecha_vto, ;
                        (a.importe + a.monto_ndeb) - ;
                            (a.abonado + a.monto_ncre) AS saldo, ;
                        a.fecha - DATE() AS dias, ;
                        b.moneda AS cod_moneda, ;
                        c.nombre AS moneda, ;
                        c.simbolo, ;
                        IIF(c.decimales == '0', .F., .T.) AS decimales, ;
                        b.cliente AS cod_cliente, ;
                        d.nombre AS cliente, ;
                        d.ruc, ;
                        d.direc1 AS direccion, ;
                        e.nombre AS departamen, ;
                        f.nombre AS ciudad, ;
                        d.telefono ;
                    FROM ;
                        cuotas_ventas a ;
                        INNER JOIN ventas b ;
                            ON a.tipodocu == b.tipodocu AND ;
                               a.nrodocu == b.nrodocu ;
                        LEFT JOIN monedas c ;
                            ON b.moneda == c.codigo ;
                        INNER JOIN clientes d ;
                            ON b.cliente == d.codigo ;
                        LEFT JOIN departamentos e ;
                            ON d.departamen == e.codigo ;
                        LEFT JOIN ciudades f ;
                            ON d.ciudad == f.codigo ;
                    WHERE ;
                        (a.importe + a.monto_ndeb) - ;
                            (a.abonado + a.monto_ncre) != 0 AND ;
                        b.cliente = tnCodigo AND ;
                        &tcCondicionFiltrado ;
                    ORDER BY ;
                        d.nombre, ;
                        b.moneda, ;
                        a.fecha, ;
                        a.nrodocu, ;
                        a.nrocuota ;
                    INTO CURSOR ;
                        tm_resultado
                ELSE
                    SELECT ;
                        a.tipodocu, ;
                        a.nrodocu, ;
                        TRANSFORM(a.nrocuota, '@L 99') + '/' + ;
                            TRANSFORM(b.qty_cuotas, '@L 99') AS cuota, ;
                        b.fechadocu AS fecha_emi, ;
                        a.fecha AS fecha_vto, ;
                        (a.importe + a.monto_ndeb) - ;
                            (a.abonado + a.monto_ncre) AS saldo, ;
                        a.fecha - DATE() AS dias, ;
                        b.moneda AS cod_moneda, ;
                        c.nombre AS moneda, ;
                        c.simbolo, ;
                        IIF(c.decimales == '0', .F., .T.) AS decimales, ;
                        b.cliente AS cod_cliente, ;
                        d.nombre AS cliente, ;
                        d.ruc, ;
                        d.direc1 AS direccion, ;
                        e.nombre AS departamen, ;
                        f.nombre AS ciudad, ;
                        d.telefono ;
                    FROM ;
                        cuotas_ventas a ;
                        INNER JOIN ventas b ;
                            ON a.tipodocu == b.tipodocu AND ;
                               a.nrodocu == b.nrodocu ;
                        LEFT JOIN monedas c ;
                            ON b.moneda == c.codigo ;
                        INNER JOIN clientes d ;
                            ON b.cliente == d.codigo ;
                        LEFT JOIN departamentos e ;
                            ON d.departamen == e.codigo ;
                        LEFT JOIN ciudades f ;
                            ON d.ciudad == f.codigo ;
                    WHERE ;
                        (a.importe + a.monto_ndeb) - ;
                            (a.abonado + a.monto_ncre) != 0 AND ;
                        b.cliente = tnCodigo ;
                    ORDER BY ;
                        d.nombre, ;
                        b.moneda, ;
                        a.fecha, ;
                        a.nrodocu, ;
                        a.nrocuota ;
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
        ELSE
            RETURN .F.    && No se pudo realizar la conexión.
        ENDIF
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