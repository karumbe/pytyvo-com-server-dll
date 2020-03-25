DEFINE CLASS DAOFactory AS CUSTOM

    * Propiedades.
    PROTECTED cClaseDAOImpl

    * Inicialización de propiedades.
    cClaseDAOImpl = 'DAOBaseDBFImpl'

    **/
    * Crea una instancia de la clase DAOBase.
    *
    * @return object
    * object instancia de la clase DAOBaseImpl.
    */
    FUNCTION CrearDAO
        LPARAMETERS toConexion
        RETURN CREATEOBJECT(THIS.cClaseDAOImpl, toConexion)
    ENDFUNC

ENDDEFINE