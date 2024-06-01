package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.MainInterface;

public class QuestionBoardContentCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		String flag = request.getParameter("flag")==null ? "" : request.getParameter("flag");
		String search = request.getParameter("search")==null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString")==null ? "" : request.getParameter("searchString");
		
		QuestionBoardDAO dao = new QuestionBoardDAO();
		
		// 게시글 조회수 1씩 증가시키기
		HttpSession session = request.getSession();
		ArrayList<String> contentReadNum = (ArrayList<String>)session.getAttribute("sContentIdx");
		if(contentReadNum==null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "questionBoard"+idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			dao.setQuestionBoardReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		// 좋아요(내가 한적 있는지)(중복 불허)
		ArrayList<String> contentGood = (ArrayList<String>)session.getAttribute("sContentGood");
		if(contentGood==null) contentGood = new ArrayList<String>();
		String imsiContentGood = "questionBoardGood"+idx;
		String good = "0";
		if(!contentGood.contains(imsiContentGood)) {
			good = "1";
		}
		request.setAttribute("good", good);
		
		QuestionBoardVO vo = dao.getQuestionBoardContent(idx);
		request.setAttribute("vo", vo);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		
		request.setAttribute("flag", flag);
		request.setAttribute("search", search);
		request.setAttribute("searchString", searchString);
		
		ReplyDAO rDao = new ReplyDAO();
		
		// 댓글 처리
		ArrayList<ReplyVO> replyVos = rDao.getBoardReply("questionBoard",idx);
		request.setAttribute("replyVos", replyVos);
		
		QuestionBoardDAO qDao = new QuestionBoardDAO();
		ArrayList<QuestionBoardVO> qVos = qDao.getRecentQuestionBoard();
		request.setAttribute("qVos", qVos);
	}

}
