<?php

$xml=simplexml_load_file("tmp.xml") or die("Error: Cannot create object");

foreach ($xml as $fila) {
    echo $fila->nombre . ' | ' . $fila->ruc . '<br>';
}

//print_r($xml);


?>