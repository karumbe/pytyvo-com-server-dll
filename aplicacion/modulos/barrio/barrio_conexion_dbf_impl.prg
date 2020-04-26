DEFINE CLASS BarrioConexionDBFImpl AS ConexionBaseDBFImpl

    **/
    * Conexion para realizar búsqueda.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION Busqueda
        * {fila, 1} Tabla  |  {fila, 2} Alias  |  {fila, 3} Lectura y escritura.
        DIMENSION laTablas[3,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'barrios'
        laTablas[1,2] = 'barrios'
        laTablas[2,1] = 'ciudades'
        laTablas[2,2] = 'ciudades'
        laTablas[3,1] = 'depar'
        laTablas[3,2] = 'departamentos'


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
        DIMENSION laTablas[5,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'barrios'
        laTablas[1,2] = 'barrios'
        laTablas[2,1] = 'ciudades'
        laTablas[2,2] = 'ciudades'
        laTablas[3,1] = 'clientes'
        laTablas[3,2] = 'clientes'
        laTablas[4,1] = 'depar'
        laTablas[4,2] = 'departamentos'
        laTablas[5,1] = 'ot'
        laTablas[5,2] = 'ordenes_trabajo'

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
        DIMENSION laTablas[5,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'barrios'
        laTablas[1,2] = 'barrios'
        laTablas[1,3] = .T.
        laTablas[2,1] = 'ciudades'
        laTablas[2,2] = 'ciudades'
        laTablas[3,1] = 'clientes'
        laTablas[3,2] = 'clientes'
        laTablas[4,1] = 'depar'
        laTablas[4,2] = 'departamentos'
        laTablas[5,1] = 'ot'
        laTablas[5,2] = 'ordenes_trabajo'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE
