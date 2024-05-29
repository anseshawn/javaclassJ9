package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;

public class FreeBoardEditOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pag = request.getParameter("pag")==null ? 0 : Integer.parseInt(request.getParameter("pag"));
		int pageSize = request.getParameter("pageSize")==null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName")==null ? "" : request.getParameter("nickName");
		String title = request.getParameter("title")==null ? "" : request.getParameter("title");
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String hostIp = request.getParameter("hostIp")==null ? "" : request.getParameter("hostIp");
		
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		
		FreeBoardVO vo = new FreeBoardVO();
		vo.setIdx(idx);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		
		FreeBoardDAO dao = new FreeBoardDAO();
		
		int res = dao.setFreeBoardEdit(vo);
		
		if(res != 0) {
			request.setAttribute("message", "게시글이 수정되었습니다.");
		}
		else {
			request.setAttribute("message", "게시글 수정 실패");
		}
		request.setAttribute("url", "FreeBoardContent.do?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);			
	}

}
