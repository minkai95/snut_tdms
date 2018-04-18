package com.snut_tdms.model.vo;

import java.util.Arrays;

/**
 * 分页类
 * Created by huankai on 2018/3/22.
 */
public class Page {
    private int totalNumber;//总记录数
    private int currentPage;//当前页
    private int totalPage;//总页数
    private int pageNumber = 10;//每页数据数
    private int dbIndex;
    private int dbNumber;
    private String[] selectParam;

    private void count() {
        // 计算总页数
        int totalPageTemp = this.totalNumber / this.pageNumber;
        int plus = (this.totalNumber % this.pageNumber) == 0 ? 0 : 1;
        totalPageTemp = totalPageTemp + plus;
        if (totalPageTemp <= 0) {
            totalPageTemp = 1;
        }
        this.totalPage = totalPageTemp;

        // 设置当前页数
        // 总页数小于当前页数，应将当前页数设置为总页数
        if (this.totalPage < this.currentPage) {
            this.totalPage = this.currentPage;
        }
        // 当前页数小于1设置为1
        if (this.currentPage < 1) {
            this.currentPage = 1;
        }

        // 设置limit的参数
        this.dbIndex = (this.currentPage - 1) * this.pageNumber;
        this.dbNumber = this.pageNumber;
    }

    public int getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(int totalNumber) {
        this.totalNumber = totalNumber;
        this.count();
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
        this.count();
    }

    public int getDbIndex() {
        return dbIndex;
    }

    public void setDbIndex(int dbIndex) {
        this.dbIndex = dbIndex;
    }

    public int getDbNumber() {
        return dbNumber;
    }

    public void setDbNumber(int dbNumber) {
        this.dbNumber = dbNumber;
    }

    public String[] getSelectParam() {
        return selectParam;
    }

    public void setSelectParam(String[] selectParam) {
        this.selectParam = selectParam;
    }

    @Override
    public String toString() {
        return "Page{" +
                "totalNumber=" + totalNumber +
                ", currentPage=" + currentPage +
                ", totalPage=" + totalPage +
                ", pageNumber=" + pageNumber +
                ", dbIndex=" + dbIndex +
                ", dbNumber=" + dbNumber +
                ", selectParam=" + Arrays.toString(selectParam) +
                '}';
    }
}
