DEFINE CLASS PermisoDAODBFImpl AS DAOBaseDBFImpl

    * Inicialización de propiedades.
    cTabla = 'permisos'
    cClaseModelo = 'PermisoVO'

    **/
    * Recupera todos los registros.
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
    * @Override
    FUNCTION ObtenerTodos
        LPARAMETERS tcCursor, tcCondicionFiltrado

        * inicio { validaciones de parámetros }
        IF !THIS.oUtiles.ValidarTexto(tcCursor, 8, 8) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
            IF !THIS.oUtiles.ValidarTexto(tcCondicionFiltrado, 6, 50) THEN
                RETURN .F.
            ENDIF
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL loExcepcion

        IF THIS.oConexion.Conectar() THEN
            TRY
                IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
                    SELECT ;
                        usuario, ;
                        prgname AS modulo, ;
                        access AS acceder, ;
                        add AS agregar, ;
                        edit AS modificar, ;
                        delete AS borrar, ;
                        print AS imprimir ;
                    FROM ;
                        (THIS.cTabla) ;
                    WHERE ;
                        &tcCondicionFiltrado ;
                    ORDER BY ;
                        prgname ;
                    INTO CURSOR ;
                        tm_resultado
                ELSE
                    SELECT ;
                        usuario, ;
                        prgname AS modulo, ;
                        access AS acceder, ;
                        add AS agregar, ;
                        edit AS modificar, ;
                        delete AS borrar, ;
                        print AS imprimir ;
                    FROM ;
                        (THIS.cTabla) ;
                    ORDER BY ;
                        prgname ;
                    INTO CURSOR ;
                        tm_resultado
                ENDIF

                IF RECCOUNT('tm_resultado') > 0 THEN
                    SELECT * FROM tm_resultado INTO CURSOR (tcCursor)
                ENDIF

                SELECT tm_resultado
                USE
            CATCH TO loExcepcion
            FINALLY
                THIS.oConexion.Desconectar()
                WAIT CLEAR
            ENDTRY
        ENDIF
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
    * @Override
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
                .EstablecerUsuario(usuario)
                .EstablecerModulo(modulo)
                .EstablecerAcceder(acceder)
                .EstablecerAgregar(agregar)
                .EstablecerModificar(modificar)
                .EstablecerBorrar(borrar)
                .EstablecerImprimir(imprimir)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

ENDDEFINE