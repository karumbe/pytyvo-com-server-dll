* @Interface
DEFINE CLASS ConexionBase AS CUSTOM

    **/
    * Conexion para realizar b�squeda.
    *
    * @return object
    * object si tiene �xito y false en caso contrario.
    */
    FUNCTION Busqueda
        RETURN .F.
    ENDFUNC

    **/
    * Conexion para verificar integridad referencial.
    *
    * @return object
    * object si tiene �xito y false en caso contrario.
    */
    FUNCTION IntegridadReferencial
        RETURN .F.
    ENDFUNC

    **/
    * Conexion para realizar mantenimiento.
    *
    * @return object
    * object si tiene �xito y false en caso contrario.
    */
    FUNCTION Mantenimiento
        RETURN .F.
    ENDFUNC

ENDDEFINE