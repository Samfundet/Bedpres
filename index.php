<?php require ( 'events.php' ); ?>

<!DOCTYPE html>
<html class='production' lang='no'>
    <head>
        <meta charset='UTF-8'>
        <title>Bedriftspresentasjoner på Studentersamfundet</title>
        <link href="style.css" rel="stylesheet" type="text/css" />
        <link href="bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="jquery.expander.min.js"></script>
        <script src="javascript.js"></script>
    </head>

    <body>
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="brand" href="#">Bedriftspresentasjoner på Studentersamfundet</a>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="hero-unit">
                <?php if ( isset ( $first_upcoming_event ) ): ?>
                    <h1><?= $first_upcoming_event["name"]; ?>, <?= date ( "d.m.y", $first_upcoming_event["date"] ); ?></h1>
                    <p><?= $first_upcoming_event["description"]; ?></p>
                    <p><a class="btn btn-primary btn-large" href="#registration">Meld meg på &raquo;</a></p>
                <?php endif; ?>
            </div>

            <div class="row">
                <div class="span6">
                    <h3 id="registration">Påmelding</h3>
                    <form class="form-horizontal">
                        <div class="control-group">
                            <label class="control-label" for="inputName">Fullt navn</label>
                            <div class="controls">
                                <input type="text" id="inputName" placeholder="Fullt navn">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputEmail">E-post</label>
                            <div class="controls">
                                <input type="text" id="inputEmail" placeholder="E-post">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputPhone">Telefon</label>
                            <div class="controls">
                                <input type="text" id="inputPhone" placeholder="Telefon">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputPresentation">Bedriftspresentasjon</label>
                            <div class="controls">
                                <select id="inputPresentation">
                                    <?php foreach ( $upcoming_events as $event ): ?>
                                        <option><?= $event["name"] ?>, <?= date ( "d.m.y", $event["date"] ); ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="controls">
                                <button type="submit" class="btn">Meld meg på</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="span6">
                    <h3>Avmelding</h3>
                    <p>
                        Avmelding foregår ved å sende en e-post med ditt navn og den bedriftspresentasjonen du ønsker å
                        melde deg av til <a href="mailto:bedpres@samfundet.no">bedpres@samfundet.no</a>.
                    </p>
                </div>
            </div>

            <div class="row">
                <div class="span12">
                    <h2>Kommende bedriftspresentasjoner</h2>
                    <table class="table" id="upcoming-events">
                        <thead>
                        <tr>
                            <th>Bedriftnavn</th>
                            <th>Dato</th>
                            <th>Beskrivelse</th>
                        </tr>
                        </thead>
                        <tbody>
                            <?php foreach ( $upcoming_events as $event ): ?>
                                <tr>
                                    <td><?= $event["name"] ?></td>
                                    <td><?= date ( "d.m.y", $event["date"] ); ?></td>
                                    <td><?= $event["description"] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
