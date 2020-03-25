DEFINE CLASS PermisoVO AS CUSTOM    && Value Objects pattern.

    * Propiedades.
    PROTECTED nUsuario
    PROTECTED cModulo
    PROTECTED lAcceder
    PROTECTED lAgregar
    PROTECTED lModificar
    PROTECTED lBorrar
    PROTECTED lImprimir

    **/
    * Constructor.
    *
    * @param integer tnUsuario
    * Código del usuario.
    *
    * @param string tcModulo
    * Nombre del módulo.
    *
    * @param boolean tlAcceder
    * Permiso para acceder.
	*
    * @param boolean tlAgregar
    * Permiso para agregar.
	*
    * @param boolean tlModificar
    * Permiso para modificar.
	*
    * @param boolean tlBorrar
    * Permiso para borrar.
	*
    * @param boolean tlImprimir
    * Permiso para imprimir.
	*
    * @return boolean true (default)
    */
    PROCEDURE Init
        LPARAMETERS tnUsuario, tcModulo, tlAcceder, tlAgregar, tlModificar, ;
			tlBorrar, tlImprimir

        IF PARAMETERS() != 7 THEN
            tnUsuario = 0
            tcModulo = ''
            tlAcceder = .F.
            tlAgregar = .F.
            tlModificar = .F.
            tlBorrar = .F.
            tlImprimir = .F.
        ENDIF

        WITH THIS
            .EstablecerUsuario(tnUsuario)
            .EstablecerModulo(tcModulo)
            .EstablecerAcceder(tlAcceder)
            .EstablecerAgregar(tlAgregar)
            .EstablecerModificar(tlModificar)
            .EstablecerBorrar(tlBorrar)
            .EstablecerImprimir(tlImprimir)
        ENDWITH
    ENDPROC

    **/
    * Devuelve el código del usuario.
    *
    * @return integer
    */
    FUNCTION ObtenerUsuario
        RETURN THIS.nUsuario
    ENDFUNC

    **/
    * Devuelve el nombre del módulo.
    *
    * @return string
    */
    FUNCTION ObtenerModulo
        RETURN THIS.cModulo
    ENDFUNC

    **/
    * Devuelve el permiso para acceder.
    *
    * @return boolean
    */
    FUNCTION PuedeAcceder
        RETURN THIS.lAcceder
    ENDFUNC

    **/
    * Devuelve el permiso para agregar.
    *
    * @return boolean
    */
    FUNCTION PuedeAgregar
        RETURN THIS.lAgregar
    ENDFUNC

    **/
    * Devuelve el permiso para modificar.
    *
    * @return boolean
    */
    FUNCTION PuedeModificar
        RETURN THIS.lModificar
    ENDFUNC

    **/
    * Devuelve el permiso para borrar.
    *
    * @return boolean
    */
    FUNCTION PuedeBorrar
        RETURN THIS.lBorrar
    ENDFUNC

    **/
    * Devuelve el permiso para imprimir.
    *
    * @return boolean
    */
    FUNCTION PuedeImprimir
        RETURN THIS.lImprimir
    ENDFUNC

    **/
    * Establece el código del usuario.
    *
    * @param integer tnUsuario
    * Código del usuario.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerUsuario
    	LPARAMETERS tnUsuario
    	THIS.nUsuario = tnUsuario
    ENDFUNC

    **/
    * Establece el nombre del módulo.
    *
    * @param string tcModulo
    * Nombre del módulo.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerModulo
        LPARAMETERS tcModulo
        THIS.cModulo = tcModulo
    ENDFUNC

    **/
    * Establece el permiso para acceder.
    *
    * @param boolean tlAcceder
    * Permiso para acceder.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerAcceder
        LPARAMETERS tlAcceder
        THIS.lAcceder = tlAcceder
    ENDFUNC

    **/
    * Establece el permiso para agregar.
    *
    * @param boolean tlAgregar
    * Permiso para agregar.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerAgregar
        LPARAMETERS tlAgregar
        THIS.lAgregar = tlAgregar
    ENDFUNC

    **/
    * Establece el permiso para modificar.
    *
    * @param boolean tlModificar
    * Permiso para modificar.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerModificar
        LPARAMETERS tlModificar
        THIS.lModificar = tlModificar
    ENDFUNC

    **/
    * Establece el permiso para borrar.
    *
    * @param boolean tlBorrar
    * Permiso para borrar.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerBorrar
        LPARAMETERS tlBorrar
        THIS.lBorrar = tlBorrar
    ENDFUNC

    **/
    * Establece el permiso para imprimir.
    *
    * @param boolean tlImprimir
    * Permiso para imprimir.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerImprimir
        LPARAMETERS tlImprimir
        THIS.lImprimir = tlImprimir
    ENDFUNC

ENDDEFINE