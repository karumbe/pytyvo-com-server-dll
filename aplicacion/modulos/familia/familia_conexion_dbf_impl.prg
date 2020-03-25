DEFINE CLASS FamiliaConexionDBFImpl AS ConexionBaseDBFImpl

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

        laTablas[1,1] = 'familias'
        laTablas[1,2] = 'familias'

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

        laTablas[1,1] = 'maesprod'
        laTablas[1,2] = 'articulos'
        laTablas[2,1] = 'familias'
        laTablas[2,2] = 'familias'

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

        laTablas[1,1] = 'maesprod'
        laTablas[1,2] = 'articulos'
        laTablas[2,1] = 'familias'
        laTablas[2,2] = 'familias'
        laTablas[2,3] = .T.

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE