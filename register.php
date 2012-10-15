<?php

    require_once ( "presentations.php" );

    $valid_presentations = array_map ( function ( $presentation ) {
        return $presentation["name"] . ", " . date ( "d.m.y", $presentation["date"] );
    }, $upcoming_presentations );

    if ( !empty ( $_POST["name"] ) &&
         !empty ( $_POST["email"] ) &&
         !empty ( $_POST["phone"] ) &&
         !empty ( $_POST["presentation"] ) ) {
        if ( in_array ( $_POST["presentation"], $valid_presentations ) ) {
            $status = 0;
        } else {
            $status = 2;
        }
    } else {
        $status = 1;
    }

    require ( "index.php" );
