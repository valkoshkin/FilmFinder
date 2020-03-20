<%@ page import="com.filmlibrary.DAO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.filmlibrary.entities.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body bgcolor='#ffffff'>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
<jsp:useBean id="person" class="com.filmlibrary.entities.Person" scope="request"/>
<%
    if (request.getParameter("action") != null) {
        DAO dao = new DAO();
        int personId = Integer.parseInt(request.getParameter("action"));
        person = (Person) dao.getEntityById(personId, new Person());
    } else {
        person = null;
    }
%>
<form method='POST' action='personView.jsp'>
    <input type="hidden" readonly name="personId" value="<%if(person!=null)out.print(person.getId());%>"/>
    <input type="hidden" name="action" value="<% if(person!=null) out.print("Edit"); else out.print("Add");%>"/>
    <h2><% if (person != null) out.print(person.getFirstName());%> <% if (person != null)
        out.print(person.getLastName());%></h2>
    <b>Страна:</b> <% if (person != null) out.print(person.getCountry());%>
    <br><br>
    <b>Дата рождения:</b> <%= person.getBirthday()%>
    <br><br>
    <b>Карьера:</b> тут амплуа
    <br><br>
    <b>Жанры:</b> тут жанры
    <br><br>
    <b>Всего фильмов:</b>
    <%
        DAO dao = new DAO();
        out.print(dao.getNumOfProjects("film", person.getId()));
    %>
</form>
<%
    ArrayList<EntityDB> listPosition = dao.getAllEntity(new Position());
    ArrayList<EntityDB> listProject;
    out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html><body>");
    for (int i = 0; i < listPosition.size(); i++) {
        Position position = (Position) listPosition.get(i);
        listProject = dao.getProjectsByPerson("film", position.getNamePosition(), person.getId(), new Film());
        if (listProject.size() != 0) {
            out.println("<br><br>Фильмы (" + position.getNamePosition() + "):");
            out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
            out.println("<tr><th>Название</th><th>Год</th></tr>");
            for (int j = 0; j < listProject.size(); j++) {
                Object o = listProject.get(j);
                Film film = (Film) o;
                out.println("<tr><td>" + film.getTitle() +
                        "</td><td>" + film.getIssueYear() + "</td></tr>");
            }
            out.println("</tbody></table>");
        }
        listProject = dao.getProjectsByPerson("serial", position.getNamePosition(), person.getId(), new Serial());
        if (listProject.size() != 0) {
            out.println("<br><br>Сериалы (" + position.getNamePosition() + "):");
            out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
            out.println("<tr><th>Название</th><th>Год запуска</th><th>Год завершения</th></tr>");
            for (int j = 0; j < listProject.size(); j++) {
                Object o = listProject.get(j);
                Serial serial = (Serial) o;
                out.println("<tr><td>" + serial.getTitle() +
                        "</td><td>" + serial.getYearStart() +
                        "</td><td>" + serial.getYearFinish() + "</td></tr>");
            }
            out.println("</tbody></table>");
        }
    }
    out.println("</body></html>");
%>
<jsp:include page="_footer.jsp"/>
</body>
</html>
