DEFINE CLASS MonedaVO AS VOBase

    * Propiedades.
    PROTECTED cSimbolo
    PROTECTED lDecimales

    **/
    * Constructor.
    *
    * @param integer tnCodigo
    * Código del registro.
    *
    * @param string tcNombre
    * Nombre del registro.
    *
    * @param string tcSimbolo
    * Símbolo de la moneda.
    *
    * @param boolean tlDecimales
    * Decimales de la moneda.
    *
    * @param boolean tlVigente
    * Vigencia del registro.
    *
    * @return boolean true (default)
    * true si puede crear la instancia y false en caso contrario.
    */
    * @Override
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tcSimbolo, tlDecimales, tlVigente

        IF PARAMETERS() == 5 THEN
            IF !VOBase::Init(tnCodigo, tcNombre, tlVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            IF !VOBase::Init() THEN
                RETURN .F.
            ENDIF

            tcSimbolo = ''
            tlDecimales = .F.
        ENDIF

        WITH THIS
            .EstablecerSimbolo(tcSimbolo)
            .EstablecerDecimales(tlDecimales)
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el símbolo de la moneda.
    *
    * @return string
    */
    FUNCTION ObtenerSimbolo
        RETURN THIS.cSimbolo
    ENDFUNC

    **/
    * Devuelve si la moneda utiliza decimales.
    *
    * @return boolean
    */
    FUNCTION UtilizaDecimales
        RETURN THIS.lDecimales
    ENDFUNC

    **/
    * Establece el símbolo de la moneda.
    *
    * @param string tcSimbolo
    * Símbolo de la moneda.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerSimbolo
        LPARAMETERS tcSimbolo
        THIS.cSimbolo = ALLTRIM(tcSimbolo)
    ENDFUNC

    **/
    * Establece si la moneda utiliza decimales.
    *
    * @param boolean tlDecimales
    * Divisibilidad de la moneda.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDecimales
        LPARAMETERS tlDecimales
        THIS.lDecimales = tlDecimales
    ENDFUNC

ENDDEFINE
