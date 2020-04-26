DEFINE CLASS BarrioValidadorDBFImpl AS ValidadorBaseDBFImpl

    * Propiedades.
    PROTECTED oDepartamenConexion
    PROTECTED oDepartamenRepositorio
    PROTECTED oCiudadConexion
    PROTECTED oCiudadRepositorio

    PROTECTED nDepartamen
    PROTECTED nCiudad

    * Inicialización de propiedades.
    cClaseConexion = 'BarrioConexionFactory'
    cClaseModelo = 'BarrioVO'
    cClaseRepositorio = 'BarrioDAOFactory'

    nDepartamen = 0
    nCiudad = 0

    **/
    * Constructor.
    *
    * @param object toModelo
    * Objeto modelo a ser validado.
    *
    * @param integer tnBandera
    * Bandera a ser validada.
    *
    * @return boolean
    * true si puede crear la instancia y false en caso contrario.
    */
    * @Override
    FUNCTION Init
        LPARAMETERS toModelo, tnBandera

        IF PARAMETERS() == 2 THEN
            IF !ValidadorBase::Init(toModelo, tnBandera) THEN
                RETURN .F.
            ENDIF
        ELSE
            IF !ValidadorBase::Init() THEN
                RETURN .F.
            ENDIF
        ENDIF

        * Establece conexiones y repositorios de tablas relacionadas.
        IF !THIS.EstablecerDepartamenConexion() OR ;
                !THIS.EstablecerDepartamenRepositorio() OR ;
                !THIS.EstablecerCiudadConexion() OR ;
                !THIS.EstablecerCiudadRepositorio() THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida el campo 'departamen'.
    *
    * @field
    * departamen N(3) not null
    *
    * @param integer tnDepartamen
    * Código de departamento a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarDepartamen
        LPARAMETERS tnDepartamen

        IF !THIS.oUtiles.ValidarNumero(tnDepartamen, 1, 999) THEN
            ? 'Departamento: No es válido.'
            RETURN .F.
        ENDIF

        IF !THIS.oDepartamenRepositorio.CodigoExiste(tnDepartamen) THEN
            ? 'Departamento: No existe.'
            RETURN .F.
        ENDIF

        IF !THIS.oDepartamenRepositorio.EstaVigente(tnDepartamen) THEN
            ? 'Departamento: No está vigente.'
            RETURN .F.
        ENDIF

        THIS.nDepartamen = tnDepartamen
    ENDFUNC

    **/
    * Valida el campo 'ciudad'.
    *
    * @field
    * ciudad N(5) not null
    *
    * @param integer tnCiudad
    * Código de ciudad a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarCiudad
        LPARAMETERS tnCiudad

        IF !THIS.oUtiles.ValidarNumero(tnCiudad, 1, 99999) THEN
            ? 'Ciudad: No es válida.'
            RETURN .F.
        ENDIF

        IF !THIS.oCiudadRepositorio.CodigoExiste(tnCiudad) THEN
            ? 'Ciudad: No existe.'
            RETURN .F.
        ENDIF

        IF !THIS.oCiudadRepositorio.EstaVigente(tnCiudad) THEN
            ? 'Ciudad: No está vigente.'
            RETURN .F.
        ENDIF

        LOCAL loCiudad
        loCiudad = THIS.oCiudadRepositorio.ObtenerPorCodigo(tnCiudad)

        IF VARTYPE(loCiudad) != 'O' THEN
            ? "Ciudad: El método 'ObtenerPorCodigo' ha fallado."
            RETURN .F.
        ENDIF

        IF loCiudad.ObtenerDepartamen() != THIS.nDepartamen THEN
            ? 'Ciudad: No pertenece al departamento.'
            RETURN .F.
        ENDIF

        THIS.nCiudad = tnCiudad
    ENDFUNC

    **/
    * Valida el campo 'nombre'.
    *
    * @field
    * nombre C(30) not null unique
    *
    * @param string tcNombre
    * Nombre a ser validado.
    *
    * @param integer tnBandera
    * Bandera a ser validada.
    *
    * @param integer tnCodigo
    * Código a ser validado.
    *
    * @param integer tnDepartamen
    * Código de departamento a ser validado.
    *
    * @param integer tnCiudad
    * Código de ciudad a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    * @Override
    FUNCTION ValidarNombre
        LPARAMETERS tcNombre, tnBandera, tnCodigo, tnDepartamen, tnCiudad

        * inicio { validaciones de parámetros }
        IF !THIS.ValidarParamNombre(tcNombre) THEN
            ? 'Nombre: No es válido.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarBandera(tnBandera) THEN
            ? 'Nombre: La bandera no es válida.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarCodigo(tnCodigo, tnBandera) THEN
            ? 'Nombre: El código no es válido.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarDepartamen(tnDepartamen) THEN
            ? 'Nombre: El departamento no es válido.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarCiudad(tnCiudad) THEN
            ? 'Nombre: La ciudad no es válida.'
            RETURN .F.
        ENDIF

        tcNombre = ALLTRIM(UPPER(tcNombre))
        * fin { validaciones de parámetros }

        LOCAL loModelo

        IF THIS.nBandera == 1 THEN    && agregar.
            IF THIS.oRepositorio.NombreExiste(tcNombre, tnDepartamen, tnCiudad) THEN
                ? 'Nombre: Ya existe.'
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.nBandera == 2 THEN    && modificar.
            loModelo = THIS.oRepositorio.ObtenerPorNombre(tcNombre, tnDepartamen, ;
                tnCiudad)

            IF VARTYPE(loModelo) == 'O' THEN
                IF loModelo.ObtenerCodigo() != THIS.nCodigo THEN
                    ? 'Nombre: Ya existe.'
                    RETURN .F.
                ENDIF
            ENDIF
        ENDIF

        THIS.cNombre = tcNombre
    ENDFUNC

    **/
    * Establece los valores desde el objeto modelo.
    *
    * @param object toModelo
    * Objeto modelo.
    *
    * @param integer tnBandera
    * Bandera a ser validada.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION EstablecerValores
        LPARAMETERS toModelo, tnBandera

        * inicio { validación de parámetros }
        IF !ValidadorBase::EstablecerValores(toModelo, tnBandera) THEN
            RETURN .F.
        ENDIF
        * fin { validación de parámetros }

        WITH THIS
            .nDepartamen = toModelo.ObtenerDepartamen()
            .nCiudad = toModelo.ObtenerCiudad()
        ENDWITH
    ENDFUNC

    **/
    * Establece el objeto 'oDepartamenConexion'.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerDepartamenConexion
        LOCAL loConexionFactory, loConexion

        loConexionFactory = CREATEOBJECT('DeparConexionFactory')

        IF VARTYPE(loConexionFactory) != 'O' THEN
            RETURN .F.
        ENDIF

        loConexion = loConexionFactory.CrearConexion('BUSQUEDA')

        IF VARTYPE(loConexion) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oDepartamenConexion = loConexion
    ENDFUNC

    **/
    * Establece el objeto 'oDepartamenRepositorio'.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerDepartamenRepositorio
        LOCAL loRepositorioFactory, loRepositorio

        loRepositorioFactory = CREATEOBJECT('DeparDAOFactory')

        IF VARTYPE(loRepositorioFactory) != 'O' THEN
            RETURN .F.
        ENDIF

        loRepositorio = loRepositorioFactory.CrearDAO(THIS.oDepartamenConexion)

        IF VARTYPE(loRepositorio) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oDepartamenRepositorio = loRepositorio
    ENDFUNC

    **/
    * Establece el objeto 'oCiudadConexion'.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerCiudadConexion
        LOCAL loConexionFactory, loConexion

        loConexionFactory = CREATEOBJECT('CiudadConexionFactory')

        IF VARTYPE(loConexionFactory) != 'O' THEN
            RETURN .F.
        ENDIF

        loConexion = loConexionFactory.CrearConexion('BUSQUEDA')

        IF VARTYPE(loConexion) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oCiudadConexion = loConexion
    ENDFUNC

    **/
    * Establece el objeto 'oCiudadRepositorio'.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerCiudadRepositorio
        LOCAL loRepositorioFactory, loRepositorio

        loRepositorioFactory = CREATEOBJECT('CiudadDAOFactory')

        IF VARTYPE(loRepositorioFactory) != 'O' THEN
            RETURN .F.
        ENDIF

        loRepositorio = loRepositorioFactory.CrearDAO(THIS.oCiudadConexion)

        IF VARTYPE(loRepositorio) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oCiudadRepositorio = loRepositorio
    ENDFUNC

    **/
    * Valida todas las propiedades.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION Validar
        IF THIS.ValidarCodigo(THIS.nCodigo, THIS.nBandera) AND ;
                THIS.ValidarDepartamen(THIS.nDepartamen) AND ;
                THIS.ValidarCiudad(THIS.nCiudad) AND ;
                THIS.ValidarNombre(THIS.cNombre, THIS.nBandera, THIS.nCodigo, ;
                    THIS.nDepartamen, THIS.nCiudad) AND ;
                THIS.ValidarVigente(THIS.lVigente) THEN
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDFUNC

    **/
    * Carga los datos de las propiedades a un objeto.
    *
    * @param object toModelo
    * Objeto a ser cargado.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION CargarDatos
        LPARAMETERS toModelo

        * inicio { validación del parámetro }
        toModelo = ValidadorBase::CargarDatos(toModelo)

        IF VARTYPE(toModelo) != 'O' THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        LOCAL loExcepcion

        TRY
            WITH toModelo
                .EstablecerDepartamen(THIS.nDepartamen)
                .EstablecerCiudad(THIS.nCiudad)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

    **/
    * Valida el parámetro tnCodigo.
    *
    * @field
    * codigo N(5) not null unique
    *
    * @param integer tnCodigo
    * Código a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION ValidarParamCodigo
        LPARAMETERS tnCodigo
        RETURN THIS.oUtiles.ValidarNumero(tnCodigo, 0, 99999)
    ENDFUNC

ENDDEFINE
