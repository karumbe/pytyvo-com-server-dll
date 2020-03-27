DEFINE CLASS ModeloValidadorDBFImpl AS ValidadorBaseDBFImpl

    * Propiedades.
    PROTECTED oMaquinaConexion
    PROTECTED oMaquinaRepositorio
    PROTECTED oMarcaConexion
    PROTECTED oMarcaRepositorio

    PROTECTED nMaquina
    PROTECTED nMarca

    * Inicialización de propiedades.
    cClaseConexion = 'ModeloConexionFactory'
    cClaseModelo = 'ModeloVO'
    cClaseRepositorio = 'ModeloDAOFactory'

    nMaquina = 0
    nMarca = 0

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
        IF !THIS.EstablecerMaquinaConexion() OR ;
                !THIS.EstablecerMaquinaRepositorio() OR ;
                !THIS.EstablecerMarcaConexion() OR ;
                !THIS.EstablecerMarcaRepositorio() THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Valida el campo 'maquina'.
    *
    * @field
    * maquina N(3) not null
    *
    * @param integer tnMaquina
    * Código de máquina a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarMaquina
        LPARAMETERS tnMaquina

        IF !THIS.oUtiles.ValidarNumero(tnMaquina, 1, 999) THEN
            ? 'Máquina: No es válido.'
            RETURN .F.
        ENDIF

        IF !THIS.oMaquinaRepositorio.CodigoExiste(tnMaquina) THEN
            ? 'Máquina: No existe.'
            RETURN .F.
        ENDIF

        IF !THIS.oMaquinaRepositorio.EstaVigente(tnMaquina) THEN
            ? 'Máquina: No está vigente.'
            RETURN .F.
        ENDIF

        THIS.nMaquina = tnMaquina
    ENDFUNC

    **/
    * Valida el campo 'marca'.
    *
    * @field
    * marca N(4) not null
    *
    * @param integer tnMarca
    * Código de marca a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarMarca
        LPARAMETERS tnMarca

        IF !THIS.oUtiles.ValidarNumero(tnMarca, 1, 9999) THEN
            ? 'Marca: No es válido.'
            RETURN .F.
        ENDIF

        IF !THIS.oMarcaRepositorio.CodigoExiste(tnMarca) THEN
            ? 'Marca: No existe.'
            RETURN .F.
        ENDIF

        IF !THIS.oMarcaRepositorio.EstaVigente(tnMarca) THEN
            ? 'Marca: No está vigente.'
            RETURN .F.
        ENDIF

        THIS.nMarca = tnMarca
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
    * @param integer tnMaquina
    * Código de máquina a ser validado.
    *
    * @param integer tnMarca
    * Código de marca a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    * @Override
    FUNCTION ValidarNombre
        LPARAMETERS tcNombre, tnBandera, tnCodigo, tnMaquina, tnMarca

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

        IF !THIS.ValidarMaquina(tnMaquina) THEN
            ? 'Nombre: La máquina no es válida.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarMarca(tnMarca) THEN
            ? 'Nombre: La marca no es válida.'
            RETURN .F.
        ENDIF

        tcNombre = ALLTRIM(UPPER(tcNombre))
        * fin { validaciones de parámetros }

        LOCAL loModelo

        IF THIS.nBandera == 1 THEN    && agregar.
            IF THIS.oRepositorio.NombreExiste(tcNombre, tnMaquina, tnMarca) THEN
                ? 'Nombre: Ya existe.'
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.nBandera == 2 THEN    && modificar.
            loModelo = THIS.oRepositorio.ObtenerPorNombre(tcNombre, tnMaquina, ;
                tnMarca)

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
            .nMaquina = toModelo.ObtenerMaquina()
            .nMarca = toModelo.ObtenerMarca()
        ENDWITH
    ENDFUNC

    **/
    * Establece el objeto 'oMaquinaConexion'.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerMaquinaConexion
        LOCAL loConexionFactory, loConexion

        loConexionFactory = CREATEOBJECT('MaquinaConexionFactory')

        IF VARTYPE(loConexionFactory) != 'O' THEN
            RETURN .F.
        ENDIF

        loConexion = loConexionFactory.CrearConexion('BUSQUEDA')

        IF VARTYPE(loConexion) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oMaquinaConexion = loConexion
    ENDFUNC

    **/
    * Establece el objeto 'oMaquinaRepositorio'.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerMaquinaRepositorio
        LOCAL loRepositorioFactory, loRepositorio

        loRepositorioFactory = CREATEOBJECT('MaquinaDAOFactory')

        IF VARTYPE(loRepositorioFactory) != 'O' THEN
            RETURN .F.
        ENDIF

        loRepositorio = loRepositorioFactory.CrearDAO(THIS.oMaquinaConexion)

        IF VARTYPE(loRepositorio) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oMaquinaRepositorio = loRepositorio
    ENDFUNC

    **/
    * Establece el objeto 'oMarcaConexion'.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerMarcaConexion
        LOCAL loConexionFactory, loConexion

        loConexionFactory = CREATEOBJECT('MarcaOtConexionFactory')

        IF VARTYPE(loConexionFactory) != 'O' THEN
            RETURN .F.
        ENDIF

        loConexion = loConexionFactory.CrearConexion('BUSQUEDA')

        IF VARTYPE(loConexion) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oMarcaConexion = loConexion
    ENDFUNC

    **/
    * Establece el objeto 'oMarcaRepositorio'.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerMarcaRepositorio
        LOCAL loRepositorioFactory, loRepositorio

        loRepositorioFactory = CREATEOBJECT('MarcaOtDAOFactory')

        IF VARTYPE(loRepositorioFactory) != 'O' THEN
            RETURN .F.
        ENDIF

        loRepositorio = loRepositorioFactory.CrearDAO(THIS.oMarcaConexion)

        IF VARTYPE(loRepositorio) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oMarcaRepositorio = loRepositorio
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
                THIS.ValidarMaquina(THIS.nMaquina) AND ;
                THIS.ValidarMarca(THIS.nMarca) AND ;
                THIS.ValidarNombre(THIS.cNombre, THIS.nBandera, THIS.nCodigo, ;
                    THIS.nMaquina, THIS.nMarca) AND ;
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
                .EstablecerMaquina(THIS.nMaquina)
                .EstablecerMarca(THIS.nMarca)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

ENDDEFINE
