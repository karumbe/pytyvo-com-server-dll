#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Depar AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'DeparConexionFactory'
    cClaseModelo = 'DeparVO'
    cClaseRepositorio = 'DeparDAOFactory'
    cClaseValidador = 'DeparValidadorFactory'
    cModulo = 'depar'

ENDDEFINE
