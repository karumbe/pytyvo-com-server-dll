#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Maquina AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'MaquinaConexionFactory'
    cClaseModelo = 'MaquinaVO'
    cClaseRepositorio = 'MaquinaDAOFactory'
    cClaseValidador = 'MaquinaValidadorFactory'
    cModulo = 'maquina'

ENDDEFINE