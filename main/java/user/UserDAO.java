package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet; // 단축키 : ctrl + shift + 'o'

public class UserDAO {
	private Connection conn; //db 접근 객체 
	private PreparedStatement pstmt;
	private ResultSet rs; // db 결과를 담는 객체
	
	public UserDAO() { // dao 생성자에서 db connection 
		try {
			String dbURL = "jdbc:mysql://localhost:3306/users"; //mySQL 서버의 BBS DB 접근 경로
			String dbID = "aegi04"; //계정
			String dbPassword = "p@ssw0rd"; //비밀번호
			Class.forName("com.mysql.cj.jdbc.Driver"); //mysql에 접속을 도와주는 라이브러리 
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}


	// 로그인 기능 
	public int login(String email, String password) {
		String SQL = "SELECT password FROM userInfo WHERE email = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email); //sql Injection 공격 방어 수단 : 1번째 물음표에 userID 입력
			rs = pstmt.executeQuery(); // 쿼리 실행 
			if (rs.next()) {
				if (rs.getString(1).equals(password)) // rs.getString(1) : select된 첫번째 컬럼
					return 1; //로그인 성공
				else
					return 0; // 비밀번호 틀림
			}
			return -1; // 아이디 없음 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //DB 오류 
	}


	// 세션으로 부터 사용자 이름 가져오기
	public String ssName(String email) {
		String SQL = "SELECT username FROM userInfo WHERE email = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email); //sql Injection 공격 방어 수단 : 1번째 물음표에 email 입력
			rs = pstmt.executeQuery(); // 쿼리 실행
			if (rs.next()) {
				return rs.getString(1);
			}
			else return email;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	// 사용자 이름으로 메일 가져오기
	public String ssEmail(String name) {
		String SQL = "SELECT email FROM userInfo WHERE username = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, name); //sql Injection 공격 방어 수단 : 1번째 물음표에 name 입력
			rs = pstmt.executeQuery(); // 쿼리 실행
			if (rs.next()) {
				return rs.getString(1);
			}
			else return name;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	

	// 회원가입 기능
	public int join(User user) {
		String SQL = "INSERT INTO userInfo VALUES(?,?,?, NOW())";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUsername());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}
}
