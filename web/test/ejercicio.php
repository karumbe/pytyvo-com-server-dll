<?php

/**
 *
 * Crear un programa en PHP que nos  permita  dar un  resultado de  una encuesta
 * realizada en Carapeguá, en las compañías de Aguai'y,  Itape, Potrero, Pacheco
 * e Ysla Ybate  a  100  personas  en  cada  compañía sobre que religión profesa 
 * siendo las opciones 5=Católico, 6=Evangélico, 7=Musulmán, 8=Budista y 9=otro.
 *
 * Para el efecto cargar en un vector los nombres de las compañías, y para saber
 * la religión elegida se utiliza rand.
 * 
 * Imprimir los  resultados con los nombres de la compañía, imprimir el mayor  y
 * menor de católica y de que compañía es, utilizar función para el  efecto,  el
 * vector no se pasa como parámetro.
 *
 * Imprimir la cantidad general que profesan el catolicismo en Carapeguá.
 *
 */


// Declaración e inicialización de la cantidad de personas.
$cantidad_personas = 100;

// Matriz asociativa multidimensional de compañías.
$companias = [
    'Aguai\'y' => array(),
    'Itape' => array(),
    'Potrero' => array(),
    'Pacheco' => array(),
    'Ysla Ybate' => array(),
];

// Matriz asociativa de religiones.
$religiones = [
    5 => 'Católico',
    6 => 'Evangélico',
    7 => 'Musulmán',
    8 => 'Budista',
    9 => 'otro',
];

// Ciclo para cargar la matriz.
for ($i = 0; $i < $cantidad_personas; $i++) {
    foreach ($companias as $clave => $valor) {
        $companias[$clave][$i] = rand(5, 9);
    }
}

imprimir_resultados();


function imprimir_resultados() {
    /**
     *
     * Calcula e imprime los resultados de la encuesta.
     *
     */

    global $cantidad_personas, $companias, $religiones;

    $resultado = [
        'Aguai\'y' => array(5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0),
        'Itape' => array(5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0),
        'Potrero' => array(5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0),
        'Pacheco' => array(5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0),
        'Ysla Ybate' => array(5 => 0, 6 => 0, 7 => 0, 8 => 0, 9 => 0),
    ];

    // Suma la respuesta de cada una de las personas de la encuesta.
    for ($i = 0; $i < $cantidad_personas; $i++) {
        foreach ($resultado as $clave => $valor) {
            $religion = $companias[$clave][$i];
            $cantidad = $resultado[$clave][$religion] + 1;
            $resultado[$clave][$religion] = $cantidad;
        }
    }

    // Calcula e imprime el mayor y menor de católica y la cantidad general que profesan el catolicismo en Carapeguá.
    $total_catolicos = 0;
    $catolicos = [
        'menor' => array('cantidad' => null, 'compania' => null),
        'mayor' => array('cantidad' => null, 'compania' => null),
    ];

    foreach ($resultado as $compania => $valor) {
        foreach ($valor as $religion => $cantidad) {
            if ($religion == 5) {
                if (!is_null($catolicos['menor']['cantidad']) && !is_null($catolicos['mayor']['cantidad'])) {
                    if ($resultado[$compania][$religion] < $catolicos['menor']['cantidad']) {
                        $catolicos['menor']['cantidad'] = $resultado[$compania][$religion];
                        $catolicos['menor']['compania'] = $compania;
                    }

                    if ($resultado[$compania][$religion] > $catolicos['mayor']['cantidad']) {
                        $catolicos['mayor']['cantidad'] = $resultado[$compania][$religion];
                        $catolicos['mayor']['compania'] = $compania;
                    }
                } else {
                    $catolicos['menor']['cantidad'] = $resultado[$compania][$religion];
                    $catolicos['menor']['compania'] = $compania;

                    $catolicos['mayor']['cantidad'] = $resultado[$compania][$religion];
                    $catolicos['mayor']['compania'] = $compania;
                }

                $total_catolicos += $resultado[$compania][$religion];
            }
        }
    }

    echo '<h2>Encuesta realizada en Carapegúa sobre las religiones que profesan los habitantes por compañía.</h2>';

    foreach ($resultado as $compania => $valor) {
        echo '<br>' . 'Compañía: ' . $compania;
        echo '<ul>';
        foreach ($valor as $religion => $cantidad) {
            echo '<li>' . $religiones[$religion] . ' = ' . $resultado[$compania][$religion] . '</li>';
        }
        echo '</ul>';
    }


    echo '<br>';
    echo 'El mayor de católica es <b>' . $catolicos['mayor']['cantidad'] . '</b> de la compañía <b>' . $catolicos['mayor']['compania'] . '</b>.';
    echo '<br>';
    echo 'El menor de católica es <b>' . $catolicos['menor']['cantidad'] . '</b> de la compañía <b>' . $catolicos['menor']['compania'] . '</b>.';
    echo '<br>';
    echo '<br>';
    echo 'Cantidad general de personas que profesan el catolicismo en Carapeguá: <b>' . $total_catolicos . '</b>.';
}

?>