package com.snut_tdms.interceptor;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

/**
 * 跨域过滤器—支持跨域访问
 * Created by huankai on 2018/3/23.
 */
public class CrossFilter implements  Filter {

    @Override
    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
            throws IOException, ServletException {
        HttpServletResponse httpServletResponse = (HttpServletResponse) arg1;
        httpServletResponse.setHeader("Access-Control-Allow-Origin", "*");
        arg2.doFilter(arg0, httpServletResponse);
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
    }

}
