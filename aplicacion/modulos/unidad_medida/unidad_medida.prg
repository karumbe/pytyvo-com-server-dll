#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS UnidadMedida AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'UnidadMedidaConexionFactory'
    cClaseModelo = 'UnidadMedidaVO'
    cClaseRepositorio = 'UnidadMedidaDAOFactory'
    cClaseValidador = 'UnidadMedidaValidadorFactory'
    cModulo = 'unidad'

    **/
    * Verifica si un símbolo existe.
    *
    * @param string tcSimbolo
    * Símbolo a ser verificado.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    FUNCTION SimboloExiste(tcSimbolo AS String) AS Logical ;
        HELPSTRING 'Devuelve true si existe el símbolo u ocurre un error, false en caso contrario.'

        LOCAL llExiste
        llExiste = .T.

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            llExiste = THIS.oRepositorio.SimboloExiste(tcSimbolo)
        ENDIF

        * Devuelve el resultado.
        RETURN llExiste
    ENDFUNC

    **/
    * Realiza una búsqueda por símbolo.
    *
    * @param string tcSimbolo
    * Símbolo a buscar.
    *
    * @return string
    * Cadena XML con los datos de un registro.
    */
    FUNCTION ObtenerPorSimbolo(tcSimbolo AS String) AS String ;
        HELPSTRING 'Devuelve una cadena XML con los datos de un registro.'

        LOCAL lcXML

        * Crea el cursor que contendrá el resultado de la búsqueda.
        THIS.CrearCursorResultado()

        * Realiza la búsqueda.
        IF THIS.EstablecerConexion('BUSQUEDA') AND ;
                THIS.EstablecerRepositorio() THEN
            THIS.CargarObjetoAlCursorResultado( ;
                THIS.oRepositorio.ObtenerPorSimbolo(tcSimbolo))
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
            simbolo C(5), ;
            divisible L(1), ;
            vigente L(1) ;
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
                        simbolo WITH toModelo.ObtenerSimbolo(), ;
                        divisible WITH toModelo.EsDivisible(), ;
                        vigente WITH toModelo.EstaVigente()
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
            WITH toDTO
                .EstablecerNombre(loModelo.ObtenerNombre())
                .EstablecerSimbolo(loModelo.ObtenerSimbolo())
                .EstablecerDivisible(loModelo.EsDivisible())
            ENDWITH
        ENDIF

        RETURN toDTO
    ENDFUNC

ENDDEFINE