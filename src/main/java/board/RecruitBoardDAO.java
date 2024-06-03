package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mysql.fabric.xmlrpc.base.Array;

import common.GetConn;

public class RecruitBoardDAO {

	private Connection conn = GetConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	RecruitBoardVO vo = null;
	
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
					sql = "select count(*) as cnt from recruitBoard";
					pstmt = conn.prepareStatement(sql);
				}
				else {
					sql = "select count(*) as cnt from recruitBoard where report < 5";
					pstmt = conn.prepareStatement(sql);
				}				
			}
			else if(search.equals("part")){
				if(contentsShow.equals("adminOK")) {
					sql = "select count(*) as cnt from recruitBoard where "+search+" = '"+searchString+"'";
					pstmt = conn.prepareStatement(sql);
				}
				else {
					sql = "select count(*) as cnt from recruitBoard"
							+ " where report < 5 and "+search+" = '"+searchString+"'";
					pstmt = conn.prepareStatement(sql);
				}
			}
			else {
				if(contentsShow.equals("adminOK")) {
					sql = "select count(*) as cnt from recruitBoard where "+search+" like ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+searchString+"%");
				}
				else {
					sql = "select count(*) as cnt from recruitBoard"
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
	public List<RecruitBoardVO> getRecruitBoardList(int startIndexNo, int pageSize, String contentsShow, String search,	String searchString) {
		List<RecruitBoardVO> vos = new ArrayList<RecruitBoardVO>();
		try {
			if(search  == null || search.equals("")) {		// 검색어가 들어오지 않았을 때(전체 리스트)
				if(contentsShow.equals("adminOK")) {
					sql = "select *, datediff(wDate, now()) as date_diff,"
							+ " timestampdiff(hour, wDate, now()) as hour_diff,"
							+ " (select count(*) from reply where board='recruitBoard' and boardIdx = b.idx) as replyCnt"
							+ " from recruitBoard b order by idx desc limit ?,?";
				}
				else {
					sql = "select *, datediff(wDate, now()) as date_diff,"
							+ " timestampdiff(hour, wDate, now()) as hour_diff,"
							+ " (select count(*) from reply where board='recruitBoard' and boardIdx = b.idx) as replyCnt"
							+ " from recruitBoard b where report < 5 order by idx desc limit ?,?";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else if(search.equals("part")){		// 검색을 분류로 했을 때
				if(contentsShow.equals("adminOK")) {
					sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff,"
							+ " (select count(*) from reply where board='recruitBoard' and boardIdx = b.idx) as replyCnt"
							+ " from recruitBoard b where part='"+searchString+"' order by idx desc limit ?,?";
				}
				else {
					sql = "select *, datediff(wDate, now()) as date_diff,"
							+ " timestampdiff(hour, wDate, now()) as hour_diff,"
							+ " (select count(*) from reply where board='recruitBoard' and boardIdx = b.idx) as replyCnt"
							+ " from recruitBoard b where report < 5 and part='"+searchString+"' order by idx desc limit ?,?";
				}
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startIndexNo);
				pstmt.setInt(2, pageSize);
			}
			else {		// 검색어가 들어왔을 때
				if(contentsShow.equals("adminOK")) {
					sql = "select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff,"
							+ " (select count(*) from reply where board='recruitBoard' and boardIdx = b.idx) as replyCnt"
							+ " from recruitBoard b where "+search+" like ? order by idx desc limit ?,?";
				}
				else {
					sql = "select *, datediff(wDate, now()) as date_diff,"
							+ " timestampdiff(hour, wDate, now()) as hour_diff,"
							+ " (select count(*) from reply where board='recruitBoard' and boardIdx = b.idx) as replyCnt"
							+ " from recruitBoard b where report < 5 and "+search+" like ? order by idx desc limit ?,?";
				}			
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+searchString+"%");
				pstmt.setInt(2, startIndexNo);
				pstmt.setInt(3, pageSize);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new RecruitBoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setwDate(rs.getString("wDate"));
				vo.setPart(rs.getString("part"));
				vo.setLocation(rs.getString("location"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setEndDate(rs.getString("endDate"));
				vo.setEtcContent(rs.getString("etcContent"));
				vo.setRcfName(rs.getString("rcfName"));
				vo.setRcfSName(rs.getString("rcfSName"));
				vo.setGood(rs.getInt("good"));
				vo.setReport(rs.getInt("report"));
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setDate_diff(rs.getInt("date_diff"));
				vo.setReplyCnt(rs.getInt("replyCnt"));
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 채용공고: 게시글 등록하기
	public int setRecruitBoardInput(RecruitBoardVO vo) {
		int res = 0;
		try {
			sql = "insert into recruitBoard values(default,?,?,?,?,?,default,default,?,?,default,?,?,?,?,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getHostIp());
			pstmt.setString(6, vo.getPart());
			pstmt.setString(7, vo.getLocation());
			pstmt.setString(8, vo.getEndDate());
			pstmt.setString(9, vo.getEtcContent());
			pstmt.setString(10, vo.getRcfName());
			pstmt.setString(11, vo.getRcfSName());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL오류: "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 게시글 조회수 증가시키기
	public void setRecruitBoardReadNumPlus(int idx) {
		try {
			sql="update recruitBoard set readNum = readNum+1 where idx=?";
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
	public RecruitBoardVO getRecruitBoardContent(int idx) {
		vo = new RecruitBoardVO();
		try {
			sql="select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff,"
					+ " (select count(*) from reply where board='recruitBoard' and boardIdx = b.idx) as replyCnt"
					+ " from recruitBoard b where idx=?";
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
				vo.setPart(rs.getString("part"));
				vo.setLocation(rs.getString("location"));
				vo.setStartDate(rs.getString("startDate"));
				vo.setEndDate(rs.getString("endDate"));
				vo.setEtcContent(rs.getString("etcContent"));
				vo.setRcfName(rs.getString("rcfName"));
				vo.setRcfSName(rs.getString("rcfSName"));
				vo.setGood(rs.getInt("good"));
				vo.setReport(rs.getInt("report"));
				
				vo.setHour_diff(rs.getInt("hour_diff"));
				vo.setDate_diff(rs.getInt("date_diff"));
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
	public int setRecruitBoardEdit(RecruitBoardVO vo) {
		int res = 0;
		try {
			sql="update recruitBoard set mid=?,nickName=?, title=?,content=?,hostIp=?,"
					+ " wDate=now(),part=?,location=?,endDate=?,etcContent=?,rcfName=?,rcfSName=? where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getNickName());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getHostIp());
			pstmt.setString(6, vo.getPart());
			pstmt.setString(7, vo.getLocation());
			pstmt.setString(8, vo.getEndDate());
			pstmt.setString(9, vo.getEtcContent());
			pstmt.setString(10, vo.getRcfName());
			pstmt.setString(11, vo.getRcfSName());
			pstmt.setInt(12, vo.getIdx());
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 게시글 삭제(댓글 함께삭제)
	public int setRecruitBoardDelete(int idx, String contentsShow) {
		int res = 0;
		try {
			sql="select count(*) as cnt from reply where board='recruitBoard' and boardIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			int cnt = rs.getInt("cnt");
			if(cnt==0 || contentsShow.equals("adminOK")) {
				pstmtClose();
				sql="delete from recruitBoard where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, idx);
				res = pstmt.executeUpdate();				
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 인기 게시글 리스트 가져오기
	public ArrayList<RecruitBoardVO> getBestRecruitBoard() {
		ArrayList<RecruitBoardVO> vos = new ArrayList<RecruitBoardVO>();
		try {
			sql="select *, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff,"
					+ " (select count(*) from reply where board='recruitBoard' and boardIdx = b.idx) as replyCnt"
					+ " from recruitBoard b where report < 5 order by good desc limit 3";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new RecruitBoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setwDate(rs.getString("wDate"));
				vo.setPart(rs.getString("part"));
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
	public void setRecruitBoardGoodCheck(int idx) {
		try {
			sql = "update recruitBoard set good = good+1 where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : "+e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 최근 댓글 포스트
	public ArrayList<RecruitBoardVO> getRecentRecruitBoard() {
		ArrayList<RecruitBoardVO> vos = new ArrayList<RecruitBoardVO>();
		try {
			sql="select b.*, datediff(wDate, now()) as date_diff, timestampdiff(hour, wDate, now()) as hour_diff,"
					+ " (select count(*) from reply where board='recruitBoard' and boardIdx = b.idx) as replyCnt,"
					+ " r.rDate from recruitBoard b, reply r where b.idx=r.boardIdx and b.report < 5"
					+ " group by b.idx order by r.rDate desc limit 5";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new RecruitBoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setwDate(rs.getString("wDate"));
				vo.setPart(rs.getString("part"));
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
	
	
}
