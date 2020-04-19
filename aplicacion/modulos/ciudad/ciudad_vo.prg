DEFINE CLASS CiudadVO AS VOBase
    * Propiedades.
    PROTECTED nDepartamen
    PROTECTED cNombreCompleto

    **/
    * Constructor.
    *
    * @param integer tnCodigo
    * Código de la ciudad.
    *
    * @param string tcNombre
    * Nombre de la ciudad.
    *
    * @param integer tnDepartamen
    * Código de departamento.
    *
    * @param boolean tlVigente
    * Vigencia de la ciudad.
    *
    * @return boolean
    * true si puede crear la instancia y false en caso contrario.
    */
    * @Override
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamen, tlVigente, ;
            tcNombreCompleto

        IF PARAMETERS() != 5 THEN
            IF !VOBase::Init() THEN
                RETURN .F.
            ENDIF

            tnDepartamen = 0
            tcNombreCompleto = ''
        ELSE
            IF !VOBase::Init(tnCodigo, tcNombre, tlVigente) THEN
                RETURN .F.
            ENDIF
        ENDIF

        WITH THIS
            .EstablecerDepartamen(tnDepartamen)
            .EstablecerNombreCompleto(tcNombreCompleto)
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el código de departamento.
    *
    * @return integer
    */
    FUNCTION ObtenerDepartamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **/
    * Devuelve el nombre completo de la ciudad.
    *
    * @return string
    */
    FUNCTION ObtenerNombreCompleto
        RETURN THIS.cNombreCompleto
    ENDFUNC

    **/
    * Establece el código de departamento.
    *
    * @param integer tnDepartamen
    * Código de departamento.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDepartamen
        LPARAMETERS tnDepartamen
        THIS.nDepartamen = tnDepartamen
    ENDFUNC

    **/
    * Establece el nombre completo de la ciudad.
    *
    * @param string tcNombreCompleto
    * Nombre completo de la ciudad.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerNombreCompleto
        LPARAMETERS tcNombreCompleto
        THIS.cNombreCompleto = ALLTRIM(UPPER(tcNombreCompleto))
    ENDFUNC

ENDDEFINE
