DEFINE CLASS PaisConexionDBFImpl AS ConexionBaseDBFImpl

    **/
    * Conexion para realizar b�squeda.
    *
    * @return object
    * object si tiene �xito y false en caso contrario.
    */
    * @Override
    FUNCTION Busqueda
        * {fila, 1} Tabla  |  {fila, 2} Alias  |  {fila, 3} Lectura y escritura.
        DIMENSION laTablas[1,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'proceden'
        laTablas[1,2] = 'paises'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

    **/
    * Conexion para verificar integridad referencial.
    *
    * @return object
    * object si tiene �xito y false en caso contrario.
    */
    * @Override
    FUNCTION IntegridadReferencial
        * {fila, 1} Tabla  |  {fila, 2} Alias  |  {fila, 3} Lectura y escritura.
        DIMENSION laTablas[2,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'maesprod'
        laTablas[1,2] = 'articulos'
        laTablas[2,1] = 'proceden'
        laTablas[2,2] = 'paises'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

    **/
    * Conexion para realizar mantenimiento.
    *
    * @return object
    * object si tiene �xito y false en caso contrario.
    */
    * @Override
    FUNCTION Mantenimiento
        * {fila, 1} Tabla  |  {fila, 2} Alias  |  {fila, 3} Lectura y escritura.
        DIMENSION laTablas[2,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'maesprod'
        laTablas[1,2] = 'articulos'
        laTablas[2,1] = 'proceden'
        laTablas[2,2] = 'paises'
        laTablas[2,3] = .T.

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE
