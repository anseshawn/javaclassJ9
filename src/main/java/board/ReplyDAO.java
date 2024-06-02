package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.eclipse.jdt.internal.compiler.ast.TrueLiteral;

import common.GetConn;

public class ReplyDAO {

	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	private ReplyVO vo = null;
	
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

	public ArrayList<ReplyVO> getBoardReply(String board, int boardIdx) {
		ArrayList<ReplyVO> vos = new ArrayList<ReplyVO>();
		try {
			sql = "select *, datediff(rDate, now()) as date_diff,"
					+ " timestampdiff(hour, rDate, now()) as hour_diff"
					+ " from (select * from reply where board='"+board+"' and boardIdx=?) as r"
					+ " left join reReply p on r.idx=p.replyIdx order by r.idx, p.replyIdx";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new ReplyVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setBoard(rs.getString("board"));
				vo.setBoardIdx(rs.getInt("boardIdx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setrDate(rs.getString("rDate"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				vo.setReport(rs.getInt("report"));
				
				vo.setDate_diff(rs.getInt("date_diff"));
				vo.setHour_diff(rs.getInt("hour_diff"));
				
				vo.setReIdx(rs.getInt("reIdx"));
				vo.setReplyIdx(rs.getInt("replyIdx"));
				vo.setReMid(rs.getString("reMid"));
				vo.setReNickName(rs.getString("reNickName"));
				vo.setReDate(rs.getString("reDate"));
				vo.setReHostIp(rs.getString("reHostIp"));
				vo.setReContent(rs.getString("reContent"));
				vo.setReReport(rs.getInt("reReport"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 댓글 작성하기
	public int setBoardReply(ReplyVO vo) {
		int res = 0;
		try {
			sql = "insert into reply values(default,?,?,?,?,default,?,?,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getBoard());
			pstmt.setInt(2, vo.getBoardIdx());
			pstmt.setString(3, vo.getMid());
			pstmt.setString(4, vo.getNickName());
			pstmt.setString(5, vo.getHostIp());
			pstmt.setString(6, vo.getContent());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 게시글에 딸린 댓글 모두 삭제
	public int setBoardDeleteAll(String board, int boardIdx) {
		int res = 0;
		try {
			sql = "delete from reply where board='"+board+"' and boardIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 댓글 하나만 삭제
	public int setReplyDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from reply where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	public int setReplyEdit(int idx, String content) {
		int res = 0;
		try {
			sql = "update reply set content=? where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 대댓글 작성
	public int setBoardReReply(ReplyVO vo) {
		int res = 0;
		try {
			sql = "insert into reReply values(default,?,?,?,default,?,?,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getReplyIdx());
			pstmt.setString(2, vo.getReMid());
			pstmt.setString(3, vo.getReNickName());
			pstmt.setString(4, vo.getReHostIp());
			pstmt.setString(5, vo.getReContent());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 대댓글 수정
	public int setReReplyEdit(int reIdx, String reContent) {
		int res = 0;
		try {
			sql = "update reReply set reContent=? where reIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reContent);
			pstmt.setInt(2, reIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 대댓글 삭제
	public int setReReplyDelete(int reIdx) {
		int res = 0;
		try {
			sql = "delete from reReply where reIdx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reIdx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

}
