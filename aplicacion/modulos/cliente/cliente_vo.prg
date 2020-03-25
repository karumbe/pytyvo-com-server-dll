DEFINE CLASS ClienteVO AS VOBase

    * Propiedades.
    PROTECTED cDirec1
    PROTECTED cDirec2
    PROTECTED cDirec3
    PROTECTED cDirec4
    PROTECTED cDirec5
    PROTECTED cDirec6
    PROTECTED cDirec7
    PROTECTED cDirec8
    PROTECTED cDirec9
    PROTECTED nDepartamen
    PROTECTED nCiudad
    PROTECTED nBarrio
    PROTECTED cTelefono
    PROTECTED cFax
    PROTECTED cCorreo
    PROTECTED dFechaNac
    PROTECTED cContacto
    PROTECTED cRUC
    PROTECTED cDocumento
    PROTECTED nLimiteCre
    PROTECTED dFecIOper
    PROTECTED nMotivoClie
    PROTECTED cODatosClie
    PROTECTED nSaldoActu
    PROTECTED nSaldoUSD
    PROTECTED cObs1
    PROTECTED cObs2
    PROTECTED cObs3
    PROTECTED cObs4
    PROTECTED cObs5
    PROTECTED cObs6
    PROTECTED cObs7
    PROTECTED cObs8
    PROTECTED cObs9
    PROTECTED cObs10
    PROTECTED cRef1
    PROTECTED cRef2
    PROTECTED cRef3
    PROTECTED cRef4
    PROTECTED cRef5
    PROTECTED nLista
    PROTECTED nPlazo
    PROTECTED nVendedor
    PROTECTED cCuenta
    PROTECTED nRuta
    PROTECTED cFacturar
    PROTECTED cEstado

    **/
    * Devuelve la direcci�n 1.
    *
    * @return string
    */
    FUNCTION ObtenerDirec1
        RETURN THIS.cDirec1
    ENDFUNC

    **/
    * Devuelve la direcci�n 2.
    *
    * @return string
    */
    FUNCTION ObtenerDirec2
        RETURN THIS.cDirec2
    ENDFUNC

    **/
    * Devuelve la direcci�n 3.
    *
    * @return string
    */
    FUNCTION ObtenerDirec3
        RETURN THIS.cDirec3
    ENDFUNC

    **/
    * Devuelve la direcci�n 4.
    *
    * @return string
    */
    FUNCTION ObtenerDirec4
        RETURN THIS.cDirec4
    ENDFUNC

    **/
    * Devuelve la direcci�n 5.
    *
    * @return string
    */
    FUNCTION ObtenerDirec5
        RETURN THIS.cDirec5
    ENDFUNC

    **/
    * Devuelve la direcci�n 6.
    *
    * @return string
    */
    FUNCTION ObtenerDirec6
        RETURN THIS.cDirec6
    ENDFUNC

    **/
    * Devuelve la direcci�n 7.
    *
    * @return string
    */
    FUNCTION ObtenerDirec7
        RETURN THIS.cDirec7
    ENDFUNC

    **/
    * Devuelve la direcci�n 8.
    *
    * @return string
    */
    FUNCTION ObtenerDirec8
        RETURN THIS.cDirec8
    ENDFUNC

    **/
    * Devuelve la direcci�n 9.
    *
    * @return string
    */
    FUNCTION ObtenerDirec9
        RETURN THIS.cDirec9
    ENDFUNC

    **/
    * Devuelve el c�digo del departamento.
    *
    * @return integer
    */
    FUNCTION ObtenerDepartamen
        RETURN THIS.nDepartamen
    ENDFUNC

    **/
    * Devuelve el c�digo de la ciudad.
    *
    * @return integer
    */
    FUNCTION ObtenerCiudad
        RETURN THIS.nCiudad
    ENDFUNC

    **/
    * Devuelve el c�digo del barrio.
    *
    * @return integer
    */
    FUNCTION ObtenerBarrio
        RETURN THIS.nBarrio
    ENDFUNC

    **/
    * Devuelve el n�mero de tel�fono.
    *
    * @return string
    */
    FUNCTION ObtenerTelefono
        RETURN THIS.cTelefono
    ENDFUNC

    **/
    * Devuelve el n�mero de fax.
    *
    * @return string
    */
    FUNCTION ObtenerFax
        RETURN THIS.cFax
    ENDFUNC

    **/
    * Devuelve la direcci�n de correo electr�nico.
    *
    * @return string
    */
    FUNCTION ObtenerCorreo
        RETURN THIS.cCorreo
    ENDFUNC

    **/
    * Devuelve la fecha de nacimiento.
    *
    * @return date
    */
    FUNCTION ObtenerFechaNac
        RETURN THIS.dFechaNac
    ENDFUNC

    **/
    * Devuelve el nombre del contacto.
    *
    * @return string
    */
    FUNCTION ObtenerContacto
        RETURN THIS.cContacto
    ENDFUNC

    **/
    * Devuelve el n�mero de RUC.
    *
    * @return string
    */
    FUNCTION ObtenerRUC
        RETURN THIS.cRUC
    ENDFUNC

    **/
    * Devuelve el n�mero de documento.
    *
    * @return string
    */
    FUNCTION ObtenerDocumento
        RETURN THIS.cDocumento
    ENDFUNC

    **/
    * Devuelve el l�mite de cr�dito en Guaran�es.
    *
    * @return integer
    */
    FUNCTION ObtenerLimiteCre
        RETURN THIS.nLimiteCre
    ENDFUNC

    **/
    * Devuelve la fecha de inicio de operaciones.
    *
    * @return date
    */
    FUNCTION ObtenerFecIOper
        RETURN THIS.dFecIOper
    ENDFUNC

    **/
    * Devuelve el c�digo del motivo de ser cliente.
    *
    * @return integer
    */
    FUNCTION ObtenerMotivoClie
        RETURN THIS.nMotivoClie
    ENDFUNC

    **/
    * Devuelve otros datos del cliente.
    *
    * @return string
    */
    FUNCTION ObtenerODatosClie
        RETURN THIS.cODatosClie
    ENDFUNC

    **/
    * Devuelve el saldo actual en Guaran�es.
    *
    * @return integer
    */
    FUNCTION ObtenerSaldoActu
        RETURN THIS.nSaldoActu
    ENDFUNC

    **/
    * Devuelve el saldo actual en D�lares Estadounidenses.
    *
    * @return decimal
    */
    FUNCTION ObtenerSaldoUSD
        RETURN THIS.nSaldoUSD
    ENDFUNC

    **/
    * Devuelve la observaci�n 1.
    *
    * @return string
    */
    FUNCTION ObtenerObs1
        RETURN THIS.cObs1
    ENDFUNC

    **/
    * Devuelve la observaci�n 2.
    *
    * @return string
    */
    FUNCTION ObtenerObs2
        RETURN THIS.cObs2
    ENDFUNC

    **/
    * Devuelve la observaci�n 3.
    *
    * @return string
    */
    FUNCTION ObtenerObs3
        RETURN THIS.cObs3
    ENDFUNC

    **/
    * Devuelve la observaci�n 4.
    *
    * @return string
    */
    FUNCTION ObtenerObs4
        RETURN THIS.cObs4
    ENDFUNC

    **/
    * Devuelve la observaci�n 5.
    *
    * @return string
    */
    FUNCTION ObtenerObs5
        RETURN THIS.cObs5
    ENDFUNC

    **/
    * Devuelve la observaci�n 6.
    *
    * @return string
    */
    FUNCTION ObtenerObs6
        RETURN THIS.cObs6
    ENDFUNC

    **/
    * Devuelve la observaci�n 7.
    *
    * @return string
    */
    FUNCTION ObtenerObs7
        RETURN THIS.cObs7
    ENDFUNC

    **/
    * Devuelve la observaci�n 8.
    *
    * @return string
    */
    FUNCTION ObtenerObs8
        RETURN THIS.cObs8
    ENDFUNC

    **/
    * Devuelve la observaci�n 9.
    *
    * @return string
    */
    FUNCTION ObtenerObs9
        RETURN THIS.cObs9
    ENDFUNC

    **/
    * Devuelve la observaci�n 10.
    *
    * @return string
    */
    FUNCTION ObtenerObs10
        RETURN THIS.cObs10
    ENDFUNC

    **/
    * Devuelve la referencia 1.
    *
    * @return string
    */
    FUNCTION ObtenerRef1
        RETURN THIS.cRef1
    ENDFUNC

    **/
    * Devuelve la referencia 2.
    *
    * @return string
    */
    FUNCTION ObtenerRef2
        RETURN THIS.cRef2
    ENDFUNC

    **/
    * Devuelve la referencia 3.
    *
    * @return string
    */
    FUNCTION ObtenerRef3
        RETURN THIS.cRef3
    ENDFUNC

    **/
    * Devuelve la referencia 4.
    *
    * @return string
    */
    FUNCTION ObtenerRef4
        RETURN THIS.cRef4
    ENDFUNC

    **/
    * Devuelve la referencia 5.
    *
    * @return string
    */
    FUNCTION ObtenerRef5
        RETURN THIS.cRef5
    ENDFUNC

    **/
    * Devuelve el n�mero de lista de precios.
    *
    * @return integer
    */
    FUNCTION ObtenerLista
        RETURN THIS.nLista
    ENDFUNC

    **/
    * Devuelve el c�digo del plazo del cr�dito.
    *
    * @return integer
    */
    FUNCTION ObtenerPlazo
        RETURN THIS.nPlazo
    ENDFUNC

    **/
    * Devuelve el c�digo del vendedor.
    *
    * @return integer
    */
    FUNCTION ObtenerVendedor
        RETURN THIS.nVendedor
    ENDFUNC

    **/
    * Devuelve el c�digo de la cuenta de mayor.
    *
    * @return string
    */
    FUNCTION ObtenerCuenta
        RETURN THIS.cCuenta
    ENDFUNC

    **/
    * Devuelve el c�digo de la ruta.
    *
    * @return integer
    */
    FUNCTION ObtenerRuta
        RETURN THIS.nRuta
    ENDFUNC

    **/
    * Devuelve si se puede facturar con cuenta atrasada.
    *
    * @return string
    * 'S' si se puede y 'N' en caso contrario (predeterminado).
    */
    FUNCTION ObtenerFacturar
        RETURN THIS.cFacturar
    ENDFUNC

    **/
    * Devuelve si el cliente est� activo.
    *
    * @return string
    * 'A' si lo est� e 'I' en caso contrario (predeterminado).
    */
    FUNCTION ObtenerEstado
        RETURN THIS.cEstado
    ENDFUNC

    **/
    * Establece la direcci�n 1.
    *
    * @param string tcDirec1
    * Direcci�n 1.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDirec1
        LPARAMETERS tcDirec1
        THIS.cDirec1 = ALLTRIM(UPPER(tcDirec1))
    ENDFUNC

    **/
    * Establece la direcci�n 2.
    *
    * @param string tcDirec2
    * Direcci�n 2.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDirec2
        LPARAMETERS tcDirec2
        THIS.cDirec2 = ALLTRIM(UPPER(tcDirec2))
    ENDFUNC

    **/
    * Establece la direcci�n 3.
    *
    * @param string tcDirec3
    * Direcci�n 3.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDirec3
        LPARAMETERS tcDirec3
        THIS.cDirec3 = ALLTRIM(UPPER(tcDirec3))
    ENDFUNC

    **/
    * Establece la direcci�n 4.
    *
    * @param string tcDirec4
    * Direcci�n 4.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDirec4
        LPARAMETERS tcDirec4
        THIS.cDirec4 = ALLTRIM(UPPER(tcDirec4))
    ENDFUNC

    **/
    * Establece la direcci�n 5.
    *
    * @param string tcDirec5
    * Direcci�n 5.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDirec5
        LPARAMETERS tcDirec5
        THIS.cDirec5 = ALLTRIM(UPPER(tcDirec5))
    ENDFUNC

    **/
    * Establece la direcci�n 6.
    *
    * @param string tcDirec6
    * Direcci�n 6.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDirec6
        LPARAMETERS tcDirec6
        THIS.cDirec6 = ALLTRIM(UPPER(tcDirec6))
    ENDFUNC

    **/
    * Establece la direcci�n 7.
    *
    * @param string tcDirec7
    * Direcci�n 7.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDirec7
        LPARAMETERS tcDirec7
        THIS.cDirec7 = ALLTRIM(UPPER(tcDirec7))
    ENDFUNC

    **/
    * Establece la direcci�n 8.
    *
    * @param string tcDirec8
    * Direcci�n 8.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDirec8
        LPARAMETERS tcDirec8
        THIS.cDirec8 = ALLTRIM(UPPER(tcDirec8))
    ENDFUNC

    **/
    * Establece la direcci�n 9.
    *
    * @param string tcDirec9
    * Direcci�n 9.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDirec9
        LPARAMETERS tcDirec9
        THIS.cDirec9 = ALLTRIM(UPPER(tcDirec9))
    ENDFUNC

    **/
    * Establece el c�digo del departamento.
    *
    * @param integer tnDepartamen
    * C�digo del departamento.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDepartamen
        LPARAMETERS tnDepartamen
        THIS.nDepartamen = tnDepartamen
    ENDFUNC

    **/
    * Establece el c�digo de la ciudad.
    *
    * @param integer tnCiudad
    * C�digo de la ciudad.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerCiudad
        LPARAMETERS tnCiudad
        THIS.nCiudad = tnCiudad
    ENDFUNC

    **/
    * Establece el c�digo del barrio.
    *
    * @param integer tnBarrio
    * C�digo del barrio.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerBarrio
        LPARAMETERS tnBarrio
        THIS.nBarrio = tnBarrio
    ENDFUNC

    **/
    * Establece el n�mero de tel�fono.
    *
    * @param string tcTelefono
    * N�mero de tel�fono.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerTelefono
        LPARAMETERS tcTelefono
        THIS.cTelefono = ALLTRIM(UPPER(tcTelefono))
    ENDFUNC

    **/
    * Establece el n�mero de fax.
    *
    * @param string tcFax
    * N�mero de fax.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerFax
        LPARAMETERS tcFax
        THIS.cFax = ALLTRIM(UPPER(tcFax))
    ENDFUNC

    **/
    * Establece la direcci�n de correo electr�nico.
    *
    * @param string tcCorreo
    * Direcci�n de correo electr�nico.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerCorreo
        LPARAMETERS tcCorreo
        THIS.cCorreo = ALLTRIM(LOWER(tcCorreo))
    ENDFUNC

    **/
    * Establece la fecha de nacimiento.
    *
    * @param date tdFechaNac
    * Fecha de nacimiento.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerFechaNac
        LPARAMETERS tdFechaNac
        THIS.dFechaNac = tdFechaNac
    ENDFUNC

    **/
    * Establece el nombre del contacto.
    *
    * @param string tcContacto
    * Nombre del contacto.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerContacto
        LPARAMETERS tcContacto
        THIS.cContacto = ALLTRIM(UPPER(tcContacto))
    ENDFUNC

    **/
    * Establece el n�mero de RUC.
    *
    * @param string tcRUC
    * N�mero de RUC.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerRUC
        LPARAMETERS tcRUC
        THIS.cRUC = ALLTRIM(UPPER(tcRUC))
    ENDFUNC

    **/
    * Establece el n�mero de documento.
    *
    * @param string tcDocumento
    * N�mero de documento.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerDocumento
        LPARAMETERS tcDocumento
        THIS.cDocumento = ALLTRIM(UPPER(tcDocumento))
    ENDFUNC

    **/
    * Establece el l�mite de cr�dito en Guaran�es.
    *
    * @param integer tnLimiteCre
    * L�mite de cr�dito en Guaran�es.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerLimiteCre
        LPARAMETERS tnLimiteCre
        THIS.nLimiteCre = tnLimiteCre
    ENDFUNC

    **/
    * Establece la fecha de inicio de operaciones.
    *
    * @param date tdFecIOper
    * Fecha de inicio de operaciones.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerFecIOper
        LPARAMETERS tdFecIOper
        THIS.dFecIOper = tdFecIOper
    ENDFUNC

    **/
    * Establece el c�digo del motivo de ser cliente.
    *
    * @param integer tnMotivoClie
    * C�digo del motivo de ser cliente.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerMotivoClie
        LPARAMETERS tnMotivoClie
        THIS.nMotivoClie = tnMotivoClie
    ENDFUNC

    **/
    * Establece otros datos del cliente.
    *
    * @param string tcODatosClie
    * Otros datos del cliente.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerODatosClie
        LPARAMETERS tcODatosClie
        THIS.cODatosClie = ALLTRIM(UPPER(tcODatosClie))
    ENDFUNC

    **/
    * Establece el saldo actual en Guaran�es.
    *
    * @param integer tnSaldoActu
    * Saldo actual en Guaran�es.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerSaldoActu
        LPARAMETERS tnSaldoActu
        THIS.nSaldoActu = tnSaldoActu
    ENDFUNC

    **/
    * Establece el saldo actual en D�lares Estadounidenses.
    *
    * @param decimal tnSaldoUSD
    * Saldo actual en D�lares Estadounidenses.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerSaldoUSD
        LPARAMETERS tnSaldoUSD
        THIS.nSaldoUSD = tnSaldoUSD
    ENDFUNC

    **/
    * Establece la observaci�n 1.
    *
    * @param string tcObs1
    * Observaci�n 1.
    *
    * @return boolean true (default)
    */

    FUNCTION EstablecerObs1
        LPARAMETERS tcObs1
        THIS.cObs1 = ALLTRIM(UPPER(tcObs1))
    ENDFUNC

    **/
    * Establece la observaci�n 2.
    *
    * @param string tcObs2
    * Observaci�n 2.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerObs2
        LPARAMETERS tcObs2
        THIS.cObs2 = ALLTRIM(UPPER(tcObs2))
    ENDFUNC

    **/
    * Establece la observaci�n 3.
    *
    * @param string tcObs3
    * Observaci�n 3.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerObs3
        LPARAMETERS tcObs3
        THIS.cObs3 = ALLTRIM(UPPER(tcObs3))
    ENDFUNC

    **/
    * Establece la observaci�n 4.
    *
    * @param string tcObs4
    * Observaci�n 4.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerObs4
        LPARAMETERS tcObs4
        THIS.cObs4 = ALLTRIM(UPPER(tcObs4))
    ENDFUNC

    **/
    * Establece la observaci�n 5.
    *
    * @param string tcObs5
    * Observaci�n 5.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerObs5
        LPARAMETERS tcObs5
        THIS.cObs5 = ALLTRIM(UPPER(tcObs5))
    ENDFUNC

    **/
    * Establece la observaci�n 6.
    *
    * @param string tcObs6
    * Observaci�n 6.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerObs6
        LPARAMETERS tcObs6
        THIS.cObs6 = ALLTRIM(UPPER(tcObs6))
    ENDFUNC

    **/
    * Establece la observaci�n 7.
    *
    * @param string tcObs7
    * Observaci�n 7.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerObs7
        LPARAMETERS tcObs7
        THIS.cObs7 = ALLTRIM(UPPER(tcObs7))
    ENDFUNC

    **/
    * Establece la observaci�n 8.
    *
    * @param string tcObs8
    * Observaci�n 8.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerObs8
        LPARAMETERS tcObs8
        THIS.cObs8 = ALLTRIM(UPPER(tcObs8))
    ENDFUNC

    **/
    * Establece la observaci�n 9.
    *
    * @param string tcObs9
    * Observaci�n 9.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerObs9
        LPARAMETERS tcObs9
        THIS.cObs9 = ALLTRIM(UPPER(tcObs9))
    ENDFUNC

    **/
    * Establece la observaci�n 10.
    *
    * @param string tcObs10
    * Observaci�n 10.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerObs10
        LPARAMETERS tcObs10
        THIS.cObs10 = ALLTRIM(UPPER(tcObs10))
    ENDFUNC

    **/
    * Establece la referencia 1.
    *
    * @param string tcRef1
    * Referencia 1.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerRef1
        LPARAMETERS tcRef1
        THIS.cRef1 = ALLTRIM(UPPER(tcRef1))
    ENDFUNC

    **/
    * Establece la referencia 2.
    *
    * @param string tcRef2
    * Referencia 2.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerRef2
        LPARAMETERS tcRef2
        THIS.cRef2 = ALLTRIM(UPPER(tcRef2))
    ENDFUNC

    **/
    * Establece la referencia 3.
    *
    * @param string tcRef3
    * Referencia 3.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerRef3
        LPARAMETERS tcRef3
        THIS.cRef3 = ALLTRIM(UPPER(tcRef3))
    ENDFUNC

    **/
    * Establece la referencia 4.
    *
    * @param string tcRef4
    * Referencia 4.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerRef4
        LPARAMETERS tcRef4
        THIS.cRef4 = ALLTRIM(UPPER(tcRef4))
    ENDFUNC

    **/
    * Establece la referencia 5.
    *
    * @param string tcRef5
    * Referencia 5.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerRef5
        LPARAMETERS tcRef5
        THIS.cRef5 = ALLTRIM(UPPER(tcRef5))
    ENDFUNC

    **/
    * Establece el n�mero de lista de precios.
    *
    * @param integer tnLista
    * N�mero de lista de precios.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerLista
        LPARAMETERS tnLista
        THIS.nLista = tnLista
    ENDFUNC

    **/
    * Establece el c�digo del plazo del cr�dito.
    *
    * @param integer tnPlazo
    * C�digo del plazo del cr�dito.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerPlazo
        LPARAMETERS tnPlazo
        THIS.nPlazo = tnPlazo
    ENDFUNC

    **/
    * Establece el c�digo del vendedor.
    *
    * @param integer tnVendedor
    * C�digo del vendedor.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerVendedor
        LPARAMETERS tnVendedor
        THIS.nVendedor = tnVendedor
    ENDFUNC

    **/
    * Establece el c�digo de la cuenta de mayor.
    *
    * @param string tcCuenta
    * C�digo de la cuenta de mayor.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerCuenta
        LPARAMETERS tcCuenta
        THIS.cCuenta = ALLTRIM(UPPER(tcCuenta))
    ENDFUNC

    **/
    * Establece el c�digo de la ruta.
    *
    * @param integer tnRuta
    * C�digo de la ruta.
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerRuta
        LPARAMETERS tnRuta
        THIS.nRuta = tnRuta
    ENDFUNC

    **/
    * Establece si se puede facturar con cuenta atrasada.
    *
    * @param string tcFacturar
    * 'S' si se puede y 'N' en caso contrario (predeterminado).
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerFacturar
        LPARAMETERS tcFacturar
        THIS.cFacturar = ALLTRIM(UPPER(tcFacturar))

        IF THIS.cFacturar != 'S' THEN
            THIS.cFacturar = 'N'
        ENDIF
    ENDFUNC

    **/
    * Establece si el cliente est� activo.
    *
    * @param string tcEstado
    * 'A' si lo est� e 'I' en caso contrario (predeterminado).
    *
    * @return boolean true (default)
    */
    FUNCTION EstablecerEstado
        LPARAMETERS tcEstado
        THIS.cEstado = ALLTRIM(UPPER(tcEstado))

        IF THIS.cEstado != 'A' THEN
            THIS.cEstado = 'I'
        ENDIF
    ENDFUNC

ENDDEFINE