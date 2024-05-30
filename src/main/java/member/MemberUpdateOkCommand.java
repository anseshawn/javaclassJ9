package member;

import java.io.IOException;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;
import common.SecurityUtil;

public class MemberUpdateOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String birthday = request.getParameter("birthday")==null ? "" : request.getParameter("birthday");
		String email = request.getParameter("email")==null ? "" : request.getParameter("email");
		String emailNews = request.getParameter("emailNews")==null ? "NO" : request.getParameter("emailNews");
		String phone = request.getParameter("phone")==null ? "" : request.getParameter("phone");
		String address = request.getParameter("address")==null ? "" : request.getParameter("address");
		String mGroup = request.getParameter("mGroup")==null ? "개인" : request.getParameter("mGroup");
		String cName = request.getParameter("cName")==null ? "" : request.getParameter("cName");
		String cCategory = request.getParameter("cCategory")==null ? "" : request.getParameter("cCategory");
		String cAddress = request.getParameter("cAddress")==null ? "" : request.getParameter("cAddress");
		String cTel = request.getParameter("cTel")==null ? "" : request.getParameter("cTel");
		
		String[] purposes = request.getParameterValues("purpose");
		
		/* : 값이 제대로 넘어왔는지 확인하는 과정
		
		// 모든 요청 파라미터 출력
    System.out.println("서블릿 도착");

    Enumeration<String> parameterNames = request.getParameterNames();
    while (parameterNames.hasMoreElements()) {
        String paramName = parameterNames.nextElement();
        String[] paramValues = request.getParameterValues(paramName);
        System.out.println("Parameter Name: " + paramName + ", Values: " + String.join(", ", paramValues));
    }

    // 체크박스의 값들을 배열로 받기
    if (purposes == null) {
        System.out.println("선택된 체크박스가 없습니다. 또는 체크박스의 값이 전달되지 않았습니다.");
    } else {
        for (String purpose : purposes) {
            System.out.println("선택된 값: " + purpose);
        }
    }
    */
		
		String purpose = "";
		if(purposes.length != 0) {
			for(String p : purposes) {
				purpose += p + "/";
			}
		}
		purpose = purpose.substring(0, purpose.lastIndexOf("/"));

		// DB에 저장시킬 자료 중 not null 데이터는 BackEnd 체크 시켜준다...(추후에)
		
		// 닉네임 중복체크...
		MemberDAO dao = new MemberDAO();
		MemberVO vo = new MemberVO();
		/*
		vo = dao.getMemberNickCheck(nickName);
		if(vo.getMid() != mid && vo.getNickName() != null) { // 내가 아닌 사용자 중에서
			request.setAttribute("message", "이미 사용중인 닉네임입니다.");
			request.setAttribute("url", "MemberUpdate.do");
			return;
		}
		*/
		
		// 모든 체크가 끝난 자료는 vo에 담아서 DB에 저장처리한다.
		vo = new MemberVO();
		vo.setName(name);
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setBirthday(birthday);
		vo.setEmail(email);
		vo.setEmailNews(emailNews);
		vo.setPhone(phone);
		vo.setAddress(address);
		vo.setmGroup(mGroup);
		vo.setcName(cName);
		vo.setcCategory(cCategory);
		vo.setcAddress(cAddress);
		vo.setcTel(cTel);
		vo.setPurpose(purpose);
		
		int res = dao.setMemberUpdateOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "회원정보 수정이 완료되었습니다.");
			request.setAttribute("url", "Main.do");
		}
		else {
			request.setAttribute("message", "회원정보 수정 실패");
			request.setAttribute("url", "MemberUpdate.do");
		}
	}

}
