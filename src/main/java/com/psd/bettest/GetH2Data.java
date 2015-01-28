package com.psd.bettest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class GetH2Data {
    
    static String defaultUser = "sa";
    static String defaultPw = "TYTY$%^7";
    public Connection getConnection(String dbName)
            throws Exception {
        Class.forName("org.h2.Driver");
        Connection conn = DriverManager.
            getConnection("jdbc:h2:~/" + dbName, defaultUser, defaultPw);
        // add application code here
        //conn.close();
        return conn;
    }
    public String createTable(String tableName, String field1, String field2, Connection con, boolean drop){
        String rt = "ok";
        try
        {
            Statement stmt = con.createStatement();
            if (drop) stmt.executeUpdate( "DROP TABLE " + tableName );
            stmt.executeUpdate( "CREATE TABLE IF NOT EXISTS " + tableName +  "  ( " + field1 + " varchar(150), " + field2 + " varchar(4000))" );
            stmt.close();
            //con.close();
           
        }
        catch( Exception e )
        {
            System.out.println( e.getMessage() );
            rt = e.getMessage();
        }
        return rt;
    }
    public String insertTable(String tableName, String value1, String value2, Connection con){
        System.out.println( "key="+ value1 + "; value=" + value2 );
        try
        {
            Statement stmt = con.createStatement();
            //insert into employees values (1,'Tom')
            stmt.executeUpdate( "INSERT INTO  " + tableName +  " VALUES ( '" + value1 + "', '" + value2 + "')" );
            stmt.close();
            
        }
        catch( Exception e )
        {
            System.out.println( e.getMessage() );
        }
        return "";
    }  
    public Map<String,String> readTable(String tableName, String field1, String field2, Connection con){
        Map<String,String> result = new HashMap<String,String>();
        try
        {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM " + tableName);
            while( rs.next() )
            {
                String key = rs.getString(field1);
                String value = rs.getString(field2);
                result.put(key, value);
            }
            stmt.close();
            
        }
        catch( Exception e )
        {
            System.out.println( e.getMessage() );
        }
        return result;
    }
    public Map<String,String> queryTable(String tableName, String field1, String field2, String givenKey, Connection con){
        Map<String,String> result = new HashMap<String,String>();
        try
        {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM " + tableName + " where " + field1 + "='" + givenKey + "'");
            while( rs.next() )
            {
                String key = rs.getString(field1);
                String value = rs.getString(field2);
                result.put(key, value);
            }
            stmt.close();
            
        }
        catch( Exception e )
        {
            System.out.println( e.getMessage() );
        }
        return result;
    }  
    public void closeConnection(Connection conn){
        try{
            conn.close();
        }
        catch (Exception e){
            System.out.println( e.getMessage() );
        }
    }
}
