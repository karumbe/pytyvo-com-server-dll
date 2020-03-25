DEFINE CLASS ConexionVendedorDBFImpl AS ConexionBaseDBFImpl

    **/
    * Conexion para realizar búsqueda.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION Busqueda
        * {fila, 1} Tabla  |  {fila, 2} Alias  |  {fila, 3} Lectura y escritura.
        DIMENSION laTablas[1,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'vendedor'
        laTablas[1,2] = 'vendedores'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

    **/
    * Conexion para verificar integridad referencial.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION IntegridadReferencial
        * {fila, 1} Tabla  |  {fila, 2} Alias  |  {fila, 3} Lectura y escritura.
        DIMENSION laTablas[8,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'clientes'
        laTablas[1,2] = 'clientes'
        laTablas[2,1] = 'cabepedc'
        laTablas[2,2] = 'pedidos_clientes'
        laTablas[3,1] = 'cabepusd'
        laTablas[3,2] = 'pedidos_clientes_usd'
        laTablas[4,1] = 'cabepres'
        laTablas[4,2] = 'presupuestos_clientes'
        laTablas[5,1] = 'cabemot2'
        laTablas[5,2] = 'presupuestos_ot'
        laTablas[6,1] = 'cabemot'
        laTablas[6,2] = 'reparaciones_ot'
        laTablas[7,1] = 'vendedor'
        laTablas[7,2] = 'vendedores'
        laTablas[8,1] = 'cabevent'
        laTablas[8,2] = 'ventas'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

    **/
    * Conexion para realizar mantenimiento.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION Mantenimiento
        * {fila, 1} Tabla  |  {fila, 2} Alias  |  {fila, 3} Lectura y escritura.
        DIMENSION laTablas[8,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'clientes'
        laTablas[1,2] = 'clientes'
        laTablas[2,1] = 'cabepedc'
        laTablas[2,2] = 'pedidos_clientes'
        laTablas[3,1] = 'cabepusd'
        laTablas[3,2] = 'pedidos_clientes_usd'
        laTablas[4,1] = 'cabepres'
        laTablas[4,2] = 'presupuestos_clientes'
        laTablas[5,1] = 'cabemot2'
        laTablas[5,2] = 'presupuestos_ot'
        laTablas[6,1] = 'cabemot'
        laTablas[6,2] = 'reparaciones_ot'
        laTablas[7,1] = 'vendedor'
        laTablas[7,2] = 'vendedores'
        laTablas[7,3] = .T.
        laTablas[8,1] = 'cabevent'
        laTablas[8,2] = 'ventas'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE