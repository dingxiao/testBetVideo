package com.psd.bettest;

import java.sql.Connection;
import java.util.Map;

public class TestH2 {
    static String dbName = "test2";
    static String tableName = "table1";

    public static Map<String, String> test(String keyPre){
        GetH2Data h2dbObj = new GetH2Data();
        try{
            Connection con = h2dbObj.getConnection(dbName);
            if (con == null){
                return null;
            }
            h2dbObj.createTable(tableName, "name", "value", con, false);
            if (keyPre != null && !keyPre.isEmpty()){
                h2dbObj.insertTable(tableName, "key1", "value1111", con);
                h2dbObj.insertTable(tableName, "key2", "value2 with", con);
                h2dbObj.insertTable(tableName, "key3", "value3 and some", con);
            }
            Map<String, String> m = h2dbObj.readTable(tableName, "name", "value", con);
            con.close();
            return m;
        }
        catch (Exception e){
            System.out.println( e.getMessage() );
        }
        return null;
    }
    public static String create(String table){
        GetH2Data h2dbObj = new GetH2Data();
        try{
            Connection con = h2dbObj.getConnection(dbName);
            if (con == null){
                return null;
            }
           
            String rt = h2dbObj.createTable(table, "name", "value", con, true);
            con.close();
            return rt;
        }
        catch (Exception e){
            System.out.println( e.getMessage() );
        }
        return null;
    }
    public static String insert(String key, String value){
        GetH2Data h2dbObj = new GetH2Data();
        try{
            Connection con = h2dbObj.getConnection(dbName);
            if (con == null){
                return null;
            }
            if (key != null && !key.isEmpty()){
                h2dbObj.insertTable(tableName, key, value, con);
            }
            return "ok";
        }
        catch (Exception e){
            System.out.println( e.getMessage() );
        }
        return null;
    }
    public static Map<String, String> query(String givenKey){
        GetH2Data h2dbObj = new GetH2Data();
        try{
            Connection con = h2dbObj.getConnection(dbName);
            if (con == null){
                return null;
            }
            Map<String, String> m = h2dbObj.queryTable(tableName, "name", "value", givenKey, con);
            con.close();
            return m;
        }
        catch (Exception e){
            System.out.println( e.getMessage() );
        }
        return null;
    }

}
