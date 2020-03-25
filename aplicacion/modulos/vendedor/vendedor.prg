#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Vendedor AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'ConexionVendedorFactory'
    cClaseRepositorio = 'VendedorDAOFactory'

    **/
    * Crea el cursor que contendrá el resultado de la búsqueda.
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

ENDDEFINE