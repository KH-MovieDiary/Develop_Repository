package com.kh.moviediary.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.moviediary.member.vo.Member;

public class DetailDirectBlockInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        String uri = request.getRequestURI();
        String method = request.getMethod();
        String referer = request.getHeader("Referer");
        String ctx = request.getContextPath();

        HttpSession session = request.getSession(false);
        Member loginUser = (session == null) ? null : (Member) session.getAttribute("loginUser");

        if (uri.endsWith("/detail.review") && "GET".equalsIgnoreCase(method)) {

            String scheme = request.getScheme();
            String server = request.getServerName();
            int port = request.getServerPort();

            String baseUrl;
            if (port == 80 || port == 443) {
                baseUrl = scheme + "://" + server + ctx;
            } else {
                baseUrl = scheme + "://" + server + ":" + port + ctx;
            }

            boolean fromMain = referer != null &&
                    (referer.equals(baseUrl)
                     || referer.equals(baseUrl + "/")
                     || referer.startsWith(baseUrl + "/?"));

            boolean fromList = referer != null && (referer.contains(ctx + "/reviewList.bo")
            									|| referer.contains(ctx + "/searchList.bo"));
            boolean fromMovieInfo = referer != null && referer.contains(ctx + "/movieInfo.mo");

            if (!(fromMain || fromList || fromMovieInfo)) {
                response.sendRedirect(ctx + "/reviewList.bo");
                return false;
            }
        }

        if (uri.contains("/websocket/noteList")
                || uri.contains("/websocket/noteHandler")) {

            if (loginUser == null) {
                response.sendRedirect(ctx + "/");
                return false;
            }

            return true;
        }

        if (uri.contains("/websocket/noteDetail")) {

            if (loginUser == null) {
                response.sendRedirect(ctx + "/");
                return false;
            }

            boolean ok = referer != null &&
                    referer.contains(ctx + "/websocket/noteList");

            if (!ok) {
                response.sendRedirect(ctx + "/websocket/noteList?type=received");
                return false;
            }
        }

        return true;
    }
}
