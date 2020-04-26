CLEAR
CLEAR ALL

DO biblioteca.prg

cClaseConexion = 'BarrioConexionFactory'
cClaseRepositorio = 'BarrioDAOFactory'

loConexionFactory = CREATEOBJECT(cClaseConexion)
loConexion = loConexionFactory.CrearConexion('MANTENIMIENTO')

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

*!*	loPermiso = CREATEOBJECT('Barrio')

*!*	IF VARTYPE(loPermiso) = 'O' THEN
*!*	*!*        ? 'loPermiso'
*!*	*!*        ? 'Usuario 1'
*!*	*!*        ? loPermiso.PuedeAcceder(1, 'brwFamil.prg')
*!*	*!*        ? 'Usuario 2'
*!*	*!*        ? loPermiso.PuedeAcceder(2, 'brwFamil.prg')
*!*	*!*        ? 'Usuario 3'
*!*	*!*        ? loPermiso.PuedeAcceder(3, 'brwFamil.prg')
*!*	*!*        ? 'Usuario 4'
*!*	*!*        ? loPermiso.PuedeAcceder(4, 'brwFamil.prg')
*!*	*!*        ? 'Usuario 100'
*!*	*!*        ? loPermiso.PuedeAcceder(100, 'brwFamil.prg')
*!*	*!*        ? loPermiso.PuedeAgregar(100, 'brwFamil.prg')
*!*	*!*        ? loPermiso.PuedeModificar(100, 'brwFamil.prg')
*!*	*!*        ? loPermiso.PuedeBorrar(100, 'brwFamil.prg')
*!*	*!*        ? loPermiso.PuedeImprimir(100, 'brwFamil.prg')
*!*	ENDIF

*!*	llExiste = loRepositorio.SimboloExiste('M')

*!*	IF llExiste
*!*	    ? 'El simbolo m existe'
*!*	endif


oBarrio = loRepositorio.ObtenerPorCodigo(10)

IF VARTYPE(oBarrio) = 'O' THEN
    ? 'Codigo: ' + STR(oBarrio.ObtenerCodigo())
    ? 'Nombre: ' + oBarrio.ObtenerNombre()
    ? 'Departamen: ' + STR(oBarrio.ObtenerDepartamen())
    ? 'Ciudad: ' + STR(oBarrio.ObtenerCiudad())
    ? 'Vigente: ' + IIF(oBarrio.EstaVigente(), 'Sí', 'No')
ELSE
    ? VARTYPE(oBarrio)
ENDIF

oBarrio.EstablecerCodigo(0)
oBarrio.EstablecerNombre('HOLAHOLA')

? loRepositorio.Agregar(oBarrio)

*!*	oBarrio = loRepositorio.ObtenerPorCodigo(10)

*!*	IF VARTYPE(oBarrio) = 'O' THEN
*!*	    ? 'Codigo: ' + STR(oBarrio.ObtenerCodigo())
*!*	    ? 'Nombre: ' + oBarrio.ObtenerNombre()
*!*	    ? 'Símbolo: ' + oBarrio.ObtenerSimbolo()
*!*	    ? 'Divisible: ' + IIF(oBarrio.EsDivisible(), 'Sí', 'No')
*!*	ELSE
*!*	    ? VARTYPE(oBarrio)
*!*	ENDIF

* COM+ test
? 'COM+ test'
o = NEWOBJECT('barrio')
x = o.ObtenerDTO()
x.EstablecerDepartamen(12)
x.EstablecerCiudad(165)
x.EstablecerNombre('HOLAHOLA2')
? o.Agregar(7, x)
