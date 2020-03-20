<%@ page import="com.filmlibrary.DAO" %>
<%@ page import="com.filmlibrary.entities.Serial" %>
<%@ page import="com.filmlibrary.entities.Person" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.filmlibrary.entities.EntityDB" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body bgcolor='#ffffff'>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
<jsp:useBean id="serial" class="com.filmlibrary.entities.Serial" scope="request"/>
<h1> Добавление нового сериала </h1>
<%
    DAO dao = new DAO();
    if (request.getParameter("action") != null) {
        int id = Integer.parseInt(request.getParameter("action"));
        serial = (Serial) dao.getEntityById(id, new Serial());
    } else {
        serial = null;
    }
    ArrayList<EntityDB> listPerson = dao.getAllEntity(new Person());
%>
<form method='POST' action='serial.jsp'>
    <input type="hidden" readonly name="serialId" value="<%if(serial!=null)out.print(serial.getId());%>"/>
    <input type="hidden" name="action" value="<% if(serial!=null) out.print("Edit"); else out.print("Add");%>"/>
    Название: <input name="title" value="<% if(serial!=null) out.print(serial.getTitle());%>"/>
    <br><br>
    Дата запуска: <input name="yearStart" value="<% if(serial!=null) out.print(serial.getYearStart());%>"/>
    <br><br>
    Дата окончания: <input name="yearFinish" value="<% if(serial!=null) out.print(serial.getYearFinish());%>"/>
    <br><br>
    Кол-во эпизодов: <input name="numEpisodes" value="<% if(serial!=null) out.print(serial.getNumEpisodes());%>"/>
    <br><br>
    Кол-во сезонов: <input name="numSeasons" value="<% if(serial!=null) out.print(serial.getNumSeasons());%>"/>
    <br><br>
    Оценка: <input name="imdb" value="<% if(serial!=null) out.print(serial.getImdb());%>"/>
    <br><br>
    Выберите личностей, которые участвовали в создании сериала:
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
        <button onclick="location.href ='serial.jsp'">Назад</button>
    </div>
</form>
<jsp:include page="_footer.jsp"/>
</body>
</html>