#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Modelo AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'ModeloConexionFactory'
    cClaseModelo = 'ModeloVO'
    cClaseRepositorio = 'ModeloDAOFactory'
    cClaseValidador = 'ModeloValidadorFactory'
    cModulo = 'modelo'

    **/
    * Devuelve el nombre completo de un modelo.
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
            maquina N(3), ;
            marca N(4), ;
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
                        maquina WITH toModelo.ObtenerMaquina(), ;
                        marca WITH toModelo.ObtenerMarca(), ;
                        vigente WITH toModelo.EstaVigente()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

ENDDEFINE
