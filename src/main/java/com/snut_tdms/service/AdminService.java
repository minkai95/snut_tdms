package com.snut_tdms.service;

import com.snut_tdms.dao.AdminDao;
import com.snut_tdms.dao.UserDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 管理员service层
 * Created by huankai on 2018/3/27.
 */
@Service("adminService")
public class AdminService extends UserService{

    private AdminDao adminDao;
    private UserDao userDao;

    @Autowired
    public AdminService(AdminDao adminDao, UserDao userDao) {
        super(userDao);
        this.adminDao = adminDao;
        this.userDao = userDao;
    }

    /**
     * 通过id删除资料
     * @param idList id列表
     * @param map 插入日志的数据
     * @return 成功删除条数
     */
    public Integer deleteDataByIds(List<String> idList, Map<String,Object> map){
        StringBuffer sb = new StringBuffer();
        String[] strArr = idList.toArray(new String[idList.size()]);
        String str = Arrays.toString(strArr);
        sb.append("(");
        sb.append(str.substring(1,str.length()-1));
        sb.append(")");
        Map<String,Object> m = new HashMap<>();
        m.put("ids",sb.toString());
        int count = adminDao.deleteDataByIds(m);
        if(count>0){
            map.put("content","管理员彻底删除了"+count+"份资料！");
            insertLog(map);
        }
        return count;
    }
}
