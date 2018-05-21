package com.snut_tdms.util;

import com.snut_tdms.model.po.Data;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * 用POI的方式实现对EXCEL文件的读写
 * Created by huankai on 2018/4/26.
 */
public class ExcelUtilPOI {

    public static boolean createExcel(String rootPath,String departmentCode,String name, String style, List<String> titles, List<List<String>> values) {
        boolean result = false;
        //得到上传文件的保存目录，将上传的文件存放于WEB-INF目录下，不允许外界直接访问，保证上传文件的安全
        String savePath = rootPath+"\\snut_tdms\\WEB-INF\\backups";
        String path = savePath+"\\"+departmentCode;
        // 创建工作簿
        Workbook workbook;
        if ("XLS".equals(style.toUpperCase())){
            workbook = new HSSFWorkbook();
        }else {
            workbook = new XSSFWorkbook();
        }
        // 创建sheet页
        Sheet sheet = workbook.createSheet();
        // 设置表格默认列宽度为15个字节
        sheet.setDefaultColumnWidth((short) 15);
        // 创建第一行
        Row row = sheet.createRow(0);
        // 单元格
        Cell cell = null;
        // 初始化第一行
        for (int i=0;i<titles.size();i++){
            cell = row.createCell(i);
            cell.setCellValue(titles.get(i));
        }
        // 追加数据
        for (int i=0;i<values.size();i++){
            Row rowContent = sheet.createRow(i+1);
            Cell cellContent;
            for (int j=0;j<values.get(i).size();j++){
                cellContent = rowContent.createCell(j);
                cellContent.setCellValue(values.get(i).get(j));
            }
        }
        // 创建文件并写入数据
        File file = new File(path+"\\"+name+"."+style);
        try {
            if (!file.isFile()||!file.exists()){
                File src = new File(path);
                if (!src.exists() || !src.isDirectory()){
                    boolean a = src.mkdirs();
                    System.out.println(a);
                }
                file.createNewFile();
            }
            FileOutputStream stream = new FileOutputStream(file);
            workbook.write(stream);
            stream.close();
            workbook.close();
            result = true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    public static List<List<String>> readExcel(String path, String name, String style) {
        List<List<String>> result = null;
        File file = new File(path+name+"."+style);
        try{
            // 创建工作表
            Workbook workbook;
            if ("XLS".equals(style.toUpperCase())){
                workbook = new HSSFWorkbook(FileUtils.openInputStream(file));
            }else {
                workbook = new XSSFWorkbook(FileUtils.openInputStream(file));
            }
            // 读取第一张sheet
            Sheet sheet = workbook.getSheetAt(0);
            result = new ArrayList<>();
            // 读取每一行
            Data data;
            for (int i =1;i<=sheet.getLastRowNum();i++){
                Row row = sheet.getRow(i);
                List<String> strList = new ArrayList<>();
                for(int j=0;j<row.getLastCellNum();j++){
                    Cell cell = row.getCell(j);
                    if (cell!=null && !"".equals(cell.getStringCellValue())) {
                        strList.add(cell.getStringCellValue());
                    }else {
                        strList.add(null);
                    }
                }
                result.add(strList);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

}
