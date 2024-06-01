package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;

public class QuestionBoardInputOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String title = request.getParameter("title")==null ? "" : request.getParameter("title");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		String part = request.getParameter("part")==null ? "" : request.getParameter("part");
		
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		
		QuestionBoardVO vo = new QuestionBoardVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		vo.setPart(part);
		
		QuestionBoardDAO dao = new QuestionBoardDAO();
		
		int res = dao.setQuestionBoardInput(vo);
		if(res != 0) {
			request.setAttribute("message", "질문이 등록되었습니다.");
			request.setAttribute("url", "QuestionBoard.do");
		}
		else {
			request.setAttribute("message", "질문 등록 실패.");
			request.setAttribute("url", "QuestionBoardInput.do");
		}
	}

}
