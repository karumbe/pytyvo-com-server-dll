#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Subrubro AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'SubrubroConexionFactory'
    cClaseModelo = 'SubrubroVO'
    cClaseRepositorio = 'SubrubroDAOFactory'
    cClaseValidador = 'SubrubroValidadorFactory'
    cModulo = 'subrubro'

ENDDEFINE