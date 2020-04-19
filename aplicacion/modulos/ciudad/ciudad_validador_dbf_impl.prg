DEFINE CLASS CiudadValidadorDBFImpl AS ValidadorBaseDBFImpl

    * Propiedades.
    PROTECTED oDepartamenConexion
    PROTECTED oDepartamenRepositorio

    PROTECTED nDepartamen

    * Inicialización de propiedades.
    cClaseConexion = 'CiudadConexionFactory'
    cClaseModelo = 'CiudadVO'
    cClaseRepositorio = 'CiudadDAOFactory'

    nDepartamen = 0

    **/
    * Constructor.
    *
    * @param object toCiudad
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
        LPARAMETERS toCiudad, tnBandera

        IF PARAMETERS() == 2 THEN
            IF !ValidadorBase::Init(toCiudad, tnBandera) THEN
                RETURN .F.
            ENDIF
        ELSE
            IF !ValidadorBase::Init() THEN
                RETURN .F.
            ENDIF
        ENDIF

        * Establece conexiones y repositorios de tablas relacionadas.
        IF !THIS.EstablecerDepartamenConexion() OR ;
                !THIS.EstablecerDepartamenRepositorio() THEN
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
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    * @Override
    FUNCTION ValidarNombre
        LPARAMETERS tcNombre, tnBandera, tnCodigo, tnDepartamen

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

        tcNombre = ALLTRIM(UPPER(tcNombre))
        * fin { validaciones de parámetros }

        LOCAL loCiudad

        IF THIS.nBandera == 1 THEN    && agregar.
            IF THIS.oRepositorio.NombreExiste(tcNombre, tnDepartamen) THEN
                ? 'Nombre: Ya existe.'
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.nBandera == 2 THEN    && modificar.
            loCiudad = THIS.oRepositorio.ObtenerPorNombre(tcNombre, ;
                tnDepartamen)

            IF VARTYPE(loCiudad) == 'O' THEN
                IF loCiudad.ObtenerCodigo() != THIS.nCodigo THEN
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
    * @param object toCiudad
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
        LPARAMETERS toCiudad, tnBandera

        * inicio { validación de parámetros }
        IF !ValidadorBase::EstablecerValores(toCiudad, tnBandera) THEN
            RETURN .F.
        ENDIF
        * fin { validación de parámetros }

        WITH THIS
            .nDepartamen = toCiudad.ObtenerDepartamen()
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
    * Valida todas las propiedades.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION Validar
        IF THIS.ValidarCodigo(THIS.nCodigo, THIS.nBandera) AND ;
                THIS.ValidarDepartamen(THIS.nDepartamen) AND ;
                THIS.ValidarNombre(THIS.cNombre, THIS.nBandera, THIS.nCodigo, ;
                    THIS.nDepartamen) AND ;
                THIS.ValidarVigente(THIS.lVigente) THEN
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDFUNC

    **/
    * Carga los datos de las propiedades a un objeto.
    *
    * @param object toCiudad
    * Objeto a ser cargado.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION CargarDatos
        LPARAMETERS toCiudad

        * inicio { validación del parámetro }
        toCiudad = ValidadorBase::CargarDatos(toCiudad)

        IF VARTYPE(toCiudad) != 'O' THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        LOCAL loExcepcion

        TRY
            WITH toCiudad
                .EstablecerDepartamen(THIS.nDepartamen)
            ENDWITH
        CATCH TO loExcepcion
            toCiudad = .F.
        ENDTRY

        RETURN toCiudad
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
