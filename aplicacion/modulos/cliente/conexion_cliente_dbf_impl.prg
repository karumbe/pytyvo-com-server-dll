DEFINE CLASS ConexionClienteDBFImpl AS ConexionBaseDBFImpl

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

        laTablas[1,1] = 'clientes'
        laTablas[1,2] = 'clientes'

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
        DIMENSION laTablas[9,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'clientes'
        laTablas[1,2] = 'clientes'
        laTablas[2,1] = 'cabecob'
        laTablas[2,2] = 'cobros'
        laTablas[3,1] = 'cabenotc'
        laTablas[3,2] = 'devoluciones_clientes'
        laTablas[4,1] = 'ot'
        laTablas[4,2] = 'ordenes_trabajo'
        laTablas[5,1] = 'cabepedc'
        laTablas[5,2] = 'pedidos_clientes'
        laTablas[6,1] = 'cabepusd'
        laTablas[6,2] = 'pedidos_clientes_usd'
        laTablas[7,1] = 'cabepres'
        laTablas[7,2] = 'presupuestos_clientes'
        laTablas[8,1] = 'caberemi'
        laTablas[8,2] = 'remisiones_clientes'
        laTablas[9,1] = 'cabevent'
        laTablas[9,2] = 'ventas'

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
        DIMENSION laTablas[9,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'barrios'
        laTablas[1,2] = 'barrios'
        laTablas[2,1] = 'ciudades'
        laTablas[2,2] = 'ciudades'
        laTablas[3,1] = 'clientes'
        laTablas[3,2] = 'clientes'
        laTablas[3,3] = .T.
        laTablas[4,1] = 'cuentas'
        laTablas[4,2] = 'cuentas'
        laTablas[5,1] = 'depar'
        laTablas[5,2] = 'departamentos'
        laTablas[6,1] = 'motivocl'
        laTablas[6,2] = 'motivos_ser_cliente'
        laTablas[7,1] = 'plazos'
        laTablas[7,2] = 'plazos'
        laTablas[8,1] = 'ruta'
        laTablas[8,2] = 'rutas'
        laTablas[9,1] = 'vendedor'
        laTablas[9,2] = 'vendedores'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE