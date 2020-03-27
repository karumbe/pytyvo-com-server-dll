DEFINE CLASS ValidadorBaseDBFImpl AS ValidadorBase

    **/
    * Valida el campo 'codigo'.
    *
    * @field
    * codigo N(4) not null unique
    *
    * @param integer tnCodigo
    * C�digo a ser validado.
    *
    * @param integer tnBandera
    * Bandera a ser validada.
    *
    * @return boolean
    * true si es v�lido y false en caso contrario.
    */
    * @Override
    FUNCTION ValidarCodigo
        LPARAMETERS tnCodigo, tnBandera

        * inicio { validaciones de par�metros }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            ? 'C�digo: No es v�lido.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarBandera(tnBandera) THEN
            ? 'C�digo: La bandera no es v�lida.'
            RETURN .F.
        ENDIF
        * fin { validaciones de par�metros }

        IF THIS.nBandera == 1 THEN    && agregar.
            IF tnCodigo != 0 THEN
                ? 'C�digo: Debe ser igual a cero.'
                RETURN .F.
            ENDIF
        ENDIF

        IF THIS.nBandera == 2 THEN    && modificar.
            IF tnCodigo <= 0 THEN
                ? 'C�digo: Debe ser mayor a cero.'
                RETURN .F.
            ENDIF

            IF !THIS.oRepositorio.CodigoExiste(tnCodigo) THEN
                ? 'C�digo: No existe.'
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
    * C�digo a ser validado.
    *
    * @return boolean
    * true si es v�lido y false en caso contrario.
    */
    FUNCTION ValidarNombre
        LPARAMETERS tcNombre, tnBandera, tnCodigo

        * inicio { validaciones de par�metros }
        IF !THIS.ValidarParamNombre(tcNombre) THEN
            ? 'Nombre: No es v�lido.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarBandera(tnBandera) THEN
            ? 'Nombre: La bandera no es v�lida.'
            RETURN .F.
        ENDIF

        IF !THIS.ValidarCodigo(tnCodigo, tnBandera) THEN
            ? 'Nombre: El c�digo no es v�lido.'
            RETURN .F.
        ENDIF

        tcNombre = ALLTRIM(UPPER(tcNombre))
        * fin { validaciones del par�metro }

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
    * true si es v�lida y false en caso contrario.
    */
    FUNCTION ValidarVigente
        LPARAMETERS tlVigente

        * inicio { validaciones del par�metro }
        IF PARAMETERS() != 1 THEN
            ? 'Vigente: Muy pocos argumentos.'
            RETURN .F.
        ENDIF

        IF VARTYPE(tlVigente) != 'L' THEN
            ? 'Vigente: Debe ser de tipo l�gico.'
            RETURN .F.
        ENDIF
        * fin { validaciones del par�metro }

        THIS.lVigente = tlVigente
    ENDFUNC

    **/
    * Valida el par�metro tnCodigo.
    *
    * @field
    * codigo N(4) not null unique
    *
    * @param integer tnCodigo
    * C�digo a ser validado.
    *
    * @return boolean
    * true si es v�lido y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarParamCodigo
        LPARAMETERS tnCodigo
        RETURN THIS.oUtiles.ValidarNumero(tnCodigo, 0, 9999)
    ENDFUNC

    **/
    * Valida el par�metro tcNombre.
    *
    * @field
    * nombre C(30) not null unique
    *
    * @param string tcNombre
    * Nombre a ser validado.
    *
    * @return boolean
    * true si es v�lido y false en caso contrario.
    */
    PROTECTED FUNCTION ValidarParamNombre
        LPARAMETERS tcNombre
        RETURN THIS.oUtiles.ValidarTexto(tcNombre, 3, 30)
    ENDFUNC

ENDDEFINE
