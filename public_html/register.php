<?php

    require_once ( "presentations.php" );

    if ( !empty ( $_POST["name"] ) &&
         !empty ( $_POST["email"] ) &&
         !empty ( $_POST["phone"] ) &&
         !empty ( $_POST["presentation"] ) ) {
        if ( ( $presentation = get_presentation_from_string ( $upcoming_presentations, $_POST["presentation"] ) ) !== null ) {
            if ( get_registration_count ( $presentation ) < $presentation["max_registrations"] ) {
                $line = "\"" . $_POST["name"] . "\"|" .
                        "\"" . $_POST["email"] . "\"|" .
                        "\"" . $_POST["phone"] . "\"|\"Påmeldt\"";

                $file = get_registration_file ( $presentation );

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
