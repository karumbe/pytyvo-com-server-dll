CLEAR
CLEAR ALL

DO biblioteca.prg

cClaseConexion = 'UnidadMedidaConexionFactory'
cClaseRepositorio = 'UnidadMedidaDAOFactory'

loConexionFactory = CREATEOBJECT(cClaseConexion)
loConexion = loConexionFactory.CrearConexion('BUSQUEDA')

loDAOFactory = CREATEOBJECT(cClaseRepositorio)
loRepositorio = loDAOFactory.CrearDAO(loConexion)

IF VARTYPE(loConexionFactory) = 'O' THEN
    ? 'loConexionFactory'
ENDIF

IF VARTYPE(loConexion) = 'O' THEN
    ? 'loConexion'
ENDIF

IF VARTYPE(loDAOFactory) = 'O' THEN
    ? 'loDAOFactory'
ENDIF

IF VARTYPE(loRepositorio) = 'O' THEN
    ? 'loRepositorio'
ENDIF

loPermiso = CREATEOBJECT('UnidadMedida')

IF VARTYPE(loPermiso) = 'O' THEN
*!*        ? 'loPermiso'
*!*        ? 'Usuario 1'
*!*        ? loPermiso.PuedeAcceder(1, 'brwFamil.prg')
*!*        ? 'Usuario 2'
*!*        ? loPermiso.PuedeAcceder(2, 'brwFamil.prg')
*!*        ? 'Usuario 3'
*!*        ? loPermiso.PuedeAcceder(3, 'brwFamil.prg')
*!*        ? 'Usuario 4'
*!*        ? loPermiso.PuedeAcceder(4, 'brwFamil.prg')
*!*        ? 'Usuario 100'
*!*        ? loPermiso.PuedeAcceder(100, 'brwFamil.prg')
*!*        ? loPermiso.PuedeAgregar(100, 'brwFamil.prg')
*!*        ? loPermiso.PuedeModificar(100, 'brwFamil.prg')
*!*        ? loPermiso.PuedeBorrar(100, 'brwFamil.prg')
*!*        ? loPermiso.PuedeImprimir(100, 'brwFamil.prg')
ENDIF

llExiste = loRepositorio.SimboloExiste('M')

IF llExiste
    ? 'El simbolo m existe'
endif


oUnidadMedida = loRepositorio.ObtenerPorSimbolo('m')

IF VARTYPE(oUnidadMedida) = 'O' THEN
    ? 'Codigo: ' + STR(oUnidadMedida.ObtenerCodigo())
    ? 'Nombre: ' + oUnidadMedida.ObtenerNombre()
    ? 'Símbolo: ' + oUnidadMedida.ObtenerSimbolo()
    ? 'Divisible: ' + IIF(oUnidadMedida.EsDivisible(), 'Sí', 'No')
ELSE
    ? VARTYPE(oUnidadMedida)
ENDIF

oUnidadMedida = loRepositorio.ObtenerPorCodigo(10)

IF VARTYPE(oUnidadMedida) = 'O' THEN
    ? 'Codigo: ' + STR(oUnidadMedida.ObtenerCodigo())
    ? 'Nombre: ' + oUnidadMedida.ObtenerNombre()
    ? 'Símbolo: ' + oUnidadMedida.ObtenerSimbolo()
    ? 'Divisible: ' + IIF(oUnidadMedida.EsDivisible(), 'Sí', 'No')
ELSE
    ? VARTYPE(oUnidadMedida)
ENDIF

