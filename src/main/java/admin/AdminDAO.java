package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import board.ReportVO;
import common.GetConn;

public class AdminDAO {

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

	// 신고 내역 저장하기
	public int setReportInput(ReportVO vo) {
		int res = 0;
		try {
			conn.setAutoCommit(false);
			sql="insert into report values(default,?,?,?,?,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getBoard());
			pstmt.setInt(2, vo.getBoardIdx());
			pstmt.setString(3, vo.getRpMid());
			pstmt.setString(4, vo.getRpContent());
			pstmt.executeUpdate();
			pstmtClose();
			
			sql="update "+vo.getBoard()+" set report=report+1 where idx=?";
			pstmt =conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getBoardIdx());
			res = pstmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
			try {
				// 커넥션 객체가 진행중인 상태에서 예외처리를 만나면 롤백시킨다.
				if(conn != null) conn.rollback(); // 예외오류 발생시는 기존에 작업된 sql문이 모두 rollback처리된다.
			} catch (Exception e2) {}
		} finally {
			pstmtClose();
		}
		return res;
	}
	
	
}
