package com.snut_tdms.util;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 文件上传工具类
 * Created by huankai on 2018/3/25.
 */
public class FileUploadUtil {

    public static  Map<String,Object> upload(HttpServletRequest request){
        //得到上传文件的保存目录，将上传的文件存放于WEB-INF目录下，不允许外界直接访问，保证上传文件的安全
        String savePath = request.getServletContext().getRealPath("\\WEB-INF\\upload");
        //上传时生成的临时文件保存目录
        String tempPath = request.getServletContext().getRealPath("\\WEB-INF\\temp");
        String departmentCode = (String) request.getAttribute("departmentCode");
        File tmpFile = new File(tempPath);
        if (!tmpFile.exists()) {
            //创建临时目录
            boolean tmpSrc = tmpFile.mkdir();
        }
        Map<String,Object> map = new HashMap<>();
        try {
            //使用Apache文件上传组件处理文件上传步骤：
            //1、创建一个DiskFileItemFactory工厂
            DiskFileItemFactory factory = new DiskFileItemFactory();
            //设置工厂的缓冲区的大小，当上传的文件大小超过缓冲区的大小时，就会生成一个临时文件存放到指定的临时目录当中。
            factory.setSizeThreshold(1024*100);//设置缓冲区的大小为100KB，如果不指定，那么缓冲区的大小默认是10KB
            //设置上传时生成的临时文件的保存目录
            factory.setRepository(tmpFile);
            //2、创建一个文件上传解析器
            ServletFileUpload upload = new ServletFileUpload(factory);
            //监听文件上传进度
            upload.setProgressListener(new ProgressListener(){
                public void update(long pBytesRead, long pContentLength, int arg2) {
                    System.out.println("文件大小为：" + pContentLength + ",当前已处理：" + pBytesRead);
                    /*
                     * 文件大小为：14608,当前已处理：4096
                     * 文件大小为：14608,当前已处理：7367
                     * 文件大小为：14608,当前已处理：11419
                     * 文件大小为：14608,当前已处理：14608
                     */
                }
            });
            //解决上传文件名的中文乱码
            upload.setHeaderEncoding("UTF-8");
            //3、判断提交上来的数据是否是上传表单的数据
            if(!ServletFileUpload.isMultipartContent(request)){
                //按照传统方式获取数据
                return map;
            }
            //设置上传单个文件的大小的最大值，目前是设置为1024*1024*10字节，也就是10MB
            upload.setFileSizeMax(1024*1024*10);
            //设置上传文件总量的最大值，最大值=同时上传的多个文件的大小的最大值的和，目前设置为30MB
            upload.setSizeMax(1024*1024*30);
            //4、使用ServletFileUpload解析器解析上传数据，解析结果返回的是一个List<FileItem>集合，每一个FileItem对应一个Form表单的输入项
            List<FileItem> list = upload.parseRequest(request);
            for(FileItem item : list){
            //如果fileitem中封装的是普通输入项的数据
                if(item.isFormField()){
                    String name = item.getFieldName();
                    //解决普通输入项的数据的中文乱码问题
                    String value = item.getString("UTF-8");
                    //value = new String(value.getBytes("iso8859-1"),"UTF-8");
                    System.out.println(name + "=" + value);
                } else {//如果fileitem中封装的是上传文件
                    // 得到上传的文件名称，
                    String filename = item.getName();
                    System.out.println(filename);
                    if(filename==null || filename.trim().equals("")){
                        continue;
                    }
                    //注意：不同的浏览器提交的文件名是不一样的，有些浏览器提交上来的文件名是带有路径的，如：  c:\a\b\1.txt，而有些只是单纯的文件名，如：1.txt
                    //处理获取到的上传文件的文件名的路径部分，只保留文件名部分
                    filename = filename.substring(filename.lastIndexOf("\\")+1);
                    //得到上传文件的扩展名
                    String fileExtName = filename.substring(filename.lastIndexOf(".")+1);
                    //如果需要限制上传的文件类型，那么可以通过文件的扩展名来判断上传的文件类型是否合法
                    System.out.println("上传的文件的扩展名是："+fileExtName);
                    List<String> fileFormat = new ArrayList<>();
                    fileFormat.add("txt");
                    fileFormat.add("pdf");
                    fileFormat.add("ppt");
                    fileFormat.add("pptx");
                    fileFormat.add("doc");
                    fileFormat.add("docx");
                    fileFormat.add("xls");
                    fileFormat.add("xlsx");
                    fileFormat.add("png");
                    fileFormat.add("jpg");
                    fileFormat.add("jpeg");
                    if(!fileFormat.contains(fileExtName.toLowerCase())){
                        map.put("message",StatusCode.FILE_FORMAT_ERROR);
                        break;
                    }
                    //获取item中的上传文件的输入流
                    InputStream in = item.getInputStream();
                    //得到文件保存的名称
                    String saveFilename = makeFileName(filename,request);
                    //得到文件的保存目录
                    String realSavePath = makePath(saveFilename, savePath,departmentCode);
                    //创建一个文件输出流
                    FileOutputStream out = new FileOutputStream(realSavePath + "\\" + saveFilename);
                    //创建一个缓冲区
                    byte buffer[] = new byte[1024];
                    //判断输入流中的数据是否已经读完的标识
                    int len = 0;
                    //循环将输入流读入到缓冲区当中，(len=in.read(buffer))>0就表示in里面还有数据
                    while((len = in.read(buffer))>0){
                        //使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath + "\\" + filename)当中
                        out.write(buffer, 0, len);
                    }
                    //关闭输入流
                    in.close();
                    //关闭输出流
                    out.close();
                    //删除处理文件上传时生成的临时文件
                    //item.delete();
                    map.put("message",StatusCode.FILE_UPLOAD_SUCCESS);
                    map.put("src",realSavePath);
                    map.put("filename",filename);
                }
            }
        }catch (FileUploadBase.FileSizeLimitExceededException e) {
            e.printStackTrace();
            map.put("message", StatusCode.FILE_BIG);
        }catch (FileUploadBase.SizeLimitExceededException e) {
            e.printStackTrace();
            map.put("message",StatusCode.FILE_ALL_BIG);
        }catch (Exception e) {
            map.put("message",StatusCode.FILE_UPLOAD_ERROR);
            e.printStackTrace();
        }
        if(!map.containsKey("src")){
            map.put("src",null);
        }
        if(!map.containsKey("filename")){
            map.put("filename",null);
        }
        return map;
    }

    /**
     * 防止文件名重复
     * @param fileName 文件名
     * @return String
     */
    private static String makeFileName(String fileName,HttpServletRequest request){
        return request.getAttribute("id")+"_"+fileName;
    }

    /**
     * 防止一个目录下面出现太多文件，要使用hash算法打散存储
     * @param filename 文件名，要根据文件名生成存储目录
     * @param savePath 文件存储路径
     * @return String
     */
    private static String makePath(String filename,String savePath,String departmentCode){
        int hashcode = filename.hashCode();
        int dir1 = hashcode & 0xf;  //0--15
        int dir2 = (hashcode & 0xf0)>>4;  //0-15
        String dir = savePath + "\\" + departmentCode + "\\" + dir1 + "\\" + dir2;  //upload\2\3  upload\3\5
        File fileDir = new File(dir);
        if(!fileDir.exists()){
            boolean mkdirs = fileDir.mkdirs();
        }
        return dir;
    }

}
