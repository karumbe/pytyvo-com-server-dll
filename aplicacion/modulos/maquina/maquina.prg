#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Maquina AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'MaquinaConexionFactory'
    cClaseModelo = 'MaquinaVO'
    cClaseRepositorio = 'MaquinaDAOFactory'
    cClaseValidador = 'MaquinaValidadorFactory'
    cModulo = 'maquina'

ENDDEFINE