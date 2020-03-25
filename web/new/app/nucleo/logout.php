<?php
include_once 'app/nucleo/config.inc.php';
include_once 'app/nucleo/ControlSesion.inc.php';
include_once 'app/nucleo/Redireccion.inc.php';

ControlSesion::cerrar_sesion();
Redireccion::redirigir(SERVIDOR);
?>