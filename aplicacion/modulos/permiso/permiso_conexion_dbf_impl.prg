DEFINE CLASS PermisoConexionDBFImpl AS ConexionBaseDBFImpl

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

        laTablas[1,1] = 'usercfg'
        laTablas[1,2] = 'permisos'

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
        DIMENSION laTablas[2,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'usercfg'
        laTablas[1,2] = 'permisos'
        laTablas[2,1] = 'usuarios'
        laTablas[2,2] = 'usuarios'

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
        DIMENSION laTablas[2,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'usercfg'
        laTablas[1,2] = 'permisos'
        laTablas[1,3] = .T.
        laTablas[2,1] = 'usuarios'
        laTablas[2,2] = 'usuarios'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE