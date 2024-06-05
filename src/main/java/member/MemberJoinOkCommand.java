package member;

import java.io.IOException;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;
import common.SecurityUtil;

public class MemberJoinOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
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
		
		//System.out.println(request.getParameterValues("purpose"));
		//System.out.println("purposes: "+purposes);
		String purpose = "";
		if(purposes.length != 0) {
			for(String p : purposes) {
				purpose += p + "/";
				//System.out.println("purpose: "+purpose);
			}
		}
		purpose = purpose.substring(0, purpose.lastIndexOf("/"));

		// DB에 저장시킬 자료 중 not null 데이터는 BackEnd 체크 시켜준다...(추후에)
		
		// 아이디 / 닉네임 중복체크...
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdCheck(mid);
		if(vo.getMid() != null) {
			request.setAttribute("message", "이미 사용중인 아이디입니다.");
			request.setAttribute("url", "/MemberJoin.do");
			return;
		}
		vo = dao.getMemberNickCheck(nickName);
		if(vo.getNickName() != null) {
			request.setAttribute("message", "이미 사용중인 닉네임입니다.");
			request.setAttribute("url", "/MemberJoin.do");
			return;
		}
		
		
		// 비밀번호 암호화(SHA-256) - salt키를 만든 후 암호화 시켜준다...(uuid코드 중 앞의 8자리와 같이 병행 처리 후 암호화)
		UUID uuid = UUID.randomUUID();
		String salt = uuid.toString().substring(0,8);
		
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(salt+pwd);
		
		pwd = salt + pwd; // DB에 따로 salt키 필드를 만들지 않고(만들면 보안에 취약) pwd에 합쳐서 저장
		
		// 모든 체크가 끝난 자료는 vo에 담아서 DB에 저장처리한다.
		vo = new MemberVO();
		vo.setName(name);
		vo.setMid(mid);
		vo.setPwd(pwd); // vo.setPwd(salt+pwd); // 솔트키를 앞에 놓고 저장 후 나중에 앞의 여덟자리만 잘라서 비교
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
		
		int res = dao.setMemberJoinOk(vo);
		
		if(res != 0) {
			request.setAttribute("message", "회원 가입이 완료되었습니다.\\n 다시 로그인 해 주세요.");
			request.setAttribute("url", "MemberLogin.do");
		}
		else {
			request.setAttribute("message", "회원 가입 실패");
			request.setAttribute("url", "MemberJoin.do");
		}
	}

}
