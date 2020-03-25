#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Familia AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'FamiliaConexionFactory'
    cClaseModelo = 'FamiliaVO'
    cClaseRepositorio = 'FamiliaDAOFactory'
    cClaseValidador = 'FamiliaValidadorFactory'
    cModulo = 'familia'

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
            p1 N(6,2), ;
            p2 N(6,2), ;
            p3 N(6,2), ;
            p4 N(6,2), ;
            p5 N(6,2), ;
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
                        p1 WITH toModelo.ObtenerP1(), ;
                        p2 WITH toModelo.ObtenerP2(), ;
                        p3 WITH toModelo.ObtenerP3(), ;
                        p4 WITH toModelo.ObtenerP4(), ;
                        p5 WITH toModelo.ObtenerP5(), ;
                        vigente WITH toModelo.EstaVigente()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

ENDDEFINE