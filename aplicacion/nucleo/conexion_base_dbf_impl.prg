#INCLUDE 'constantes.h'

SET PROCEDURE TO conexion_base.prg ADDITIVE
SET PROCEDURE TO conexion.prg ADDITIVE
SET PROCEDURE TO tabla.prg ADDITIVE

DEFINE CLASS ConexionBaseDBFImpl AS ConexionBase

    **/
    * Devuelve un objeto conexion.
    *
    * @param array taTablas
    * Arreglo que contiene las tablas.
    *
    * @return boolean
    * object si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION ObtenerConexion
        LPARAMETERS taTablas
        EXTERNAL ARRAY taTablas

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF TYPE('taTablas', 1) != 'A' THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        LOCAL loConexion, lnContador, lcTabla, lcAlias, llLecturaEscritura

        loConexion = CREATEOBJECT('Conexion', RUTA_DATOS)

        IF VARTYPE(loConexion) == 'O' THEN
            IF TYPE('taTablas', 1) == 'A' THEN
                IF VARTYPE(taTablas) == 'C' THEN
                    FOR lnContador = 1 TO ALEN(taTablas, 1)
                        IF VARTYPE(taTablas[lnContador, 1]) == 'C' AND ;
                                !EMPTY(taTablas[lnContador, 1]) THEN
                            lcTabla = taTablas[lnContador, 1]

                            IF VARTYPE(taTablas[lnContador, 2]) == 'C' AND ;
                                    !EMPTY(taTablas[lnContador, 2]) THEN
                                lcAlias = taTablas[lnContador, 2]
                            ELSE
                                lcAlias = lcTabla
                            ENDIF

                            llLecturaEscritura = taTablas[lnContador, 3]

                            IF !loConexion.AgregarTabla(CREATEOBJECT('Tabla', ;
                                    lcTabla, lcAlias, llLecturaEscritura)) THEN
                                RETURN .F.
                            ENDIF
                        ENDIF
                    ENDFOR
                ELSE
                    RETURN .F.
                ENDIF
            ELSE
                RETURN .F.
            ENDIF
        ELSE
            RETURN .F.
        ENDIF

        RETURN loConexion
    ENDFUNC

ENDDEFINE