package board;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.MainInterface;
import common.Pagination;

public class RecruitBoardSearchCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String search = request.getParameter("search")==null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString")==null ? "" : request.getParameter("searchString");
		String partSelect = request.getParameter("partSelect")==null ? "" : request.getParameter("partSelect");
		
		if(search.equals("part")) {
			/*
			if(partSelect.equals("new")) partSelect="신입";
			else if(partSelect.equals("expert")) partSelect="경력";
			else if(partSelect.equals("both")) partSelect="경력무관";
			else if(partSelect.equals("intern")) partSelect="인턴";
			else if(partSelect.equals("etc")) partSelect="기타";
			*/
			search += "/"+partSelect;	
		}
		else search += "/"+searchString;
		
		HttpSession session = request.getSession();
		String contentsShow = "";
		if(session.getAttribute("sMid") != null) {
			int level = (int)session.getAttribute("sLevel");
			if(level==0) contentsShow = "adminOK";			
		}
		
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		Pagination.pageChange(request, pag, pageSize, contentsShow, "recruitBoard", search);
		
		LocalDate today = LocalDate.now();
		request.setAttribute("today", today);
		
		RecruitBoardDAO dao = new RecruitBoardDAO();
		ArrayList<RecruitBoardVO> rcVos = dao.getPartCount();
		request.setAttribute("rcVos", rcVos);
		
	}

}
