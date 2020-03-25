DEFINE CLASS ValidadorFactory AS CUSTOM

    * Propiedades.
    PROTECTED cClaseValidadorImpl

    * Inicialización de propiedades.
    cClaseValidadorImpl = 'ValidadorBaseDBFImpl'

    **/
    * Crea una instancia de la clase ValidadorBase.
    *
    * @return object
    * object instancia de la clase ValidorBaseImpl.
    */
    FUNCTION CrearValidador
        LPARAMETERS toModelo, tnBandera
        RETURN CREATEOBJECT(THIS.cClaseValidadorImpl, toModelo, tnBandera)
    ENDFUNC

ENDDEFINE