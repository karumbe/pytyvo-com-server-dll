DEFINE CLASS EstadoOtConexionDBFImpl AS ConexionBaseDBFImpl

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

        laTablas[1,1] = 'estadoot'
        laTablas[1,2] = 'estados_ot'

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

        laTablas[1,1] = 'estadoot'
        laTablas[1,2] = 'estados_ot'
        laTablas[2,1] = 'ot'
        laTablas[2,2] = 'ordenes_trabajo'

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

        laTablas[1,1] = 'estadoot'
        laTablas[1,2] = 'estados_ot'
        laTablas[1,3] = .T.
        laTablas[2,1] = 'ot'
        laTablas[2,2] = 'ordenes_trabajo'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE
