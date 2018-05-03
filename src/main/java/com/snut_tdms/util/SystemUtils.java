package com.snut_tdms.util;

import com.jacob.com.ComThread;
import com.snut_tdms.model.vo.Page;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import java.util.regex.Pattern;
import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;

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

    public static boolean officeToPDF(String officeFile,String pdfFile){
        String officeType = officeFile.substring(officeFile.lastIndexOf(".")+1).toLowerCase();
        if ("pdf".equals(officeType)){
            return true;
        }else if ("doc".equals(officeType)||"docx".equals(officeType)||"txt".equals(officeType)){
            return wordToPDF(officeFile,pdfFile);
        }else if ("ppt".equals(officeType)||"pptx".equals(officeType)){
            return pptToPDF(officeFile,pdfFile);
        }else if ("xls".equals(officeType)||"xlsx".equals(officeType)){
            return excelToPDF(officeFile,pdfFile);
        }else {
            return false;
        }
    }

    private static boolean wordToPDF(String inputFile, String pdfFile) {
      try {
          // 打开Word应用程序
          ActiveXComponent app = new ActiveXComponent("KWPS.Application");
          System.out.println("开始转化Word为PDF...");
          long date = new Date().getTime();
          // 设置Word不可见
          app.setProperty("Visible", new Variant(false));
          // 禁用宏
          app.setProperty("AutomationSecurity", new Variant(3));
          // 获得Word中所有打开的文档，返回documents对象
          Dispatch docs = app.getProperty("Documents").toDispatch();
          // 调用Documents对象中Open方法打开文档，并返回打开的文档对象Document
          Dispatch doc = Dispatch.call(docs, "Open", inputFile, false, true).toDispatch();
          Dispatch.call(doc, "ExportAsFixedFormat", pdfFile, 17);// word保存为pdf格式宏，值为17
          System.out.println(doc);
          // 关闭文档
          long date2 = new Date().getTime();
          int time = (int) ((date2 - date) / 1000);
          Dispatch.call(doc, "Close", false);
          // 关闭Word应用程序
          app.invoke("Quit", 0);
          return true;
      }catch (Exception e) {
          return false;
      }
    }

    private static boolean excelToPDF(String els,String pdf){
        System.out.println("开始转换excel...");
        long start = System.currentTimeMillis();
        ActiveXComponent app = null;
        try {
            app = new ActiveXComponent("Excel.Application");
            app.setProperty("Visible", new Variant(false));
            app.setProperty("AutomationSecurity", new Variant(3)); //禁用宏
            Dispatch excels=app.getProperty("Workbooks").toDispatch();
            Dispatch excel=Dispatch.invoke(excels,"Open",Dispatch.Method,new Object[]{
                            els,
                            new Variant(false),
                            new Variant(false)
                    },
                    new int[9]).toDispatch();
            //转换格式
            Dispatch.invoke(excel,"ExportAsFixedFormat",Dispatch.Method,new Object[]{
                    new Variant(0), //PDF格式=0
                    pdf,
                    new Variant(0)  //0=标准 (生成的PDF图片不会变模糊) 1=最小文件 (生成的PDF图片糊的一塌糊涂)
            },new int[1]);
            Dispatch.call(excel, "Close",new Variant(false));
            if(app != null){
                app.invoke("Quit",new Variant[]{});
                app=null;
            }
            ComThread.Release();
            long end = System.currentTimeMillis();
            System.out.println("转换成功，用时：" + (end - start) + "ms");
            return true;
        } catch (Exception e) {
            System.out.println("转换失败:" + e.getMessage());
        }
        return false;
    }

    private static boolean pptToPDF(String inputFile, String pdfFile) {
        try {
           ComThread.InitSTA(true);
           ActiveXComponent app = new ActiveXComponent("PowerPoint.Application");
           // app.setProperty("Visible", false);
           System.out.println("开始转化PPT为PDF...");
           long date = new Date().getTime();
           Dispatch ppts = app.getProperty("Presentations").toDispatch();
           Dispatch ppt = Dispatch.call(ppts, "Open", inputFile, true,
                   //    false, // Untitled指定文件是否有标题
                   false// WithWindow指定文件是否可见
           ).toDispatch();
           Dispatch.invoke(ppt, "SaveAs", Dispatch.Method, new Object[]{
                   pdfFile, new Variant(32)}, new int[1]);
           Dispatch.call(ppt, "Close");
           app.invoke("Quit");
           return true;
        } catch (Exception e) {
           return false;
        }
    }

}
