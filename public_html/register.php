<?php

    require_once ( "presentations.php" );

    if ( !empty ( $_POST["name"] ) &&
         !empty ( $_POST["email"] ) &&
         !empty ( $_POST["phone"] ) &&
         !empty ( $_POST["presentation"] ) ) {
        if ( ( $presentation = Presentation :: getPresentationFromString ( $_POST["presentation"] ) ) !== null ) {
            if ( $presentation -> getRegistrationCount () < $presentation -> getMaxRegistrations () ) {
                $line = "\"" . $_POST["name"] . "\"|" .
                        "\"" . $_POST["email"] . "\"|" .
                        "\"" . $_POST["phone"] . "\"|\"Påmeldt\"";

                $file = $presentation -> getRegistrationFile ();

                if ( file_exists ( $file ) ) {
                    file_put_contents ( $file, file_get_contents ( $file ) . "\n" . $line );
                } else {
                    file_put_contents ( $file, $line );
                }

                $status = 0;
            } else {
                $status = 3;
            }
        } else {
            $status = 2;
        }
    } else {
        $status = 1;
    }

    require ( "index.php" );
