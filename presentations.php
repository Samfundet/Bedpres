<?php
    require_once ( "presentation.class.php" );

    /*
      int mktime ([ int $hour = date("H") [, int $minute = date("i") [, int $second = date("s") [, int $month = date("n") [, int $day = date("j") [, int $year = date("Y") [, int $is_dst = -1 ]]]]]]] )
    */

    new Presentation (
        "Statoil",
        mktime ( 20, 00, 00, 10, 14, 2012 ),
        "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
        20 );

    new Presentation (
        "Statoil",
        mktime ( 20, 00, 00, 10, 20, 2012 ),
        "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
        20 );

    new Presentation (
        "Statoil",
        mktime ( 20, 00, 00, 10, 21, 2012 ),
        "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
        20 );

    new Presentation (
        "Statoil",
        mktime ( 20, 00, 00, 10, 22, 2012 ),
        "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
        20 );

    $upcoming_presentations = Presentation :: getUpcomingPresentations ();

    if ( count ( $upcoming_presentations ) > 0 ) {
        $first_upcoming_presentation = $upcoming_presentations[0];
    }
