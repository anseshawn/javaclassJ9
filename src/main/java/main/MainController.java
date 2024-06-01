package main;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.FreeBoardContentCommand;
import board.FreeBoardEditCommand;
import board.FreeBoardInputOkCommand;
import board.FreeBoardListCommand;
import board.FreeBoardSearchCommand;
import board.QuestionBoardCommand;
import board.QuestionBoardContentCommand;
import board.QuestionBoardInputCommand;
import board.QuestionBoardSearchCommand;
import common.MainInterface;
import member.MemberUpdateCommand;

@WebServlet("*.do")
public class MainController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MainInterface command = null;
		String viewPage = "";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"),com.lastIndexOf("."));
		
		// 인증 처리
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(com.equals("/Main")) {
			viewPage += "/main/main.jsp";
		}
		else if(com.equals("/MemberJoin")) {
			viewPage += "/member/memberJoin.jsp";
		}
		else if(com.equals("/MemberLogin")) {
			viewPage += "/member/memberLogin.jsp";
		}
		else if(com.equals("/FreeBoard")) {
			command = new FreeBoardListCommand();
			command.execute(request, response);
			viewPage += "/board/freeBoard.jsp";
		}
		else if(com.equals("/FreeBoardContent")) {
			command = new FreeBoardContentCommand();
			command.execute(request, response);
			viewPage += "/board/freeBoardContent.jsp";
		}
		else if(com.equals("/FreeBoardSearch")) {
			command = new FreeBoardSearchCommand();
			command.execute(request, response);
			viewPage += "/board/freeBoardSearch.jsp";
		}
		else if(com.equals("/QuestionBoard")) {
			command = new QuestionBoardCommand();
			command.execute(request, response);
			viewPage += "/board/questionBoard.jsp";
		}
		else if(com.equals("/QuestionBoardContent")) {
			command = new QuestionBoardContentCommand();
			command.execute(request, response);
			viewPage += "/board/questionBoardContent.jsp";
		}
		else if(com.equals("/QuestionBoardSearch")) {
			command = new QuestionBoardSearchCommand();
			command.execute(request, response);
			viewPage += "/board/questionBoardSearch.jsp";
		}
		else if(com.equals("/AboutUs")) {
			viewPage += "/company/aboutUs.jsp";
		}
		else if(com.equals("/Service")) {
			viewPage += "/service/serviceMain.jsp";
		}
		else if(com.equals("/Complaint")) {
			viewPage += "/service/complaintMain.jsp";
		}
		else if(com.equals("/Product")) {
			viewPage += "/product/product.jsp";
		}
		else if(level > 2 || level < 0) {
			request.setAttribute("message", "로그인 후 사용해 주세요.");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.do");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/FreeBoardInput")) {
			viewPage += "/board/freeBoardInput.jsp";
		}
		else if(com.equals("/FreeBoardEdit")) {
			command = new FreeBoardEditCommand();
			command.execute(request, response);
			viewPage += "/board/freeBoardEdit.jsp";
		}
		else if(com.equals("/QuestionBoardInput")) {
			command = new QuestionBoardInputCommand();
			command.execute(request, response);
			viewPage += "/board/questionBoardInput.jsp";
		}
		else if(com.equals("/PwdChange")) {
			viewPage += "/mypage/pwdChange.jsp";
		}
		else if(com.equals("/MemberUpdate")) {
			command = new MemberUpdateCommand();
			command.execute(request, response);
			viewPage += "/mypage/memberUpdate.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}