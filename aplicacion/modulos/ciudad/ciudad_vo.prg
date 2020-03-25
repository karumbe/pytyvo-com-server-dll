DEFINE CLASS CiudadVO AS VOBase

    * Propiedades.
    PROTECTED nDepartamen

    **/
    * Devuelve el c�digo del departamento.
    *
    * @return integer
    */
    FUNCTION ObtenerDepartamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **/
    * Establece el c�digo del departamento.
    *
    * @param integer tnDepartamen
    * C�digo del departamento.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDepartamen
        LPARAMETERS tnDepartamen
        THIS.nDepartamen = tnDepartamen
    ENDFUNC

ENDDEFINE