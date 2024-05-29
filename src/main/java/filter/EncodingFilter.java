package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

// 한글 인코딩 필터
@WebFilter("/*")
public class EncodingFilter implements Filter {
	 
  private static final String UTF_8 = "utf-8";
  private static final String TEXT_HTML_UTF_8 = "text/html; charset=utf-8";
  
  @Override
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
      HttpServletRequest httpRequest = (HttpServletRequest) request;
      String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

      if (!path.startsWith("/css/") && !path.startsWith("/js/") && !path.startsWith("/images/") && !path.startsWith("/plugins/")) {
          request.setCharacterEncoding(UTF_8);
          response.setContentType(TEXT_HTML_UTF_8);
      }
      chain.doFilter(request, response);
  }
}
