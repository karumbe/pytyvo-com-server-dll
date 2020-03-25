DEFINE CLASS RutaVO AS VOBase

    * Propiedades.
    PROTECTED cSitios

    **/
    * Devuelve los sitios.
    *
    * @return string
    */
    FUNCTION ObtenerSitios
        RETURN THIS.cSitios
    ENDFUNC

    **/
    * Establece los sitios.
    *
    * @param string tcSitios
    * Sitios.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerSitios
        LPARAMETERS tcSitios
        THIS.cSitios = tcSitios
    ENDFUNC

ENDDEFINE