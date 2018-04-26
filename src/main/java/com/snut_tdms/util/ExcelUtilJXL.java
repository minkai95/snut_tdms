package com.snut_tdms.util;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import java.io.File;
import java.util.List;

/**
 * 用JXL的方式实现对EXCEL文件的读写
 * Created by huankai on 2018/4/26.
 */
public class ExcelUtilJXL {

    public static boolean createExcel(String path, String name, String style, List<String> titles, List<List<String>> values){
        boolean result = false;

        File file = new File(path+name+"."+style);
        try {
            if (!file.exists() || !file.isFile()) {
                file.createNewFile();
            }
            WritableWorkbook workbook = Workbook.createWorkbook(file);
            WritableSheet sheet = workbook.createSheet("sheet111",0);
            Label label = null;
            // 写入表头
            for(int i =0;i<titles.size();i++){
                label = new Label(i,0,titles.get(i));
                sheet.addCell(label);
            }
            // 写入数据
            for (int i=0;i<values.size();i++){
                List<String> list = values.get(i);
                for (int j=0;j<list.size();j++){
                    label = new Label(j,i+1,list.get(j));
                    sheet.addCell(label);
                }
            }
            workbook.write();
            workbook.close();
            result = true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

    public static boolean readExcel(String path, String name, String style) {
        boolean result = false;
        try {
            Workbook workbook = Workbook.getWorkbook(new File(path + name + "." + style));
            Sheet sheet = workbook.getSheet(0);
            for (int i =0;i<sheet.getRows();i++){
                for (int j=0;j<sheet.getColumns();j++){
                    Cell cell = sheet.getCell(j,i);
                    System.out.print(cell.getContents());
                    if ("".equals(cell.getContents())||cell.getContents()==null){
                        System.out.print("null");
                    }
                }
                System.out.println();
            }
            workbook.close();
            result = true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return result;
    }

}
