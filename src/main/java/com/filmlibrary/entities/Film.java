package com.filmlibrary.entities;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class Film implements Serializable, EntityDB {

    private int id;
    private String title;
    private int issueYear;
    private double imdb;
    private int length;
    private String table;
    private int countColumns;
    private ArrayList<String> columns;

    public Film() {
        table = "public.film";
        countColumns = 5;
        addColumns();
    }

    public Film(int id, String title, int issueYear, double imdb, int length) {
        this.id = id;
        this.title = title;
        this.issueYear = issueYear;
        this.imdb = imdb;
        this.length = length;
        table = "public.film";
        countColumns = 5;
        addColumns();
    }

    public Film(String title, int issueYear, double imdb, int length) {
        this.title = title;
        this.issueYear = issueYear;
        this.imdb = imdb;
        this.length = length;
        table = "public.film";
        countColumns = 5;
        addColumns();
    }

    @Override
    public void addColumns() {
        columns = new ArrayList<>();
        columns.add("id_film");
        columns.add("title");
        columns.add("issue_year");
        columns.add("imdb");
        columns.add("length");
    }

    @Override
    public EntityDB getEntity(ResultSet resultSet) {
        Film film = new Film();
        try {
            film.setId(resultSet.getInt("id_film"));
            film.setTitle(resultSet.getString("title"));
            film.setIssueYear(resultSet.getInt("issue_year"));
            film.setImdb(resultSet.getInt("imdb"));
            film.setLength(resultSet.getInt("length"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return film;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getIssueYear() {
        return issueYear;
    }

    public void setIssueYear(int issueYear) {
        this.issueYear = issueYear;
    }

    public double getImdb() {
        return imdb;
    }

    public void setImdb(double imdb) {
        this.imdb = imdb;
    }

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
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
        row.add(getTitle());
        row.add(String.valueOf(getIssueYear()));
        row.add(String.valueOf(getImdb()));
        row.add(String.valueOf(getLength()));
        return row;
    }

    @Override
    public PreparedStatement setDataAdd(PreparedStatement preparedStatement) throws SQLException {
        preparedStatement.setString(1, title);
        preparedStatement.setInt(2, issueYear);
        preparedStatement.setDouble(3, imdb);
        preparedStatement.setInt(4, length);
        return preparedStatement;
    }

    @Override
    public PreparedStatement setDataUpdate(PreparedStatement preparedStatement) throws SQLException {
        preparedStatement.setString(1, title);
        preparedStatement.setInt(2, issueYear);
        preparedStatement.setDouble(3, imdb);
        preparedStatement.setInt(4, length);
        preparedStatement.setInt(5, id);
        return preparedStatement;
    }

    public void setColumns(ArrayList<String> columns) {
        this.columns = columns;
    }

}
