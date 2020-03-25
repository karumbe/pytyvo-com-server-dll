DEFINE CLASS VOBase AS CUSTOM    && Value Objects pattern.

    * Propiedades.
    PROTECTED nCodigo
    PROTECTED cNombre
    PROTECTED lVigente

    **/
    * Constructor.
    *
    * @param integer tnCodigo
    * Código del registro.
    *
    * @param string tcNombre
    * Nombre del registro.
    *
    * @param boolean tlVigente
    * Vigencia del registro.
    *
    * @return boolean true (default)
    * true si puede crear la instancia y false en caso contrario.
    */
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tlVigente

        IF PARAMETERS() != 3 THEN
            tnCodigo = 0
            tcNombre = ''
            tlVigente = .F.
        ENDIF

        WITH THIS
            .EstablecerCodigo(tnCodigo)
            .EstablecerNombre(tcNombre)
            .EstablecerVigente(tlVigente)
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el código del registro.
    *
    * @return integer
    */
    FUNCTION ObtenerCodigo
        RETURN THIS.nCodigo
    ENDFUNC

    **/
    * Devuelve el nombre del registro.
    *
    * @return string
    */
    FUNCTION ObtenerNombre
        RETURN THIS.cNombre
    ENDFUNC

    **/
    * Devuelve la vigencia del registro.
    *
    * @return boolean
    */
    FUNCTION EstaVigente
        RETURN THIS.lVigente
    ENDFUNC

    **/
    * Establece el código del registro.
    *
    * @param integer tnCodigo
    * Código del registro.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerCodigo
        LPARAMETERS tnCodigo
        THIS.nCodigo = tnCodigo
    ENDFUNC

    **/
    * Establece el nombre del registro.
    *
    * @param string tcNombre
    * Nombre del registro.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerNombre
        LPARAMETERS tcNombre
        THIS.cNombre = ALLTRIM(UPPER(tcNombre))
    ENDFUNC

    **/
    * Establece la vigencia del registro.
    *
    * @param boolean tlVigente
    * Vigencia del registro.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerVigente
        LPARAMETERS tlVigente
        THIS.lVigente = tlVigente
    ENDFUNC

ENDDEFINE