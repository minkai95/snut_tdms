package com.snut_tdms.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

/**
 * 文件下载工具类
 * Created by huankai on 2018/3/25.
 */
public class FileDownloadUtil {

    public static String selectFile(HttpServletRequest request){
        //得到要下载的文件名
        String fileName = (String) request.getAttribute("filename");  //bd3256e4650b42ca4b77a70e435b7fca_阿凡达.doc
        //fileName = new String(fileName.getBytes("UTF-8"),"iso8859-1");
        String departmentCode = (String) request.getAttribute("departmentCode");
        //上传的文件都是保存在/WEB-INF/upload目录下的子目录当中
        String fileSaveRootPath = request.getServletContext().getRealPath("\\WEB-INF\\upload\\"+departmentCode);
        //通过文件名找出文件的所在目录
        String path = path = findFileSavePathByFileName(fileName,fileSaveRootPath);
        //得到要下载的文件
        String realType = (String) request.getAttribute("realType");
        if (realType!=null && !realType.equals(fileName.substring(fileName.lastIndexOf(".")+1))){
            fileName = fileName.substring(0,fileName.lastIndexOf("."))+"."+realType;
        }
        File file = new File(path + "\\" + fileName);
        //如果文件不存在
        if(!file.exists()){
            return StatusCode.FILE_DELETE.getnCode();
        }else {
            return path;
        }
    }

    public static StatusCode download(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //得到要下载的文件名
        String fileName = (String) request.getAttribute("filename");  //bd3256e4650b42ca4b77a70e435b7fca_阿凡达.doc
        //fileName = new String(fileName.getBytes("UTF-8"),"iso8859-1");
        String departmentCode = (String) request.getAttribute("departmentCode");
        //上传的文件都是保存在/WEB-INF/upload目录下的子目录当中
        String fileSaveRootPath = request.getServletContext().getRealPath("\\WEB-INF\\upload\\"+departmentCode);
        //通过文件名找出文件的所在目录
        String path = findFileSavePathByFileName(fileName,fileSaveRootPath);
        //得到要下载的文件
        File file = new File(path + "\\" + fileName);
        //如果文件不存在
        if(!file.exists()){
            return StatusCode.FILE_DELETE;
        }
        //处理文件名
        String realName = fileName.substring(fileName.indexOf("_")+1);
        //设置响应头，控制浏览器下载该文件
        response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(realName, "UTF-8"));
        //读取要下载的文件，保存到文件输入流
        FileInputStream in = new FileInputStream(path + "\\" + fileName);
        //创建输出流
        OutputStream out = response.getOutputStream();
        //创建缓冲区
        byte buffer[] = new byte[1024];
        int len = 0;
        //循环将输入流中的内容读取到缓冲区当中
        while((len=in.read(buffer))>0){
            //输出缓冲区的内容到浏览器，实现文件下载
            out.write(buffer, 0, len);
        }
        //关闭文件输入流
        in.close();
        //关闭输出流
        out.close();
        return StatusCode.FILE_DOWNLOAD_SUCCESS;
    }


    private static String findFileSavePathByFileName(String filename,String saveRootPath){
         int hashcode = filename.hashCode();
         int dir1 = hashcode&0xf;  //0--15
         int dir2 = (hashcode&0xf0)>>4;  //0-15
         String dir = saveRootPath + "\\" + dir1 + "\\" + dir2;  //upload\2\3  upload\3\5
         File file = new File(dir);
         if(!file.exists()){
             //创建目录
             file.mkdirs();
         }
         return dir;
    }

}
