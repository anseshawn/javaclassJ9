package board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.FreeBoardInputOkCommand;
import board.FreeBoardListCommand;
import common.MainInterface;

@WebServlet("*.bo")
public class BoardController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MainInterface command = null;
		String viewPage = "";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"),com.lastIndexOf("."));
		
		// 인증 처리
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(com.equals("/ReplyInputOk")) {
			command = new ReplyInputOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/ReplyDelete")) {
			command = new ReplyDeleteCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/ReplyEditOk")) {
			command = new ReplyEditOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/FreeBoardInputOk")) {
			command = new FreeBoardInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/FreeBoardEditOk")) {
			command = new FreeBoardEditOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/FreeBoardDelete")) {
			command = new FreeBoardDeleteCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardGoodCheck")) {
			command = new BoardGoodCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/BoardReportOk")) {
			command = new BoardReportOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/QuestionBoardInputOk")) {
			command = new QuestionBoardInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/QuestionBoardDelete")) {
			command = new QuestionBoardDeleteCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/QuestionBoardEditOk")) {
			command = new QuestionBoardEditOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
