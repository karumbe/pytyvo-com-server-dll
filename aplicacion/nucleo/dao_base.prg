* @Interface
DEFINE CLASS DAOBase AS CUSTOM

    * Propiedades.
    PROTECTED oUtiles
    PROTECTED oConexion
    PROTECTED cTabla
    PROTECTED cClaseModelo

    **/
    * Constructor.
    *
    * @param object toConexion
    * Objeto conexion.
    *
    * @return boolean
    * true si puede crear la instancia y false en caso contrario.
    */
    FUNCTION Init
        LPARAMETERS toConexion

        THIS.oUtiles = CREATEOBJECT('Utiles')

        IF VARTYPE(THIS.oUtiles) != 'O' OR ;
                !THIS.EstablecerConexion(toConexion) THEN
            RETURN .F.
        ENDIF
    ENDFUNC

    **/
    * Establece el objeto conexion.
    *
    * @param object toConexion
    * Objeto conexion.
    *
    * @return boolean
    * true si tiene �xito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerConexion
        LPARAMETERS toConexion

        * inicio { validaciones del par�metro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toConexion) != 'O' THEN
            RETURN .F.
        ENDIF

        IF LOWER(toConexion.Class) != LOWER('Conexion') THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del par�metro }

        THIS.oConexion = toConexion
    ENDFUNC

    **/
    * Verifica si un c�digo existe.
    *
    * @field
    * codigo N(4) not null unique
    *
    * @param integer tnCodigo
    * C�digo a ser verificado.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    FUNCTION CodigoExiste
        LPARAMETERS tnCodigo
        RETURN .T.
    ENDFUNC

    **/
    * Verifica si un nombre existe.
    *
    * @field
    * nombre C(30) not null unique
    *
    * @param string tcNombre
    * Nombre a ser verificado.
    *
    * @return boolean
    * true si existe u ocurre un error y false en caso contrario.
    */
    FUNCTION NombreExiste
        LPARAMETERS tcNombre
        RETURN .T.
    ENDFUNC

    **/
    * Verifica si el registro est� vigente.
    *
    * @field
    * vigente L(1) not null
    *
    * @param integer tnCodigo
    * C�digo a ser verificado.
    *
    * @return boolean
    * true si �sta vigente y false si no lo est� u ocurre un error.
    */
    FUNCTION EstaVigente
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Genera un nuevo c�digo para el registro.
    *
    * @field
    * codigo N(4) not null unique
    *
    * @return integer
    */
    FUNCTION NuevoCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Realiza una b�squeda por c�digo.
    *
    * @field
    * codigo N(4) not null unique
    *
    * @param integer tnCodigo
    * C�digo a buscar.
    *
    * @return object|boolean
    * object si tiene �xito y false en caso contrario.
    */
    FUNCTION ObtenerPorCodigo
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Realiza una b�squeda por nombre.
    *
    * @field
    * nombre C(30) not null unique
    *
    * @param string tcNombre
    * Nombre a buscar.
    *
    * @return object|boolean
    * object si tiene �xito y false en caso contrario.
    */
    FUNCTION ObtenerPorNombre
        LPARAMETERS tcNombre
        RETURN .F.
    ENDFUNC

    **/
    * Realiza una b�squeda por codigo, nombre.
    *
    * @field
    * codigo N(4) not null unique
    * nombre C(30) not null unique
    *
    * @param string tcExpresion
    * Expresi�n a buscar.
    *
    * @param string tcCursor
    * Cursor en el cual se guardar� el resultado de la b�squeda.
    *
    * @param string tcCondicionFiltrado (opcional)
    * Condici�n de filtrado de registros.
    *
    * @return cursor|boolean
    * cursor|true si tiene �xito y false en caso contrario.
    */
    FUNCTION Obtener
        LPARAMETERS tcExpresion, tcCursor, tcCondicionFiltrado
        RETURN .F.
    ENDFUNC

    **/
    * Agrega un nuevo registro.
    *
    * @param object modelo
    * Objeto a ser agregado.
    *
    * @return boolean
    * true si tiene �xito y false en caso contrario.
    */
    FUNCTION Agregar
        LPARAMETERS toModelo
        RETURN .F.
    ENDFUNC

    **/
    * Modifica un registro existente.
    *
    * @param object modelo
    * Objeto a ser modificado.
    *
    * @return boolean
    * true si tiene �xito y false en caso contrario.
    */
    FUNCTION Modificar
        LPARAMETERS toModelo
        RETURN .F.
    ENDFUNC

    **/
    * Borra un registro existente.
    *
    * @param integer tnCodigo
    * C�digo a ser borrado.
    *
    * @return boolean
    * true si tiene �xito y false en caso contrario.
    */
    FUNCTION Borrar
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Verifica la integridad referencial de un registro.
    *
    * @param integer tnCodigo
    * C�digo a ser verificado.
    *
    * @return boolean
    * true si est� relacionado u ocurre un error y false en caso contrario.
    */
    FUNCTION EstaRelacionado
        LPARAMETERS tnCodigo
        RETURN .T.
    ENDFUNC

    **/
    * Carga los datos de la tabla a un objeto.
    *
    * @param object toModelo
    * Objeto a ser cargado.
    *
    * @return object
    * object si tiene �xito y false en caso contrario.
    */
    PROTECTED FUNCTION CargarDatos
        LPARAMETERS toModelo

        * inicio { validaciones del par�metro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toModelo) != 'O' THEN
            RETURN .F.
        ENDIF

        IF LOWER(toModelo.Class) != LOWER(THIS.cClaseModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del par�metro }

        TRY
            WITH toModelo
                .EstablecerCodigo(codigo)
                .EstablecerNombre(nombre)
                .EstablecerVigente(vigente)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

    **/
    * Valida el objeto modelo.
    *
    * @param object toModelo
    * Objeto modelo.
    *
    * @return boolean
    * true si es v�lido y false en caso contrario.
    */
    PROTECTED FUNCTION EsObjeto
        LPARAMETERS toModelo

        * inicio { validaciones del par�metro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toModelo) != 'O' THEN
            RETURN .F.
        ENDIF

        IF LOWER(toModelo.Class) != LOWER(THIS.cClaseModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del par�metro }
    ENDFUNC

ENDDEFINE