<?php
    /*
      int mktime ([ int $hour = date("H") [, int $minute = date("i") [, int $second = date("s") [, int $month = date("n") [, int $day = date("j") [, int $year = date("Y") [, int $is_dst = -1 ]]]]]]] )
    */

    $presentations = array (
        /*array (
            "name" => "Statoil",
            "description" => "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
            "date" => mktime ( 20, 00, 00, 10, 14, 2012 ),
            "max_registrations" => 40,
        ),
        array (
            "name" => "Statoil",
            "description" => "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
            "date" => mktime ( 20, 00, 00, 10, 20, 2012 ),
            "max_registrations" => 2,
        ),
        array (
            "name" => "Statoil",
            "description" => "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
            "date" => mktime ( 20, 00, 00, 10, 21, 2012 ),
            "max_registrations" => 2,
        ),
        array (
            "name" => "Statoil",
            "description" => "Statoil har 40 årsjubileum, og dette feires med brask og bram på Studentersamfundet i Trondheim. For å avslutte det hele får vi besøk av Syntpopelektronika-kollektivet fra Norrköping Slagsmålsklubben som kommer til å få ALLE til å danse!",
            "date" => mktime ( 20, 00, 00, 10, 22, 2012 ),
            "max_registrations" => 2,
        ),*/
    );

    usort ( $presentations, function ( $presentation_1, $presentation_2 ) {
        return $presentation_1["date"] - $presentation_2["date"];
    } );

    function get_upcoming_presentations ( $presentations ) {
        $upcoming_presentations = array ();

        foreach ( $presentations as $presentation ) {
            if ( $presentation["date"] > time () ) {
                $upcoming_presentations[] = $presentation;
            }
        }

        return $upcoming_presentations;
    }

    function get_presentation_from_string ( $presentations, $presentation_string ) {
        foreach ( $presentations as $presentation ) {
            if ( $presentation["name"] . ", " . date ( "d.m.y", $presentation["date"] ) == $presentation_string ) {
                return $presentation;
            }
        }
    }

    function get_registration_count ( $presentation ) {
        $file = get_registration_file ( $presentation );

        if ( file_exists ( $file ) ) {
            return count ( split ( "\n", file_get_contents ( $file ) ) );
        } else {
            return 0;
        }
    }

    function get_registration_file ( $presentation ) {
        return "registrations/" . $presentation["name"] . ", " . date ( "d.m.y", $presentation["date"] )  . ".csv";
    }

    $upcoming_presentations = get_upcoming_presentations ( $presentations );

    if ( count ( $upcoming_presentations ) > 0 ) {
        $first_upcoming_presentation = $upcoming_presentations[0];
    }
