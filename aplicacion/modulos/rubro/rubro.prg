#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Rubro AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'RubroConexionFactory'
    cClaseModelo = 'RubroVO'
    cClaseRepositorio = 'RubroDAOFactory'
    cClaseValidador = 'RubroValidadorFactory'
    cModulo = 'rubro'

ENDDEFINE