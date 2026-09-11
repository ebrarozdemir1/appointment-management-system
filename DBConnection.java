package randevusistemi;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    Connection conn;

    public Connection connect() {

        try {

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            String url =
            "jdbc:sqlserver://localhost:1433;"
            + "databaseName=RandevuDB;"
            + "encrypt=true;"
            + "trustServerCertificate=true;";

            String user = System.getenv("DB_USER");
            String password = System.getenv("DB_PASSWORD");

            if (user == null || password == null) {
                throw new IllegalStateException(
                    "Database credentials are not configured."
                );
            }

            conn = DriverManager.getConnection(url, user, password);

            System.out.println("Database connection successful.");

        } catch (Exception e) {

            System.out.println("Database connection failed!");
            e.printStackTrace();
        }

        return conn;
    }
}