DEFINE CLASS ValidadorBaseDBFImpl AS ValidadorBase

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
    * @Override
    FUNCTION ValidarCodigo
        LPARAMETERS tnCodigo, tnBandera

        * inicio { validaciones de parámetros }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            ? 'Código: No es válido.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarBandera(tnBandera) THEN
            ? 'Código: La bandera no es válida.'
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        IF THIS.nBandera == 1 THEN    && agregar.
            IF tnCodigo != 0 THEN
                ? 'Código: Debe ser igual a cero.'
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.nBandera == 2 THEN    && modificar.
            IF tnCodigo <= 0 THEN
                ? 'Código: Debe ser mayor a cero.'
                RETURN .F.
            ENDIF

            IF !THIS.oRepositorio.CodigoExiste(tnCodigo) THEN
                ? 'Código: No existe.'
                RETURN .F.
            ENDIF
        ENDIF

        THIS.nCodigo = tnCodigo
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

        tcNombre = ALLTRIM(UPPER(tcNombre))
        * fin { validaciones del parámetro }

        LOCAL loModelo

        IF THIS.nBandera == 1 THEN    && agregar.
            IF THIS.oRepositorio.NombreExiste(tcNombre) THEN
                ? 'Nombre: Ya existe.'
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.nBandera == 2 THEN    && modificar.
            loModelo = THIS.oRepositorio.ObtenerPorNombre(tcNombre)

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

        * inicio { validaciones del parámetro }
        IF PARAMETERS() != 1 THEN
            ? 'Vigente: Muy pocos argumentos.'
            RETURN .F.
        ENDIF

        IF VARTYPE(tlVigente) != 'L' THEN
            ? 'Vigente: Debe ser de tipo lógico.'
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        THIS.lVigente = tlVigente
    ENDFUNC

    **/
    * Valida el parámetro tnCodigo.
    *
    * @field
    * codigo N(4) not null unique
    *
    * @param integer tnCodigo
    * Código a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarParamCodigo
        LPARAMETERS tnCodigo
        RETURN THIS.oUtiles.ValidarNumero(tnCodigo, 0, 9999)
    ENDFUNC

    **/
    * Valida el parámetro tcNombre.
    *
    * @field
    * nombre C(30) not null unique
    *
    * @param string tcNombre
    * Nombre a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarParamNombre
        LPARAMETERS tcNombre
        RETURN THIS.oUtiles.ValidarTexto(tcNombre, 3, 30)
    ENDFUNC

ENDDEFINE
