package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.MainInterface;

public class RecruitBoardContentCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		String flag = request.getParameter("flag")==null ? "" : request.getParameter("flag");
		String search = request.getParameter("search")==null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString")==null ? "" : request.getParameter("searchString");
		
		RecruitBoardDAO dao = new RecruitBoardDAO();
		
		// 게시글 조회수 1씩 증가시키기
		HttpSession session = request.getSession();
		ArrayList<String> contentReadNum = (ArrayList<String>)session.getAttribute("sContentIdx");
		if(contentReadNum==null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "recruitBoard"+idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			dao.setRecruitBoardReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		// 좋아요(내가 한적 있는지)(중복 불허)
		ArrayList<String> contentGood = (ArrayList<String>)session.getAttribute("sContentGood");
		if(contentGood==null) contentGood = new ArrayList<String>();
		String imsiContentGood = "recruitBoardGood"+idx;
		String good = "0";
		if(!contentGood.contains(imsiContentGood)) {
			good = "1";
		}
		request.setAttribute("good", good);
		
		RecruitBoardVO vo = dao.getRecruitBoardContent(idx);
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		
		request.setAttribute("flag", flag);
		request.setAttribute("search", search);
		request.setAttribute("searchString", searchString);
		
		ReplyDAO rDao = new ReplyDAO();
		
		// 댓글 처리
		ArrayList<ReplyVO> replyVos = rDao.getBoardReply("recruitBoard",idx);
		request.setAttribute("replyVos", replyVos);
		
		ArrayList<RecruitBoardVO> rcVos = dao.getPartCount();
		request.setAttribute("rcVos", rcVos);
		
	}

}
