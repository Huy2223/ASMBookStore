package dao;

import dto.Account;
import utils.DBUtils; // Sẽ mock phương thức static của class này

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement; // Thêm import này
import java.util.List;

import mockit.*;
import org.junit.Test;
import static org.junit.Assert.*;

public class AccountDAOTest {

    @Tested // Đối tượng DAO chúng ta muốn test
    AccountDAO accountDAO;

    // Mock các thành phần JDBC
    @Mocked
    Connection mockConnection;
    @Mocked
    PreparedStatement mockPreparedStatement;
    @Mocked
    Statement mockStatement;
    @Mocked
    ResultSet mockResultSet;

    // Test case 1: Lấy tài khoản theo email thành công
    @Test // Đánh dấu đây là một phương thức test để JUnit có thể chạy nó.
public void testGetAccountByEmail_Success() throws Exception {
    // PHẦN 1: THIẾT LẬP DỮ LIỆU VÀ MOCK OBJECTS (GIVEN - Khi có...)
    // ------------------------------------------------------------------

    // Dữ liệu đầu vào cho phương thức getAccountByEmail
    final String emailToFind = "test@example.com";   
    final Account expectedAccount = new Account(1, "testUser", "password123", emailToFind, "CUSTOMER");

    // Mock DBUtils.makeConnection() để trả về mockConnection
    // Lớp DBUtils có phương thức static là makeConnection(). Để kiểm soát nó,
    // chúng ta dùng new MockUp<DBUtils>() {} để "ghi đè" tạm thời phương thức đó.
    new MockUp<DBUtils>() {
        @Mock 
        public Connection makeConnection() {
            // Khi AccountDAO gọi DBUtils.makeConnection(), thay vì kết nối DB thật,
            // nó sẽ nhận được mockConnection của chúng ta.
            return mockConnection; 
        }
    };

    // PHẦN 2: Kịch bản/Kỳ vọng (EXPECTATIONS - Thì tôi kỳ vọng...)
    // ------------------------------------------------------------------
    // Khối này nói cho JMockit biết: "Khi AccountDAO chạy, tôi mong đợi các
    // tương tác sau đây sẽ xảy ra trên các đối tượng đã được mock (mockConnection,
    // mockPreparedStatement, mockResultSet), và đây là kết quả của chúng."
    new Expectations() {{
        // 1. Kỳ vọng AccountDAO sẽ gọi mockConnection.prepareStatement()
        //    với câu lệnh SQL chính xác để tìm tài khoản theo email.
        //    Và khi gọi, nó sẽ trả về mockPreparedStatement của chúng ta.
        mockConnection.prepareStatement("SELECT * FROM Accounts WHERE Email = ?");
        result = mockPreparedStatement;       
        mockPreparedStatement.setString(1, emailToFind);       
        mockPreparedStatement.executeQuery();
        result = mockResultSet;       
        mockResultSet.next(); returns(true, false);       
mockResultSet.getInt("accountID"); result = expectedAccount.getAccountID();
        mockResultSet.getString("userName"); result = expectedAccount.getUserName();
        mockResultSet.getString("password"); result = expectedAccount.getPassword();
        mockResultSet.getString("email"); result = expectedAccount.getEmail();
        mockResultSet.getString("role"); result = expectedAccount.getRole();
    }};

    // PHẦN 3: GỌI PHƯƠNG THỨC ĐANG ĐƯỢC TEST (WHEN - Khi tôi thực hiện...)
    // ------------------------------------------------------------------
    // Bây giờ, chúng ta thực sự gọi phương thức getAccountByEmail của AccountDAO.
    // AccountDAO accountDAO; đã được đánh dấu @Tested, nên JMockit đã tạo instance cho nó.
    // Khi phương thức này chạy, nó sẽ tương tác với các mock object (mockConnection,
    // mockPreparedStatement, mockResultSet) theo cách chúng ta đã định nghĩa
    // trong khối Expectations ở trên. 
    Account actualAccount = accountDAO.getAccountByEmail(emailToFind);

    // PHẦN 4: KIỂM TRA KẾT QUẢ (ASSERTIONS - Thì kết quả phải là...)   
    assertNotNull(actualAccount);
    
    // So sánh các trường của actualAccount với expectedAccount
    assertEquals(expectedAccount.getAccountID(), actualAccount.getAccountID());
    assertEquals(expectedAccount.getEmail(), actualAccount.getEmail());
    assertEquals(expectedAccount.getRole(), actualAccount.getRole()); 
    // PHẦN 5: XÁC MINH LỜI GỌI (VERIFICATIONS - Và tôi xác minh rằng...)
    // ------------------------------------------------------------------
    // Khối này để đảm bảo rằng một số hành động quan trọng đã thực sự xảy ra
    // trên các mock object, đặc biệt là việc đóng các tài nguyên.
    new Verifications() {{        
        mockPreparedStatement.close(); times = 1;       
        mockConnection.close(); times = 1;      
         mockResultSet.close(); times = 1;
    }};
}
}
