package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.MainInterface;

public class QuestionBoardDeleteCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		HttpSession session = request.getSession();
		String contentsShow = "";
		if(session.getAttribute("sMid") != null) {
			int level = (int)session.getAttribute("sLevel");
			if(level==0) contentsShow = "adminOK";			
		}
		
		QuestionBoardDAO dao = new QuestionBoardDAO();
		int res = dao.setQuestionBoardDelete(idx,contentsShow);
		
		if(res != 0) {
			request.setAttribute("message", "게시글이 삭제되었습니다.");
			request.setAttribute("url", "QuestionBoard.do");				
		}
		else {
			request.setAttribute("message", "게시글 삭제 실패");
			request.setAttribute("url", "QuestionBoard.do?idx="+idx);			
		}
	}

}
