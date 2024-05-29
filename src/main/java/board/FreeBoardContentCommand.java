package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.MainInterface;

public class FreeBoardContentCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		String flag = request.getParameter("flag")==null ? "" : request.getParameter("flag");
		String search = request.getParameter("search")==null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString")==null ? "" : request.getParameter("searchString");
		
		FreeBoardDAO dao = new FreeBoardDAO();
		
		// 게시글 조회수 1씩 증가시키기
		HttpSession session = request.getSession();
		ArrayList<String> contentReadNum = (ArrayList<String>)session.getAttribute("sContentIdx");
		if(contentReadNum==null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "freeBoard"+idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			dao.setFreeBoardReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		// 좋아요 중복불허
		
		FreeBoardVO vo = dao.getFreeBoardContent(idx);
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		
		request.setAttribute("flag", flag);
		request.setAttribute("search", search);
		request.setAttribute("searchString", searchString);
		
		ReplyDAO rDao = new ReplyDAO();
		
		// 댓글 처리
		ArrayList<ReplyVO> replyVos = rDao.getBoardReply("freeBoard",idx);
		request.setAttribute("replyVos", replyVos);
		
		// 사이드 인기글 리스트 가져오기
		ArrayList<FreeBoardVO> gVos = dao.getBestFreeBoard();
		request.setAttribute("gVos", gVos);
	}

}
