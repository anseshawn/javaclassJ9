package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;

public class MidSearchResultCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");	
		String email = request.getParameter("email1")==null ? "" : request.getParameter("email1");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getMemberNameCheck(name);
		
		if(!email.equals(vo.getEmail())) {
			request.setAttribute("res", "0");
		}
		else {
			String mid = "";
			//int ran = (int)(Math.random()*4+1-2)+2;
			int ran = 0;
			if(vo.getMid().length()<=5) ran=2;
			else if(vo.getMid().length()<=7) ran=3;
			else ran=4;
			for(int i=0; i<vo.getMid().length(); i++) {
				if(i < ran) {
					mid += vo.getMid().charAt(i);					
				}
				else {
					mid += "*";
				}
			}
			request.setAttribute("res", "1");
			request.setAttribute("mid", mid);
		}
		
	}
}
