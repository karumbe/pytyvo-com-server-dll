DEFINE CLASS UnidadMedidaVO AS VOBase

    * Propiedades.
    PROTECTED cSimbolo
    PROTECTED lDivisible

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
    * Símbolo de la unidad de medida.
    *
    * @param boolean tlDivisible
    * Divisibilidad de la unidad de medida.
    *
    * @param boolean tlVigente
    * Vigencia del registro.
    *
    * @return boolean true (default)
    * true si puede crear la instancia y false en caso contrario.
    */
    * @Override
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tcSimbolo, tlDivisible, tlVigente

        IF PARAMETERS() == 5 THEN
            IF !VOBase::Init(tnCodigo, tcNombre, tlVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            IF !VOBase::Init() THEN
                RETURN .F.
            ENDIF

            tcSimbolo = ''
            tlDivisible = .F.
        ENDIF

        WITH THIS
            .EstablecerSimbolo(tcSimbolo)
            .EstablecerDivisible(tlDivisible)
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el símbolo de la unidad de medida.
    *
    * @return string
    */
    FUNCTION ObtenerSimbolo
        RETURN THIS.cSimbolo
    ENDFUNC

    **/
    * Devuelve la divisibilidad de la unidad de medida.
    *
    * @return boolean
    */
    FUNCTION EsDivisible
        RETURN THIS.lDivisible
    ENDFUNC

    **/
    * Establece el símbolo de la unidad de medida.
    *
    * @param string tcSimbolo
    * Símbolo de la unidad de medida.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerSimbolo
        LPARAMETERS tcSimbolo
        THIS.cSimbolo = ALLTRIM(UPPER(tcSimbolo))
    ENDFUNC

    **/
    * Establece la divisibilidad de la unidad de medida.
    *
    * @param boolean tlDivisible
    * Divisibilidad de la unidad de medida.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDivisible
        LPARAMETERS tlDivisible
        THIS.lDivisible = tlDivisible
    ENDFUNC

ENDDEFINE