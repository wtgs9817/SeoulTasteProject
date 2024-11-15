package com.example.DBConnectionTest;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

import static org.springframework.test.util.AssertionErrors.assertNotNull;

@SpringBootTest
public class DBConnectionTests {

    @Autowired
    DataSource dataSource;

    @Test
    public void connectionTest() {

        try {
            Connection connection = dataSource.getConnection();
            assertNotNull("연결실패",connection);

            System.out.println("연결 성공");
        }
        catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
