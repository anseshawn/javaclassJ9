package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;

public class ReplyEditOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		ReplyDAO dao = new ReplyDAO();
		int res = dao.setReplyEdit(idx,content);
		
		response.getWriter().write(res+"");
	}

}
