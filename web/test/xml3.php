<?php

$com = new COM('Pytyvo.Cliente');

$result = $com->Obtener('JOSE AV', null);

//echo $result;

$xml=simplexml_load_string($result) or die("Error: Cannot create object");

foreach ($xml as $fila) {
    echo $fila->nombre . ' | ' . $fila->ruc . '<br>';
}

//print_r($xml);


?>