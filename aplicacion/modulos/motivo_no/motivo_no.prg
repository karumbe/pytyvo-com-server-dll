#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS MotivoNo AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'MotivoNoConexionFactory'
    cClaseModelo = 'MotivoNoVO'
    cClaseRepositorio = 'MotivoNoDAOFactory'
    cClaseValidador = 'MotivoNoValidadorFactory'
    cModulo = 'motivo_no'

ENDDEFINE
