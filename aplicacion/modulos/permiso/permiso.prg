#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Permiso AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'PermisoConexionFactory'
    cClaseRepositorio = 'PermisoDAOFactory'

    **/
    * Verifica si un usuario puede acceder a un m�dulo.
    *
    * @param integer tnUsuario
    * C�digo del usuario.
    *
    * @param string tcModulo
    * Nombre del m�dulo.
    *
    * @return boolean
    * true si tiene permiso para acceder al m�dulo y false en caso contrario.
    */
    FUNCTION PuedeAcceder(tnUsuario AS Integer, tcModulo AS String) AS Logical ;
        HELPSTRING 'Verifica si un usuario puede acceder a un m�dulo.'

        * inicio { validaci�n de par�metros }
        IF !THIS.oUtiles.ValidarNumero(tnUsuario, 1, 9999) THEN
            RETURN .F.
        ENDIF

        IF !THIS.oUtiles.ValidarTexto(tcModulo, 5, 12) THEN
            RETURN .F.
        ENDIF
        * fin { validaci�n de par�metros }

        LOCAL llAcceder, lcCondicionFiltrado
        llAcceder = .F.
        lcCondicionFiltrado = 'usuario == ' + ALLTRIM(STR(tnUsuario)) + ;
            ' AND prgname == [' + tcModulo + ']'

        * Crea el cursor que contendr� el resultado de la b�squeda.
        THIS.CrearCursorResultado()

        * Realiza la b�squeda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.oRepositorio.ObtenerTodos(THIS.cResultado, lcCondicionFiltrado)

            IF RECCOUNT(THIS.cResultado) > 0 THEN
                SELECT (THIS.cResultado)
                GOTO TOP
                llAcceder = acceder
            ENDIF
        ENDIF

        * Cierra el cursor que contiene el resultado de la b�squeda.
        USE IN (THIS.cResultado)

        * Devuelve el resultado.
        RETURN llAcceder
    ENDFUNC

    **/
    * Verifica si un usuario puede agregar registros.
    *
    * @param integer tnUsuario
    * C�digo del usuario.
    *
    * @param string tcModulo
    * Nombre del m�dulo.
    *
    * @return boolean
    * true si tiene permiso para agregar registros y false en caso contrario.
    */
    FUNCTION PuedeAgregar(tnUsuario AS Integer, tcModulo AS String) AS Logical ;
        HELPSTRING 'Verifica si un usuario puede agregar registros.'

        * inicio { validaci�n de par�metros }
        IF !THIS.oUtiles.ValidarNumero(tnUsuario, 1, 9999) THEN
            RETURN .F.
        ENDIF

        IF !THIS.oUtiles.ValidarTexto(tcModulo, 5, 12) THEN
            RETURN .F.
        ENDIF
        * fin { validaci�n de par�metros }

        LOCAL llAgregar, lcCondicionFiltrado
        llAgregar = .F.
        lcCondicionFiltrado = 'usuario == ' + ALLTRIM(STR(tnUsuario)) + ;
            ' AND prgname == [' + tcModulo + ']'

        * Crea el cursor que contendr� el resultado de la b�squeda.
        THIS.CrearCursorResultado()

        * Realiza la b�squeda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.oRepositorio.ObtenerTodos(THIS.cResultado, lcCondicionFiltrado)

            IF RECCOUNT(THIS.cResultado) > 0 THEN
                SELECT (THIS.cResultado)
                GOTO TOP
                llAgregar = agregar
            ENDIF
        ENDIF

        * Cierra el cursor que contiene el resultado de la b�squeda.
        USE IN (THIS.cResultado)

        * Devuelve el resultado.
        RETURN llAgregar
    ENDFUNC

    **/
    * Verifica si un usuario puede modificar registros.
    *
    * @param integer tnUsuario
    * C�digo del usuario.
    *
    * @param string tcModulo
    * Nombre del m�dulo.
    *
    * @return boolean
    * true si tiene permiso para modificar registros y false en caso contrario.
    */
    FUNCTION PuedeModificar(tnUsuario AS Integer, tcModulo AS String) AS Logical ;
        HELPSTRING 'Verifica si un usuario puede modificar registros.'

        * inicio { validaci�n de par�metros }
        IF !THIS.oUtiles.ValidarNumero(tnUsuario, 1, 9999) THEN
            RETURN .F.
        ENDIF

        IF !THIS.oUtiles.ValidarTexto(tcModulo, 5, 12) THEN
            RETURN .F.
        ENDIF
        * fin { validaci�n de par�metros }

        LOCAL llModificar, lcCondicionFiltrado
        llModificar = .F.
        lcCondicionFiltrado = 'usuario == ' + ALLTRIM(STR(tnUsuario)) + ;
            ' AND prgname == [' + tcModulo + ']'

        * Crea el cursor que contendr� el resultado de la b�squeda.
        THIS.CrearCursorResultado()

        * Realiza la b�squeda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.oRepositorio.ObtenerTodos(THIS.cResultado, lcCondicionFiltrado)

            IF RECCOUNT(THIS.cResultado) > 0 THEN
                SELECT (THIS.cResultado)
                GOTO TOP
                llModificar = modificar
            ENDIF
        ENDIF

        * Cierra el cursor que contiene el resultado de la b�squeda.
        USE IN (THIS.cResultado)

        * Devuelve el resultado.
        RETURN llModificar
    ENDFUNC

    **/
    * Verifica si un usuario puede borrar registros.
    *
    * @param integer tnUsuario
    * C�digo del usuario.
    *
    * @param string tcModulo
    * Nombre del m�dulo.
    *
    * @return boolean
    * true si tiene permiso para borrar registros y false en caso contrario.
    */
    FUNCTION PuedeBorrar(tnUsuario AS Integer, tcModulo AS String) AS Logical ;
        HELPSTRING 'Verifica si un usuario puede borrar registros.'

        * inicio { validaci�n de par�metros }
        IF !THIS.oUtiles.ValidarNumero(tnUsuario, 1, 9999) THEN
            RETURN .F.
        ENDIF

        IF !THIS.oUtiles.ValidarTexto(tcModulo, 5, 12) THEN
            RETURN .F.
        ENDIF
        * fin { validaci�n de par�metros }

        LOCAL llBorrar, lcCondicionFiltrado
        llBorrar = .F.
        lcCondicionFiltrado = 'usuario == ' + ALLTRIM(STR(tnUsuario)) + ;
            ' AND prgname == [' + tcModulo + ']'

        * Crea el cursor que contendr� el resultado de la b�squeda.
        THIS.CrearCursorResultado()

        * Realiza la b�squeda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.oRepositorio.ObtenerTodos(THIS.cResultado, lcCondicionFiltrado)

            IF RECCOUNT(THIS.cResultado) > 0 THEN
                SELECT (THIS.cResultado)
                GOTO TOP
                llBorrar = borrar
            ENDIF
        ENDIF

        * Cierra el cursor que contiene el resultado de la b�squeda.
        USE IN (THIS.cResultado)

        * Devuelve el resultado.
        RETURN llBorrar
    ENDFUNC

    **/
    * Verifica si un usuario puede imprimir registros.
    *
    * @param integer tnUsuario
    * C�digo del usuario.
    *
    * @param string tcModulo
    * Nombre del m�dulo.
    *
    * @return boolean
    * true si tiene permiso para imprimir registros y false en caso contrario.
    */
    FUNCTION PuedeImprimir(tnUsuario AS Integer, tcModulo AS String) AS Logical ;
        HELPSTRING 'Verifica si un usuario puede imprimir registros.'

        * inicio { validaci�n de par�metros }
        IF !THIS.oUtiles.ValidarNumero(tnUsuario, 1, 9999) THEN
            RETURN .F.
        ENDIF

        IF !THIS.oUtiles.ValidarTexto(tcModulo, 5, 12) THEN
            RETURN .F.
        ENDIF
        * fin { validaci�n de par�metros }

        LOCAL llImprimir, lcCondicionFiltrado
        llImprimir = .F.
        lcCondicionFiltrado = 'usuario == ' + ALLTRIM(STR(tnUsuario)) + ;
            ' AND prgname == [' + tcModulo + ']'

        * Crea el cursor que contendr� el resultado de la b�squeda.
        THIS.CrearCursorResultado()

        * Realiza la b�squeda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.oRepositorio.ObtenerTodos(THIS.cResultado, lcCondicionFiltrado)

            IF RECCOUNT(THIS.cResultado) > 0 THEN
                SELECT (THIS.cResultado)
                GOTO TOP
                llImprimir = imprimir
            ENDIF
        ENDIF

        * Cierra el cursor que contiene el resultado de la b�squeda.
        USE IN (THIS.cResultado)

        * Devuelve el resultado.
        RETURN llImprimir
    ENDFUNC

    **/
    * Crea el cursor que contendr� el resultado de la b�squeda.
    *
    * @return boolean true (default)
    */
    * @Override
    PROTECTED PROCEDURE CrearCursorResultado
        THIS.cResultado = THIS.oUtiles.CreaTemp()

        CREATE CURSOR (THIS.cResultado) ( ;
            usuario N(4), ;
            modulo C(12), ;
            acceder L(1), ;
            agregar L(1), ;
            modificar L(1), ;
            borrar L(1), ;
            imprimir L(1) ;
        )
    ENDPROC

    **/
    * Carga los datos de un objeto (value object) al cursor de resultado de la
    * b�squeda.
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
                REPLACE usuario WITH toModelo.ObtenerUsuario(), ;
                        modulo WITH toModelo.ObtenerModulo(), ;
                        acceder WITH toModelo.PuedeAcceder(), ;
                        agregar WITH toModelo.PuedeAgregar(), ;
                        modificar WITH toModelo.PuedeModificar(), ;
                        borrar WITH toModelo.PuedeBorrar(), ;
                        imprimir WITH toModelo.PuedeImprimir()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

ENDDEFINE