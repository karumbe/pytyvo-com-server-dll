#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS MarcaOt AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'MarcaOtConexionFactory'
    cClaseModelo = 'MarcaOtVO'
    cClaseRepositorio = 'MarcaOtDAOFactory'
    cClaseValidador = 'MarcaOtValidadorFactory'
    cModulo = 'marca_ot'

ENDDEFINE