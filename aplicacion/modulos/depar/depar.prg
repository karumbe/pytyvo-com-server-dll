#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Depar AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'DeparConexionFactory'
    cClaseModelo = 'DeparVO'
    cClaseRepositorio = 'DeparDAOFactory'
    cClaseValidador = 'DeparValidadorFactory'
    cModulo = 'depar'

ENDDEFINE
