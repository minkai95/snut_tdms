package com.snut_tdms.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

/**
 * 文件复制
 * Created by huankai on 2018/4/26.
 */
public class CopyFile {
    public static int c = 0;

    public static Integer copy(File[] fl, File file) {
        if (!file.exists()) { // 如果文件夹不存在
            file.mkdirs();// 建立新的文件夹
        }
        for (int i = 0; i < fl.length; i++) {
            if (fl[i].isFile()) { // 如果是文件类型就复制文件
                try {
                    FileInputStream fis = new FileInputStream(fl[i]);
                    FileOutputStream out = new FileOutputStream(new File(file.getPath() + File.separator + fl[i].getName()));
                    int count = fis.available();
                    byte[] data = new byte[count];
                    if ((fis.read(data)) != -1) {
                        out.write(data); // 复制文件内容
                    }
                    c++;
                    out.close(); // 关闭输出流
                    fis.close(); // 关闭输入流
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }else if (fl[i].isDirectory()) { // 如果是文件夹类型
                File des = new File(file.getPath() + File.separator + fl[i].getName());
                des.mkdir(); // 在目标文件夹中创建相同的文件夹
                copy(fl[i].listFiles(), des); // 递归调用方法本身
            }
        }
        return c;
    }

}