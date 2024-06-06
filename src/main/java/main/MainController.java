package main;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.BoardGoodCheckCommand;
import board.BoardReportOkCommand;
import board.FreeBoardContentCommand;
import board.FreeBoardDeleteCommand;
import board.FreeBoardEditCommand;
import board.FreeBoardEditOkCommand;
import board.FreeBoardInputOkCommand;
import board.FreeBoardListCommand;
import board.FreeBoardSearchCommand;
import board.QuestionBoardCommand;
import board.QuestionBoardContentCommand;
import board.QuestionBoardDeleteCommand;
import board.QuestionBoardEditCommand;
import board.QuestionBoardEditOkCommand;
import board.QuestionBoardInputCommand;
import board.QuestionBoardInputOkCommand;
import board.QuestionBoardSearchCommand;
import board.ReReplyDeleteCommand;
import board.ReReplyEditOkCommand;
import board.ReReplyInputOkCommand;
import board.RecruitBoardCommand;
import board.RecruitBoardContentCommand;
import board.RecruitBoardDeleteCommand;
import board.RecruitBoardEditCommand;
import board.RecruitBoardEditOkCommand;
import board.RecruitBoardInputOkCommand;
import board.RecruitBoardSearchCommand;
import board.ReplyDeleteCommand;
import board.ReplyEditOkCommand;
import board.ReplyInputOkCommand;
import common.MainInterface;
import member.CheckBoardCommand;
import member.MemberDeleteOkCommand;
import member.MemberIdCheckCommand;
import member.MemberJoinOkCommand;
import member.MemberLoginOkCommand;
import member.MemberLogoutCommand;
import member.MemberNickCheckCommand;
import member.MemberUpdateCommand;
import member.MemberUpdateOkCommand;
import member.MidSearchResultCommand;
import member.MyPageMenuCommand;
import member.PwdChangeOkCommand;

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
		else if(com.equals("/MemberIdCheck")) {
			command = new MemberIdCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/MemberLogin")) {
			viewPage += "/member/memberLogin.jsp";
		}
		else if(com.equals("/MemberNickCheck")) {
			command = new MemberNickCheckCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/MemberLoginOk")) {
			command = new MemberLoginOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/MemberLogout")) {
			command = new MemberLogoutCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/MemberJoinOk")) {
			command = new MemberJoinOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/PwdSearch")) {
			viewPage += "/member/pwdSearch.jsp";
		}
		else if(com.equals("/MidSearch")) {
			viewPage += "/member/midSearch.jsp";
		}
		else if(com.equals("/MidSearchResult")) {
			command = new MidSearchResultCommand();
			command.execute(request, response);
			viewPage += "/member/midSearchResult.jsp";
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
		else if(com.equals("/RecruitBoard")) {
			command = new RecruitBoardCommand();
			command.execute(request, response);
			viewPage += "/board/recruitBoard.jsp";
		}
		else if(com.equals("/RecruitBoardContent")) {
			command = new RecruitBoardContentCommand();
			command.execute(request, response);
			viewPage += "/board/recruitBoardContent.jsp";
		}
		else if(com.equals("/RecruitBoardSearch")) {
			command = new RecruitBoardSearchCommand();
			command.execute(request, response);
			viewPage += "/board/recruitBoardSearch.jsp";
		}
		else if(com.equals("/ReplyInputOk")) {
			command = new ReplyInputOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/ReplyDelete")) {
			command = new ReplyDeleteCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/ReReplyDelete")) {
			command = new ReReplyDeleteCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/ReplyEditOk")) {
			command = new ReplyEditOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/ReReplyEditOk")) {
			command = new ReReplyEditOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/ReReplyInputOk")) {
			command = new ReReplyInputOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/BoardGoodCheck")) {
			command = new BoardGoodCheckCommand();
			command.execute(request, response);
			return;
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
		else if(com.equals("/FreeBoardInputOk")) {
			command = new FreeBoardInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/FreeBoardEdit")) {
			command = new FreeBoardEditCommand();
			command.execute(request, response);
			viewPage += "/board/freeBoardEdit.jsp";
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
		else if(com.equals("/QuestionBoardInput")) {
			command = new QuestionBoardInputCommand();
			command.execute(request, response);
			viewPage += "/board/questionBoardInput.jsp";
		}
		else if(com.equals("/QuestionBoardInputOk")) {
			command = new QuestionBoardInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/QuestionBoardEdit")) {
			command = new QuestionBoardEditCommand();
			command.execute(request, response);
			viewPage += "/board/questionBoardEdit.jsp";
		}
		else if(com.equals("/QuestionBoardEditOk")) {
			command = new QuestionBoardEditOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/QuestionBoardDelete")) {
			command = new QuestionBoardDeleteCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/BoardReportOk")) {
			command = new BoardReportOkCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/MyPage")) {
			command = new MemberUpdateCommand();
			command.execute(request, response);
			command = new CheckBoardCommand();
			command.execute(request, response);
			viewPage += "/mypage/myPage.jsp";
		}
		else if(com.equals("/MyPageMenu")) {
			command = new MyPageMenuCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/PwdChange")) {
			viewPage += "/mypage/pwdChange.jsp";
		}
		else if(com.equals("/PwdChangeOk")) {
			command = new PwdChangeOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/MemberUpdate")) {
			command = new MemberUpdateCommand();
			command.execute(request, response);
			viewPage += "/mypage/memberUpdate.jsp";
		}
		else if(com.equals("/MemberUpdateOk")) {
			command = new MemberUpdateOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/CheckBoard")) {
			command = new CheckBoardCommand();
			command.execute(request, response);
			viewPage += "/mypage/checkBoard.jsp";
		}
		else if(com.equals("/MemberDelete")) {
			viewPage += "/mypage/memberDelete.jsp";
		}
		else if(com.equals("/MemberDeleteOk")) {
			command = new MemberDeleteOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		else if(level != 0 && level != 2) {
			request.setAttribute("message", "개인 회원은 이용할 수 없는 기능입니다.");
			request.setAttribute("url", request.getContextPath()+"/Main.do");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/RecruitBoardInput")) {
			viewPage += "/board/recruitBoardInput.jsp";
		}
		else if(com.equals("/RecruitBoardInputOk")) {
			command = new RecruitBoardInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/RecruitBoardEdit")) {
			command = new RecruitBoardEditCommand();
			command.execute(request, response);
			viewPage += "/board/recruitBoardEdit.jsp";
		}
		else if(com.equals("/RecruitBoardEditOk")) {
			command = new RecruitBoardEditOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/RecruitBoardDelete")) {
			command = new RecruitBoardDeleteCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
