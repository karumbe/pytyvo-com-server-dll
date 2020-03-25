DEFINE CLASS UsuarioVO AS VOBase

    * Propiedades.
    PROTECTED cUsuario
    PROTECTED cClave

    **/
    * Constructor.
    *
    * @param integer tnCodigo
    * Código del usuario.
    *
    * @param string tcNombre
    * Nombre del usuario.
    *
    * @param string tcUsuario
    * Nombre de usuario.
    *
    * @param string tcClave
    * Clave de acceso.
    *
    * @param boolean tlVigente
    * Vigencia del usuario.
    *
    * @return boolean
    * true si puede crear la instancia y false en caso contrario.
    */
    * @Override
    FUNCTION Init
        LPARAMETERS tnCodigo, tcNombre, tcUsuario, tcClave, tlVigente

        IF PARAMETERS() == 5 THEN
            IF !VOBase::Init(tnCodigo, tcNombre, tlVigente) THEN
                RETURN .F.
            ENDIF
        ELSE
            STORE '' TO tcUsuario, tcClave

            IF !VOBase::Init() THEN
                RETURN .F.
            ENDIF
        ENDIF

        WITH THIS
            .EstablecerUsuario(tcUsuario)
            .EstablecerClave(tcClave)
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el nombre de usuario.
    *
    * @return string
    */
    FUNCTION ObtenerUsuario
        RETURN THIS.cUsuario
    ENDFUNC

    **/
    * Devuelve la clave de acceso.
    *
    * @return string
    */
    FUNCTION ObtenerClave
        RETURN THIS.cClave
    ENDFUNC

    **/
    * Establece el nombre de usuario.
    *
    * @param string tcUsuario
    * Nombre de usuario.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerUsuario
        LPARAMETERS tcUsuario
        THIS.cUsuario = tcUsuario
    ENDFUNC

    **/
    * Establece el clave de acceso.
    *
    * @param string tcClave
    * Clave de acceso.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerClave
        LPARAMETERS tcClave
        THIS.cClave = tcClave
    ENDFUNC

ENDDEFINE