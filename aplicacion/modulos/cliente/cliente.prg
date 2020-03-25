#INCLUDE 'constantes.h'

DO biblioteca.prg

DEFINE CLASS Cliente AS COMBase OLEPUBLIC

    * Inicialización de propiedades.
    cClaseConexion = 'ConexionClienteFactory'
    cClaseRepositorio = 'ClienteDAOFactory'

    **/
    * Crea el cursor que contendrá el resultado de la búsqueda.
    *
    * @return boolean true (default)
    */
    * @Override
    PROTECTED PROCEDURE CrearCursorResultado
        THIS.cResultado = THIS.oUtiles.CreaTemp()

        CREATE CURSOR (THIS.cResultado) ( ;
            codigo N(5), ;
            nombre C(56), ;
            direc1 C(60), ;
            direc2 C(60), ;
            direc3 C(60), ;
            direc4 C(60), ;
            direc5 C(60), ;
            direc6 C(60), ;
            direc7 C(60), ;
            direc8 C(60), ;
            direc9 C(60), ;
            departamen N(3), ;
            ciudad N(5), ;
            barrio N(5), ;
            telefono C(30), ;
            fax C(30), ;
            e_mail C(40), ;
            fechanac D(8), ;
            contacto C(30), ;
            ruc C(15), ;
            documento C(15), ;
            limite_cre N(9), ;
            fec_ioper D(8), ;
            motivoclie N(4), ;
            odatosclie C(40), ;
            saldo_actu N(12), ;
            saldo_usd N(12,2), ;
            obs1 C(72), ;
            obs2 C(72), ;
            obs3 C(72), ;
            obs4 C(72), ;
            obs5 C(72), ;
            obs6 C(72), ;
            obs7 C(72), ;
            obs8 C(72), ;
            obs9 C(72), ;
            obs10 C(72), ;
            ref1 C(72), ;
            ref2 C(72), ;
            ref3 C(72), ;
            ref4 C(72), ;
            ref5 C(72), ;
            lista N(1), ;
            plazo N(5), ;
            vendedor N(5), ;
            cuenta C(18), ;
            ruta N(5), ;
            facturar C(1), ;
            estado C(1) ;
        )
    ENDPROC

    **/
    * Carga los datos de un objeto (value object) al cursor de resultado de la
    * búsqueda.
    *
    * @return boolean true (default)
    */
    * @Override
    PROTECTED PROCEDURE CargarObjetoAlCursorResultado
        LPARAMETERS toModelo

        LOCAL loExcepcion

        IF VARTYPE(toModelo) == 'O' THEN
            TRY
                SELECT (THIS.cResultado)
                APPEND BLANK
                REPLACE codigo WITH toModelo.ObtenerCodigo(), ;
                        nombre WITH toModelo.ObtenerNombre(), ;
                        direc1 WITH toModelo.ObtenerDirec1(), ;
                        direc2 WITH toModelo.ObtenerDirec2(), ;
                        direc3 WITH toModelo.ObtenerDirec3(), ;
                        direc4 WITH toModelo.ObtenerDirec4(), ;
                        direc5 WITH toModelo.ObtenerDirec5(), ;
                        direc6 WITH toModelo.ObtenerDirec6(), ;
                        direc7 WITH toModelo.ObtenerDirec7(), ;
                        direc8 WITH toModelo.ObtenerDirec8(), ;
                        direc9 WITH toModelo.ObtenerDirec9(), ;
                        departamen WITH toModelo.ObtenerDepartamen(), ;
                        ciudad WITH toModelo.ObtenerCiudad(), ;
                        barrio WITH toModelo.ObtenerBarrio(), ;
                        telefono WITH toModelo.ObtenerTelefono(), ;
                        fax WITH toModelo.ObtenerFax(), ;
                        e_mail WITH toModelo.ObtenerCorreo(), ;
                        fechanac WITH toModelo.ObtenerFechaNac(), ;
                        contacto WITH toModelo.ObtenerContacto(), ;
                        ruc WITH toModelo.ObtenerRUC(), ;
                        documento WITH toModelo.ObtenerDocumento(), ;
                        limite_cre WITH toModelo.ObtenerLimiteCre(), ;
                        fec_ioper WITH toModelo.ObtenerFecIOper(), ;
                        motivoclie WITH toModelo.ObtenerMotivoClie(), ;
                        odatosclie WITH toModelo.ObtenerODatosClie(), ;
                        saldo_actu WITH toModelo.ObtenerSaldoActu(), ;
                        saldo_usd WITH toModelo.ObtenerSaldoUSD(), ;
                        obs1 WITH toModelo.ObtenerObs1(), ;
                        obs2 WITH toModelo.ObtenerObs2(), ;
                        obs3 WITH toModelo.ObtenerObs3(), ;
                        obs4 WITH toModelo.ObtenerObs4(), ;
                        obs5 WITH toModelo.ObtenerObs5(), ;
                        obs6 WITH toModelo.ObtenerObs6(), ;
                        obs7 WITH toModelo.ObtenerObs7(), ;
                        obs8 WITH toModelo.ObtenerObs8(), ;
                        obs9 WITH toModelo.ObtenerObs9(), ;
                        obs10 WITH toModelo.ObtenerObs10(), ;
                        ref1 WITH toModelo.ObtenerRef1(), ;
                        ref2 WITH toModelo.ObtenerRef2(), ;
                        ref3 WITH toModelo.ObtenerRef3(), ;
                        ref4 WITH toModelo.ObtenerRef4(), ;
                        ref5 WITH toModelo.ObtenerRef5(), ;
                        lista WITH toModelo.ObtenerLista(), ;
                        plazo WITH toModelo.ObtenerPlazo(), ;
                        vendedor WITH toModelo.ObtenerVendedor(), ;
                        cuenta WITH toModelo.ObtenerCuenta(), ;
                        ruta WITH toModelo.ObtenerRuta(), ;
                        facturar WITH toModelo.ObtenerFacturar(), ;
                        estado WITH toModelo.ObtenerEstado()
            CATCH TO loExcepcion
            ENDTRY
        ENDIF
    ENDPROC

ENDDEFINE