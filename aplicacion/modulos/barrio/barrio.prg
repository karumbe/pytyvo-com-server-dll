#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Barrio AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'BarrioConexionFactory'
    cClaseModelo = 'BarrioVO'
    cClaseRepositorio = 'BarrioDAOFactory'
    cClaseValidador = 'BarrioValidadorFactory'
    cModulo = 'barrio'

    **/
    * Devuelve el nombre completo de un barrio.
    *
    * @param integer tnCodigo
    * Código a buscar.
    *
    * @return string
    */
    FUNCTION ObtenerNombreCompleto(tnCodigo AS Integer) AS String ;
        HELPSTRING 'Devuelve el nombre completo de un modelo.'

        LOCAL lcNombreCompleto
        lcNombreCompleto = ''

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            lcNombreCompleto = THIS.oRepositorio.ObtenerNombreCompleto(tnCodigo)

            * Devuelve una cadena de caracteres vacía si ocurre un error.
            IF VARTYPE(lcNombreCompleto) != 'C' THEN
                lcNombreCompleto = ''
            ENDIF
        ENDIF

        * Devuelve el resultado.
        RETURN lcNombreCompleto
    ENDFUNC

    **/
    * Verifica si un nombre existe.
    *
    * @param string tcNombre
    * Nombre a ser verificado.
    *
    * @param integer tnDepartamen
    * Código de departamento a ser verificado.
    *
    * @param integer tnCiudad
    * Código de ciudad a ser verificado.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    * @Override
    FUNCTION NombreExiste(tcNombre AS String, ;
            tnDepartamen AS Integer, tnCiudad AS Integer) AS Logical ;
        HELPSTRING 'Devuelve true si existe el nombre u ocurre un error, false en caso contrario.'

        LOCAL llExiste
        llExiste = .T.

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            llExiste = THIS.oRepositorio.NombreExiste( ;
                tcNombre, ;
                tnDepartamen, ;
                tnCiudad ;
            )
        ENDIF

        * Devuelve el resultado.
        RETURN llExiste
    ENDFUNC

    **/
    * Realiza una búsqueda por nombre.
    *
    * @param string tcNombre
    * Nombre a buscar.
    *
    * @param integer tnDepartamen
    * Código de departamento a buscar.
    *
    * @param integer tnCiudad
    * Código de ciudad a buscar.
    *
    * @return string
    * Cadena XML con los datos de un registro.
    */
    * @Override
    FUNCTION ObtenerPorNombre(tcNombre AS String, ;
            tnDepartamen AS Integer, tnCiudad AS Integer) AS Logical ;
        HELPSTRING 'Devuelve una cadena XML con los datos de un registro.'

        LOCAL lcXML

        * Crea el cursor que contendrá el resultado de la búsqueda.
        THIS.CrearCursorResultado()

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.CargarObjetoAlCursorResultado( ;
                THIS.oRepositorio.ObtenerPorNombre( ;
                    tcNombre, ;
                    tnDepartamen, ;
                    tnCiudad ;
                ) ;
            )
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
            codigo N(5), ;
            nombre C(30), ;
            departamen N(3), ;
            ciudad N(5), ;
            vigente L(1), ;
            nombre_completo C(40) ;
        )
    ENDPROC

    **/
    * Carga los datos de un objeto (value object) al cursor de resultado de la
    * búsqueda.
    *
    * @return boolean true (default)
    */
    PROTECTED PROCEDURE CargarObjetoAlCursorResultado
        LPARAMETERS toModelo

        LOCAL loExcepcion

        IF VARTYPE(toModelo) == 'O' THEN
            TRY
                SELECT (THIS.cResultado)
                APPEND BLANK
                REPLACE codigo WITH toModelo.ObtenerCodigo(), ;
                        nombre WITH toModelo.ObtenerNombre(), ;
                        departamen WITH toModelo.ObtenerDepartamen(), ;
                        ciudad WITH toModelo.ObtenerCiudad(), ;
                        vigente WITH toModelo.EstaVigente(), ;
                        nombre_completo WITH toModelo.ObtenerNombreCompleto()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

    **/
    * Verifica que los campos que no deben modificarse permanezcan así.
    *
    * @param object toDTO
    * Objeto a ser verificado.
    *
    * @return object
    * Objeto de transferencia de datos (DTO).
    */
    * @Override
    PROTECTED FUNCTION VerificarDTO
        LPARAMETERS toDTO

        LOCAL llEstaRelacionado, loModelo
        llEstaRelacionado = THIS.EstaRelacionado(toDto.ObtenerCodigo())

        IF llEstaRelacionado THEN
            * Realiza la búsqueda.
            IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                    THIS.EstablecerRepositorio() THEN
                loModelo = ;
                    THIS.oRepositorio.ObtenerPorCodigo(toDto.ObtenerCodigo())
            ENDIF
        ENDIF

        IF VARTYPE(loModelo) == 'O' THEN
            toDTO.EstablecerNombre(loModelo.ObtenerNombre())
            toDTO.EstablecerDepartamen(loModelo.ObtenerDepartamen())
            toDTO.EstablecerCiudad(loModelo.ObtenerCiudad())
        ENDIF

        RETURN toDTO
    ENDFUNC

ENDDEFINE
