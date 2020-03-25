DEFINE CLASS BarrioVO AS VOBase

    * Propiedades.
    PROTECTED nDepartamen
    PROTECTED nCiudad

    **/
    * Devuelve el código del departamento.
    *
    * @return integer
    */
    FUNCTION ObtenerDepartamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **/
    * Devuelve el código de la ciudad.
    *
    * @return integer
    */
    FUNCTION ObtenerCiudad
        RETURN THIS.nCiudad
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

    **/
    * Establece el código de la ciudad.
    *
    * @param integer tnCiudad
    * Código de la ciudad.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerCiudad
        LPARAMETERS tnCiudad
        THIS.nCiudad = tnCiudad
    ENDFUNC

ENDDEFINE