package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;

public class FreeBoardInputOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String title = request.getParameter("title")==null ? "" : request.getParameter("title");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		
		FreeBoardVO vo = new FreeBoardVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		System.out.println("vo : " + vo);
		FreeBoardDAO dao = new FreeBoardDAO();
		
		int res = dao.setFreeBoardInput(vo);
		
		if(res != 0) {
			request.setAttribute("message", "게시글이 등록되었습니다.");
			request.setAttribute("url", "FreeBoard.do");
		}
		else {
			request.setAttribute("message", "게시글 등록 실패");
			request.setAttribute("url", "FreeBoardInput.do");			
		}
	}

}
