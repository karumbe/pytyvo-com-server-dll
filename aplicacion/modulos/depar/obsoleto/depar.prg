#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Depar AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'ConexionDeparFactory'
    cClaseRepositorio = 'DeparDAOFactory'

    **/
    * Crea el cursor que contendr� el resultado de la b�squeda.
    *
    * @return boolean true (default)
    */
    * @Override
    PROTECTED PROCEDURE CrearCursorResultado
        THIS.cResultado = THIS.oUtiles.CreaTemp()

        CREATE CURSOR (THIS.cResultado) ( ;
            codigo N(3), ;
            nombre C(30), ;
            vigente L(1) ;
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
        LPARAMETERS toCiudad

        LOCAL loExcepcion

        IF VARTYPE(toCiudad) == 'O' THEN
            TRY
                SELECT (THIS.cResultado)
                APPEND BLANK
                REPLACE codigo WITH toCiudad.ObtenerCodigo(), ;
                        nombre WITH toCiudad.ObtenerNombre(), ;
                        vigente WITH toCiudad.EstaVigente()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

ENDDEFINE