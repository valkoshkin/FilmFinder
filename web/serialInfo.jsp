<%@ page import="com.filmlibrary.DAO" %>
<%@ page import="com.filmlibrary.entities.Person" %>
<%@ page import="com.filmlibrary.entities.Film" %>
<%@ page import="com.filmlibrary.entities.Serial" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body bgcolor='#ffffff'>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
<jsp:useBean id="serial" class="com.filmlibrary.entities.Serial" scope="request"/>
<jsp:useBean id="filmsAsActor" class="java.util.ArrayList" scope="application"/>
<jsp:useBean id="filmsAsDirector" class="java.util.ArrayList" scope="application"/>
<jsp:useBean id="serialsAsActor" class="java.util.ArrayList" scope="application"/>
<jsp:useBean id="serialsAsDirector" class="java.util.ArrayList" scope="application"/>
<%
    if (request.getParameter("action") != null) {
        DAO dao = new DAO();
        int id = Integer.parseInt(request.getParameter("action"));
        serial = (Serial) dao.getEntityById(id, new Serial());
        filmsAsActor = dao.getProjectsByPerson("film", "Актер", id, new Film());
        filmsAsDirector = dao.getProjectsByPerson("film", "Режиссер", id, new Film());
        serialsAsActor = dao.getProjectsByPerson("serial", "Актер", id, new Serial());
        serialsAsDirector = dao.getProjectsByPerson("serial", "Режиссер", id, new Serial());
    } else {
        serial = null;

    }
%>
<form method='POST' action='personView.jsp'>
    <input type="hidden" readonly name="personId" value="<%if(serial!=null)out.print(serial.getId());%>"/>
    <input type="hidden" name="action" value="<% if(serial!=null) out.print("Edit"); else out.print("Add");%>"/>
    <h2><% if(serial!=null) out.print(serial.getTitle());%></h2>
    <b>Годы:</b> <% if(serial!=null) out.print(serial.getYearStart());%> - <% if(serial!=null) out.print(serial.getYearFinish());%>
    <br><br>
    <b>Всего сезонов:</b> <% if(serial!=null) out.print(serial.getNumSeasons());%>
    <br><br>
    <b>Всего эпизодов:</b> <% if(serial!=null) out.print(serial.getNumEpisodes());%>
    <br><br>
    <b>IMDb:</b> <% if(serial!=null) out.print(serial.getImdb());%>
</form>
<%--<%--%>
<%--    out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html>");--%>
<%--    out.println("<body>");--%>
<%--    if (filmsAsActor.size() != 0) {--%>
<%--        out.println("<br><br>Фильмы (актер):");--%>
<%--        out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");--%>
<%--        out.println("<tr><th>Название</th><th>Год</th></tr>");--%>
<%--        for (int i = 0; i < filmsAsActor.size(); i++) {--%>
<%--            Object o = filmsAsActor.get(i);--%>
<%--            Film film = (Film) o;--%>
<%--            out.println("<tr><td>" + film.getTitle() +--%>
<%--                    "</td><td>" + film.getIssueYear() + "</td></tr>");--%>
<%--        }--%>
<%--        out.println("</tbody></table>");--%>
<%--    }--%>
<%--    if (filmsAsDirector.size() != 0) {--%>
<%--        out.println("<br><br>Фильмы (режиссер):");--%>
<%--        out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");--%>
<%--        out.println("<tr><th>Название</th><th>Год</th></tr>");--%>
<%--        for (int i = 0; i < filmsAsDirector.size(); i++) {--%>
<%--            Object o = filmsAsDirector.get(i);--%>
<%--            Film film = (Film) o;--%>
<%--            out.println("<tr><td>" + film.getTitle() +--%>
<%--                    "</td><td>" + film.getIssueYear() + "</td></tr>");--%>
<%--        }--%>
<%--        out.println("</tbody></table>");--%>
<%--    }--%>
<%--    if (serialsAsActor.size() != 0) {--%>
<%--        out.println("<br><br>Сериалы (актер):");--%>
<%--        out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");--%>
<%--        out.println("<tr><th>Название</th><th>Год запуска</th><th>Год завершения</th></tr>");--%>
<%--        for (int i = 0; i < serialsAsActor.size(); i++) {--%>
<%--            Object o = serialsAsActor.get(i);--%>
<%--            Serial serial = (Serial) o;--%>
<%--            out.println("<tr><td>" + serial.getTitle() +--%>
<%--                    "</td><td>" + serial.getYearStart() +--%>
<%--                    "</td><td>" + serial.getYearFinish() + "</td></tr>");--%>
<%--        }--%>
<%--        out.println("</tbody></table>");--%>
<%--    }--%>
<%--    if (serialsAsDirector.size() != 0) {--%>
<%--        out.println("<br><br>Сериалы (режиссер)");--%>
<%--        out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");--%>
<%--        out.println("<tr><th>Название</th><th>Год запуска</th><th>Год завершения</th></tr>");--%>
<%--        for (int i = 0; i < serialsAsDirector.size(); i++) {--%>
<%--            Object o = serialsAsDirector.get(i);--%>
<%--            Serial serial = (Serial) o;--%>
<%--            out.println("<tr><td>" + serial.getTitle() +--%>
<%--                    "</td><td>" + serial.getYearStart() +--%>
<%--                    "</td><td>" + serial.getYearFinish() + "</td></tr>");--%>
<%--        }--%>
<%--        out.println("</tbody></table>");--%>
<%--    }--%>
<%--    out.println("</body></html>");--%>
<%--%>--%>
<jsp:include page="_footer.jsp"/>
</body>
</html>