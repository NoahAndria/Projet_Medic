<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - BankWebsite</title>
    <link rel="stylesheet" href="/BankWebsite/assets/chequeList.css">
</head>
<body>

<%-- <form action="dobe2" method="GET">
    <h3>Jouet 1</h3>
    <input name="jouets[0].nomJouet" placeholder="Nom">
    <input name="jouets[0].prixJouet" type="number" step="0.01" placeholder="Prix" required>
    <input name="jouets[0].descriptionJouet" placeholder="Description">
    <input name="jouets[0].categorie.label" placeholder="Catégorie">

    <h3>Jouet 2</h3>
    <input name="jouets[1].nomJouet" placeholder="Nom">
    <input name="jouets[1].prixJouet" type="number" step="0.01" placeholder="Prix" required>
    <input name="jouets[1].descriptionJouet" placeholder="Description">
    <input name="jouets[1].categorie.label" placeholder="Catégorie">

    <p>Random ahh imput</p>
    <input name="randomInput" placeholder="Random Input">
    
    <button type="submit">Envoyer</button>
    
</form> --%>


<%-- <form action="dobe3" method="POST" enctype="multipart/form-data">
    <h3>Jouet 1</h3>
    <input name="j.nomJouet" placeholder="Nom">
    <input name="j.prixJouet" type="number" step="0.01" placeholder="Prix" required>
    <input name="j.descriptionJouet" placeholder="Description">
    <input name="j.categorie.label" placeholder="Catégorie">

    <input type="file" name="testMap">
    <button type="submit">Envoyer</button>
</form> --%>
 <form action="dobe2" method="GET">
    <h3>Jouet 1</h3>
    <input name="j.nomJouet" placeholder="Nom" value="nom123">
    <input name="j.prixJouet" type="number" step="0.01" placeholder="Prix" required>
    <input name="j.descriptionJouet" placeholder="Description" value="description000">
    <input name="j.categorie.label" placeholder="Catégorie" value="categorie_">

    <p>Random ahh imput</p>
    <input name="randomInput" placeholder="Random Input" value="random">
    
    <button type="submit">Envoyer</button>
    
</form>
</body>
