* @Interface
DEFINE CLASS ValidadorBase AS CUSTOM

    * Propiedades.
    PROTECTED oUtiles
    PROTECTED oConexion
    PROTECTED oRepositorio

    PROTECTED nBandera
    PROTECTED cClaseConexion
    PROTECTED cClaseModelo
    PROTECTED cClaseRepositorio

    PROTECTED nCodigo
    PROTECTED cNombre
    PROTECTED lVigente

    * Inicialización de propiedades.
    nBandera = 0
    cClaseModelo = ''
    cClaseConexion = ''
    cClaseRepositorio = ''

    nCodigo = 0
    cNombre = ''
    lVigente = .F.

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
    FUNCTION Init
        LPARAMETERS toModelo, tnBandera

        THIS.oUtiles = CREATEOBJECT('Utiles')

        IF VARTYPE(THIS.oUtiles) != 'O' OR ;
                EMPTY(THIS.cClaseConexion) OR ;
                EMPTY(THIS.cClaseModelo) OR ;
                EMPTY(THIS.cClaseRepositorio) OR ;
                !THIS.EstablecerConexion() OR ;
                !THIS.EstablecerRepositorio() THEN
            RETURN .F.
        ENDIF

        IF PCOUNT() == 2 THEN
            IF !THIS.EstablecerValores(toModelo, tnBandera) THEN
                RETURN .F.
            ENDIF
        ENDIF
    ENDFUNC

    **/
    * Valida el campo 'codigo'.
    *
    * @field
    * codigo N(4) not null unique
    *
    * @param integer tnCodigo
    * Código a ser validado.
    *
    * @param integer tnBandera
    * Bandera a ser validada.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarCodigo
        LPARAMETERS tnCodigo, tnBandera
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
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarNombre
        LPARAMETERS tcNombre, tnBandera, tnCodigo
    ENDFUNC

    **/
    * Valida el campo 'vigente'.
    *
    * @field
    * vigente L(1) not null
    *
    * @param boolean tlVigente
    * Vigencia a ser validada.
    *
    * @return boolean
    * true si es válida y false en caso contrario.
    */
    FUNCTION ValidarVigente
        LPARAMETERS tlVigente
    ENDFUNC

    **/
    * Determina si todas las propiedades son válidas.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    FUNCTION EsValido
        IF THIS.Validar()
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDFUNC

    **/
    * Devuelve un objeto modelo con los datos de las propiedades.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    FUNCTION ObtenerModelo
        LOCAL loModelo, loExcepcion

        loModelo = .F.

        IF THIS.EsValido() THEN
            TRY
                loModelo = CREATEOBJECT(THIS.cClaseModelo)

                IF VARTYPE(loModelo) == 'O' THEN
                    loModelo = THIS.CargarDatos(loModelo)
                ENDIF
            CATCH TO loExcepcion
                loModelo = .F.
            ENDTRY
        ENDIF

        RETURN loModelo
    ENDFUNC

    **/
    * Valida el parámetro tnBandera.
    *
    * @param integer tnBandera
    * Bandera a ser validada.
    *
    * @return boolean
    * true si es válida y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarBandera
        LPARAMETERS tnBandera

        * inicio { validaciones del parámetro }
        IF VARTYPE(tnBandera) != 'N' THEN
            RETURN .F.
        ENDIF

        IF !BETWEEN(tnBandera, 1, 2) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        THIS.nBandera = tnBandera
    ENDPROC

    **/
    * Valida el objeto modelo.
    *
    * @param object toModelo
    * Objeto modelo.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    PROTECTED FUNCTION EsObjeto
        LPARAMETERS toModelo

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toModelo) != 'O' THEN
            RETURN .F.
        ENDIF

        IF LOWER(toModelo.Class) != LOWER(THIS.cClaseModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }
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
    PROTECTED FUNCTION EstablecerValores
        LPARAMETERS toModelo, tnBandera

        * inicio { validación del parámetro }
        IF !THIS.EsObjeto(toModelo) THEN
            ? 'EstablecerValores: No es objeto.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarBandera(tnBandera) THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        WITH THIS
            .nCodigo = toModelo.ObtenerCodigo()
            .cNombre = toModelo.ObtenerNombre()
            .lVigente = toModelo.EstaVigente()
        ENDWITH
    ENDFUNC

    **/
    * Establece el objeto conexion.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerConexion
        LOCAL loConexionFactory, loConexion

        loConexionFactory = CREATEOBJECT(THIS.cClaseConexion)

        IF VARTYPE(loConexionFactory) != 'O' THEN
            RETURN .F.
        ENDIF

        loConexion = loConexionFactory.CrearConexion('BUSQUEDA')

        IF VARTYPE(loConexion) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oConexion = loConexion
    ENDFUNC

    **/
    * Establece el objeto repositorio.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerRepositorio
        LOCAL loRepositorioFactory, loRepositorio

        loRepositorioFactory = CREATEOBJECT(THIS.cClaseRepositorio)

        IF VARTYPE(loRepositorioFactory) != 'O' THEN
            RETURN .F.
        ENDIF

        loRepositorio = loRepositorioFactory.CrearDAO(THIS.oConexion)

        IF VARTYPE(loRepositorio) != 'O' THEN
            RETURN .F.
        ENDIF

        THIS.oRepositorio = loRepositorio
    ENDFUNC

    **/
    * Valida todas las propiedades.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION Validar
        IF THIS.ValidarCodigo(THIS.nCodigo, THIS.nBandera) AND ;
                THIS.ValidarNombre(THIS.cNombre, THIS.nBandera, THIS.nCodigo) AND ;
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
    PROTECTED FUNCTION CargarDatos
        LPARAMETERS toModelo

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toModelo) != 'O' THEN
            RETURN .F.
        ENDIF

        IF toModelo.Class != THIS.cClaseModelo THEN
            ? 'CargarDatos: La clase del modelo no corresponde al de la propiedad cClaseModelo.'
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        LOCAL loExcepcion

        TRY
            WITH toModelo
                .EstablecerCodigo(THIS.nCodigo)
                .EstablecerNombre(THIS.cNombre)
                .EstablecerVigente(THIS.lVigente)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

ENDDEFINE