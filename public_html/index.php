<?php require_once ( 'presentations.php' ); ?>

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
                <?php if ( isset ( $first_upcoming_presentation ) ): ?>
                    <h1><?= $first_upcoming_presentation["name"]; ?>, <?= date ( "d.m.y", $first_upcoming_presentation["date"] ); ?></h1>
                    <p><?= $first_upcoming_presentation["description"]; ?></p>
                    <p><a class="btn btn-primary btn-large" href="#registration">Meld meg på &raquo;</a></p>
                <?php else: ?>
                    <h2>Det er for tiden ingen kommende presentasjoner... :(</h2>
                <?php endif; ?>
            </div>

            <div class="row">
                <div class="span6">
                    <h3 id="registration">Påmelding</h3>
                    <?php if ( $status === 1 ): ?>
                        <p class="text-error">Vennligst fyll ut alle felter.</p>
                    <?php elseif ( $status === 3 ): ?>
                        <p class="text-error">Denne bedriftspresentasjon er dessverre full.</p>
                    <?php elseif ( $status === 0 ): ?>
                        <p class="text-success">Du er nå påmeldt på bedriftspresentasjon.</p>
                    <?php endif; ?>
                    <form class="form-horizontal" action="register.php" method="post">
                        <div class="control-group">
                            <label class="control-label" for="inputName">Fullt navn</label>
                            <div class="controls">
                                <input type="text" id="inputName" placeholder="Fullt navn" name="name"
                                    <?php if ( isset ( $status ) && $status <> 0 ): ?>value="<?= htmlentities ( $_POST["name"] ); ?>"<?php endif; ?>>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputEmail">E-post</label>
                            <div class="controls">
                                <input type="text" id="inputEmail" placeholder="E-post" name="email"
                                    <?php if ( isset ( $status ) && $status <> 0 ): ?>value="<?= htmlentities ( $_POST["email"] ); ?>"<?php endif; ?>>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputPhone">Telefon</label>
                            <div class="controls">
                                <input type="text" id="inputPhone" placeholder="Telefon" name="phone"
                                    <?php if ( isset ( $status ) && $status <> 0 ): ?>value="<?= htmlentities ( $_POST["phone"] ); ?>"<?php endif; ?>>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="inputPresentation">Bedriftspresentasjon</label>
                            <div class="controls">
                                <select id="inputPresentation" name="presentation">
                                    <option></option>
                                    <?php foreach ( $upcoming_presentations as $presentation ): ?>
                                        <option
                                            <?php if ( isset ( $status ) && $status <> 0 &&
                                                       $_POST["presentation"] == $presentation["name"] . ", " . date ( "d.m.y", $presentation["date"] ) ): ?>
                                                selected="selected"
                                            <?php endif; ?>>
                                            <?= $presentation["name"] ?>, <?= date ( "d.m.y", $presentation["date"] ); ?>
                                        </option>
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

            <?php if ( count ( $upcoming_presentations ) > 0 ): ?>
                <div class="row">
                    <div class="span12">
                        <h2>Kommende bedriftspresentasjoner</h2>
                        <table class="table" id="upcoming-presentations">
                            <thead>
                            <tr>
                                <th>Bedriftnavn</th>
                                <th>Dato</th>
                                <th>Beskrivelse</th>
                            </tr>
                            </thead>
                            <tbody>
                                <?php foreach ( $upcoming_presentations as $presentation ): ?>
                                    <tr>
                                        <td><?= $presentation["name"] ?></td>
                                        <td><?= date ( "d.m.y", $presentation["date"] ); ?></td>
                                        <td><?= $presentation["description"] ?></td>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            <?php endif; ?>
        </div>
    </body>
</html>
