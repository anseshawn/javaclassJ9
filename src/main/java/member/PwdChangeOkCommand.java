package member;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;
import common.SecurityUtil;

public class PwdChangeOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String pwdNew = request.getParameter("pwdNew")==null ? "" : request.getParameter("pwdNew");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdCheck(mid);
		
		SecurityUtil security = new SecurityUtil();
		
		// 현재 비밀번호 확인
		String salt = vo.getPwd().substring(0,8);
		pwd = security.encryptSHA256(salt+pwd);
		if(!vo.getPwd().substring(8).equals(pwd)) {
			request.setAttribute("message", "현재 비밀번호가 일치하지 않습니다.");
			request.setAttribute("url", request.getContextPath()+"/PwdChange.do");
			return;
		}
		
		salt = UUID.randomUUID().toString().substring(0,8);
		pwdNew = security.encryptSHA256(salt+pwdNew);
		int res = dao.setMemberPwdChange(mid,(salt+pwdNew));
		if(res != 0) {
			request.setAttribute("message", "비밀번호가 변경되었습니다.\\n다시 로그인 해주세요.");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.do");
		}
		else {
			request.setAttribute("message", "비밀번호 변경 실패");
			request.setAttribute("url", request.getContextPath()+"/PwdChange.do");			
		}
	}

}
