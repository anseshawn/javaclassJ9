package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.MainInterface;

public class BoardGoodCheckCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String board = request.getParameter("board")==null ? "" : request.getParameter("board");
		
		FreeBoardDAO fbDao = null;
		QuestionBoardDAO qbDao = null;
		String sw = "0";
		HttpSession session = request.getSession();
		ArrayList<String> contentGood = (ArrayList<String>)session.getAttribute("sContentGood");
		String imsicontentGood = "";
		if(board.equals("freeBoard")) {
			fbDao = new FreeBoardDAO();
			if(contentGood == null) contentGood = new ArrayList<String>();
			imsicontentGood = "freeBoardGood"+idx;
			if(!contentGood.contains(imsicontentGood)) {
				fbDao.setFreeBoardGoodCheck(idx);
				contentGood.add(imsicontentGood);
				sw = "1";
			}
		}
		else if(board.equals("questionBoard")) {
			qbDao = new QuestionBoardDAO();
			if(contentGood == null) contentGood = new ArrayList<String>();
			imsicontentGood = "questionBoardGood"+idx;
			if(!contentGood.contains(imsicontentGood)) {
				qbDao.setQuestionBoardGoodCheck(idx);
				contentGood.add(imsicontentGood);
				sw = "1";
			}
		}
		session.setAttribute("sContentGood", contentGood);
		response.getWriter().write(sw);
	}

}
