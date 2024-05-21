package board;

import java.sql.Date;

public class BoardDTO {
	private int bd_no;				// 게시글 번호
	private String bd_title;		// 게시글 제목
	private String username;		// 작성자
	private String bd_content;		// 내용
	private Date bd_date;			// 작성 날짜
	private int bd_available;		// 식별자
	private String file_name;		// 파일 이름
	private String file_realname;	// 중복 방지 이름
	private String file_route;		// 파일 경로
	
	
	public int getBd_no() {
		return bd_no;
	}
	public void setBd_no(int bd_no) {
		this.bd_no = bd_no;
	}

	public String getBd_title() {
		return bd_title;
	}
	public void setBd_title(String bd_title) {
		this.bd_title = bd_title;
	}

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}

	public String getBd_content() {
		return bd_content;
	}
	public void setBd_content(String bd_content) {
		this.bd_content = bd_content;
	}

	public Date getBd_date() {
		return bd_date;
	}
	public void setBd_date(Date bd_date) {
		this.bd_date = bd_date;
	}

	public int getBd_available() {
		return bd_available;
	}
	public void setBd_available(int bd_available) {
		this.bd_available = bd_available;
	}

	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getFile_realname() {
		return file_realname;
	}
	public void setFile_realname(String file_realname) {
		this.file_realname = file_realname;
	}

	public String getFile_route() {
		return file_route;
	}
	public void setFile_route(String file_route) {
		this.file_route = file_route;
	}
}
