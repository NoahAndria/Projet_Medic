<form action="dobe3" method="get" enctype="multipart/form-data">
    <h3>Jouet 1</h3>
    <input name="j.nomJouet" placeholder="Nom">
    <input name="j.prixJouet" type="number" step="0.01" placeholder="Prix" required>
    <input name="j.descriptionJouet" placeholder="Description">
    <input name="j.categorie.label" placeholder="Catégorie">

    <input type="file" name="testMap">
    <button type="submit">Envoyer</button>
</form>