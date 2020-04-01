DEFINE CLASS FamiliaVO AS VOBase

    * Propiedades.
    PROTECTED nP1
    PROTECTED nP2
    PROTECTED nP3
    PROTECTED nP4
    PROTECTED nP5

    **/
    * Constructor.
    *
    * @param integer tnCodigo
    * Código del registro.
    *
    * @param string tcNombre
    * Nombre del registro.
    *
    * @param decimal tnP1
    * Porcentaje para la lista 1.
    *
    * @param decimal tnP2
    * Porcentaje para la lista 2.
    *
    * @param decimal tnP3
    * Porcentaje para la lista 3.
    *
    * @param decimal tnP4
    * Porcentaje para la lista 4.
    *
    * @param decimal tnP5
    * Porcentaje para la lista 5.
    *
    * @param boolean tlVigente
    * Vigencia del registro.
    *
    * @return boolean true (default)
    * true si puede crear la instancia y false en caso contrario.
    */
    * @Override
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tnP1, tnP2, tnP3, tnP4, tnP5, tlVigente

        IF PARAMETERS() == 8 THEN
            IF !VOBase::Init(tnCodigo, tcNombre, tlVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            IF !VOBase::Init() THEN
                RETURN .F.
            ENDIF

            STORE 0 TO tnP1, tnP2, tnP3, tnP4, tnP5
        ENDIF

        WITH THIS
            .EstablecerP1(tnP1)
            .EstablecerP2(tnP2)
            .EstablecerP3(tnP3)
            .EstablecerP4(tnP4)
            .EstablecerP5(tnP5)
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el porcentaje para la lista 1.
    *
    * @return decimal
    */
    FUNCTION ObtenerP1
        RETURN THIS.nP1
    ENDFUNC

    **/
    * Devuelve el porcentaje para la lista 2.
    *
    * @return decimal
    */
    FUNCTION ObtenerP2
        RETURN THIS.nP2
    ENDFUNC

    **/
    * Devuelve el porcentaje para la lista 3.
    *
    * @return decimal
    */
    FUNCTION ObtenerP3
        RETURN THIS.nP3
    ENDFUNC

    **/
    * Devuelve el porcentaje para la lista 4.
    *
    * @return decimal
    */
    FUNCTION ObtenerP4
        RETURN THIS.nP4
    ENDFUNC

    **/
    * Devuelve el porcentaje para la lista 5.
    *
    * @return decimal
    */
    FUNCTION ObtenerP5
        RETURN THIS.nP5
    ENDFUNC

    **/
    * Establece el porcentaje para la lista 1.
    *
    * @param decimal tnP1
    * Porcentaje para la lista 1.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerP1
        LPARAMETERS tnP1
        THIS.nP1 = tnP1
    ENDFUNC

    **/
    * Establece el porcentaje para la lista 2.
    *
    * @param decimal tnP2
    * Porcentaje para la lista 2.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerP2
        LPARAMETERS tnP2
        THIS.nP2 = tnP2
    ENDFUNC

    **/
    * Establece el porcentaje para la lista 3.
    *
    * @param decimal tnP3
    * Porcentaje para la lista 3.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerP3
        LPARAMETERS tnP3
        THIS.nP3 = tnP3
    ENDFUNC

    **/
    * Establece el porcentaje para la lista 4.
    *
    * @param decimal tnP4
    * Porcentaje para la lista 4.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerP4
        LPARAMETERS tnP4
        THIS.nP4 = tnP4
    ENDFUNC

    **/
    * Establece el porcentaje para la lista 5.
    *
    * @param decimal tnP5
    * Porcentaje para la lista 5.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerP5
        LPARAMETERS tnP5
        THIS.nP5 = tnP5
    ENDFUNC

ENDDEFINE
