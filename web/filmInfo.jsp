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
<jsp:useBean id="film" class="com.filmlibrary.entities.Film" scope="request"/>
<%
    if (request.getParameter("action") != null) {
        DAO dao = new DAO();
        int id = Integer.parseInt(request.getParameter("action"));
        film = (Film) dao.getEntityById(id, new Film());
    } else {
        film = null;

    }
%>
<form method='POST' action='personView.jsp'>
    <input type="hidden" readonly name="personId" value="<%if(film!=null)out.print(film.getId());%>"/>
    <input type="hidden" name="action" value="<% if(film!=null) out.print("Edit"); else out.print("Add");%>"/>
    <h2><% if(film!=null) out.print(film.getTitle());%> </h2>
    <b>Год:</b> <% if(film!=null) out.print(film.getIssueYear());%>
    <br><br>
    <b>Длительность (мин):</b> <% if(film!=null) out.print(film.getLength());%>
    <br><br>
    <b>IMDb:</b> <% if(film!=null) out.print(film.getImdb());%>
</form>
<%
    DAO dao = new DAO();
    ArrayList<EntityDB> listPosition = dao.getAllEntity(new Position());
    ArrayList<EntityDB> listPerson;
    out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html><body>");
    for (int i = 0; i < listPosition.size(); i++) {
        Position position = (Position) listPosition.get(i);
        listPerson = dao.getPersonByProject("film", position.getNamePosition(), film.getId(), new Person());
        if (listPerson.size() != 0) {
            out.println("<br><br>" + position.getNamePosition() + "ы:");
            out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
            out.println("<tr><th>Имя</th><th>Фамилия</th><th>Дата рождения</th><th>Страна</th></tr>");
            for (int j = 0; j < listPerson.size(); j++) {
                Object o = listPerson.get(j);
                Person person = (Person) o;
                out.println("<tr><td>" + person.getFirstName() +
                        "</td><td>" + person.getLastName() +
                        "</td><td>" + person.getBirthday() +
                        "</td><td>" + person.getCountry() + "</td></tr>");
            }
            out.println("</tbody></table>");
        }
    }
    out.println("</body></html>");
%>
<jsp:include page="_footer.jsp"/>
</body>
</html>
