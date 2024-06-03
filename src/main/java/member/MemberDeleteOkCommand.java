package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.MainInterface;
import common.SecurityUtil;

public class MemberDeleteOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int deleteReason = request.getParameter("deleteReason")==null ? 0 : Integer.parseInt(request.getParameter("deleteReason"));
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdCheck(mid);
		
		String salt = vo.getPwd().substring(0,8);
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt+pwd);
		if(!vo.getPwd().substring(8).equals(pwd)) {
			request.setAttribute("message", "비밀번호가 맞지 않습니다.");
			request.setAttribute("url", request.getContextPath()+"/MemberDelete.do");
			return;
		}
		
		int res = dao.setMemberDeleteOk(mid);
		if(res != 0) {
			session.invalidate();
			request.setAttribute("message", "탈퇴 신청이 완료되었습니다.");
			request.setAttribute("url", "Main.do");
		}
		else {
			request.setAttribute("message", "탈퇴 신청 실패");
			request.setAttribute("url", "MemberDelete.do");
		}
		
	}

}
