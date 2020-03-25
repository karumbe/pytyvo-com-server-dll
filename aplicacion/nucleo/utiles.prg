DEFINE CLASS Utiles AS CUSTOM

    **/
    * Valida un número.
    *
    * @param integer tnValor
    * Número entero a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    FUNCTION ValidarNumero
        LPARAMETERS tnValor, tnValorMinimo, tnValorMaximo

        * inicio { validaciones de parámetros }
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
        * fin { validaciones de parámetros }

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
    * true si es válida y false en caso contrario.
    */
    FUNCTION ValidarTexto
        LPARAMETERS tcValor, tnLongitudMinima, tnLongitudMaxima

        * inicio { validaciones de parámetros }
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
        * fin { validaciones de parámetros }

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
    * clean string si tiene éxito y empty string en caso contrario.
    */
    FUNCTION SanitizarValor
        LPARAMETERS tcValor

        * inicio { validación del parámetro }
        IF !THIS.ValidarTexto(tcValor, 2, 50) THEN
            RETURN SPACE(0)
        ENDIF
        * fin { validación del parámetro }

        tcValor = STRTRAN(ALLTRIM(UPPER(tcValor)), '*', '%')

        * Elimina el caracter '%%' del parámetro 'tcValor'.
        DO WHILE ATC('%%', tcValor) > 0
            tcValor = STRTRAN(tcValor, '%%', '%')
        ENDDO

        * Elimina el caracter '[' del parámetro 'tcValor'.
        tcValor = STRTRAN(tcValor, '[', '')

        * Elimina el caracter ']' del parámetro 'tcValor'.
        tcValor = STRTRAN(tcValor, ']', '')

        RETURN tcValor
    ENDFUNC

    *
    * Descripción:
    * Retorna un nombre de archivo único de ocho caracteres que empieza con 'tm'
    * seguido por una combinación de letras y números.
    *
    * Historial de Modificación:
    * Septiembre 21, 2008    José Acuña    Creación del Programa.
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
    * Devuelve el número de factura de ventas con la siguiente estructura
    * 999-999-9999999.
    *
    * @return string
    */
    FUNCTION FormatearNumeroFacturaVenta
        LPARAMETERS tnNroDocu

        * inicio { validación del parámetro }
        IF !THIS.ValidarNumero(tnNroDocu, 1, 9999999)
            RETURN NAN    &&  Not a Number (en español: no es un número).
        ENDIF
        * fin { validación del parámetro }

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