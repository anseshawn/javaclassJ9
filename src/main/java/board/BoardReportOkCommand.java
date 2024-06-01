package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.AdminDAO;
import common.MainInterface;

public class BoardReportOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String board = request.getParameter("board")==null ? "" : request.getParameter("board");
		int boardIdx = request.getParameter("boardIdx")==null ? 0 : Integer.parseInt(request.getParameter("boardIdx"));
		String rpMid = request.getParameter("rpMid")==null ? "" : request.getParameter("rpMid");
		String rpContent = request.getParameter("rpContent")==null ? "" : request.getParameter("rpContent");
		
		AdminDAO dao = new AdminDAO();
		ReportVO vo = new ReportVO();
		
		int res = 0;
		HttpSession session = request.getSession();
		ArrayList<String> contentReport = (ArrayList<String>)session.getAttribute("sContentReport");
		if(contentReport == null) contentReport = new ArrayList<String>();
		String imsiContentReport = board+"report"+ boardIdx;
		if(!contentReport.contains(imsiContentReport)) {
			vo.setBoard(board);
			vo.setBoardIdx(boardIdx);
			vo.setRpMid(rpMid);
			vo.setRpContent(rpContent);
			res = dao.setReportInput(vo);
			
			contentReport.add(imsiContentReport);
		}
		session.setAttribute("sContentReport", contentReport);
		
		response.getWriter().write(res+"");
	}

}
