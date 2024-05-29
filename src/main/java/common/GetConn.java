package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GetConn {
	private static Connection conn = null;
	
	private String driver = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/javaclass9";
	private String user = "root";
	private String password = "1234";
	
	private static GetConn instance = new GetConn(); // 만들기...
	
	private GetConn() {
		// 하고싶은 내용 적기...
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패"+e.getMessage());
		} catch (SQLException e) {
			System.out.println("DB 연결 실패"+e.getMessage());
		}
	}
	
	public static GetConn getInstance() { // 밖에서 가져다 쓸 수 있도록 메소드 만들기...(타입은 클래스이름으로)
		return instance;
	}
	
	public static Connection getConn() {
		return conn; // conn을 사용하도록 메소드 따로 만들기
	}
	
}
