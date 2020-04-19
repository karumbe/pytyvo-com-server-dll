DEFINE CLASS CiudadVO AS VOBase

    * Propiedades.
    PROTECTED nDepartamen

    **/
    * Devuelve el código del departamento.
    *
    * @return integer
    */
    FUNCTION ObtenerDepartamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **/
    * Establece el código del departamento.
    *
    * @param integer tnDepartamen
    * Código del departamento.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDepartamen
        LPARAMETERS tnDepartamen
        THIS.nDepartamen = tnDepartamen
    ENDFUNC

ENDDEFINE