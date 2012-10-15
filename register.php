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
            $line = "\"" . $_POST["name"] . "\"|" .
                    "\"" . $_POST["email"] . "\"|" .
                    "\"" . $_POST["phone"] . "\"|\"Påmeldt\"";

            $file = "påmeldinger/" . $_POST["presentation"] . ".csv";

            if ( file_exists ( $file ) ) {
                file_put_contents ( $file, file_get_contents ( $file ) . "\n" . $line );
            } else {
                file_put_contents ( $file, $line );
            }

            $status = 0;
        } else {
            $status = 2;
        }
    } else {
        $status = 1;
    }

    require ( "index.php" );
