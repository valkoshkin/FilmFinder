package com.filmlibrary.entities;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Serial implements Serializable, EntityDB {

    private int id;
    private String title;
    private int yearStart;
    private int yearFinish;
    private int numEpisodes;
    private int numSeasons;
    private double imdb;
    private String table;
    private int countColumns;
    private ArrayList<String> columns;

    public Serial() {
        table = "public.serial";
        countColumns = 7;
        addColumns();
    }

    public Serial(int id, String title, int yearStart, int yearFinish, int numEpisodes, int numSeasons, double imdb) {
        table = "public.serial";
        countColumns = 7;
        addColumns();
        this.id = id;
        this.title = title;
        this.yearStart = yearStart;
        this.yearFinish = yearFinish;
        this.numEpisodes = numEpisodes;
        this.numSeasons = numSeasons;
        this.imdb = imdb;
    }

    public Serial(String title, int yearStart, int yearFinish, int numEpisodes, int numSeasons, double imdb) {
        table = "public.serial";
        countColumns = 7;
        addColumns();
        this.title = title;
        this.yearStart = yearStart;
        this.yearFinish = yearFinish;
        this.numEpisodes = numEpisodes;
        this.numSeasons = numSeasons;
        this.imdb = imdb;
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

    public int getYearStart() {
        return yearStart;
    }

    public void setYearStart(int yearStart) {
        this.yearStart = yearStart;
    }

    public int getYearFinish() {
        return yearFinish;
    }

    public void setYearFinish(int yearFinish) {
        this.yearFinish = yearFinish;
    }

    public int getNumEpisodes() {
        return numEpisodes;
    }

    public void setNumEpisodes(int numEpisodes) {
        this.numEpisodes = numEpisodes;
    }

    public int getNumSeasons() {
        return numSeasons;
    }

    public void setNumSeasons(int numSeasons) {
        this.numSeasons = numSeasons;
    }

    public double getImdb() {
        return imdb;
    }

    public void setImdb(double imdb) {
        this.imdb = imdb;
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
        row.add(String.valueOf(getYearStart()));
        row.add(String.valueOf(getYearFinish()));
        row.add(String.valueOf(getNumEpisodes()));
        row.add(String.valueOf(getNumSeasons()));
        row.add(String.valueOf(getImdb()));
        return row;
    }

    @Override
    public PreparedStatement setDataAdd(PreparedStatement preparedStatement) throws SQLException {
        preparedStatement.setString(1, title);
        preparedStatement.setInt(2, yearStart);
        preparedStatement.setInt(3, yearFinish);
        preparedStatement.setInt(4, numEpisodes);
        preparedStatement.setInt(5, numSeasons);
        preparedStatement.setDouble(6, imdb);
        return preparedStatement;
    }

    @Override
    public PreparedStatement setDataUpdate(PreparedStatement preparedStatement) throws SQLException {
        preparedStatement.setString(1, title);
        preparedStatement.setInt(2, yearStart);
        preparedStatement.setInt(3, yearFinish);
        preparedStatement.setInt(4, numEpisodes);
        preparedStatement.setInt(5, numSeasons);
        preparedStatement.setDouble(6, imdb);
        preparedStatement.setInt(7, id);
        return preparedStatement;
    }

    @Override
    public void addColumns() {
        columns = new ArrayList<>();
        columns.add("id_serial");
        columns.add("title");
        columns.add("year_start");
        columns.add("year_finish");
        columns.add("num_of_episodes");
        columns.add("num_of_seasons");
        columns.add("imdb");
    }

    @Override
    public EntityDB getEntity(ResultSet resultSet) {
        Serial serial = new Serial();
        try {
            serial.setId(resultSet.getInt("id_serial"));
            serial.setTitle(resultSet.getString("title"));
            serial.setYearStart(resultSet.getInt("year_start"));
            serial.setYearFinish(resultSet.getInt("year_finish"));
            serial.setNumEpisodes(resultSet.getInt("num_of_episodes"));
            serial.setNumSeasons(resultSet.getInt("num_of_seasons"));
            serial.setImdb(resultSet.getDouble("imdb"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return serial;
    }
}
