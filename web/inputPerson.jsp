<%@ page import="com.filmlibrary.DAO" %>
<%@ page import="com.filmlibrary.entities.Film" %>
<%@ page import="com.filmlibrary.entities.Person" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.filmlibrary.entities.EntityDB" %>
<%@ page import="com.filmlibrary.entities.Serial" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body bgcolor='#ffffff'>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>
<jsp:useBean id="person" class="com.filmlibrary.entities.Person" scope="request"/>
<jsp:useBean id="listFilm" class="java.util.ArrayList" scope="application"/>
<h1> Добавление новой личности </h1>
<%
    DAO dao = new DAO();
    if (request.getParameter("action") != null) {
        listFilm = dao.getAllEntity(new Film());
        int id = Integer.parseInt(request.getParameter("action"));
        person = (Person) dao.getEntityById(id, new Person());
        LocalDate date = person.getBirthday();
    } else {
        person = null;
    }
    listFilm = dao.getAllEntity(new Film());
    ArrayList<EntityDB> listSerial = dao.getAllEntity(new Serial());
%>
<form method='POST' action='personView.jsp'>
    <input type="hidden" readonly name="personId" value="<%if(person!=null)out.print(person.getId());%>"/>
    <input type="hidden" name="action" value="<% if(person!=null) out.print("Edit"); else out.print("Add");%>"/>
    Имя: <input name="firstName" value="<% if(person!=null) out.print(person.getFirstName());%>"/>
    <br><br>
    Фамилия: <input name="lastName" value="<% if(person!=null) out.print(person.getLastName());%>"/>
    <br><br>
    Страна: <input name="country" list="countryList" value="<% if(person!=null) out.print(person.getCountry());%>"/>
    <datalist id="countryList">
        <script>
            var countries = ["Абхазия", "Австралия", "Австрия", "Азербайджан", "Албания", "Алжир", "Ангола", "Ангуилья", "Андорра", "Антигуа и Барбуда", "Антильские острова", "Аргентина", "Армения", "Афганистан", "Багамские острова", "Бангладеш", "Барбадос", "Бахрейн", "Беларусь", "Белиз", "Бельгия", "Бенин", "Бермуды", "Болгария", "Боливия", "Босния/Герцеговина", "Ботсвана", "Бразилия", "Британские Виргинские о-ва", "Бруней", "Буркина Фасо", "Бурунди", "Бутан", "Вануату", "Ватикан", "Великобритания", "Венгрия", "Венесуэла", "Вьетнам", "Габон", "Гаити", "Гайана", "Гамбия", "Гана", "Гваделупа", "Гватемала", "Гвинея", "Гвинея-Бисау", "Германия", "Гернси остров", "Гибралтар", "Гондурас", "Гонконг", "Государство Палестина", "Гренада", "Гренландия", "Греция", "Грузия", "ДР Конго", "Дания", "Джерси остров", "Джибути", "Доминиканская Республика", "Египет", "Замбия", "Западная Сахара", "Зимбабве", "Израиль", "Индия", "Индонезия", "Иордания", "Ирак", "Иран", "Ирландия", "Исландия", "Испания", "Италия", "Йемен", "Кабо-Верде", "Казахстан", "Камбоджа", "Камерун", "Канада", "Катар", "Кения", "Кипр", "Китай", "Колумбия", "Коста-Рика", "Кот-д'Ивуар", "Куба", "Кувейт", "Кука острова", "Кыргызстан", "Лаос", "Латвия", "Лесото", "Либерия", "Ливан", "Ливия", "Литва", "Лихтенштейн", "Люксембург", "Маврикий", "Мавритания", "Мадагаскар", "Македония", "Малайзия", "Мали", "Мальдивские острова", "Мальта", "Марокко", "Мексика", "Мозамбик", "Молдова", "Монако", "Монголия", "Мьянма (Бирма)", "Мэн о-в", "Намибия", "Непал", "Нигер", "Нигерия", "Нидерланды (Голландия)", "Никарагуа", "Новая Зеландия", "Новая Каледония", "Норвегия", "О.А.Э.", "Оман", "Пакистан", "Палау", "Панама", "Папуа Новая Гвинея", "Парагвай", "Перу", "Питкэрн остров", "Польша", "Португалия", "Пуэрто Рико", "Республика Конго", "Реюньон", "Россия", "Руанда", "Румыния", "США", "Сальвадор", "Самоа", "Сан-Марино", "Сан-Томе и Принсипи", "Саудовская Аравия", "Свазиленд", "Святая Люсия", "Северная Корея", "Сейшеллы", "Сен-Пьер и Микелон", "Сенегал", "Сент Китс и Невис", "Сент-Винсент и Гренадины", "Сербия", "Сингапур", "Сирия", "Словакия", "Словения", "Соломоновы острова", "Сомали", "Судан", "Суринам", "Сьерра-Леоне", "Таджикистан", "Таиланд", "Тайвань", "Танзания", "Того", "Токелау острова", "Тонга", "Тринидад и Тобаго", "Тувалу", "Тунис", "Туркменистан", "Туркс и Кейкос", "Турция", "Уганда", "Узбекистан", "Украина", "Уоллис и Футуна острова", "Уругвай", "Фарерские острова", "Фиджи", "Филиппины", "Финляндия", "Франция", "Французская Полинезия", "Хорватия", "Чад", "Черногория", "Чехия", "Чили", "Швейцария", "Швеция", "Шри-Ланка", "Эквадор", "Экваториальная Гвинея", "Эритрея", "Эстония", "Эфиопия", "ЮАР", "Южная Корея", "Южная Осетия", "Ямайка", "Япония"];
            for (i = 0; i < countries.length; i++) {
                document.write('<option value="' + countries[i] + '">' + countries[i] + '</option>');
            }
        </script>
    </datalist>
    <br><br>
    Дата рождения:<input type="date" value="<% %>" name="birthday">
    <br><br>
    Выберите фильмы в которых участвовала личность:
    <%
        out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html>");
        out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
        out.println("<tr><th></th><th>Позиция в фильме</th><th>Название</th><th>Дата выхода</th><th>Оценка</th><th>Длина</th><th></th></tr>");
        for (int i = 0; i < listFilm.size(); i++) {
            Object o = listFilm.get(i);
            Film film = (Film) o;
            out.println("<tr><td><input type=\"checkBox\" name=\"checkFilm" + film.getId() + "\"  value=\"" + film.getId() + "\" >" +
                    "</td><td> <select name=\"positionFilm" + film.getId() + "\"> <option value=\"Актер\">Актер</option><option value=\"Режиссер\">Режиссер</option><option value=\"Продюсер\">Продюсер</option><option value=\"Сценарист\">Сценарист</option></select>" +
                    "</td><td>" + film.getTitle() +
                    "</td><td>" + film.getIssueYear() +
                    "</td><td>" + film.getImdb() +
                    "</td><td>" + film.getLength());
        }
        out.println("</tbody></table>");
    %>
    <br><br>
    Выберите сериалы в которых участвовала личность:
    <%
        out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\"styles.css\"><html>");
        out.println("<table  id=\"centerPlacement\" border=\"1\"><tbody>");
        out.println("<tr><th></th><th>Позиция в сериале</th><th>Название</th><th>Год запуска</th><th>Год окончания</th><th>Эпизоды</th><th>Сезоны</th><th>Оценка</th></tr>");
        for (int i = 0; i < listSerial.size(); i++) {
            Object o = listSerial.get(i);
            Serial serial = (Serial) o;
            out.println("<tr><td><input type=\"checkBox\" name=\"checkSerial" + serial.getId() + "\"  value=\"" + serial.getId() + "\" >" +
                    "</td><td> <select name=\"positionSerial" + serial.getId() + "\"> <option value=\"Актер\">Актер</option><option value=\"Режиссер\">Режиссер</option><option value=\"Продюссер\">Продюссер</option><option value=\"Сценарист\">Сценарист</option></select>" +
                    "</td><td>" + serial.getTitle() +
                    "</td><td>" + serial.getYearStart() +
                    "</td><td>" + serial.getYearFinish() +
                    "</td><td>" + serial.getNumEpisodes() +
                    "</td><td>" + serial.getNumSeasons() +
                    "</td><td>" + serial.getImdb());
        }
        out.println("</tbody></table>");
    %>
    <div style="padding: 5px;">
        <button type="submit">Сохранить</button>
        <button onclick="location.href ='personView.jsp'">Назад</button>
    </div>
</form>
<jsp:include page="_footer.jsp"/>
</body>
</html>