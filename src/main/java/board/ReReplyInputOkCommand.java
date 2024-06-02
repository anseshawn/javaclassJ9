package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;

public class ReReplyInputOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int replyIdx = request.getParameter("replyIdx")==null ? 0 : Integer.parseInt(request.getParameter("replyIdx"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		
		ReplyDAO dao = new ReplyDAO();
		ReplyVO vo = new ReplyVO();
		
		vo.setReplyIdx(replyIdx);
		vo.setReMid(mid);
		vo.setReNickName(nickName);
		vo.setReHostIp(hostIp);
		vo.setReContent(content);
		
		int res = dao.setBoardReReply(vo);
		
		response.getWriter().write(res+"");
	}

}
