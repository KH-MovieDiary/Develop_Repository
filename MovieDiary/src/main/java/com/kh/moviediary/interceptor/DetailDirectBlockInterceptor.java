package com.kh.moviediary.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class DetailDirectBlockInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        String uri = request.getRequestURI();
        if(uri.endsWith("/detail.review") && "GET".equalsIgnoreCase(request.getMethod())) {

            String referer = request.getHeader("Referer");

            boolean ok = (referer != null) &&
                         (referer.contains("/reviewList.bo") || referer.contains("/main") || referer.contains("/movieInfo.mo"));

            if(!ok) {
                response.sendRedirect(request.getContextPath() + "/reviewList.bo");
                return false;
            }
        }
        return true;
    }
}
