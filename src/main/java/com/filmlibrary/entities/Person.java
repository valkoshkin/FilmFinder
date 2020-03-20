package com.filmlibrary.entities;

import java.io.Serializable;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

public class Person implements Serializable, EntityDB {
    private int idPerson;
    private String firstName;
    private String lastName;
    private LocalDate birthday;
    private String country;
    private String table;
    private int countColumns;
    private ArrayList<String> columns;

    public Person() {
        table = "public.person";
        countColumns = 5;
        addColumns();
    }

    public Person(int idPerson, String firstName, String lastName, LocalDate birthday, String country) {
        this.idPerson = idPerson;
        this.firstName = firstName;
        this.lastName = lastName;
        this.birthday = birthday;
        this.country = country;
        table = "public.person";
        countColumns = 5;
        addColumns();
    }

    public Person(String firstName, String lastName, LocalDate localDate, String country) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.birthday = localDate;
        this.country = country;
        table = "public.person";
        countColumns = 5;
        addColumns();
    }

    public int getId() {
        return idPerson;
    }

    public void setId(int idPerson) {
        this.idPerson = idPerson;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String secondName) {
        this.lastName = secondName;
    }

    public LocalDate getBirthday() {
        return birthday;
    }

    public void setBirthday(LocalDate birthday) {
        this.birthday = birthday;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getTable() {
        return table;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public int getCountColumns() {
        return countColumns;
    }

    public void setCountColumns(int countColumns) {
        this.countColumns = countColumns;
    }

    public void setColumns(ArrayList<String> columns) {
        this.columns = columns;
    }

    @Override
    public String toString() {
        return firstName + " " + lastName + " " + birthday + " " + country;
    }

    @Override
    public String getTableName() {
        return table;
    }

    @Override
    public List<String> getColumns() {
        return columns;
    }

    @Override
    public List<String> getRow() {
        List<String> row = new ArrayList<>();
        row.add(String.valueOf(getId()));
        row.add(getFirstName());
        row.add(getLastName());
        row.add(getBirthday().toString());
        row.add(getCountry());
        return row;
    }

    @Override
    public PreparedStatement setDataAdd(PreparedStatement preparedStatement) throws SQLException {
        preparedStatement.setString(1, firstName);
        preparedStatement.setString(2, lastName);
        preparedStatement.setDate(3, Date.valueOf(birthday));
        preparedStatement.setString(4, country);
        return preparedStatement;
    }

    @Override
    public PreparedStatement setDataUpdate(PreparedStatement preparedStatement) throws SQLException {
        preparedStatement.setString(1, getFirstName());
        preparedStatement.setString(2, getLastName());
        preparedStatement.setDate(3, Date.valueOf(getBirthday()));
        preparedStatement.setString(4, getCountry());
        preparedStatement.setInt(5, getId());
        return preparedStatement;
    }

    @Override
    public void addColumns() {
        columns = new ArrayList<>();
        columns.add("id_person");
        columns.add("first_name");
        columns.add("second_name");
        columns.add("birthday");
        columns.add("country");
    }

    @Override
    public EntityDB getEntity(ResultSet resultSet) {
        Person person = new Person();
        try {
            person.setId(resultSet.getInt("id_person"));
            person.setFirstName(resultSet.getString("first_name"));
            person.setLastName(resultSet.getString("second_name"));
            Date date = resultSet.getDate("birthday");
            person.setBirthday(Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDate());
            person.setCountry(resultSet.getString("country"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return person;
    }
}
