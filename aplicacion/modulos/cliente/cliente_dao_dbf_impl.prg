DEFINE CLASS ClienteDAODBFImpl AS DAOBaseDBFImpl

    * Inicialización de propiedades.
    cTabla = 'clientes'
    cClaseModelo = 'ClienteVO'

    **/
    * Realiza una búsqueda por codigo, nombre, ruc y documento.
    *
    * @field
    * codigo N(5) not null unique
    * nombre C(56) not null unique
    * ruc C(15) not null unique
    * documento C(15) not null unique
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
    * @Override
    FUNCTION Obtener
        LPARAMETERS tcExpresion, tcCursor, tcCondicionFiltrado

        * inicio { validaciones de parámetros }
        IF VARTYPE(tcExpresion) == 'C' THEN
            tcExpresion = '%' + ALLTRIM(UPPER(tcExpresion)) + '%'
            tcExpresion = THIS.oUtiles.SanitizarValor(tcExpresion)
        ENDIF

        IF !THIS.oUtiles.ValidarTexto(tcExpresion, 2, 50) THEN
            RETURN .F.
        ENDIF

        IF !THIS.oUtiles.ValidarTexto(tcCursor, 8, 8) THEN
            RETURN .F.
        ENDIF

        IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
            IF !THIS.oUtiles.ValidarTexto(tcCondicionFiltrado, 6, 50) THEN
                RETURN .F.
            ENDIF
        ENDIF
        * fin { validaciones de parámetros }

        LOCAL lnCodigo, loExcepcion
        lnCodigo = INT(VAL(STRTRAN(tcExpresion, '%', '')))

        IF THIS.oConexion.Conectar() THEN
            TRY
                IF VARTYPE(tcCondicionFiltrado) == 'C' THEN
                    SELECT * ;
                    FROM ;
                        (THIS.cTabla) ;
                    WHERE ;
                        (codigo == lnCodigo OR ;
                        nombre LIKE tcExpresion OR ;
                        ruc LIKE tcExpresion OR ;
                        documento LIKE tcExpresion) AND ;
                        &tcCondicionFiltrado ;
                    ORDER BY ;
                        nombre ;
                    INTO CURSOR ;
                        tm_resultado
                ELSE
                    SELECT * ;
                    FROM ;
                        (THIS.cTabla) ;
                    WHERE ;
                        codigo == lnCodigo OR ;
                        nombre LIKE tcExpresion OR ;
                        ruc LIKE tcExpresion OR ;
                        documento LIKE tcExpresion ;
                    ORDER BY ;
                        nombre ;
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
            ENDTRY
        ENDIF
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
    * @Override
    FUNCTION EstaRelacionado
        LPARAMETERS tnCodigo

        * inicio { validación del parámetro }
        IF !THIS.ValidarParamCodigo(tnCodigo) THEN
            RETURN .T.
        ENDIF
        * fin { validación del parámetro }

        LOCAL llRelacionado, loExcepcion
        llRelacionado = .T.

        IF THIS.oConexion.Conectar() THEN
            TRY
                SELECT cobros
                SET ORDER TO TAG 'indice3'
                IF !SEEK(tnCodigo) THEN
                    SELECT devoluciones_clientes
                    SET ORDER TO TAG 'indice4'
                    IF !SEEK(tnCodigo) THEN
                        SELECT ordenes_trabajo
                        SET ORDER TO TAG 'indice4'
                        IF !SEEK(tnCodigo) THEN
                            SELECT pedidos_clientes
                            SET ORDER TO TAG 'indice3'
                            IF !SEEK(tnCodigo) THEN
                                SELECT pedidos_clientes_usd
                                SET ORDER TO TAG 'indice3'
                                IF !SEEK(tnCodigo) THEN
                                    SELECT presupuestos_clientes
                                    SET ORDER TO TAG 'indice3'
                                    IF !SEEK(tnCodigo) THEN
                                        SELECT remisiones_clientes
                                        SET ORDER TO TAG 'indice3'
                                        IF !SEEK(tnCodigo) THEN
                                            SELECT ventas
                                            SET ORDER TO TAG 'indice3'
                                            IF !SEEK(tnCodigo) THEN
                                                llRelacionado = .F.
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loExcepcion
                llRelacionado = .T.
            FINALLY
                THIS.oConexion.Desconectar()
            ENDTRY
        ENDIF

        RETURN llRelacionado
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
                .EstablecerCodigo(codigo)
                .EstablecerNombre(nombre)
                .EstablecerDirec1(direc1)
                .EstablecerDirec2(direc2)
                .EstablecerDirec3(direc3)
                .EstablecerDirec4(direc4)
                .EstablecerDirec5(direc5)
                .EstablecerDirec6(direc6)
                .EstablecerDirec7(direc7)
                .EstablecerDirec8(direc8)
                .EstablecerDirec9(direc9)
                .EstablecerDepartamen(departamen)
                .EstablecerCiudad(ciudad)
                .EstablecerBarrio(barrio)
                .EstablecerTelefono(telefono)
                .EstablecerFax(fax)
                .EstablecerCorreo(e_mail)
                .EstablecerFechaNac(fechanac)
                .EstablecerContacto(contacto)
                .EstablecerRUC(ruc)
                .EstablecerDocumento(documento)
                .EstablecerLimiteCre(limite_cre)
                .EstablecerFecIOper(fec_ioper)
                .EstablecerMotivoClie(motivoclie)
                .EstablecerODatosClie(odatosclie)
                .EstablecerSaldoActu(saldo_actu)
                .EstablecerSaldoUSD(saldo_usd)
                .EstablecerObs1(obs1)
                .EstablecerObs2(obs2)
                .EstablecerObs3(obs3)
                .EstablecerObs4(obs4)
                .EstablecerObs5(obs5)
                .EstablecerObs6(obs6)
                .EstablecerObs7(obs7)
                .EstablecerObs8(obs8)
                .EstablecerObs9(obs9)
                .EstablecerObs10(obs10)
                .EstablecerRef1(ref1)
                .EstablecerRef2(ref2)
                .EstablecerRef3(ref3)
                .EstablecerRef4(ref4)
                .EstablecerRef5(ref5)
                .EstablecerLista(lista)
                .EstablecerPlazo(plazo)
                .EstablecerVendedor(vendedor)
                .EstablecerCuenta(cuenta)
                .EstablecerRuta(ruta)
                .EstablecerFacturar(facturar)
                .EstablecerEstado(estado)
            ENDWITH
        CATCH TO loExcepcion
            toModelo = .F.
        ENDTRY

        RETURN toModelo
    ENDFUNC

    **/
    * Valida el parámetro tnCodigo.
    *
    * @field
    * codigo N(5) not null unique
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
        RETURN THIS.oUtiles.ValidarNumero(tnCodigo, 1, 99999)
    ENDFUNC

    **/
    * Valida el parámetro tcNombre.
    *
    * @field
    * nombre C(56) not null unique
    *
    * @param string tcNombre
    * Nombre a ser validado.
    *
    * @return boolean
    * true si es válido y false en caso contrario.
    */
    * @Override
    PROTECTED FUNCTION ValidarParamNombre
        LPARAMETERS tcNombre
        RETURN THIS.oUtiles.ValidarTexto(tcNombre, 3, 56)
    ENDFUNC

ENDDEFINE