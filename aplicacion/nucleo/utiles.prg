DEFINE CLASS Utiles AS CUSTOM

    **/
    * Valida un n�mero.
    *
    * @param integer tnValor
    * N�mero entero a ser validado.
    *
    * @return boolean
    * true si es v�lido y false en caso contrario.
    */
    FUNCTION ValidarNumero
        LPARAMETERS tnValor, tnValorMinimo, tnValorMaximo

        * inicio { validaciones de par�metros }
        IF PARAMETERS() < 3 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnValor) != 'N' THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnValorMinimo) != 'N' THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnValorMaximo) != 'N' THEN
            RETURN .F.
        ENDIF

        IF tnValorMinimo < 0 THEN
            RETURN .F.
        ENDIF

        IF tnValorMinimo > tnValorMaximo THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de par�metros }

        IF tnValor < tnValorMinimo THEN
            RETURN .F.
        ELSE
            IF tnValor > tnValorMaximo THEN
                RETURN .F.
            ENDIF
        ENDIF
    ENDFUNC

    **/
    * Valida una cadena de caracteres.
    *
    * @param string tcValor
    * Cadena de caracteres a ser validada.
    *
    * @return boolean
    * true si es v�lida y false en caso contrario.
    */
    FUNCTION ValidarTexto
        LPARAMETERS tcValor, tnLongitudMinima, tnLongitudMaxima

        * inicio { validaciones de par�metros }
        IF PARAMETERS() < 3 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcValor) != 'C' THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnLongitudMinima) != 'N' THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tnLongitudMaxima) != 'N' THEN
            RETURN .F.
        ENDIF

        IF tnLongitudMinima < 0 THEN
            RETURN .F.
        ENDIF

        IF tnLongitudMinima > tnLongitudMaxima THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de par�metros }

        IF tnLongitudMinima > 0 THEN    && requerido.
            IF EMPTY(tcValor) THEN
                RETURN .F.
            ENDIF
        ENDIF

        IF LEN(tcValor) < tnLongitudMinima THEN
            RETURN .F.
        ELSE
            IF LEN(tcValor) > tnLongitudMaxima THEN
	            RETURN .F.
            ENDIF
        ENDIF
    ENDFUNC

    **/
    * Limpia una cadena de caracteres para realizar una consulta SQL.
    *
    * @param string tcValor
    * Cadena de caracteres a ser limpiada.
    *
    * @return string
    * clean string si tiene �xito y empty string en caso contrario.
    */
    FUNCTION SanitizarValor
        LPARAMETERS tcValor

        * inicio { validaci�n del par�metro }
        IF !THIS.ValidarTexto(tcValor, 2, 50) THEN
            RETURN SPACE(0)
        ENDIF
        * fin { validaci�n del par�metro }

        tcValor = STRTRAN(ALLTRIM(UPPER(tcValor)), '*', '%')

        * Elimina el caracter '%%' del par�metro 'tcValor'.
        DO WHILE ATC('%%', tcValor) > 0
            tcValor = STRTRAN(tcValor, '%%', '%')
        ENDDO

        * Elimina el caracter '[' del par�metro 'tcValor'.
        tcValor = STRTRAN(tcValor, '[', '')

        * Elimina el caracter ']' del par�metro 'tcValor'.
        tcValor = STRTRAN(tcValor, ']', '')

        RETURN tcValor
    ENDFUNC

    *
    * Descripci�n:
    * Retorna un nombre de archivo �nico de ocho caracteres que empieza con 'tm'
    * seguido por una combinaci�n de letras y n�meros.
    *
    * Historial de Modificaci�n:
    * Septiembre 21, 2008    Jos� Acu�a    Creaci�n del Programa.
    *
    FUNCTION CreaTemp
        LOCAL lcNombreArchivo

        DO WHILE .T.
            lcNombreArchivo = 'tm' + RIGHT(SYS(2015), 6)
            IF !FILE(lcNombreArchivo + '.dbf') AND ;
                    !FILE(lcNombreArchivo + '.cdx') AND ;
                    !FILE(lcNombreArchivo + '.txt') AND ;
                    !FILE(lcNombreArchivo + '.rtf') AND ;
                    !FILE(lcNombreArchivo + '.doc') AND ;
                    !FILE(lcNombreArchivo + '.xls') AND ;
                    !FILE(lcNombreArchivo + '.pdf') THEN
                EXIT
            ENDIF
        ENDDO

        RETURN lcNombreArchivo
    ENDFUNC

    **/
    * Devuelve el n�mero de factura de ventas con la siguiente estructura
    * 999-999-9999999.
    *
    * @return string
    */
    FUNCTION FormatearNumeroFacturaVenta
        LPARAMETERS tnNroDocu

        * inicio { validaci�n del par�metro }
        IF !THIS.ValidarNumero(tnNroDocu, 1, 9999999)
            RETURN NAN    &&  Not a Number (en espa�ol: no es un n�mero).
        ENDIF
        * fin { validaci�n del par�metro }

        DO CASE
        CASE BETWEEN(tnNroDocu, 1000000, 1999999)
            lcNroDocu = "001-001-0" + ;
                TRANSFORM(tnNroDocu - 1000000, "@L 999999")
        CASE BETWEEN(tnNroDocu, 2000000, 2999999)
            lcNroDocu = "001-002-0" + ;
                TRANSFORM(tnNroDocu - 2000000, "@L 999999")
        CASE BETWEEN(tnNroDocu, 3000000, 3999999)
            lcNroDocu = "003-001-0" + ;
                TRANSFORM(tnNroDocu - 3000000, "@L 999999")
        CASE BETWEEN(tnNroDocu, 4000000, 4999999)
            lcNroDocu = "001-001-0" + ;
                TRANSFORM(tnNroDocu - 4000000, "@L 999999")
        CASE BETWEEN(tnNroDocu, 6000000, 6999999)
            lcNroDocu = "006-001-0" + ;
                TRANSFORM(tnNroDocu - 6000000, "@L 999999")
        OTHERWISE
            lcNroDocu = STR(tnNroDocu, 15)
        ENDCASE

        RETURN lcNroDocu
    ENDFUNC

ENDDEFINE