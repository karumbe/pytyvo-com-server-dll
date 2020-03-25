#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Plazo AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'ConexionPlazoFactory'
    cClaseRepositorio = 'PlazoDAOFactory'

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
            nombre C(40), ;
            num_vtos N(5), ;
            separacion C(1), ;
            primero N(5), ;
            resto N(5) ;
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
                        num_vtos WITH toModelo.ObtenerNumVtos(), ;
                        separacion WITH toModelo.ObtenerSeparacion(), ;
                        primero WITH toModelo.ObtenerPrimero(), ;
                        resto WITH toModelo.ObtenerResto()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

ENDDEFINE