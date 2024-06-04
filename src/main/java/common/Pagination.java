package common;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import board.FreeBoardDAO;
import board.FreeBoardVO;
import board.QuestionBoardDAO;
import board.QuestionBoardVO;
import board.RecruitBoardDAO;
import board.RecruitBoardVO;
import board.ReplyDAO;
import board.ReplyVO;

public class Pagination {

	// 항상 사용하는 메소드: static
	public static void pageChange(HttpServletRequest request, int pag, int pageSize, String contentsShow, String board, String searchKey) {
		FreeBoardDAO fBoardDao = new FreeBoardDAO();
		QuestionBoardDAO qBoardDao = new QuestionBoardDAO();
		RecruitBoardDAO rcBoardDao = new RecruitBoardDAO();
		
		// part - 검색: search/searchString의 값이 넘어올 경우(검색 분류 / 검색어)
		String search = "", searchString = "";
		if(searchKey != null && !searchKey.equals("")) {
			if(board.equals("freeBoard")|| board.equals("questionBoard") || board.equals("recruitBoard")) {
				search = searchKey.split("/")[0];
				searchString = searchKey.split("/")[1];
			}
		}

		int totRecCnt = 0;
		
		if(board.equals("freeBoard")) {
			if(searchKey==null || searchKey.equals("")) {
				totRecCnt = fBoardDao.getTotRecCnt(contentsShow,"",""); // 게시판의 전체 레코드수 구하기(contentsShow - 관리자:adminOK)
			}
			else {
				totRecCnt = fBoardDao.getTotRecCnt(contentsShow,search,searchString); // 게시판의 전체 레코드수 구하기(contentsShow - 관리자:adminOK/일반유저:아이디 구별)				
			}
		}
		else if(board.equals("questionBoard")) {
			if(searchKey==null || searchKey.equals("")) {
				totRecCnt = qBoardDao.getTotRecCnt(contentsShow,"","");
			}
			else {
				totRecCnt = qBoardDao.getTotRecCnt(contentsShow,search,searchString);				
			}
		}
		else if(board.equals("recruitBoard")) {
			if(searchKey==null || searchKey.equals("")) {
				totRecCnt = rcBoardDao.getTotRecCnt(contentsShow,"",""); 
			}
			else {
				totRecCnt = rcBoardDao.getTotRecCnt(contentsShow,search,searchString);
			}
		}
		
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize)+1;
		if(pag > totPage) pag = 1;
		int startIndexNo = (pag-1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		List<FreeBoardVO> fBoardVos = null;
		List<QuestionBoardVO> qBoardVos = null;
		List<RecruitBoardVO> rcBoardVos = null;
		
		ReplyDAO rDao = new ReplyDAO();
		ArrayList<ReplyVO> replyVos = null;
		int idx = 0;
		if(board.equals("freeBoard")) {
			if(searchKey==null || searchKey.equals("")) {
				fBoardVos = fBoardDao.getFreeBoardList(startIndexNo, pageSize, contentsShow, "", ""); // 게시판의 전체 자료 가져오기				
			}
			else {
				fBoardVos = fBoardDao.getFreeBoardList(startIndexNo, pageSize, contentsShow, search, searchString);
			}
			for(int i=0; i<fBoardVos.size(); i++) {
				idx = fBoardVos.get(i).getIdx();
				replyVos = rDao.getBoardReply(board, idx);
			}
			request.setAttribute("vos", fBoardVos);
			request.setAttribute("replyVos", replyVos);
		}
		else if(board.equals("questionBoard")) {
			if(searchKey==null || searchKey.equals("")) {
				qBoardVos = qBoardDao.getQuestionBoardList(startIndexNo, pageSize, contentsShow, "", ""); // 게시판의 전체 자료 가져오기				
			}
			else {
				qBoardVos = qBoardDao.getQuestionBoardList(startIndexNo, pageSize, contentsShow, search, searchString);
			}
			request.setAttribute("vos", qBoardVos);
		}
		else if(board.equals("recruitBoard")) {
			if(searchKey==null || searchKey.equals("")) {
				rcBoardVos = rcBoardDao.getRecruitBoardList(startIndexNo, pageSize, contentsShow, "", ""); // 게시판의 전체 자료 가져오기				
			}
			else {
				rcBoardVos = rcBoardDao.getRecruitBoardList(startIndexNo, pageSize, contentsShow, search, searchString);
			}
			request.setAttribute("vos", rcBoardVos);
		}
		
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("totRecCnt", totRecCnt);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
		
		String searchTitle = "";
		if(search.equals("title")) searchTitle = "제목";
		else if(search.equals("nickName")) searchTitle = "작성자";
		else if(search.equals("content")) searchTitle = "내용";
		else if(search.equals("part")) searchTitle = "분류";
		
		/*
		if(board.equals("freeBoard") && searchKey != null && !searchKey.equals("")) {
			request.setAttribute("searchTitle", searchTitle);
			request.setAttribute("search", search);
			request.setAttribute("searchString", searchString);			
			request.setAttribute("searchCount", totRecCnt);
		}
		else if(board.equals("questionBoard")) {
			request.setAttribute("searchTitle", searchTitle);
			request.setAttribute("search", search);
			request.setAttribute("searchString", searchString);			
			request.setAttribute("searchCount", totRecCnt);
		}
		else if(board.equals("recruitBoard")) {
			request.setAttribute("searchTitle", searchTitle);
			request.setAttribute("search", search);
			request.setAttribute("searchString", searchString);			
			request.setAttribute("searchCount", totRecCnt);
		}
	*/
		if(searchKey != null && !searchKey.equals("")) {
			request.setAttribute("searchTitle", searchTitle);
			request.setAttribute("search", search);
			request.setAttribute("searchString", searchString);			
			request.setAttribute("searchCount", totRecCnt);
		}
	}

}
