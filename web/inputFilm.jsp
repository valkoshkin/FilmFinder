<%@ page import="com.filmlibrary.DAO" %>
<%@ page import="com.filmlibrary.entities.EntityDB" %>
<%@ page import="com.filmlibrary.entities.Film" %>
<%@ page import="com.filmlibrary.entities.Person" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body bgcolor='#ffffff'>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
<jsp:useBean id="film" class="com.filmlibrary.entities.Film" scope="request"/>
<h1> Добавление нового фильма </h1>
<%
    DAO dao = new DAO();
    if (request.getParameter("action") != null) {
        int id = Integer.parseInt(request.getParameter("action"));
        film = (Film) dao.getEntityById(id, new Film());
    } else {
        film = null;
    }
    ArrayList<EntityDB> listPerson = dao.getAllEntity(new Person());
%>
<form method='POST' action='film.jsp'>
    <input type="hidden" readonly name="filmId" value="<%if(film!=null)out.print(film.getId());%>"/>
    <input type="hidden" name="action" value="<% if(film!=null) out.print("Edit"); else out.print("Add");%>"/>
    Название: <input name="title" value="<% if(film!=null) out.print(film.getTitle());%>"/>
    <br><br>
    Дата выхода: <input name="issueYear" value="<% if(film!=null) out.print(film.getIssueYear());%>"/>
    <br><br>
    Оценка: <input name="imdb" value="<% if(film!=null) out.print(film.getImdb());%>"/>
    <br><br>
    Длина: <input value="<%if(film!=null) out.print(film.getLength()); %>" name="length">
    <br><br>
    Выберите личностей, которые участвовали в создании фильма:
    <%
        out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html>");
        out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
        out.println("<tr><th></th><th>Позиция</th><th>Имя</th><th>Фамилия</th><th>Дата рождения</th><th>Страна</th></tr>");
        for (int i = 0; i < listPerson.size(); i++) {
            Object o = listPerson.get(i);
            Person person = (Person) o;
            out.println("<tr><td><input type=\"checkBox\" name=\"check" + person.getId() + "\"  value=\"" + person.getId() + "\" >" +
                    "</td><td> <select name=\"position" + person.getId() + "\"> <option value=\"Актер\">Актер</option><option value=\"Режиссер\">Режиссер</option><option value=\"Продюссер\">Продюссер</option><option value=\"Сценарист\">Сценарист</option></select>" +
                    "</td><td>" + person.getFirstName() +
                    "</td><td>" + person.getLastName() +
                    "</td><td>" + person.getBirthday() +
                    "</td><td>" + person.getCountry());
        }
        out.println("</tbody></table>");
    %>
    <div style="padding: 5px;">
        <button type="submit">Сохранить</button>
        <button onclick="location.href ='film.jsp'">Назад</button>
    </div>
</form>
<jsp:include page="_footer.jsp"/>
</body>
</html>