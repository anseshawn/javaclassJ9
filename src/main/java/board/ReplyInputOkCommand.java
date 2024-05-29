package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;

public class ReplyInputOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String board = request.getParameter("board")==null ? "" : request.getParameter("board");
		int boardIdx = request.getParameter("boardIdx")==null ? 0 : Integer.parseInt(request.getParameter("boardIdx"));
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		String content = request.getParameter("board")==null ? "" : request.getParameter("content");
		
		ReplyDAO dao = new ReplyDAO();
		ReplyVO vo = new ReplyVO();
		
		vo.setBoard(board);
		vo.setBoardIdx(boardIdx);
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setHostIp(hostIp);
		vo.setContent(content);
		
		int res = dao.setBoardReply(vo);
		
		response.getWriter().write(res+"");
	}

}
