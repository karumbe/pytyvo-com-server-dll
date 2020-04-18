DEFINE CLASS DeparValidadorDBFImpl AS ValidadorBaseDBFImpl

    * Inicialización de propiedades.
    cClaseConexion = 'DeparConexionFactory'
    cClaseModelo = 'DeparVO'
    cClaseRepositorio = 'DeparDAOFactory'

    **/
    * Valida el parámetro tnCodigo.
    *
    * @field
    * codigo N(3) not null unique
    *
    * @param integer tnCodigo
    * Código a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION ValidarParamCodigo
        LPARAMETERS tnCodigo
        RETURN THIS.oUtiles.ValidarNumero(tnCodigo, 0, 999)
    ENDFUNC

ENDDEFINE
