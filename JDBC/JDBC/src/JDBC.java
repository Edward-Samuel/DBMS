package JDBC.src;\

import java.sql.*;
import java.util.Scanner;

public class JDBC {
    public static void main(String[] args) throws Exception {
        readrecords();
    }

    public static void readrecords() throws Exception {
        String url="jdbc:mysql://localhost:3306/jdbc";
        String username="root";
        String password="password";
        String query="SELECT * FROM employee";
        Connection con=DriverManager.getConnection(url, username, password);
        Statement st=con.createStatement();
        ResultSet rs=st.executeQuery(query);

        while (rs.next()) {
            System.out.println("ID IS " + rs.getInt(1));Z
            System.out.println("NAME IS " + rs.getString(2));
            System.out.println("SALARY IS " + rs.getInt\(3));
        }
        con.close();
    }

    public static void insertrecords() throws Exception {
        String url="jdbc:mysql://localhost:3306/jdbc";
        String username="root";
        String password="password";
        Scanner s=new Scanner(System.in);
        System.out.println("ENTER YOUR ID :");
        int id=s.nextInt();
        s.nextLine();
        System.out.println("ENTER YOUR NAME :");
        String str=s.nextLine();
        System.out.println("ENTER YOUR SALARY :");
        int sal=s.nextInt();
        String query="INSERT INTO employee VALUES(" + id + ",'" + str + "," + sal + ");";

        Connection con=DriverManager.getConnection(url, username, password);
        Statement st=con.createStatement();
        int rows=st.executeUpdate(query);

        System.out.println("NUMBER OF ROWS AFFECTED :" + rows);
        con.close();
    }
}
