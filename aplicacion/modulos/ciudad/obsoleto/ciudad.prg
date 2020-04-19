#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Ciudad AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'ConexionCiudadFactory'
    cClaseRepositorio = 'CiudadDAOFactory'

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
                        departamen WITH toModelo.ObtenerDepartamen(), ;
                        vigente WITH toModelo.EstaVigente()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

ENDDEFINE