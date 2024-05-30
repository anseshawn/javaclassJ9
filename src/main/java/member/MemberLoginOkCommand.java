package member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.MainInterface;
import common.SecurityUtil;

public class MemberLoginOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdCheck(mid);
		
		// 아래로 회원 인증 처리
		if(vo.getPwd() == null || vo.getUserDel().equals("OK")) {
			request.setAttribute("message", "입력하신 회원 정보가 없습니다. \\n아이디 혹은 비밀번호를 확인하세요.");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.mem");
			return;
		}
		
		// 저장된 비밀번호에서 salt키를 분리시켜서 다시 암호화 시킨 후 맞는지 비교처리한다.
		String salt = vo.getPwd().substring(0,8);
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt+pwd);
		if(!vo.getPwd().substring(8).equals(pwd)) {
			request.setAttribute("message", "비밀번호를 확인하세요.");
			request.setAttribute("url", request.getContextPath()+"/MemberLogin.do");
			return;
		}
		
		// 로그인 체크 완료 후에 처리할 내용...(쿠키/세션/...)
		
		// 회원일 때 처리할 부분
		// *** 2-2. 준회원을 자동으로 정회원 등업처리
		// *** 3.처리 완료된 자료(vo)를 DB에 업데이트해준다.
		
		// 1번/2-1번 : 방문포인트 처리를 위한 날짜 추출 비교하기 - 조건에 맞도록 방문 포인트와 카운트를 증가처리한다.
//		Date today = new Date();
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		String strToday = sdf.format(today);
		
		// ** Q&A게시판에 댓글 달아줬을 때 포인트 +10
		
		// 3번 : 방문 포인트와 카운트를 증가처리한 내용을 vo에 모두 담았다면 DB 자신의 레코드에 변경된 사항들을 갱신처리해준다.
		dao.setLoginUpdate(vo);
		
		
		// 쿠키에 아이디를 저장/해제 처리한다.
		// 로그인시 아이디저장시킨다고 체크하면 쿠키에 아이디 저장하고, 그렇지 않으면 쿠키에서 아이디를 제거한다.
		String idSave = request.getParameter("idSave")==null ? "off" : "on";
		Cookie cookieMid = new Cookie("cMid", mid);
		cookieMid.setPath("/"); // 가장 상위에 쿠키값을 저장하겠다는 의미 (서블릿과 jsp를 오가게 되면 경로가 달라지므로 필요)
		if(idSave.equals("on")) {
			cookieMid.setMaxAge(60*60*24*7);	// 쿠키의 만료시간은 1주일로 한다.
		}
		else {
			cookieMid.setMaxAge(0);
		}
		response.addCookie(cookieMid);
		
		// 레벨에 따른 등급 명칭을 저장한다.
		String strLevel = "";
		if(vo.getLevel() == 0) strLevel = "관리자";
		else if(vo.getLevel() == 1) strLevel = "일반회원";
		else if(vo.getLevel() == 2) strLevel = "기업회원";
		
		// 필요한 정보를 session에 저장처리한다.
		HttpSession session = request.getSession();
		session.setAttribute("sMid", mid);
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("strLevel", strLevel);
		
		request.setAttribute("message", vo.getNickName()+"님 로그인 되었습니다.");
		request.setAttribute("url", request.getContextPath()+"/Main.do");
	}

}
