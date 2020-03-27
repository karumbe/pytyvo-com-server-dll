DEFINE CLASS ModeloConexionDBFImpl AS ConexionBaseDBFImpl

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

        laTablas[1,1] = 'maquinas'
        laTablas[1,2] = 'maquinas'
        laTablas[2,1] = 'marcas2'
        laTablas[2,2] = 'marcas_ot'
        laTablas[3,1] = 'modelos'
        laTablas[3,2] = 'modelos'

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
        DIMENSION laTablas[4,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'maquinas'
        laTablas[1,2] = 'maquinas'
        laTablas[2,1] = 'marcas2'
        laTablas[2,2] = 'marcas_ot'
        laTablas[3,1] = 'modelos'
        laTablas[3,2] = 'modelos'
        laTablas[4,1] = 'ot'
        laTablas[4,2] = 'ordenes_trabajo'

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
        DIMENSION laTablas[4,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'maquinas'
        laTablas[1,2] = 'maquinas'
        laTablas[2,1] = 'marcas2'
        laTablas[2,2] = 'marcas_ot'
        laTablas[3,1] = 'modelos'
        laTablas[3,2] = 'modelos'
        laTablas[3,3] = .T.
        laTablas[4,1] = 'ot'
        laTablas[4,2] = 'ordenes_trabajo'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE
