<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entities.Jouet" %>
<%@ page import="entities.CategorieJouet" %>
<%@ page import="java.util.List" %>
<%@ page import="myframework.utils.MapFile"%>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des jouets</title>
</head>
<body>

<%-- <%
    List<Jouet> jouets = (List<Jouet>) request.getAttribute("jouets");
    String randomInput = (String) request.getAttribute("randomInput");
    if (jouets != null) {
        for (Jouet j : jouets) {
            String name = j.getNomJouet();
            double prix = j.getPrixJouet();
            String description = j.getDescriptionJouet();
            String labelCategorie = j.getCategorie() != null
                ? j.getCategorie().getLabel()
                : "";
%>

    <p>Nom : <%= name %></p>
    <p>Prix : <%= prix %></p>
    <p>Description : <%= description %></p>
    <p>Catégorie : <%= labelCategorie %></p>
    <hr>

<%
        }
        %>
        
        <%= randomInput %>
         <%
    }
%> --%>


<%
    Jouet j = (Jouet) request.getAttribute("jouet");
    String ri = (String) request.getAttribute("randomInput");
    String s = (String) request.getAttribute("st");
%>

<%= j.getNomJouet() %>
<%= j.getPrixJouet() %>
<%= ri %>
<%= s %>

</body>
</html>