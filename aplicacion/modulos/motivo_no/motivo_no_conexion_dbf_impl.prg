DEFINE CLASS MotivoNoConexionDBFImpl AS ConexionBaseDBFImpl

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

        laTablas[1,1] = 'motivono'
        laTablas[1,2] = 'motivos_notas'

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
        DIMENSION laTablas[3,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'cabenotc'
        laTablas[1,2] = 'devoluciones_clientes'
        laTablas[2,1] = 'cabenotp'
        laTablas[2,2] = 'devoluciones_proveedores'
        laTablas[3,1] = 'motivono'
        laTablas[3,2] = 'motivos_notas'

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
        DIMENSION laTablas[3,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'cabenotc'
        laTablas[1,2] = 'devoluciones_clientes'
        laTablas[2,1] = 'cabenotp'
        laTablas[2,2] = 'devoluciones_proveedores'
        laTablas[3,1] = 'motivono'
        laTablas[3,2] = 'motivos_notas'
        laTablas[3,3] = .T.

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE
