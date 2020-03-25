#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Marca AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'MarcaConexionFactory'
    cClaseModelo = 'MarcaVO'
    cClaseRepositorio = 'MarcaDAOFactory'
    cClaseValidador = 'MarcaValidadorFactory'
    cModulo = 'marca'

ENDDEFINE