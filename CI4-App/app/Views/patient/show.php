
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Patient #<?= esc($patient['id']) ?></title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #edf3fa;
            color: #10233f;
        }

        header {
            background: #10233f;
            color: white;
            padding: 20px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font-size: 20px;
            font-weight: bold;
        }

        .logo span {
            color: #60a5fa;
        }

        .container {
            max-width: 760px;
            margin: 65px auto;
            padding: 0 20px;
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 35px;
            box-shadow: 0 8px 30px
                rgba(16, 35, 63, 0.08);
        }

        .profile {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .avatar {
            width: 70px;
            height: 70px;
            background: #eaf1ff;
            color: #2165cc;
            border-radius: 16px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 30px;
            font-weight: bold;
        }

        h1 {
            margin: 0;
            font-size: 26px;
        }

        .subtitle {
            color: #64748b;
            margin-top: 7px;
        }

        .patient-id {
            display: inline-block;
            margin-top: 10px;
            background: #eaf1ff;
            color: #2165cc;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .field {
            background: #f5f8fc;
            padding: 20px;
            border-radius: 10px;
        }

        .label {
            color: #b1d2ff;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .value {
            color: #0d1c32;
            font-size: 17px;
            font-weight: bold;
            overflow-wrap: anywhere;
        }

        .footer {
            margin-top: 28px;
            text-align: center;
            color: #3f4a59;
            font-size: 13px;
        }

        @media (max-width: 600px) {
            .grid {
                grid-template-columns: 1fr;
            }

            .card {
                padding: 22px;
            }

            .container {
                margin: 30px auto;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="logo">
        Patient <span>Portal</span>
    </div>
    <div>Dossier médical</div>
</header>

<div class="container">

    <div class="card">

        <div class="profile">

            <div class="avatar">
                <?= esc(strtoupper(substr($patient['prenom'], 0, 1))) ?>
            </div>

            <div>
                <h1>
                    <?= esc($patient['prenom']) ?>
                    <?= esc($patient['nom']) ?>
                </h1>

                <div class="subtitle">
                    Informations du patient
                </div>
            </div>

        </div>

        <div class="grid">

            <div class="field">
                <div class="label">Identifiant</div>
                <div class="value">
                    <?= esc($patient['id']) ?>
                </div>
            </div>

            <div class="field">
                <div class="label">Nom</div>
                <div class="value">
                    <?= esc($patient['nom']) ?>
                </div>
            </div>

            <div class="field">
                <div class="label">Prénom</div>
                <div class="value">
                    <?= esc($patient['prenom']) ?>
                </div>
            </div>

            <div class="field">
                <div class="label">Date de naissance</div>
                <div class="value">
                    <?= esc($patient['date_naissance']) ?>
                </div>
            </div>

            <div class="field">
                <div class="label">CIN</div>
                <div class="value">
                    <?= esc($patient['cin']) ?>
                </div>
            </div>
            <div class="field">
                <div class="label">Sexe</div>
                <div class="value">
                    <?= esc($patient['sexe']) ?>
                </div>
            </div>

        </div>

    </div>

    <div class="footer">
        Patient Portal — Informations personnelles
    </div>

</div>

</body>
</html>
