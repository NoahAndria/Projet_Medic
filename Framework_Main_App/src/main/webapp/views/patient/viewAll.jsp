<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="entities.Patient" %>

<%!
    private String escapeHtml(Object value) {
        if (value == null) return "-";

        return String.valueOf(value)
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
    }
%>

<%
    List<Patient> patients = (List<Patient>) request.getAttribute("patients");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Liste des patients - NAF</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f5f5f5;
            color: #171717;
            min-height: 100vh;
        }

        /* HEADER */

        header {
            background: #171717;
            padding: 25px 7%;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .brand {
            font-size: 26px;
            font-weight: 800;
            letter-spacing: 1px;
        }

        .brand span {
            color: #dc2626;
        }

        .header-text {
            color: #aaa;
            font-size: 13px;
        }

        /* CONTAINER */

        .container {
            max-width: 1350px;
            margin: 50px auto;
            padding: 0 25px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            gap: 20px;
        }

        .page-header h1 {
            font-size: 30px;
            font-weight: 800;
        }

        .page-header p {
            margin-top: 8px;
            color: #777;
            font-size: 14px;
        }

        .red-line {
            width: 60px;
            height: 4px;
            background: #dc2626;
            margin-top: 15px;
            border-radius: 4px;
        }

        /* CARD */

        .card {
            background: white;
            border-radius: 14px;
            overflow: hidden;
            border: 1px solid #e8e8e8;
            box-shadow: 0 8px 35px rgba(0,0,0,0.04);
        }

        .card-header {
            padding: 25px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .card-header h2 {
            font-size: 19px;
        }

        .patient-count {
            margin-top: 7px;
            color: #888;
            font-size: 13px;
        }

        /* SEARCH */

        .search-input {
            padding: 12px 16px;
            width: 300px;
            max-width: 100%;
            border: 1px solid #ddd;
            border-radius: 8px;
            outline: none;
            font-size: 13px;
        }

        .search-input:focus {
            border-color: #dc2626;
            box-shadow: 0 0 0 3px rgba(220,38,38,0.08);
        }

        /* TABLE */

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        thead {
            background: #fafafa;
        }

        th {
            padding: 18px 22px;
            color: #777;
            text-transform: uppercase;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.5px;
            border-bottom: 1px solid #eee;
            white-space: nowrap;
        }

        td {
            padding: 20px 22px;
            font-size: 14px;
            border-bottom: 1px solid #f1f1f1;
            white-space: nowrap;
        }

        tbody tr:hover {
            background: #fff9f9;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .patient-id {
            color: #dc2626;
            font-weight: 800;
        }

        .patient-name {
            font-weight: 700;
        }

        .sexe-badge {
            display: inline-block;
            background: #f1f1f1;
            color: #444;
            padding: 7px 12px;
            border-radius: 20px;
            font-size: 12px;
        }

        /* ACTIONS */

        .actions {
            display: flex;
            gap: 10px;
        }

        .btn {
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 7px;
            font-size: 12px;
            font-weight: 700;
            transition: 0.2s;
            display: inline-block;
        }

        .btn-edit {
            background: #171717;
            color: white;
        }

        .btn-edit:hover {
            background: #444;
        }

        .btn-delete {
            background: #fff0f0;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        .btn-delete:hover {
            background: #dc2626;
            color: white;
        }

        /* EMPTY STATE */

        .empty {
            text-align: center;
            padding: 60px;
            color: #888;
        }

        /* FOOTER */

        .card-footer {
            padding: 20px 30px;
            background: #fafafa;
            border-top: 1px solid #eee;
            color: #888;
            font-size: 12px;
        }

        @media (max-width: 700px) {
            .container {
                margin-top: 25px;
                padding: 0 15px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .search-input {
                width: 100%;
            }

            .header-text {
                display: none;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="brand">
        NAF<span>.</span>
    </div>

    <div class="header-text">
        <a href="<%= contextPath %>/patient/new" style="color: white; text-decoration: none;">
            Referencer une nouveau patient
        </a>
    </div>
    <div class="header-text">
        PATIENT MANAGEMENT SYSTEM
    </div>
</header>

<main class="container">

    <div class="page-header">
        <div>
            <h1>Gestion des patients</h1>

            <div class="red-line"></div>
        </div>
    </div>

    <div class="card">

        <div class="card-header">

            <div>
                <h2>Liste des patients</h2>

                <p class="patient-count" id="patientCount">
                    <%= patients.size() %> patient(s)
                </p>
            </div>

        </div>

        <div class="table-container">

            <table>

                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Date de naissance</th>
                        <th>CIN</th>
                        <th>Sexe</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody id="patientsTable">

                    <% if (patients.isEmpty()) { %>

                        <tr id="emptyRow">
                            <td colspan="7" class="empty">
                                Aucun patient enregistré.
                            </td>
                        </tr>

                    <% } else { %>

                        <% for (Patient patient : patients) { %>

                            <tr class="patient-row">

                                <td class="patient-id">
                                    #<%= patient.getId() %>
                                </td>

                                <td class="patient-name">
                                <a href="<%= contextPath %>/patient/view?id=<%= patient.getId() %>">
                                    <%= escapeHtml(patient.getNom()) %>
                                </a>
                                </td>

                                <td>
                                    <%= escapeHtml(patient.getPrenom()) %>
                                </td>

                                <td>
                                    <%= escapeHtml(patient.getDate_naissance()) %>
                                </td>

                                <td>
                                    <%= escapeHtml(patient.getCIN()) %>
                                </td>

                                <td>
                                    <span class="sexe-badge">
                                        <%= escapeHtml(patient.getSexe()) %>
                                    </span>
                                </td>

                                <td>

                                    <div class="actions">

                                        <a
                                            href="<%= contextPath %>/patient/view?id=<%= patient.getId() %>"
                                            class="btn btn-edit"
                                        >
                                            Modifier
                                        </a>

                                        <a
                                            href="<%= contextPath %>/patient/delete?id=<%= patient.getId() %>"
                                            class="btn btn-delete"
                                            onclick="return confirm('Voulez-vous vraiment supprimer ce patient ?');"
                                        >
                                            Supprimer
                                        </a>

                                    </div>

                                </td>

                            </tr>

                        <% } %>

                    <% } %>

                </tbody>

            </table>

        </div>

        <div class="card-footer">
            NAF Framework — Gestion des dossiers médicaux
        </div>

    </div>

</main>


</body>
</html>