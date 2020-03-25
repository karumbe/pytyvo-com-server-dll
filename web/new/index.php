<?php
session_start();

$componentes_url = parse_url($_SERVER['REQUEST_URI']);

$ruta = $componentes_url['path'];

$partes_ruta = explode('/', $ruta);
$partes_ruta = array_filter($partes_ruta);
$partes_ruta = array_slice($partes_ruta, 0);

$ruta_elegida = 'vistas/404.phtml';

if ($partes_ruta[0] == 'pytyvo') {
    if (count($partes_ruta) == 1) {
        $ruta_elegida = 'app/modulos/sistema/controlador/home.php';
    } else if (count($partes_ruta) == 2) {
        switch($partes_ruta[1]) {
            case 'login':
                $ruta_elegida = 'app/modulos/login/controlador/login.php';
                break;
            case 'logout':
                $ruta_elegida = 'app/nucleo/logout.php';
                break;
        }
    }
}

include_once $ruta_elegida;
?>