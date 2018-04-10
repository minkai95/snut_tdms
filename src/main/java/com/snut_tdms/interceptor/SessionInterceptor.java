package com.snut_tdms.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 拦截除登录页外所有页的session,判断是否过期
 * Created by huankai on 2018/3/22.
 */
public class SessionInterceptor implements HandlerInterceptor {

    private static final String LOGIN_URL = "/user/sessionError";

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        HttpSession session = httpServletRequest.getSession(true);  //若存在会话则返回该会话，否则新建一个会话
        String servletPath = httpServletRequest.getServletPath();   //获取请求servlet路径
        String role = (String) session.getAttribute("role");    //获取用户权限
        if (role == null || "".equals(role)) {  //若session中无用户权限(超时登录)，则返回到登录页
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + LOGIN_URL + "?errorFlag=sessionTimeoutError");
            return false;
        } else {
            if (servletPath.contains("selectPerson") || servletPath.contains("updatePerson"))
                return true;
            if (!servletPath.contains(role)) {  //若请求路径中不包含权限，则返回到登录页
                session.removeAttribute("role");
                session.removeAttribute("userObject");
                session.invalidate();
                httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + LOGIN_URL + "?errorFlag=roleError");
                return false;
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }

}
