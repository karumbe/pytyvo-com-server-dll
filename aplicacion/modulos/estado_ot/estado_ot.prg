#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS EstadoOt AS COMBase OLEPUBLIC

    * Inicializaci�n de propiedades.
    cClaseConexion = 'EstadoOtConexionFactory'
    cClaseModelo = 'EstadoOtVO'
    cClaseRepositorio = 'EstadoOtDAOFactory'
    cClaseValidador = 'EstadoOtValidadorFactory'
    cModulo = 'estado_ot'

ENDDEFINE
