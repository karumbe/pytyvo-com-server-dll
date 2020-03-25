DEFINE CLASS UnidadMedidaValidadorDBFImpl AS ValidadorBaseDBFImpl

    * Propiedades.
    PROTECTED cSimbolo
    PROTECTED lDivisible

    * Inicialización de propiedades.
    cClaseConexion = 'UnidadMedidaConexionFactory'
    cClaseModelo = 'UnidadMedidaVO'
    cClaseRepositorio = 'UnidadMedidaDAOFactory'

    cSimbolo = ''
    lDivisible = .F.

    **/
    * Valida el campo 'simbolo'.
    *
    * @field
    * nombre C(5) not null unique
    *
    * @param string tcSimbolo
    * Símbolo a ser validado.
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
    FUNCTION ValidarSimbolo
        LPARAMETERS tcSimbolo, tnBandera, tnCodigo

        * inicio { validaciones de parámetros }
        IF !THIS.ValidarParamSimbolo(tcSimbolo) THEN
            ? 'Símbolo: No es válido.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarBandera(tnBandera) THEN
            ? 'Símbolo: La bandera no es válida.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarCodigo(tnCodigo, tnBandera) THEN
            ? 'Símbolo: El código no es válido.'
            RETURN .F.
        ENDIF

        tcSimbolo = ALLTRIM(UPPER(tcSimbolo))
        * fin { validaciones del parámetro }

        LOCAL loModelo

        IF THIS.nBandera == 1 THEN    && agregar.
            IF THIS.oRepositorio.SimboloExiste(tcSimbolo) THEN
                ? 'Símbolo: Ya existe.'
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.nBandera == 2 THEN    && modificar.
            loModelo = THIS.oRepositorio.ObtenerPorSimbolo(tcSimbolo)

            IF VARTYPE(loModelo) == 'O' THEN
                IF loModelo.ObtenerCodigo() != THIS.nCodigo THEN
                    ? 'Símbolo: Ya existe.'
                    RETURN .F.
                ENDIF
            ENDIF
        ENDIF

        THIS.cSimbolo = tcSimbolo
    ENDPROC

    **/
    * Valida el campo 'divisible'.
    *
    * @field
    * divisible L(1) not null
    *
    * @param boolean tlDivisible
    * Divisibilidad a ser validada.
    *
    * @return boolean
    * true si es válida y false en caso contrario.
    */
    FUNCTION ValidarDivisible
        LPARAMETERS tlDivisible

        * inicio { validaciones del parámetro }
        IF PARAMETERS() != 1 THEN
            ? 'Divisible: Muy pocos argumentos.'
            RETURN .F.
        ENDIF

        IF VARTYPE(tlDivisible) != 'L' THEN
            ? 'Divisible: Debe ser de tipo lógico.'
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        THIS.lDivisible = tlDivisible
    ENDPROC

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
            .cSimbolo = toModelo.ObtenerSimbolo()
            .lDivisible = toModelo.EsDivisible()
        ENDWITH
    ENDFUNC

    **/
    * Valida todas las propiedades.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION Validar

        IF ValidadorBase::Validar() AND ;
                THIS.ValidarSimbolo(THIS.cSimbolo, THIS.nBandera, THIS.nCodigo) AND ;
                THIS.ValidarDivisible(THIS.lDivisible) THEN
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
                .EstablecerSimbolo(THIS.cSimbolo)
                .EstablecerDivisible(THIS.lDivisible)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

    **/
    * Valida el parámetro tcSimbolo.
    *
    * @field
    * simbolo C(5) not null unique
    *
    * @param string tcSimbolo
    * Símbolo a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarParamSimbolo
        LPARAMETERS tcSimbolo
        RETURN THIS.oUtiles.ValidarTexto(tcSimbolo, 1, 5)
    ENDFUNC

ENDDEFINE