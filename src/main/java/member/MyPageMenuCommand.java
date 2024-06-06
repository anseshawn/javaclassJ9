package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;

public class MyPageMenuCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int part = request.getParameter("part")==null ? 0 : Integer.parseInt(request.getParameter("part"));
		
		if(part==1) {
			
		}
		// map을 만들어서 변수명 변수 넣어서 보내기..?
		response.getWriter().write(part+"");
	}

}
