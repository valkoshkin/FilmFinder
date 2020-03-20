<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>FilmFinder: Сериалы</title>
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
<%@page import="com.filmlibrary.entities.Serial" %>
<%@ page import="com.filmlibrary.entities.Position" %>
<%@ page import="com.filmlibrary.entities.EntityDB" %>
<%@ page import="com.filmlibrary.entities.Person" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="listSerial" class="java.util.ArrayList" scope="application"/>
<jsp:useBean id="listPosition" class="java.util.ArrayList" scope="application"/>
<form action="serial.jsp" method="post">
    <input type="text" name="search">
    <select name="column">
        <option value="title">Название</option>
        <option value="year_start">Дата запуска</option>
        <option value="year_finish">Дата окончания</option>
        <option value="num_of_episodes">Кол-во эпизодов</option>
        <option value="num_of_seasons">Кол-во сезонов</option>
        <option value="imdb">Оценка</option>
    </select>
    <button type="submit" name="search" value="Search">Поиск</button>
    <button type="button" name="reset" onclick="location.href ='serial.jsp'" value="Reset">Сбросить</button>
</form>
<form id="checkedForm" action="serial.jsp" method="post">
    <%
        DAO dao = new DAO();
        request.setCharacterEncoding("UTF-8");
        listSerial = dao.getAllEntity(new Serial());
        listPosition = dao.getAllEntity(new Position());
        ArrayList<EntityDB> persons = dao.getAllEntity(new Person());
        Serial copySerial;
        if (request.getParameter("action") != null) {
            if (request.getParameter("serialId") != null) {
                if (request.getParameter("serialId").equals("")) {
                    String title = request.getParameter("title");
                    String yearStart = request.getParameter("yearStart");
                    String yearFinish = request.getParameter("yearFinish");
                    String numEpisodes = request.getParameter("numEpisodes");
                    String numSeasons = request.getParameter("numSeasons");
                    String imdb = request.getParameter("imdb");
                    dao.addEntity(new Serial(title, Integer.parseInt(yearStart), Integer.parseInt(yearFinish),
                            Integer.parseInt(numEpisodes), Integer.parseInt(numSeasons), Double.parseDouble(imdb)));
                } else if (!request.getParameter("serialId").equals("")) {
                    int serialId = Integer.parseInt(request.getParameter("serialId"));
                    String title = request.getParameter("title");
                    String yearStart = request.getParameter("yearStart");
                    String yearFinish = request.getParameter("yearFinish");
                    String numEpisodes = request.getParameter("numEpisodes");
                    String numSeasons = request.getParameter("numSeasons");
                    String imdb = request.getParameter("imdb");
                    Serial newSerial = new Serial(serialId, title, Integer.parseInt(yearStart), Integer.parseInt(yearFinish),
                            Integer.parseInt(numEpisodes), Integer.parseInt(numSeasons), Double.parseDouble(imdb));
                    for (int i = 0; i < listPosition.size(); i++) {
                        Position pos = (Position) listPosition.get(i);
                        for (int j = 0; j < persons.size(); j++) {
                            Person person = (Person) persons.get(j);
                            if (request.getParameter("check" + person.getId()) != null) {
                                String position = request.getParameter("position" + person.getId());
                                if (position.equals(pos.getNamePosition())) {
                                    dao.setProjectToPerson("serial", serialId, person.getId(), pos.getId());
                                }
                            }
                        }
                    }
                    dao.updateEntity(newSerial);
                }
            } else {
                for (int i = 0; i < listSerial.size(); i++) {
                    if (request.getParameter("checkBox" + i) != null) {
                        switch (request.getParameter("action")) {
                            case "Delete":
                                dao.deleteEntity(Integer.parseInt(request.getParameter("checkBox" + i)), new Serial());
                                break;
                            case "Copy":
                                copySerial = (Serial) dao.getEntityById(Integer.parseInt(request.getParameter("checkBox" + i)), new Serial());
                                dao.addEntity(copySerial);
                                break;
                        }
                    }
                }
            }
        }
        if (request.getParameter("search") != null) {
            listSerial = dao.searchEntity(request.getParameter("column"), request.getParameter("search"), new Serial());
        } else {
            listSerial = dao.getAllEntity(new Serial());
        }
    %>
    <div style="padding: 5px;">
        <button type="button" name="action" onclick="location.href ='inputSerial.jsp'" value="Add">Добавить сериал
        </button>
        <button type="submit" name="action" value="Delete">Удалить</button>
        <button type="submit" name="action" value="Copy">Копировать</button>
    </div>
</form>,
<%
    out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html>");
    out.println("<body>");
    out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
    out.println("<tr><th></th><th>Название</th><th>Год запуска</th><th>Год окончания</th><th>Эпизоды</th><th>Сезоны</th><th>Оценка</th><th></th></tr>");
    for (int i = 0; i < listSerial.size(); i++) {
        Object o = listSerial.get(i);
        Serial serial = (Serial) o;
        out.println("<tr><td><input form=\"checkedForm\" type=\"checkBox\" name=\"checkBox" + i + "\"  value=\"" + serial.getId() + "\" >" +
                "</td><td>" + serial.getTitle() +
                "</td><td>" + serial.getYearStart() +
                "</td><td>" + serial.getYearFinish() +
                "</td><td>" + serial.getNumEpisodes() +
                "</td><td>" + serial.getNumSeasons() +
                "</td><td>" + serial.getImdb() +
                "</td><td> <form action=\"inputSerial.jsp\" method=\"post\"><button type=\"submit\" name=\"action\" value=\"" + serial.getId() + "\">Edit</button> </form>" +
                "<form action=\"serialInfo.jsp\" method=\"post\"><button type=\"submit\" name=\"action\" value=\"" + serial.getId() + "\">Info</button> </form></td>");
    }
    out.println("</tbody></table></body>");
    out.println("</html>");
%>
<jsp:include page="_footer.jsp"/>
</body>
</html>
