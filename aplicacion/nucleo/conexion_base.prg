* @Interface
DEFINE CLASS ConexionBase AS CUSTOM

    **/
    * Conexion para realizar búsqueda.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    FUNCTION Busqueda
        RETURN .F.
    ENDFUNC

    **/
    * Conexion para verificar integridad referencial.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    FUNCTION IntegridadReferencial
        RETURN .F.
    ENDFUNC

    **/
    * Conexion para realizar mantenimiento.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    FUNCTION Mantenimiento
        RETURN .F.
    ENDFUNC

ENDDEFINE