package com.filmlibrary;

import com.filmlibrary.entities.EntityDB;
import com.filmlibrary.entities.Film;
import com.filmlibrary.entities.Person;

import javax.swing.text.html.parser.Entity;
import java.sql.*;
import java.util.ArrayList;

public class DAO {
    private Connection connection;

    public DAO() {
        connection = DBUtil.getConnection();
    }

    public void addEntity(EntityDB entity) {
        try {
            StringBuilder query = new StringBuilder();
            query.append("INSERT INTO ").append(entity.getTableName()).append("(");
            for (int i = 1; i < entity.getColumns().size() - 1; i++) {
                query.append(entity.getColumns().get(i));
                query.append(",");
            }
            query.append(entity.getColumns().get(entity.getColumns().size() - 1)).append(") values (");
            for (int i = 0; i < entity.getColumns().size() - 2; i++) {
                query.append("?,");
            }
            query.append("?)");
            System.out.println(query);
            PreparedStatement preparedStatement = connection.prepareStatement(String.valueOf(query));
            preparedStatement = entity.setDataAdd(preparedStatement);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteEntity(int id, EntityDB entity) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("delete from " + entity.getTableName() + " where " + entity.getColumns().get(0) + "=?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateEntity(EntityDB entityDB) {
        try {
            StringBuilder query = new StringBuilder();
            query.append("update " + entityDB.getTableName() + " set ");
            for (int i = 1; i < entityDB.getColumns().size() - 1; i++) {
                query.append(entityDB.getColumns().get(i) + "=?,");
            }
            query.append(entityDB.getColumns().get(entityDB.getColumns().size() - 1) + "=? where " + entityDB.getColumns().get(0) + "=?");
            PreparedStatement preparedStatement = connection.prepareStatement(String.valueOf(query));
            preparedStatement = entityDB.setDataUpdate(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<EntityDB> searchEntity(String column, String searchItem, EntityDB entityDB) {
        ArrayList<EntityDB> entities = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM " + entityDB.getTableName() + " WHERE " + column + " = ?");
            if (tryParse(searchItem, "integer")) {
                preparedStatement.setInt(1, Integer.parseInt(searchItem));
            } else if (tryParse(searchItem, "double")) {
                preparedStatement.setDouble(1, Double.parseDouble(searchItem));
            } else {
                preparedStatement.setString(1, searchItem);
            }
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                entities.add(getEntity(resultSet, entityDB));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entities;
    }

    public boolean tryParse(String value, String type) {
        try {
            switch (type) {
                case "integer":
                    Integer.parseInt(value);
                    return true;
                case "double":
                    Double.parseDouble(value);
                    return true;
            }
        } catch (NumberFormatException e) {
            return false;
        }
        return true;
    }

    public EntityDB getEntity(ResultSet resultSet, EntityDB
            entityDB) {
        return entityDB.getEntity(resultSet);
    }

    public ArrayList<EntityDB> getAllEntity(EntityDB entityDB) {
        ArrayList<EntityDB> entities = new ArrayList<>();
        try {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select * from " + entityDB.getTableName() + "");
            while (rs.next()) {
                entities.add(getEntity(rs, entityDB));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entities;
    }

    public EntityDB getEntityById(int entityId, EntityDB entityDB) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select * from " + entityDB.getTableName() + " where " + entityDB.getColumns().get(0) + "=?");
            preparedStatement.setInt(1, entityId);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                entityDB = entityDB.getEntity(rs);
            }
            return entityDB;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<EntityDB> getProjectsByPerson(String projectType, String position, int entityId, EntityDB entityDB) {
        ArrayList<EntityDB> entities = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select distinct * " +
                    "from " + projectType + " " +
                    "where id_" + projectType + " in " +
                    "      (select id_" + projectType +
                    "       from " + projectType + "_person " +
                    "       where id_position in " +
                    "             (select id_position " +
                    "              from position " +
                    "              where name_position = ?) " +
                    "         and id_person = ?) ");
            preparedStatement.setString(1, position);
            preparedStatement.setInt(2, entityId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                entities.add(getEntity(resultSet, entityDB));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entities;
    }

    public ArrayList<EntityDB> getPersonByProject(String projectType, String position, int entityId, EntityDB entityDB){
        ArrayList<EntityDB> entities = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("select distinct * " +
                    "from person " +
                    "where id_person in " +
                    "      (select id_person " +
                    "       from " + projectType + "_person" +
                    "       where id_position in (select id_position" +
                    "              from position" +
                    "              where name_position = ?) and id_" + projectType + " = ?)");
            preparedStatement.setString(1, position);
            preparedStatement.setInt(2, entityId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                entities.add(getEntity(resultSet, entityDB));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return entities;
    }

    public void setProjectToPerson(String projectType, int projectId, int personId, int positionId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("insert into " + projectType + "_person " +
                    "values (?, ?, ?) ");
            preparedStatement.setInt(1, projectId);
            preparedStatement.setInt(2, personId);
            preparedStatement.setInt(3, positionId);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getNumOfProjects(String projectType, int personId){
        int numOfProjects = 0;
        try{
            PreparedStatement preparedStatement = connection.prepareStatement("select count(*)" +
                    "from (select distinct id_person, id_" + projectType + " from " + projectType + "_person where id_person = ?)" +
                    " as numOfProjects");
            preparedStatement.setInt(1, personId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                numOfProjects = resultSet.getInt("count");
            }
        } catch (SQLException e){
            e.printStackTrace();
        }
        return numOfProjects;
    }

    public static void main(String[] arg) {
        DAO dao = new DAO();
        ArrayList<EntityDB> listPerson = dao.getPersonByProject("serial", "Актер", 1, new Person());
        for(int i = 0; i < listPerson.size(); i++){
            System.out.println(listPerson.get(i));
        }

    }
}

