DEFINE CLASS PlazoVO AS VOBase

    * Propiedades.
    PROTECTED nNumVtos
    PROTECTED cSeparacion
    PROTECTED nPrimero
    PROTECTED nResto

    **/
    * Devuelve el n�mero de vencimientos.
    *
    * @return integer
    */
    FUNCTION ObtenerNumVtos
        RETURN THIS.nNumVtos
    ENDFUNC

    **/
    * Devuelve la separaci�n entre los vencimientos.
    *
    * @return string
    * 'M' para mes o 'D' para d�a (predeterminado).
    */
    FUNCTION ObtenerSeparacion
        RETURN THIS.cSeparacion
    ENDFUNC

    **/
    * Devuelve los d�as o los meses para el primer vencimiento.
    *
    * @return integer
    */
    FUNCTION ObtenerPrimero
        RETURN THIS.nPrimero
    ENDFUNC

    **/
    * Devuelve los d�as o los meses para el resto de los vencimientos.
    *
    * @return integer
    */
    FUNCTION ObtenerResto
        RETURN THIS.nResto
    ENDFUNC

    **/
    * Establece el n�mero de vencimientos.
    *
    * @param integer tnNumVtos
    * N�mero de vencimientos.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerNumVtos
        LPARAMETERS tnNumVtos
        THIS.nNumVtos = tnNumVtos
    ENDFUNC

    **/
    * Establece la separaci�n entre los vencimientos.
    *
    * @param string tcSeparacion
    * Separaci�n entre los vencimientos.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerSeparacion
        LPARAMETERS tcSeparacion
        THIS.cSeparacion = ALLTRIM(UPPER(tcSeparacion))

        IF THIS.cSeparacion != 'M' THEN
            THIS.cSeparacion = 'D'
        ENDIF
    ENDFUNC

    **/
    * Establece los d�as o los meses para el primer vencimiento.
    *
    * @param integer tnPrimero
    * D�as o meses para el primer vencimiento.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerPrimero
        LPARAMETERS tnPrimero
        THIS.nPrimero = tnPrimero
    ENDFUNC

    **/
    * Establece los d�as o los meses para el resto de los vencimientos.
    *
    * @param integer tnResto
    * D�as o meses para el resto de los vencimientos.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerResto
        LPARAMETERS tnResto
        THIS.nResto = tnResto
    ENDFUNC

ENDDEFINE