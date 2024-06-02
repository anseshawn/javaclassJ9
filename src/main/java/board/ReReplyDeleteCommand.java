package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;

public class ReReplyDeleteCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reIdx = request.getParameter("reIdx")==null ? 0 : Integer.parseInt(request.getParameter("reIdx"));
		
		ReplyDAO dao = new ReplyDAO();
		
		int res = dao.setReReplyDelete(reIdx);
		response.getWriter().write(res+"");
	}

}
