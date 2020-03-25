#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Usuario AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'ConexionUsuarioFactory'
    cClaseRepositorio = 'UsuarioDAOFactory'

    **/
    * Verifica si un nombre de usuario existe.
    *
    * @param string tcUsuario
    * Nombre de usuario a ser verificado.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    FUNCTION UsuarioExiste(tcUsuario AS String) AS Logical ;
        HELPSTRING 'Verifica si un nombre de usuario existe.'

        * inicio { validación del parámetro }
        IF !THIS.oUtiles.ValidarTexto(tcUsuario, 5, 25) THEN
            RETURN .T.
        ENDIF
        * fin { validación del parámetro }

        LOCAL loUsuario

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            loUsuario = THIS.oRepositorio.ObtenerPorUsuario(tcUsuario)
        ENDIF

        * Devuelve el resultado.
        IF VARTYPE(loUsuario) == 'O' THEN
            RETURN .T.
        ELSE
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Realiza una búsqueda por nombre de usuario.
    *
    * @param string tcUsuario
    * Nombre de usuario a buscar.
    *
    * @return string
    * Cadena XML con los datos de un usuario.
    */
    FUNCTION ObtenerPorUsuario(tcUsuario AS String) AS String ;
        HELPSTRING 'Devuelve una cadena XML con los datos de un usuario.'

        LOCAL lcXML

        * Crea el cursor que contendrá el resultado de la búsqueda.
        THIS.CrearCursorResultado()

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.CargarObjetoAlCursorResultado( ;
                THIS.oRepositorio.ObtenerPorUsuario(tcUsuario))
        ENDIF

        * Convierte el cursor de resultado de la búsqueda en una cadena de
        * caracteres XML.
        CURSORTOXML(THIS.cResultado, 'lcXML', 0, 0, 0, '1')
        USE IN (THIS.cResultado)

        * Devuelve el resultado.
        RETURN lcXML
    ENDFUNC

    **/
    * Crea el cursor que contendrá el resultado de la búsqueda.
    *
    * @return boolean true (default)
    */
    * @Override
    PROTECTED PROCEDURE CrearCursorResultado
        THIS.cResultado = THIS.oUtiles.CreaTemp()

        CREATE CURSOR (THIS.cResultado) ( ;
            codigo N(4), ;
            nombre C(30), ;
            usuario C(25), ;
            clave C(15), ;
            vigente L(1) ;
        )
    ENDPROC

    **/
    * Carga los datos de un objeto (value object) al cursor de resultado de la
    * búsqueda.
    *
    * @return boolean true (default)
    */
    * @Override
    PROTECTED PROCEDURE CargarObjetoAlCursorResultado
        LPARAMETERS toModelo

        LOCAL loExcepcion

        IF VARTYPE(toModelo) == 'O' THEN
            TRY
                SELECT (THIS.cResultado)
                APPEND BLANK
                REPLACE codigo WITH toModelo.ObtenerCodigo(), ;
                        nombre WITH toModelo.ObtenerNombre(), ;
                        usuario WITH toModelo.ObtenerUsuario(), ;
                        clave WITH toModelo.ObtenerClave(), ;
                        vigente WITH toModelo.EstaVigente()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

ENDDEFINE