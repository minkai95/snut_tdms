package com.snut_tdms.util;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * 将读取到的数据库内容写到Excel模板表中，供下载需要
 */
public class WriterExcelFile {

    private static final Logger LOGGER = Logger.getLogger(WriterExcelFile.class.getName());

    /**
     * 将数据写入指定path下的Excel文件中
     *      这里会有一个限制条件:列名的顺序必须和数据的存储顺序一致,否则会造成混乱;这是第一版,以后再改进这个
     * @param path 文件存储路径
     * @param name sheet名
     * @param style Excel类型
     * @param titles 标题串
     * @param values 内容集
     * @return T\F
     */
    public static boolean generateWorkbook(String path, String name, String style, List<String> titles, List<Map<String, Object>> values) throws Exception {
        Workbook workbook;
        String fileAllName = path+name+"."+style;
        File fi = new File(fileAllName);
        FileInputStream in = new FileInputStream(fi);
        if ("XLS".equals(style.toUpperCase())) {
            workbook = new HSSFWorkbook(in);
        } else {
            workbook = new XSSFWorkbook(in);
        }
        // 生成一个表格
        Sheet sheet = workbook.createSheet(name);
        // 设置表格默认列宽度为15个字节
        sheet.setDefaultColumnWidth((short) 15);
        // 生成样式
        Map<String, CellStyle> styles = createStyles(workbook);
        /*
         * 创建标题行
         */
        Row row = sheet.createRow(0);
        for (int i = 0; i < titles.size(); i++) {
            Cell cell = row.createCell(i);
            cell.setCellStyle(styles.get("header"));
            cell.setCellValue(titles.get(i));
        }
        /*
         * 写入正文
         */
        Iterator<Map<String, Object>> iterator = values.iterator();
        int index = 0;
        while (iterator.hasNext()) {
            index++;
            row = sheet.createRow(index);
            Map<String, Object> value = iterator.next();
            String content = "";
            for (Map.Entry<String, Object> map : value.entrySet()) {
                Object object = map.getValue();
                content = object.toString();
            }
            for (int i = 0; i < value.size(); i++) {
                Cell cell = row.createCell(i);
                cell.setCellStyle(styles.get("cell"));
                cell.setCellValue(content);
            }
        }
        /*
         * 写入到文件中
         */
        boolean isCorrect = false;
        File file = new File(path);
        // 如果文件存在,则删除已有的文件,重新创建一份新的
        if (file.exists()) {
            file.deleteOnExit();
            file = new File(path);
        }
        OutputStream outputStream = null;
        try {
            outputStream = new FileOutputStream(file);
            workbook.write(outputStream);
            isCorrect = true;
        } catch (IOException e) {
            LOGGER.error(e.getMessage());
        } finally {
            try {
                if (null != outputStream) {
                    outputStream.close();
                }
            } catch (IOException e) {
                LOGGER.error(e.getMessage());
            }
        }
        return isCorrect;
    }

    /**
     * Create a library of cell styles
     */
    private static Map<String, CellStyle> createStyles(Workbook wb) {
        Map<String, CellStyle> styles = new HashMap<>();
        DataFormat dataFormat = wb.createDataFormat();

        // 标题样式
        CellStyle titleStyle = wb.createCellStyle();
        titleStyle.setAlignment(HorizontalAlignment.CENTER); // 水平对齐
        titleStyle.setVerticalAlignment(VerticalAlignment.CENTER); // 垂直对齐
        titleStyle.setLocked(true);
        titleStyle.setFillForegroundColor(IndexedColors.BLUE.getIndex());
        titleStyle.setFillBackgroundColor(IndexedColors.YELLOW.getIndex());
        Font titleFont = wb.createFont();
        titleFont.setFontHeightInPoints((short) 16);
        titleFont.setBold(true);
        titleFont.setFontName("微软雅黑");
        titleStyle.setFont(titleFont);
        styles.put("title", titleStyle);

        // 文件头样式
        CellStyle headerStyle = wb.createCellStyle();
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        headerStyle.setFillForegroundColor(IndexedColors.GREY_50_PERCENT.getIndex());
        headerStyle.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setWrapText(true);
        Font headerFont = wb.createFont();
        headerFont.setFontHeightInPoints((short) 12);
        headerFont.setColor(IndexedColors.WHITE.getIndex());
        titleFont.setFontName("微软雅黑");
        headerStyle.setFont(headerFont);
        styles.put("header", headerStyle);

        // 正文样式
        CellStyle cellStyle = wb.createCellStyle();
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setVerticalAlignment(VerticalAlignment.CENTER);
        cellStyle.setWrapText(true);
        cellStyle.setBorderRight(BorderStyle.THIN);
        cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
        cellStyle.setBorderLeft(BorderStyle.THIN);
        cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        cellStyle.setBorderTop(BorderStyle.THIN);
        cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
        cellStyle.setBorderBottom(BorderStyle.THIN);
        cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        styles.put("cell", cellStyle);

        return styles;
    }
}