DEFINE CLASS FamiliaValidadorDBFImpl AS ValidadorBaseDBFImpl

    * Propiedades.
    PROTECTED nP1
    PROTECTED nP2
    PROTECTED nP3
    PROTECTED nP4
    PROTECTED nP5

    * Inicialización de propiedades.
    cClaseConexion = 'FamiliaConexionFactory'
    cClaseModelo = 'FamiliaVO'
    cClaseRepositorio = 'FamiliaDAOFactory'

    nP1 = 0
    nP2 = 0
    nP3 = 0
    nP4 = 0
    nP5 = 0

    **/
    * Valida el campo 'p1'.
    *
    * @field
    * p1 N(6,2) not null
    *
    * @param decimal tnP1
    * Porcentaje a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarP1
        LPARAMETERS tnP1

        IF !THIS.ValidarParamPorcentaje(tnP1) THEN
            ? 'Porcentaje 1: No es válido.'
            RETURN .F.
        ENDIF

        THIS.nP1 = tnP1
    ENDPROC

    **/
    * Valida el campo 'p2'.
    *
    * @field
    * p2 N(6,2) not null
    *
    * @param decimal tnP2
    * Porcentaje a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarP2
        LPARAMETERS tnP2

        IF !THIS.ValidarParamPorcentaje(tnP2) THEN
            ? 'Porcentaje 2: No es válido.'
            RETURN .F.
        ENDIF

        THIS.nP2 = tnP2
    ENDPROC

    **/
    * Valida el campo 'p3'.
    *
    * @field
    * p3 N(6,2) not null
    *
    * @param decimal tnP3
    * Porcentaje a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarP3
        LPARAMETERS tnP3

        IF !THIS.ValidarParamPorcentaje(tnP3) THEN
            ? 'Porcentaje 3: No es válido.'
            RETURN .F.
        ENDIF

        THIS.nP3 = tnP3
    ENDPROC

    **/
    * Valida el campo 'p4'.
    *
    * @field
    * p4 N(6,2) not null
    *
    * @param decimal tnP4
    * Porcentaje a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarP4
        LPARAMETERS tnP4

        IF !THIS.ValidarParamPorcentaje(tnP4) THEN
            ? 'Porcentaje 4: No es válido.'
            RETURN .F.
        ENDIF

        THIS.nP4 = tnP4
    ENDPROC

    **/
    * Valida el campo 'p5'.
    *
    * @field
    * p5 N(6,2) not null
    *
    * @param decimal tnP5
    * Porcentaje a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarP5
        LPARAMETERS tnP5

        IF !THIS.ValidarParamPorcentaje(tnP5) THEN
            ? 'Porcentaje 5: No es válido.'
            RETURN .F.
        ENDIF

        THIS.nP5 = tnP5
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
            .nP1 = toModelo.ObtenerP1()
            .nP2 = toModelo.ObtenerP2()
            .nP3 = toModelo.ObtenerP3()
            .nP4 = toModelo.ObtenerP4()
            .nP5 = toModelo.ObtenerP5()
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
                THIS.ValidarP1(THIS.nP1) AND ;
                THIS.ValidarP2(THIS.nP2) AND ;
                THIS.ValidarP3(THIS.nP3) AND ;
                THIS.ValidarP4(THIS.nP4) AND ;
                THIS.ValidarP5(THIS.nP5) THEN
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
                .EstablecerP1(THIS.nP1)
                .EstablecerP2(THIS.nP2)
                .EstablecerP3(THIS.nP3)
                .EstablecerP4(THIS.nP4)
                .EstablecerP5(THIS.nP5)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

    **/
    * Valida el parámetro tnPorcentaje.
    *
    * @field
    * p[1..5] N(6,2) not null
    *
    * @param decimal tnPorcentaje
    * Porcentaje a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarParamPorcentaje
        LPARAMETERS tnPorcentaje
        RETURN THIS.oUtiles.ValidarNumero(tnPorcentaje, 0, 999.99)
    ENDFUNC

ENDDEFINE