#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Pais AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'PaisConexionFactory'
    cClaseModelo = 'PaisVO'
    cClaseRepositorio = 'PaisDAOFactory'
    cClaseValidador = 'PaisValidadorFactory'
    cModulo = 'pais'

ENDDEFINE
