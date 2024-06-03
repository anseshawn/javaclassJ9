package board;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.MainInterface;

public class RecruitBoardEditOkCommand implements MainInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/images/board");
		int maxSize = 1024 * 1024 * 10;
		String encoding = "utf-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		int idx = multipartRequest.getParameter("idx")==null ? 0 : Integer.parseInt(multipartRequest.getParameter("idx"));
		int pag = multipartRequest.getParameter("pag")==null ? 1 : Integer.parseInt(multipartRequest.getParameter("pag"));
		int pageSize = multipartRequest.getParameter("pageSize")==null ? 5 : Integer.parseInt(multipartRequest.getParameter("pageSize"));
		
		String mid = multipartRequest.getParameter("mid")==null ? "" : multipartRequest.getParameter("mid");
		String nickName = multipartRequest.getParameter("nickName")==null ? "" : multipartRequest.getParameter("nickName");
		String hostIp = multipartRequest.getParameter("hostIp")==null ? "" : multipartRequest.getParameter("hostIp");
		String part = multipartRequest.getParameter("part")==null ? "" : multipartRequest.getParameter("part");
		String title = multipartRequest.getParameter("title")==null ? "" : multipartRequest.getParameter("title");
		String location = multipartRequest.getParameter("location")==null ? "" : multipartRequest.getParameter("location");
		String endDate = multipartRequest.getParameter("datePicker")==null ? "" : multipartRequest.getParameter("datePicker");
		String etcContent = multipartRequest.getParameter("etcContent")==null ? "" : multipartRequest.getParameter("etcContent");
		String content = multipartRequest.getParameter("content")==null ? "" : multipartRequest.getParameter("content");
		
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		
		Enumeration fileNames = multipartRequest.getFileNames();
		
		String file = "";
		String rcfName = "";
		String rcfSName = "";
		
		while(fileNames.hasMoreElements()) {
			file = (String)fileNames.nextElement();
			
			if(multipartRequest.getFilesystemName(file) != null) {
				rcfName += multipartRequest.getOriginalFileName(file) + "/";
				rcfSName += multipartRequest.getFilesystemName(file)+"/";				
			}
		}
		if(rcfName.lastIndexOf("/")!=-1 && rcfSName.lastIndexOf("/")!=-1) {
			rcfName = rcfName.substring(0, rcfName.lastIndexOf("/"));
			rcfSName = rcfSName.substring(0, rcfSName	.lastIndexOf("/"));			
		}
		
		RecruitBoardVO vo = new RecruitBoardVO();
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		vo.setPart(part);
		vo.setLocation(location);
		vo.setEndDate(endDate);
		vo.setEtcContent(etcContent);
		vo.setRcfName(rcfName);
		vo.setRcfSName(rcfSName);
		
		RecruitBoardDAO dao = new RecruitBoardDAO();
		
		int res = dao.setRecruitBoardEdit(vo);
		
		if(res != 0) {
			request.setAttribute("message", "게시글이 수정되었습니다.");
		}
		else {
			request.setAttribute("message", "게시글 수정 실패");
		}
		request.setAttribute("url", "RecruitBoardContent.do?idx="+idx+"&pag="+pag+"&pageSize="+pageSize);		
	}

}
