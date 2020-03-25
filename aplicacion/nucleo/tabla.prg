DEFINE CLASS Tabla AS CUSTOM

    * Propiedades.
    PROTECTED cTabla
    PROTECTED cAlias
    PROTECTED lLecturaEscritura

    **/
    * Constructor.
    *
    * @param string tcTabla
    * Nombre de la tabla.
    *
    * @param string tcAlias
    * Alias de la tabla.
    *
    * @param boolean tlLecturaEscritura
    * Modo de lectura y escritura.
    *
    * @return boolean
    * true si puede crear la instancia y false en caso contrario.
    */
    FUNCTION Init
        LPARAMETERS tcTabla, tcAlias, tlLecturaEscritura

        * inicio { validaciones de parámetros }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcTabla) != 'C' THEN
            RETURN .F.
        ENDIF

        IF EMPTY(tcTabla) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones de parámetros }

        IF VARTYPE(tcAlias) == 'C' THEN
            IF EMPTY(tcAlias) THEN
                tcAlias = tcTabla
            ENDIF
        ELSE
            tcAlias = tcTabla
        ENDIF

        IF VARTYPE(tlLecturaEscritura) != 'L' THEN
            tlLecturaEscritura = .F.
        ENDIF

        WITH THIS
            .cTabla = ALLTRIM(LOWER(tcTabla))
            .cAlias = ALLTRIM(LOWER(tcAlias))
            .lLecturaEscritura = tlLecturaEscritura
        ENDWITH
    ENDFUNC

    **/
    * Devuelve el nombre de la tabla.
    *
    * @return string
    */
    FUNCTION ObtenerTabla
        RETURN THIS.cTabla
    ENDFUNC

    **/
    * Devuelve el alias de la tabla.
    *
    * @return string
    */
    FUNCTION ObtenerAlias
        RETURN THIS.cAlias
    ENDFUNC

    **/
    * Devuelve si el modo de lectura y escritura está activo.
    *
    * @return boolean
    */
    FUNCTION EnModoLecturaEscritura
        RETURN THIS.lLecturaEscritura
    ENDFUNC

ENDDEFINE