package com.filmlibrary.entities;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public interface EntityDB {
    String getTableName();

    List<String> getColumns();

    List<String> getRow();

    PreparedStatement setDataAdd(PreparedStatement preparedStatement) throws SQLException;

    PreparedStatement setDataUpdate(PreparedStatement preparedStatement) throws SQLException;

    void addColumns();

    EntityDB getEntity(ResultSet resultSet);
}
