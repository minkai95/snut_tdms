package com.snut_tdms.util;

import com.snut_tdms.model.vo.Page;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.regex.Pattern;

/**
 * 系统工具类
 * Created by sunt on 2017/5/29.
 */
public class SystemUtils {
    /**
     * 获取UUID
     *
     * @return UUID字符串
     */
    public static String getUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }

    /**
     * 获取系统时间
     *
     * @return 时间字符串
     */
    public static String getSystemDate() {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    }

    /**
     * 获取处理后的分页参数
     *
     * @param currentPage 当前页面上的页码
     * @return 分页参数
     */
    public static Page getPage(String currentPage) {
        Page page = new Page();
        Pattern pattern = Pattern.compile("[0-9]{1,9}");
        if (currentPage == null || "".equals(currentPage) || !pattern.matcher(currentPage).matches()) {
            page.setCurrentPage(1);
        } else {
            page.setCurrentPage(Integer.valueOf(currentPage));
        }
        return page;
    }

}
