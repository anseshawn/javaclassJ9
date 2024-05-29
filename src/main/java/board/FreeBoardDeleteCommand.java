package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.MainInterface;

public class FreeBoardDeleteCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int replyCnt = request.getParameter("replyCnt")==null ? 0 : Integer.parseInt(request.getParameter("replyCnt"));
		
		FreeBoardDAO dao = new FreeBoardDAO();
		int res = dao.setFreeBoardDelete(idx);
		int res2 = 0;
		
		// 댓글 달려있으면 댓글도 삭제
		if(replyCnt !=0) {
			ReplyDAO rDao = new ReplyDAO();
			res2 = rDao.setBoardDeleteAll("freeBoard", idx);
			if(res2==0) {
				request.setAttribute("message", "게시글의 댓글 삭제 중 에러가 발생했습니다.");
 				request.setAttribute("url", "FreeBoard.do?idx="+idx);
 				return;
			}
		}
		
		if(res != 0) {
			request.setAttribute("message", "게시글이 삭제되었습니다.");
			request.setAttribute("url", "FreeBoard.do");				
		}
		else {
			request.setAttribute("message", "게시글 삭제 실패");
			request.setAttribute("url", "FreeBoard.do?idx="+idx);			
		}
	}

}
