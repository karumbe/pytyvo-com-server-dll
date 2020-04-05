DEFINE CLASS MonedaConexionDBFImpl AS ConexionBaseDBFImpl

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

        laTablas[1,1] = 'monedas'
        laTablas[1,2] = 'monedas'

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

        laTablas[1,1] = 'cabecob'
        laTablas[1,2] = 'cobros'
        laTablas[2,1] = 'cabecomp'
        laTablas[2,2] = 'compras'
        laTablas[3,1] = 'monedas'
        laTablas[3,2] = 'monedas'
        laTablas[4,1] = 'cabepag'
        laTablas[4,2] = 'pagos'
        laTablas[5,1] = 'cabepres'
        laTablas[5,2] = 'presupuestos'
        laTablas[6,1] = 'cabemot2'
        laTablas[6,2] = 'presupuestos_ot'
        laTablas[7,1] = 'cabemot'
        laTablas[7,2] = 'reparaciones_ot'
        laTablas[8,1] = 'cotizaci'
        laTablas[8,2] = 'tipos_cambios_set'
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

        laTablas[1,1] = 'cabecob'
        laTablas[1,2] = 'cobros'
        laTablas[2,1] = 'cabecomp'
        laTablas[2,2] = 'compras'
        laTablas[3,1] = 'monedas'
        laTablas[3,2] = 'monedas'
        laTablas[3,3] = .T.
        laTablas[4,1] = 'cabepag'
        laTablas[4,2] = 'pagos'
        laTablas[5,1] = 'cabepres'
        laTablas[5,2] = 'presupuestos'
        laTablas[6,1] = 'cabemot2'
        laTablas[6,2] = 'presupuestos_ot'
        laTablas[7,1] = 'cabemot'
        laTablas[7,2] = 'reparaciones_ot'
        laTablas[8,1] = 'cotizaci'
        laTablas[8,2] = 'tipos_cambios_set'
        laTablas[9,1] = 'cabevent'
        laTablas[9,2] = 'ventas'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE
