DEFINE CLASS BarrioVO AS VOBase

    * Propiedades.
    PROTECTED nDepartamen
    PROTECTED nCiudad

    **/
    * Devuelve el c�digo del departamento.
    *
    * @return integer
    */
    FUNCTION ObtenerDepartamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **/
    * Devuelve el c�digo de la ciudad.
    *
    * @return integer
    */
    FUNCTION ObtenerCiudad
        RETURN THIS.nCiudad
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

    **/
    * Establece el c�digo de la ciudad.
    *
    * @param integer tnCiudad
    * C�digo de la ciudad.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerCiudad
        LPARAMETERS tnCiudad
        THIS.nCiudad = tnCiudad
    ENDFUNC

ENDDEFINE