package com.filmlibrary.entities;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Position implements Serializable, EntityDB {
    private int id;
    private String namePosition;
    private String table;
    private int countColumns;
    private ArrayList<String> columns;

    public Position(){
        table = "public.position";
        countColumns = 2;
        addColumns();
    }

    public Position(int id, String namePosition){
        table = "public.position";
        countColumns = 2;
        addColumns();
        this.id = id;
        this.namePosition = namePosition;
    }

    public Position(String namePosition){
        table = "public.position";
        countColumns = 2;
        addColumns();
        this.namePosition = namePosition;
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
        row.add(String.valueOf(id));
        row.add(namePosition);
        return row;
    }

    @Override
    public PreparedStatement setDataAdd(PreparedStatement preparedStatement) throws SQLException {
        preparedStatement.setString(1, namePosition);
        return preparedStatement;
    }

    @Override
    public PreparedStatement setDataUpdate(PreparedStatement preparedStatement) throws SQLException {
        preparedStatement.setString(1, getNamePosition());
        return preparedStatement;
    }

    @Override
    public void addColumns() {
        columns = new ArrayList<>();
        columns.add("id_position");
        columns.add("name_position");
    }

    @Override
    public EntityDB getEntity(ResultSet resultSet) {
        Position position = new Position();
        try{
            position.setId(resultSet.getInt("id_position"));
            position.setNamePosition(resultSet.getString("name_position"));
        } catch (SQLException e){
            e.printStackTrace();
        }
        return position;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId(){
        return id;
    }

    public void setNamePosition(String namePosition){
        this.namePosition = namePosition;
    }

    public String getNamePosition(){
        return namePosition;
    }
}
