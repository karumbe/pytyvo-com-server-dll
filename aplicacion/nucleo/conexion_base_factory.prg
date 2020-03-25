DEFINE CLASS ConexionBaseFactory AS CUSTOM

    * Propiedades.
    PROTECTED oUtiles
    PROTECTED cClaseConexionBaseImpl

    * Inicialización de propiedades.
    cClaseConexionBaseImpl = 'ConexionBaseDBFImpl'

    **/
    * Constructor.
    *
    * @return boolean
    * true si puede crear la instancia y false en caso contrario.
    */
    FUNCTION Init
        THIS.oUtiles = CREATEOBJECT('Utiles')

        IF VARTYPE(THIS.oUtiles) != 'O' THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Crea una instancia de la clase ConexionBase.
    *
    * @return object ConexionBaseImpl
    * object si tiene éxito y false en caso contrario.
    */
    FUNCTION CrearConexion
        LPARAMETERS tcTipo

        * inicio { validación del parámetro }
        IF !THIS.oUtiles.ValidarTexto(tcTipo, 2, 13) THEN
            RETURN .F.
        ENDIF
        * fin { validación del parámetro }

        LOCAL loConexionBase
        loConexionBase = CREATEOBJECT(THIS.cClaseConexionBaseImpl)

        IF VARTYPE(loConexionBase) == 'O' THEN
            DO CASE
            CASE UPPER(tcTipo) == 'BUSQUEDA'
                RETURN loConexionBase.Busqueda()
            CASE UPPER(tcTipo) == 'MANTENIMIENTO'
                RETURN loConexionBase.Mantenimiento()
            CASE UPPER(tcTipo) == 'IR'
                RETURN loConexionBase.IntegridadReferencial()
            ENDCASE
        ENDIF

        RETURN .F.
    ENDFUNC

ENDDEFINE