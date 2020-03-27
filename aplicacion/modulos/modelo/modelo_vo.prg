DEFINE CLASS ModeloVO AS VOBase
    * Propiedades.
    PROTECTED nMaquina
    PROTECTED nMarca

    **/
    * Constructor.
    *
    * @param integer tnCodigo
    * C�digo del modelo.
    *
    * @param string tcNombre
    * Nombre del modelo.
    *
    * @param integer tnMaquina
    * C�digo de la m�quina.
    *
    * @param integer tnMarca
    * C�digo de la marca.
    *
    * @param boolean tlVigente
    * Vigencia del modelo.
    *
    * @return boolean
    * true si puede crear la instancia y false en caso contrario.
    */
    * @Override
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnMaquina, tnMarca, tlVigente

        IF PARAMETERS() != 5 THEN
            IF !VOBase::Init() THEN
                RETURN .F.
            ENDIF

            STORE 0 TO tnMaquina, tnMarca
        ELSE
            IF !VOBase::Init(tnCodigo, tcNombre, tlVigente) THEN
                RETURN .F.
            ENDIF
        ENDIF

        WITH THIS
            .EstablecerMaquina(tnMaquina)
            .EstablecerMarca(tnMarca)
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el c�digo de la m�quina.
    *
    * @return integer
    */
    FUNCTION ObtenerMaquina
        RETURN THIS.nMaquina
    ENDFUNC

    **/
    * Devuelve el c�digo de la marca.
    *
    * @return integer
    */
    FUNCTION ObtenerMarca
        RETURN THIS.nMarca
    ENDFUNC

    **/
    * Establece el c�digo de la m�quina.
    *
    * @param integer tnMaquina
    * C�digo de la m�quina.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerMaquina
        LPARAMETERS tnMaquina
        THIS.nMaquina = tnMaquina
    ENDFUNC

    **/
    * Establece el c�digo de la marca.
    *
    * @param integer tnMarca
    * C�digo de la marca.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerMarca
        LPARAMETERS tnMarca
        THIS.nMarca = tnMarca
    ENDFUNC

ENDDEFINE
