#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS MotivoClie AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'MotivoClieConexionFactory'
    cClaseModelo = 'MotivoClieVO'
    cClaseRepositorio = 'MotivoClieDAOFactory'
    cClaseValidador = 'MotivoClieValidadorFactory'
    cModulo = 'motivo_clie'

ENDDEFINE