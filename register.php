<?php
    if ( !empty ( $_POST["name"] ) &&
         !empty ( $_POST["email"] ) &&
         !empty ( $_POST["phone"] ) &&
         !empty ( $_POST["presentation"] ) ) {
        $status = 0;
    } else {
        $status = 1;
    }

    require ( "index.php" );
