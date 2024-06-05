package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.GetConn;

public class MemberDAO {

	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {}
			finally {
				pstmtClose();
			}
		}
	}

	// 로그인시 아이디 체크(회원가입시 아이디 중복검사)
	public MemberVO getMemberIdCheck(String mid) {
		MemberVO vo = new MemberVO();
		try {
			sql = "select * from member where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setEmail(rs.getString("email"));
				vo.setEmailNews(rs.getString("emailNews"));
				vo.setPhone(rs.getString("phone"));
				vo.setAddress(rs.getString("address"));
				vo.setmGroup(rs.getString("mGroup"));
				vo.setcName(rs.getString("cName"));
				vo.setcCategory(rs.getString("cCategory"));
				vo.setcAddress(rs.getString("cAddress"));
				vo.setcTel(rs.getString("cTel"));
				vo.setPurpose(rs.getString("purpose"));
				vo.setLevel(rs.getInt("level"));
				vo.setPoint(rs.getInt("point"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
			}
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		}
		finally {
			rsClose();
		}
		return vo;
	}

	// 닉네임 체크
	public MemberVO getMemberNickCheck(String nickName) {
		MemberVO vo = new MemberVO();
		try {
			sql = "select * from member where nickName=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setEmail(rs.getString("email"));
				vo.setEmailNews(rs.getString("emailNews"));
				vo.setPhone(rs.getString("phone"));
				vo.setAddress(rs.getString("address"));
				vo.setmGroup(rs.getString("mGroup"));
				vo.setcName(rs.getString("cName"));
				vo.setcCategory(rs.getString("cCategory"));
				vo.setcAddress(rs.getString("cAddress"));
				vo.setcTel(rs.getString("cTel"));
				vo.setPurpose(rs.getString("purpose"));
				vo.setLevel(rs.getInt("level"));
				vo.setPoint(rs.getInt("point"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
			}
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		}
		finally {
			rsClose();
		}
		return vo;
	}

	// 회원 로그인 시 처리
	public void setLoginUpdate(MemberVO vo) {
		try {
			sql="update member set lastDate=now() where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 회원 가입 처리
	public int setMemberJoinOk(MemberVO vo) {
		int res = 0;
		try {
			sql = "insert into member values(default,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,default,default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getMid());
			pstmt.setString(3, vo.getPwd());
			pstmt.setString(4, vo.getNickName());
			pstmt.setString(5, vo.getBirthday());
			pstmt.setString(6, vo.getEmail());
			pstmt.setString(7, vo.getEmailNews());
			pstmt.setString(8, vo.getPhone());
			pstmt.setString(9, vo.getAddress());
			pstmt.setString(10, vo.getmGroup());
			pstmt.setString(11, vo.getcName());
			pstmt.setString(12, vo.getcCategory());
			pstmt.setString(13, vo.getcAddress());
			pstmt.setString(14, vo.getcTel());
			pstmt.setString(15, vo.getPurpose());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 비밀번호 변경
	public int setMemberPwdChange(String mid, String pwd) {
		int res = 0;
		try {
			//conn.setAutoCommit(false);
			sql = "update member set pwd=? where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, mid);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
			/*
			try {
			
				if(conn != null) conn.rollback();
			} catch (Exception e2) {}
			*/
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 회원정보 수정
	public int setMemberUpdateOk(MemberVO vo) {
		int res = 0;
		try {
			sql = "update member set name=?,nickName=?,birthday=?,email=?,emailNews=?,"
					+ "phone=?,address=?,mGroup=?,cName=?,cCategory=?,cAddress=?,cTel=?,purpose=? where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getBirthday());
			pstmt.setString(4, vo.getEmail());
			pstmt.setString(5, vo.getEmailNews());
			pstmt.setString(6, vo.getPhone());
			pstmt.setString(7, vo.getAddress());
			pstmt.setString(8, vo.getmGroup());
			pstmt.setString(9, vo.getcName());
			pstmt.setString(10, vo.getcCategory());
			pstmt.setString(11, vo.getcAddress());
			pstmt.setString(12, vo.getcTel());
			pstmt.setString(13, vo.getPurpose());
			pstmt.setString(14, vo.getMid());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 이름으로 멤버 검색
	public MemberVO getMemberNameCheck(String name) {
		MemberVO vo = new MemberVO();
		try {
			sql = "select * from member where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setNickName(rs.getString("nickName"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setEmail(rs.getString("email"));
				vo.setEmailNews(rs.getString("emailNews"));
				vo.setPhone(rs.getString("phone"));
				vo.setAddress(rs.getString("address"));
				vo.setmGroup(rs.getString("mGroup"));
				vo.setcName(rs.getString("cName"));
				vo.setcCategory(rs.getString("cCategory"));
				vo.setcAddress(rs.getString("cAddress"));
				vo.setcTel(rs.getString("cTel"));
				vo.setPurpose(rs.getString("purpose"));
				vo.setLevel(rs.getInt("level"));
				vo.setPoint(rs.getInt("point"));
				vo.setUserDel(rs.getString("userDel"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setLastDate(rs.getString("lastDate"));
			}
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		}
		finally {
			rsClose();
		}
		return vo;
	}

	// 회원 탈퇴 요청
	public int setMemberDeleteOk(String mid) {
		int res = 0;
		try {
			sql="update member set userDel='OK',level=99 where mid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	
	
}
