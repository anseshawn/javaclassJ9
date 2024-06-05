package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.fabric.xmlrpc.base.Array;

import common.GetConn;

public class FreeBoardDAO {

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

	//  게시물 총 레코드 건수(페이지 처리 / 신고글 제외한 번호 정렬)
	public int getTotRecCnt(String contentsShow, String search, String searchString) {
		int totRecCnt=0;
		try {
			if(search==null || search.equals("")) {
				if(contentsShow.equals("adminOK")) {
					sql = "select count(*) as cnt from freeBoard";
					pstmt = conn.prepareStatement(sql);
				}
				else {
					sql = "select count(*) as cnt from freeBoard where report < 5";
					pstmt = conn.prepareStatement(sql);
				}				
			}
			else {
				if(contentsShow.equals("adminOK")) {
					sql = "select count(*) as cnt from freeBoard where "+search+" like ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+searchString+"%");
				}
				else {
					sql = "select count(*) as cnt from freeBoard"
							+ " where report < 5 and "+search+" like ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+searchString+"%");
				}
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}

	// 게시판 전체 리스트 (검색어의 경우 포함)
	public List<FreeBoardVO> getFreeBoardList(int startIndexNo, int pageSize, String contentsShow, String search,	String searchString) {
		List<FreeBoardVO> vos = new ArrayList<FreeBoardVO>();
		try {
			if(search  == null || search.equals("")) {		// 검색어가 들어오지 않았을 때(전체 리스트)
				if(contentsShow.equals("adminOK")) {
					sql = "select *, datediff(wDate, now()) as date_diff,"
							+ " timestampdiff(hour, wDate, now()) as hour_diff,"
							+ " (select count(*) from reply where board='freeBoard' and boardIdx = b.idx) as replyCnt"
							+ " from freeBoard b order by idx desc limit ?,?";
				}
				else {
					sql = "select *, datediff(wDate, now()) as date_diff,"
							+ " timestampdiff(hour, wDate, now()) as hour_diff,"
							+ " (select count(*) from reply where board='freeBoard' and boardIdx = b.idx) as replyCnt"
							+ " from freeBoard b where report < 5 order by idx desc limit ?,?";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else {		// 검색어가 들어왔을 때
				if(contentsShow.equals("adminOK")) {
					sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff,"
							+ " (select count(*) from boardReply where board='freeBoard' and  boardIdx = b.idx) as replyCnt"
							+ " from freeBoard b where "+search+" like ? order by idx desc limit ?,?";
				}
				else {
					sql = "select *, datediff(wDate, now()) as date_diff,"
							+ " timestampdiff(hour, wDate, now()) as hour_diff,"
							+ " (select count(*) from reply where board='freeBoard' and boardIdx = b.idx) as replyCnt"
							+ " from freeBoard b where report < 5 and "+search+" like ? order by idx desc limit ?,?";
				}			
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+searchString+"%");
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			ReplyDAO rDao = new ReplyDAO();
			ArrayList<ReplyVO> rVos = new ArrayList<ReplyVO>();
			while(rs.next()) {
				int imsiCnt = 0;
				FreeBoardVO vo = new FreeBoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vo.setReport(rs.getInt("report"));
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setDate_diff(rs.getInt("date_diff"));
				vo.setReplyCnt(rs.getInt("replyCnt"));
						
				rVos = rDao.getBoardReply("freeBoard", rs.getInt("idx"));
				for(int i=0; i<rVos.size(); i++) {
					imsiCnt = rVos.get(i).getReCnt();
					//System.out.println(i+". imsiCnt: "+imsiCnt);
				}
				vo.setReCnt(imsiCnt);
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 자유게시판: 게시글 등록하기
	public int setFreeBoardInput(FreeBoardVO vo) {
		int res = 0;
		try {
			sql = "insert into freeBoard values(default,?,?,?,?,?,default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getHostIp());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 게시글 조회수 증가시키기
	public void setFreeBoardReadNumPlus(int idx) {
		try {
			sql="update freeBoard set readNum = readNum+1 where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 게시글 하나의 내용 불러오기
	public FreeBoardVO getFreeBoardContent(int idx) {
		FreeBoardVO vo = new FreeBoardVO();
		try {
			sql="select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff,"
					+ " (select count(*) from reply where board='freeBoard' and boardIdx = b.idx) as replyCnt"
					+ " from freeBoard b where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vo.setReport(rs.getInt("report"));
				
				vo.setDate_diff(rs.getInt("date_diff"));
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setReplyCnt(rs.getInt("replyCnt"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 게시글 수정하기
	public int setFreeBoardEdit(FreeBoardVO vo) {
		int res = 0;
		try {
			sql="update freeBoard set mid=?,nickName=?,title=?,content=?,hostIp=?,wDate=now() where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getHostIp());
			pstmt.setInt(6, vo.getIdx());
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 게시글 삭제(댓글이 있다면 댓글도 함께 삭제할것)
	public int setFreeBoardDelete(int idx) {
		int res = 0;
		try {
			sql="delete from freeBoard where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 인기 게시글 리스트 가져오기
	public ArrayList<FreeBoardVO> getBestFreeBoard() {
		ArrayList<FreeBoardVO> vos = new ArrayList<FreeBoardVO>();
		try {
			sql="select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff,"
					+ " (select count(*) from reply where board='freeBoard' and boardIdx = b.idx) as replyCnt"
					+ " from freeBoard b where report < 5 order by good desc limit 5";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FreeBoardVO vo = new FreeBoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vo.setReport(rs.getInt("report"));
				
				vo.setDate_diff(rs.getInt("date_diff"));
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setReplyCnt(rs.getInt("replyCnt"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 게시판 글 좋아요 수 증가
	public void setFreeBoardGoodCheck(int idx) {
		try {
			sql = "update freeBoard set good = good+1 where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 개인이 쓴 글 건수(마이페이지)
	public int getMyTotRecCnt(String contentsShow, String search, String searchString) {
		int totRecCnt=0;
		try {
			if(search==null || search.equals("")) {
				sql = "select count(*) as cnt from freeBoard where mid = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, contentsShow);
			}
			else {
					sql = "select count(*) as cnt from freeBoard where "+search+" like ? and mid=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+searchString+"%");
					pstmt.setString(2, contentsShow);
			}
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt("cnt");
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}
	
	// 개인이 쓴 글만
	// 게시판 전체 리스트 (검색어의 경우 포함)
	public List<FreeBoardVO> getMyFreeBoardList(int startIndexNo, int pageSize, String contentsShow, String search,	String searchString) {
		List<FreeBoardVO> vos = new ArrayList<FreeBoardVO>();
		try {
			if(search  == null || search.equals("")) {		// 검색어가 들어오지 않았을 때(전체 리스트)
				sql = "select *, datediff(wDate, now()) as date_diff,"
						+ " timestampdiff(hour, wDate, now()) as hour_diff,"
						+ " (select count(*) from reply where board='freeBoard' and boardIdx = b.idx) as replyCnt"
						+ " from freeBoard b where mid=? order by idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, contentsShow);
				//pstmt.setInt(2, startIndexNo);
				//pstmt.setInt(3, pageSize);
			}
			else {		// 검색어가 들어왔을 때
				sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff,"
						+ " (select count(*) from boardReply where board='freeBoard' and  boardIdx = b.idx) as replyCnt"
						+ " from freeBoard b where "+search+" like ? and mid=? order by idx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+searchString+"%");
				pstmt.setString(2, contentsShow);
				//pstmt.setInt(3, startIndexNo);
				//pstmt.setInt(4, pageSize);
			}
			rs = pstmt.executeQuery();
			
			ReplyDAO rDao = new ReplyDAO();
			ArrayList<ReplyVO> rVos = new ArrayList<ReplyVO>();
			while(rs.next()) {
				int imsiCnt = 0;
				FreeBoardVO vo = new FreeBoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setwDate(rs.getString("wDate"));
				vo.setGood(rs.getInt("good"));
				vo.setReport(rs.getInt("report"));
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setDate_diff(rs.getInt("date_diff"));
				vo.setReplyCnt(rs.getInt("replyCnt"));
						
				rVos = rDao.getBoardReply("freeBoard", rs.getInt("idx"));
				for(int i=0; i<rVos.size(); i++) {
					imsiCnt = rVos.get(i).getReCnt();
				}
				vo.setReCnt(imsiCnt);
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}
	
}
