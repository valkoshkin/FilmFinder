<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>FilmFinder: Фильмы</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        td, th {
            padding: 4px;
            border: 1px solid #000080;
        }
        th {
            background: #000080;
            color: #ffe;
            text-align: left;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
<%@page import="com.filmlibrary.DAO" %>
<%@page import="com.filmlibrary.entities.Film" %>
<%@ page import="com.filmlibrary.entities.Position" %>
<%@ page import="com.filmlibrary.entities.EntityDB" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.filmlibrary.entities.Person" %>
<jsp:useBean id="listFilm" class="java.util.ArrayList" scope="application"/>
<jsp:useBean id="listPosition" class="java.util.ArrayList" scope="application"/>
<form action="film.jsp" method="post">
    <input type="text" name="search">
    <select name="column">
        <option value="title">Название</option>
        <option value="issue_year">Дата выхода</option>
        <option value="imdb">Оценка</option>
        <option value="length">Длина</option>
    </select>
    <button type="submit" name="search" value="Search">Поиск</button>
    <button type="button" name="search  " onclick="location.href ='film.jsp'" value="Add">Сбросить</button>
</form>
<form id="checkedForm" action="film.jsp" method="post">
    <%
        DAO dao = new DAO();
        request.setCharacterEncoding("UTF-8");
        listFilm = dao.getAllEntity(new Film());
        listPosition = dao.getAllEntity(new Position());
        ArrayList<EntityDB> persons = dao.getAllEntity(new Person());
        Film copyFilm;
        if (request.getParameter("action") != null) {
            if (request.getParameter("filmId") != null) {
                if (request.getParameter("filmId").equals("")) {
                    String title = request.getParameter("title");
                    String length = request.getParameter("length");
                    String imdb = request.getParameter("imdb");
                    String issueYear = request.getParameter("issueYear");
                    dao.addEntity(new Film(title, Integer.parseInt(issueYear), Double.parseDouble(imdb), Integer.parseInt(length)));
                } else if (!request.getParameter("filmId").equals("")) {
                    String title = request.getParameter("title");
                    String length = request.getParameter("length");
                    String imdb = request.getParameter("imdb");
                    String issueYear = request.getParameter("issueYear");
                    int filmId = Integer.parseInt(request.getParameter("filmId"));
                    Film newFilm = new Film(filmId, title, Integer.parseInt(issueYear), Double.parseDouble(imdb), Integer.parseInt(length));
                    for (int i = 0; i < listPosition.size(); i++) {
                        Position pos = (Position) listPosition.get(i);
                        for (int j = 0; j < persons.size(); j++) {
                            Person person = (Person) persons.get(j);
                            if (request.getParameter("check" + person.getId()) != null) {
                                String position = request.getParameter("position" + person.getId());
                                if (position.equals(pos.getNamePosition())) {
                                    dao.setProjectToPerson("film", filmId, person.getId(), pos.getId());
                                }
                            }
                        }
                    }
                    dao.updateEntity(newFilm);
                }
            } else {
                for (int i = 0; i < listFilm.size(); i++) {
                    if (request.getParameter("checkBox" + i) != null) {
                        switch (request.getParameter("action")) {
                            case "Delete":
                                dao.deleteEntity(Integer.parseInt(request.getParameter("checkBox" + i)), new Film());
                                break;
                            case "Copy":
                                copyFilm = (Film) dao.getEntityById(Integer.parseInt(request.getParameter("checkBox" + i)), new Film());
                                dao.addEntity(copyFilm);
                                break;
                        }
                    }
                }
            }
        }
        if (request.getParameter("search") != null) {
            listFilm = dao.searchEntity(request.getParameter("column"), request.getParameter("search"), new Film());
        } else {
            listFilm = dao.getAllEntity(new Film());
        }
    %>
    <div style="padding: 5px;">
        <button type="button" name="action" onclick="location.href ='inputFilm.jsp'" value="Add">Добавить новый фильм
        </button>
        <button type="submit" name="action" value="Delete">Удалить</button>
        <button type="submit" name="action" value="Copy">Копировать</button>
    </div>
</form>
<%
    out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html>");
    out.println("<body>");
    out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
    out.println("<tr><th></th><th>Название</th><th>Дата выхода</th><th>Оценка</th><th>Длина</th><th></th></tr>");
    for (int i = 0; i < listFilm.size(); i++) {
        Object o = listFilm.get(i);
        Film film = (Film) o;
        out.println("<tr><td><input form=\"checkedForm\" type=\"checkBox\" name=\"checkBox" + i + "\"  value=\"" + film.getId() + "\" >" +
                "</td><td>" + film.getTitle() +
                "</td><td>" + film.getIssueYear() +
                "</td><td>" + film.getImdb() +
                "</td><td>" + film.getLength() +
                "</td><td> <form action=\"inputFilm.jsp\" method=\"post\"><button type=\"submit\" name=\"action\" value=\"" + film.getId() + "\">Edit</button></form>" +
                "<form action=\"filmInfo.jsp\" method=\"post\"><button type=\"submit\" name=\"action\" value=\"" + film.getId() + "\">Info</button></form>");
    }
    out.println("</tbody></table></body>");
    out.println("</html>");
%>
<jsp:include page="_footer.jsp"/>
</body>
</html>