package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
    private Connection conn;
    private ResultSet rs;

    public BoardDAO() {
        // db 연결
        try {
            String dbURL = "jdbc:mysql://localhost:3306/users";
			String dbID = "aegi04";
			String dbPassword = "p@ssw0rd";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch(Exception e) {
			e.printStackTrace();
		}
    }

        // 게시글 정렬
        public int getNext() {
            String SQL = "SELECT bd_no FROM board ORDER BY bd_no DESC";
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) + 1;
                }
                return 1;
            }catch(Exception e) {
			e.printStackTrace();
		    }
			return -1;
        }

        //게시글 작성
        public int write(String bd_title, String username, String bd_content, String file_name, String file_realname, String file_route) {
            String SQL = "INSERT INTO board VALUES (?, ?, ?, ?, NOW(), ?, ?, ?, ?)";
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setInt(1, getNext());
                pstmt.setString(2, bd_title);
                pstmt.setString(3, username);
                pstmt.setString(4, bd_content);
                pstmt.setInt(5, 1);
                pstmt.setString(6, file_name);
                pstmt.setString(7, file_realname);
                pstmt.setString(8, file_route);
                return pstmt.executeUpdate();
            }catch(Exception e) {
                e.printStackTrace();
            }
            return -1;  //db오류
        }

        // 게시글 목록 불러오기
        public ArrayList<BoardDTO> getList(int pageNumbdr) {
            String SQL = "SELECT * FROM board WHERE bd_no < ? AND bd_available = 1 ORDER BY bd_no DESC LIMIT 10";
            ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setInt(1, getNext()-(pageNumbdr - 1) * 10);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    BoardDTO boardDTO = new BoardDTO();
                    boardDTO.setBd_no(rs.getInt(1));
                    boardDTO.setBd_title(rs.getString(2));
                    boardDTO.setUsername(rs.getString(3));
                    boardDTO.setBd_content(rs.getString(4));
                    boardDTO.setBd_date(rs.getDate(5));
                    boardDTO.setBd_available(rs.getInt(6));
                    list.add(boardDTO);
                }
            }catch(Exception e) {
                e.printStackTrace();
            }
            return list;
        }

        // 게시글 조회 권한 검사
        public boolean nextPage(int pageNumbdr) {
            String SQL = "SELECT * FROM board WHERE bd_no < ? AND bd_available = 1";
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setInt(1, getNext()-(pageNumbdr - 1) * 10);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    return true;
                }
            }catch(Exception e) {
                e.printStackTrace();
            }
            return false;
        }

        // 게시글 조회 시
        public BoardDTO getBoardDTO(int bd_no) {
            String SQL = "SELECT * FROM board WHERE bd_no = ?";
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setInt(1, bd_no);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    BoardDTO boardDTO = new BoardDTO();
                    boardDTO.setBd_no(rs.getInt(1));
                    boardDTO.setBd_title(rs.getString(2));
                    boardDTO.setUsername(rs.getString(3));
                    boardDTO.setBd_content(rs.getString(4));
                    boardDTO.setBd_date(rs.getDate(5));
                    boardDTO.setBd_available(rs.getInt(6));
                    boardDTO.setFile_name(rs.getString(7));
                    boardDTO.setFile_realname(rs.getString(8));
                    boardDTO.setFile_route(rs.getString(9));
                    return boardDTO;
                }
            }catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        // 게시글 수정
        public int update(int bd_no, String bd_title, String bd_content, String file_name, String file_realname, String file_route) {
            String SQL = "UPDATE board SET bd_title = ?, bd_Content = ?, file_name = ?, file_realname = ?, file_route =? WHERE bd_no = ?";
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, bd_title);
                pstmt.setString(2, bd_content);
                pstmt.setString(3, file_name);
                pstmt.setString(4, file_realname);
                pstmt.setString(5, file_route);
                pstmt.setInt(6, bd_no);
                return pstmt.executeUpdate();
            }catch(Exception e) {
                e.printStackTrace();
            }
            return -1;  //db 오류
        }

        // 게시글 삭제
        public int delete(int bd_no) {
            String SQL = "UPDATE board SET bd_available = 0 WHERE bd_no = ?";
            try {
                PreparedStatement pstmt = conn.prepareStatement(SQL);
                pstmt.setInt(1, bd_no);
                return pstmt.executeUpdate();
            }catch(Exception e) {
                e.printStackTrace();
            }
            return -1;  //db 오류
        }
    }
