#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Ruta AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'ConexionRutaFactory'
    cClaseRepositorio = 'RutaDAOFactory'

    **/
    * Crea el cursor que contendr� el resultado de la b�squeda.
    *
    * @return boolean true (default)
    */
    * @Override
    PROTECTED PROCEDURE CrearCursorResultado
        THIS.cResultado = THIS.oUtiles.CreaTemp()

        CREATE CURSOR (THIS.cResultado) ( ;
            codigo N(5), ;
            nombre C(50), ;
            sitios M(10) ;
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
                REPLACE codigo WITH toModelo.ObtenerCodigo(), ;
                        nombre WITH toModelo.ObtenerNombre(), ;
                        sitios WITH toModelo.ObtenerSitios()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

ENDDEFINE