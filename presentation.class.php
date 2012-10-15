<?php
    class Presentation {
        private $name;
        private $date;
        private $description;
        private $max_registrations;

        private static $presentations = array ();

        public function Presentation ( $name, $date, $description, $max_registrations ) {
            $this -> name              = $name;
            $this -> date              = $date;
            $this -> description       = $description;
            $this -> max_registrations = $max_registrations;

            self :: $presentations[] = $this;
        }

        public function getName () {
            return $this -> name;
        }

        public function getDate () {
            return $this -> date;
        }

        public function getDescription () {
            return $this -> description;
        }

        public function getMaxRegistrations () {
            return $this -> max_registrations;
        }

        public function getRegistrationCount () {
            $file = $this -> getRegistrationFile ();

            if ( file_exists ( $file ) ) {
                return count ( split ( "\n", file_get_contents ( $file ) ) );
            } else {
                return 0;
            }
        }

        public function getRegistrationFile () {
            return "registrations/" . $this -> name . ", " . date ( "d.m.y", $this -> date )  . ".csv";
        }

        public function getRegistrationsLeft () {
            return $this -> max_registrations - $this -> getRegistrationCount ();
        }

        public static function getUpcomingPresentations () {
            $upcoming_presentations = array_filter ( self :: $presentations, function ( $presentation ) {
                return $presentation -> getDate () > time ();
            } );

            usort ( $upcoming_presentations, function ( $presentation_1, $presentation_2 ) {
                return $presentation_1 -> getDate () - $presentation_2 -> getDate ();
            } );

            return $upcoming_presentations;
        }

        public static function getPresentationFromString ( $presentation_string ) {
            foreach ( self :: $presentations as $presentation ) {
                if ( $presentation -> getName () . ", " . date ( "d.m.y", $presentation -> getDate () ) == $presentation_string ) {
                    return $presentation;
                }
            }
        }
    }
