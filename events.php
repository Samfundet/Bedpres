<?php
    /*
      int mktime ([ int $hour = date("H") [, int $minute = date("i") [, int $second = date("s") [, int $month = date("n") [, int $day = date("j") [, int $year = date("Y") [, int $is_dst = -1 ]]]]]]] )
    */

    $events = array (
        array (
            "name" => "Statoil",
            "description" => "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
            "date" => mktime ( 20, 00, 00, 10, 14, 2012 ),
        ),
        array (
            "name" => "Statoil",
            "description" => "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
            "date" => mktime ( 20, 00, 00, 10, 20, 2012 ),
        ),
        array (
            "name" => "Statoil",
            "description" => "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
            "date" => mktime ( 20, 00, 00, 10, 21, 2012 ),
        ),
        array (
            "name" => "Statoil",
            "description" => "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
            "date" => mktime ( 20, 00, 00, 10, 22, 2012 ),
        ),
    );

    usort ( $events, function ( $event_1, $event_2 ) {
        return $event_1["date"] - $event_2["date"];
    } );

    function get_upcoming_events ( $events ) {
        $upcoming_events = array ();

        foreach ( $events as $event ) {
            if ( $event["date"] > time () ) {
                $upcoming_events[] = $event;
            }
        }

        return $upcoming_events;
    }

    $upcoming_events = get_upcoming_events ( $events );

    if ( count ( $upcoming_events ) > 0 ) {
        $first_upcoming_event = $upcoming_events[0];
    }
