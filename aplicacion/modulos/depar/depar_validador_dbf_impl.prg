DEFINE CLASS DeparValidadorDBFImpl AS ValidadorBaseDBFImpl

    * Inicializaci�n de propiedades.
    cClaseConexion = 'DeparConexionFactory'
    cClaseModelo = 'DeparVO'
    cClaseRepositorio = 'DeparDAOFactory'

    **/
    * Valida el par�metro tnCodigo.
    *
    * @field
    * codigo N(3) not null unique
    *
    * @param integer tnCodigo
    * C�digo a ser validado.
    *
    * @return boolean
    * true si es v�lido y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION ValidarParamCodigo
        LPARAMETERS tnCodigo
        RETURN THIS.oUtiles.ValidarNumero(tnCodigo, 0, 999)
    ENDFUNC

ENDDEFINE
