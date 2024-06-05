package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.MainInterface;

public class MemberUpdateCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberIdCheck(mid);
		
		// 전화번호 분리
		String[] phone = vo.getPhone().split("-");
		if(phone[1].equals(" ")) phone[1] = "";
		if(phone[2].equals(" ")) phone[2] = "";
		request.setAttribute("tel1", phone[0]);
		request.setAttribute("tel2", phone[1]);
		request.setAttribute("tel3", phone[2]);
		
		String[] cTel = vo.getcTel().split("-");
		if(cTel[1].equals(" ")) cTel[1] = "";
		if(cTel[2].equals(" ")) cTel[2] = "";
		request.setAttribute("tel4", cTel[0]);
		request.setAttribute("tel5", cTel[1]);
		request.setAttribute("tel6", cTel[2]);
		
		// 주소분리(/)
		String[] address = vo.getAddress().split("/");
		if(address[0].equals(" ")) address[0] = "";
		if(address[1].equals(" ")) address[1] = "";
		if(address[2].equals(" ")) address[2] = "";
		if(address[3].equals(" ")) address[3] = "";
		request.setAttribute("postcode", address[0]);
		request.setAttribute("roadAddress", address[1]);
		request.setAttribute("detailAddress", address[2]);
		request.setAttribute("extraAddress", address[3]);
		
		String[] cAddress = vo.getcAddress().split("/");
		if(cAddress[0].equals(" ")) cAddress[0] = "";
		if(cAddress[1].equals(" ")) cAddress[1] = "";
		if(cAddress[2].equals(" ")) cAddress[2] = "";
		if(cAddress[3].equals(" ")) cAddress[3] = "";
		request.setAttribute("cPostcode", cAddress[0]);
		request.setAttribute("cRoadAddress", cAddress[1]);
		request.setAttribute("cDetailAddress", cAddress[2]);
		request.setAttribute("cExtraAddress", cAddress[3]);
		request.setAttribute("purpose", vo.getPurpose());
		request.setAttribute("vo", vo);
	}

}
