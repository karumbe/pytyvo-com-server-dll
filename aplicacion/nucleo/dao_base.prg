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
    * true si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION EstablecerConexion
        LPARAMETERS toConexion

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toConexion) != 'O' THEN
            RETURN .F.
        ENDIF

        IF LOWER(toConexion.Class) != LOWER('Conexion') THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

        THIS.oConexion = toConexion
    ENDFUNC

    **/
    * Verifica si un código existe.
    *
    * @field
    * codigo N(4) not null unique
    *
    * @param integer tnCodigo
    * Código a ser verificado.
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
    * Verifica si el registro está vigente.
    *
    * @field
    * vigente L(1) not null
    *
    * @param integer tnCodigo
    * Código a ser verificado.
    *
    * @return boolean
    * true si ésta vigente y false si no lo está u ocurre un error.
    */
    FUNCTION EstaVigente
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Genera un nuevo código para el registro.
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
    * Realiza una búsqueda por código.
    *
    * @field
    * codigo N(4) not null unique
    *
    * @param integer tnCodigo
    * Código a buscar.
    *
    * @return object|boolean
    * object si tiene éxito y false en caso contrario.
    */
    FUNCTION ObtenerPorCodigo
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Realiza una búsqueda por nombre.
    *
    * @field
    * nombre C(30) not null unique
    *
    * @param string tcNombre
    * Nombre a buscar.
    *
    * @return object|boolean
    * object si tiene éxito y false en caso contrario.
    */
    FUNCTION ObtenerPorNombre
        LPARAMETERS tcNombre
        RETURN .F.
    ENDFUNC

    **/
    * Realiza una búsqueda por codigo, nombre.
    *
    * @field
    * codigo N(4) not null unique
    * nombre C(30) not null unique
    *
    * @param string tcExpresion
    * Expresión a buscar.
    *
    * @param string tcCursor
    * Cursor en el cual se guardará el resultado de la búsqueda.
    *
    * @param string tcCondicionFiltrado (opcional)
    * Condición de filtrado de registros.
    *
    * @return cursor|boolean
    * cursor|true si tiene éxito y false en caso contrario.
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
    * true si tiene éxito y false en caso contrario.
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
    * true si tiene éxito y false en caso contrario.
    */
    FUNCTION Modificar
        LPARAMETERS toModelo
        RETURN .F.
    ENDFUNC

    **/
    * Borra un registro existente.
    *
    * @param integer tnCodigo
    * Código a ser borrado.
    *
    * @return boolean
    * true si tiene éxito y false en caso contrario.
    */
    FUNCTION Borrar
        LPARAMETERS tnCodigo
        RETURN .F.
    ENDFUNC

    **/
    * Verifica la integridad referencial de un registro.
    *
    * @param integer tnCodigo
    * Código a ser verificado.
    *
    * @return boolean
    * true si está relacionado u ocurre un error y false en caso contrario.
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
    * object si tiene éxito y false en caso contrario.
    */
    PROTECTED FUNCTION CargarDatos
        LPARAMETERS toModelo

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toModelo) != 'O' THEN
            RETURN .F.
        ENDIF

        IF LOWER(toModelo.Class) != LOWER(THIS.cClaseModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }

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
    * true si es válido y false en caso contrario.
    */
    PROTECTED FUNCTION EsObjeto
        LPARAMETERS toModelo

        * inicio { validaciones del parámetro }
        IF PARAMETERS() < 1 THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(toModelo) != 'O' THEN
            RETURN .F.
        ENDIF

        IF LOWER(toModelo.Class) != LOWER(THIS.cClaseModelo) THEN
            RETURN .F.
        ENDIF
        * fin { validaciones del parámetro }
    ENDFUNC

ENDDEFINE