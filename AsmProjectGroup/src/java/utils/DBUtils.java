package utils;


import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;


public class DBUtils implements Serializable {
   
    public static Connection makeConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");


            // thay host và database name cho phù hợp
            String host = "localhost:1433";
            String databaseName = "ProjectBookStoreDraft3";
            String url = 
                "jdbc:sqlserver://"+host+";databaseName="+databaseName;
           
            // thay các tham số username và password cho phù hợp
            String username = "sa";
            String password = "12345";
            Connection con = DriverManager.getConnection(
                 url, username, password);
            return con;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
