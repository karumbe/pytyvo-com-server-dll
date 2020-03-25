DEFINE CLASS Indizador AS CUSTOM

    * Propiedades.
    PROTECTED cRuta
    PROTECTED cTabla

    **/
    * Constructor.
    *
    * @param string tcRuta
    * Ruta del origen de datos.
    *
    * @param string tcTabla
    * Tabla a ser indizada.
    *
    * @return boolean
    * true si puede crear la instancia y false en caso contrario.
    */
    FUNCTION Init
        LPARAMETERS tcRuta, tcTabla

        IF !THIS.EstablecerRuta(tcRuta) OR !THIS.EstablecerTabla(tcTabla) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Establece la ruta del origen de datos.
    *
    * @param string tcRuta
    * Ruta del origen de datos.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerRuta
        LPARAMETERS tcRuta

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcRuta) != 'C' THEN
            RETURN .F.
        ENDIF

        IF EMPTY(tcRuta) THEN
            RETURN .F.
        ENDIF

        IF !DIRECTORY(ADDBS(tcRuta)) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        THIS.cRuta = ADDBS(ALLTRIM(tcRuta))
    ENDFUNC

    **/
    * Establece la tabla a indizar.
    *
    * @param string tcTabla
    * Tabla a ser indizada.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerTabla
        LPARAMETERS tcTabla

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcTabla) != 'C' THEN
            RETURN .F.
        ENDIF

        IF EMPTY(tcTabla) THEN
            RETURN .F.
        ENDIF

        IF !FILE(THIS.cRuta + tcTabla + '.dbf') THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        THIS.cTabla = tcTabla
    ENDFUNC

    **/
    * Indiza la tabla.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    FUNCTION Indizar
        DO CASE
        CASE THIS.cTabla == 'barrios'
            RETURN THIS.Barrio()
        CASE THIS.cTabla == 'ciudades'
            RETURN THIS.Ciudad()
        CASE THIS.cTabla == 'clientes'
            RETURN THIS.Cliente()
        CASE THIS.cTabla == 'depar'
            RETURN THIS.Depar()
        CASE THIS.cTabla == 'motivocl'
            RETURN THIS.MotivoClie()
        CASE THIS.cTabla == 'plazos'
            RETURN THIS.Plazo()
        CASE THIS.cTabla == 'ruta'
            RETURN THIS.Ruta()
        CASE THIS.cTabla == 'usuarios'
            RETURN THIS.Usuario()
        CASE THIS.cTabla == 'vendedor'
            RETURN THIS.Vendedor()
        OTHERWISE
            RETURN .F.
        ENDCASE
    ENDFUNC

    **/
    * Indiza la tabla 'barrios.dbf'
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION Barrio
        LOCAL llIndizado
        llIndizado = .T.

        TRY
            USE (THIS.cRuta + THIS.cTabla) IN 0 EXCLUSIVE

            SELECT (THIS.cTabla)
            DELETE TAG ALL

            INDEX ON codigo TAG 'indice1'
            INDEX ON nombre TAG 'indice2'
            INDEX ON departamen TAG 'indice3'
            INDEX ON ciudad TAG 'indice4'

            USE
        CATCH TO loExcepcion
            llIndizado = .F.
        ENDTRY

        RETURN llIndizado
    ENDFUNC

    **/
    * Indiza la tabla 'ciudades.dbf'
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION Ciudad
        LOCAL llIndizado
        llIndizado = .T.

        TRY
            USE (THIS.cRuta + THIS.cTabla) IN 0 EXCLUSIVE

            SELECT (THIS.cTabla)
            DELETE TAG ALL

            INDEX ON codigo TAG 'indice1'
            INDEX ON nombre TAG 'indice2'
            INDEX ON departamen TAG 'indice3'

            USE
        CATCH TO loExcepcion
            llIndizado = .F.
        ENDTRY

        RETURN llIndizado
    ENDFUNC

    **/
    * Indiza la tabla 'clientes.dbf'
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION Cliente
        LOCAL llIndizado
        llIndizado = .T.

        TRY
            USE (THIS.cRuta + THIS.cTabla) IN 0 EXCLUSIVE

            SELECT (THIS.cTabla)
            DELETE TAG ALL

            INDEX ON codigo TAG 'indice1'
            INDEX ON nombre TAG 'indice2'
            INDEX ON documento TAG 'indice3'
            INDEX ON nombre_c TAG 'indice4'
            INDEX ON docconyuge TAG 'indice5'
            INDEX ON nombre_g TAG 'indice6'
            INDEX ON docgarante TAG 'indice7'
            INDEX ON departamen TAG 'indice8'
            INDEX ON ciudad TAG 'indice9'
            INDEX ON barrio TAG 'indice10'
            INDEX ON ruc TAG 'indice11'
            INDEX ON motivoclie TAG 'indice12'
            INDEX ON plazo TAG 'indice13'
            INDEX ON vendedor TAG 'indice14'
            INDEX ON cuenta TAG 'indice15'
            INDEX ON ruta TAG 'indice16'

            USE
        CATCH TO loExcepcion
            llIndizado = .F.
        ENDTRY

        RETURN llIndizado
    ENDFUNC

    **/
    * Indiza la tabla 'depar.dbf'
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION Depar
        LOCAL llIndizado
        llIndizado = .T.

        TRY
            USE (THIS.cRuta + THIS.cTabla) IN 0 EXCLUSIVE

            SELECT (THIS.cTabla)
            DELETE TAG ALL

            INDEX ON codigo TAG 'indice1'
            INDEX ON nombre TAG 'indice2'

            USE
        CATCH TO loExcepcion
            llIndizado = .F.
        ENDTRY

        RETURN llIndizado
    ENDFUNC

    **/
    * Indiza la tabla 'motivocl.dbf'
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION MotivoClie
        LOCAL llIndizado
        llIndizado = .T.

        TRY
            USE (THIS.cRuta + THIS.cTabla) IN 0 EXCLUSIVE

            SELECT (THIS.cTabla)
            DELETE TAG ALL

            INDEX ON codigo TAG 'indice1'
            INDEX ON nombre TAG 'indice2'

            USE
        CATCH TO loExcepcion
            llIndizado = .F.
        ENDTRY

        RETURN llIndizado
    ENDFUNC

    **/
    * Indiza la tabla 'plazos.dbf'
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION Plazo
        LOCAL llIndizado
        llIndizado = .T.

        TRY
            USE (THIS.cRuta + THIS.cTabla) IN 0 EXCLUSIVE

            SELECT (THIS.cTabla)
            DELETE TAG ALL

            INDEX ON codigo TAG 'indice1'
            INDEX ON nombre TAG 'indice2'

            USE
        CATCH TO loExcepcion
            llIndizado = .F.
        ENDTRY

        RETURN llIndizado
    ENDFUNC

    **/
    * Indiza la tabla 'ruta.dbf'
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION Ruta
        LOCAL llIndizado
        llIndizado = .T.

        TRY
            USE (THIS.cRuta + THIS.cTabla) IN 0 EXCLUSIVE

            SELECT (THIS.cTabla)
            DELETE TAG ALL

            INDEX ON id_ruta TAG 'indice1'
            INDEX ON nombre TAG 'indice2'

            USE
        CATCH TO loExcepcion
            llIndizado = .F.
        ENDTRY

        RETURN llIndizado
    ENDFUNC

    **/
    * Indiza la tabla 'usuarios.dbf'
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION Usuario
        LOCAL llIndizado
        llIndizado = .T.

        TRY
            USE (THIS.cRuta + THIS.cTabla) IN 0 EXCLUSIVE

            SELECT (THIS.cTabla)
            DELETE TAG ALL

            INDEX ON codigo TAG 'indice1'
            INDEX ON nombre TAG 'indice2'

            USE
        CATCH TO loExcepcion
            llIndizado = .F.
        ENDTRY

        RETURN llIndizado
    ENDFUNC

    **/
    * Indiza la tabla 'vendedor.dbf'
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION Vendedor
        LOCAL llIndizado
        llIndizado = .T.

        TRY
            USE (THIS.cRuta + THIS.cTabla) IN 0 EXCLUSIVE

            SELECT (THIS.cTabla)
            DELETE TAG ALL

            INDEX ON codigo TAG 'indice1'
            INDEX ON nombre TAG 'indice2'

            USE
        CATCH TO loExcepcion
            llIndizado = .F.
        ENDTRY

        RETURN llIndizado
    ENDFUNC

ENDDEFINE