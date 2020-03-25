DEFINE CLASS PlazoVO AS VOBase

    * Propiedades.
    PROTECTED nNumVtos
    PROTECTED cSeparacion
    PROTECTED nPrimero
    PROTECTED nResto

    **/
    * Devuelve el número de vencimientos.
    *
    * @return integer
    */
    FUNCTION ObtenerNumVtos
        RETURN THIS.nNumVtos
    ENDFUNC

    **/
    * Devuelve la separación entre los vencimientos.
    *
    * @return string
    * 'M' para mes o 'D' para día (predeterminado).
    */
    FUNCTION ObtenerSeparacion
        RETURN THIS.cSeparacion
    ENDFUNC

    **/
    * Devuelve los días o los meses para el primer vencimiento.
    *
    * @return integer
    */
    FUNCTION ObtenerPrimero
        RETURN THIS.nPrimero
    ENDFUNC

    **/
    * Devuelve los días o los meses para el resto de los vencimientos.
    *
    * @return integer
    */
    FUNCTION ObtenerResto
        RETURN THIS.nResto
    ENDFUNC

    **/
    * Establece el número de vencimientos.
    *
    * @param integer tnNumVtos
    * Número de vencimientos.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerNumVtos
        LPARAMETERS tnNumVtos
        THIS.nNumVtos = tnNumVtos
    ENDFUNC

    **/
    * Establece la separación entre los vencimientos.
    *
    * @param string tcSeparacion
    * Separación entre los vencimientos.
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
    * Establece los días o los meses para el primer vencimiento.
    *
    * @param integer tnPrimero
    * Días o meses para el primer vencimiento.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerPrimero
        LPARAMETERS tnPrimero
        THIS.nPrimero = tnPrimero
    ENDFUNC

    **/
    * Establece los días o los meses para el resto de los vencimientos.
    *
    * @param integer tnResto
    * Días o meses para el resto de los vencimientos.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerResto
        LPARAMETERS tnResto
        THIS.nResto = tnResto
    ENDFUNC

ENDDEFINE