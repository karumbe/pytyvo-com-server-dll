DEFINE CLASS MotivoClieConexionDBFImpl AS ConexionBaseDBFImpl

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

        laTablas[1,1] = 'motivocl'
        laTablas[1,2] = 'motivos_clientes'

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

        laTablas[1,1] = 'clientes'
        laTablas[1,2] = 'clientes'
        laTablas[2,1] = 'motivocl'
        laTablas[2,2] = 'motivos_clientes'

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

        laTablas[1,1] = 'clientes'
        laTablas[1,2] = 'clientes'
        laTablas[2,1] = 'motivocl'
        laTablas[2,2] = 'motivos_clientes'
        laTablas[2,3] = .T.

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE