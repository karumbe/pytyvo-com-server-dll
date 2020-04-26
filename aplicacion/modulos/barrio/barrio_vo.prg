DEFINE CLASS BarrioVO AS VOBase
    * Propiedades.
    PROTECTED nDepartamen
    PROTECTED nCiudad
    PROTECTED cNombreCompleto

    **/
    * Constructor.
    *
    * @param integer tnCodigo
    * Código de barrio.
    *
    * @param string tcNombre
    * Nombre del barrio.
    *
    * @param integer tnDepartamen
    * Código de departamento.
    *
    * @param integer tnCiudad
    * Código de ciudad.
    *
    * @param boolean tlVigente
    * Vigencia del barrio.
    *
    * @return boolean
    * true si puede crear la instancia y false en caso contrario.
    */
    * @Override
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnDepartamen, tnCiudad, tlVigente, ;
            tcNombreCompleto

        IF PARAMETERS() != 6 THEN
            IF !VOBase::Init() THEN
                RETURN .F.
            ENDIF

            STORE 0 TO tnDepartamen, tnCiudad
            tcNombreCompleto = ''
        ELSE
            IF !VOBase::Init(tnCodigo, tcNombre, tlVigente) THEN
                RETURN .F.
            ENDIF
        ENDIF

        WITH THIS
            .EstablecerDepartamen(tnDepartamen)
            .EstablecerCiudad(tnCiudad)
            .EstablecerNombreCompleto(tcNombreCompleto)
        ENDWITH
    ENDFUNC

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
    * Devuelve el nombre completo del barrio.
    *
    * @return string
    */
    FUNCTION ObtenerNombreCompleto
        RETURN THIS.cNombreCompleto
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

    **/
    * Establece el nombre completo del barrio.
    *
    * @param string tcNombreCompleto
    * Nombre completo del barrio.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerNombreCompleto
        LPARAMETERS tcNombreCompleto
        THIS.cNombreCompleto = ALLTRIM(UPPER(tcNombreCompleto))
    ENDFUNC

ENDDEFINE
