#INCLUDE 'constantes.h'

DEFINE CLASS Conexion AS CUSTOM

    * Propiedades.
    PROTECTED aTabla[1]
    PROTECTED cRuta

    **/
    * Constructor.
    *
    * @param string tcRuta
    * Ruta del origen de datos.
    *
    * @return boolean
    * true si puede crear la instancia y false en caso contrario.
    */
    FUNCTION Init
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
    * Agrega un objeto tabla al arreglo de tablas.
    *
    * @param object toTabla
    * Objeto tabla a ser agregado.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    FUNCTION AgregarTabla
        LPARAMETERS toTabla

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toTabla) != 'O' THEN
            RETURN .F.
        ENDIF

        IF toTabla.Class != 'Tabla' THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        LOCAL lnFila
        lnFila = IIF(VARTYPE(THIS.aTabla) != 'L', ALEN(THIS.aTabla, 1) + 1, 1)

        DIMENSION THIS.aTabla[lnFila]
        THIS.aTabla[lnFila] = toTabla
    ENDFUNC

    **/
    * Conecta al origen de datos.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    FUNCTION Conectar
        LOCAL llConectado, oTabla, lcTabla, lcAlias, loExcepcion

        * inicio { validaciones }
        IF VARTYPE(THIS.aTabla) == 'L' THEN
            RETURN .F.
        ENDIF

        FOR EACH oTabla IN THIS.aTabla
            IF !FILE(THIS.cRuta + oTabla.ObtenerTabla() + '.dbf') THEN
                RETURN .F.
            ENDIF

            IF !FILE(THIS.cRuta + oTabla.ObtenerTabla() + '.cdx') THEN
                RETURN .F.
            ENDIF
        ENDFOR

        THIS.Desconectar()
        * fin { validaciones }

        llConectado = .T.

        FOR EACH oTabla IN THIS.aTabla
            TRY
                lcTabla = THIS.cRuta + oTabla.ObtenerTabla()
                lcAlias = oTabla.ObtenerAlias()

                IF oTabla.EnModoLecturaEscritura() THEN
                    USE (lcTabla) IN 0 AGAIN ORDER 0 ALIAS (lcAlias) SHARED
                ELSE
                    USE (lcTabla) IN 0 AGAIN ORDER 0 ALIAS (lcAlias) SHARED ;
                        NOUPDATE
                ENDIF
            CATCH TO loExcepcion
                llConectado = .F.
            ENDTRY
        ENDFOR

        IF !llConectado THEN
            THIS.Desconectar()
        ENDIF

        RETURN llConectado
    ENDFUNC

    **/
    * Desconecta el origen de datos.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    FUNCTION Desconectar
        LOCAL llDesconectado, oTabla, lcTabla, lcAlias, loExcepcion

        * inicio { validación }
        IF VARTYPE(THIS.aTabla) == 'L' THEN
            RETURN .F.
        ENDIF
        * fin { validación }

        llDesconectado = .T.

        FOR EACH oTabla IN THIS.aTabla
            TRY
                lcTabla = oTabla.ObtenerTabla()
                lcAlias = oTabla.ObtenerAlias()

                IF USED(lcTabla) THEN
                    SELECT (lcTabla)
                    USE
                ENDIF

                IF USED(lcAlias) THEN
                    SELECT (lcAlias)
                    USE
                ENDIF
            CATCH TO loExcepcion
                llDesconectado = .F.
            ENDTRY
        ENDFOR

        RETURN llDesconectado
    ENDFUNC

    **/
    * Desconecta el origen de datos antes de destruir el objeto.
    *
    * @return boolean true (default)
    */
    PROTECTED PROCEDURE Destroy
        THIS.Desconectar()
    ENDPROC

ENDDEFINE