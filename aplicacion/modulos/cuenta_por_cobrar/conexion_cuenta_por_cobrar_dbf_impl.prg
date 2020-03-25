DEFINE CLASS ConexionCuentaPorCobrarDBFImpl AS ConexionBaseDBFImpl

    **/
    * Conexion para realizar búsqueda.
    *
    * @return object
    * object si tiene éxito y false en caso contrario.
    */
    * @Override
    FUNCTION Busqueda
        * {fila, 1} Tabla  |  {fila, 2} Alias  |  {fila, 3} Lectura y escritura.
        DIMENSION laTablas[6,3]
        EXTERNAL ARRAY taTablas

        laTablas[1,1] = 'ciudades'
        laTablas[1,2] = 'ciudades'
        laTablas[2,1] = 'clientes'
        laTablas[2,2] = 'clientes'
        laTablas[3,1] = 'cuotas_v'
        laTablas[3,2] = 'cuotas_ventas'
        laTablas[4,1] = 'depar'
        laTablas[4,2] = 'departamentos'
        laTablas[5,1] = 'monedas'
        laTablas[5,2] = 'monedas'
        laTablas[6,1] = 'cabevent'
        laTablas[6,2] = 'ventas'

        RETURN THIS.ObtenerConexion(@laTablas)
    ENDFUNC

ENDDEFINE