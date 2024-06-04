 package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.MainInterface;
import common.Pagination;

public class FreeBoardListCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 관리자는 모든글 보여주고, 관리자외에는 신고가 누적된 글은 보여주지 않게 한다. 단, 자신이 작성한글은 볼수 있게한다.
		HttpSession session = request.getSession();
		String contentsShow = "";
		if(session.getAttribute("sMid") != null) {
			int level = (int)session.getAttribute("sLevel");
			if(level==0) contentsShow = "adminOK";			
		}
		
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		
		Pagination.pageChange(request, pag, pageSize, contentsShow, "freeBoard", "");
		
		// 인기 게시글
		FreeBoardDAO dao = new FreeBoardDAO();
		ArrayList<FreeBoardVO> gVos = dao.getBestFreeBoard();
		request.setAttribute("gVos", gVos);
		
	}

}
