package com.snut_tdms.service;

import com.snut_tdms.dao.UserDao;
import com.snut_tdms.model.po.*;
import com.snut_tdms.util.FileUploadUtil;
import com.snut_tdms.util.StatusCode;
import com.snut_tdms.util.SystemUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.*;

@Service("userService")
public class UserService {
    private UserDao userDao;

    @Autowired
    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    /**
     * 用户插入日志记录
     * @param map 集合
     * @return 状态码
     */
    public StatusCode insertLog(Map<String,Object> map){
        String id = SystemUtils.getUUID();
        String content = (String) map.get("content");
        String action = (String) map.get("action");
        Timestamp time = new Timestamp(System.currentTimeMillis());
        User operationUser = userDao.selectUserByUsername(((User) map.get("operationUser")).getUsername()).getUser();
        User operatedUser = userDao.selectUserByUsername(((User) map.get("operatedUser")).getUsername()).getUser();
        String description = null;
        if(map.containsKey("description")) {
            description = (String) map.get("description");
        }
        if(userDao.insertLog(new Log(id,content,action,time,operationUser,operatedUser,description))>0){
            return StatusCode.INSERT_SUCCESS;
        }else{
            return StatusCode.INSERT_ERROR;
        }
    }

    /**
     * 上传文件
     * @param request 请求数据
     * @return 状态码
     */
    public StatusCode uploadFile(HttpServletRequest request){
        String id = SystemUtils.getUUID();
        User user = (User)request.getSession().getAttribute("user");
        Data data = new Data();
        data.setId(id);
        data.setUser(userDao.selectUserByUsername(user.getUsername()).getUser());
        data.setSubmitTime(new Timestamp(System.currentTimeMillis()));
        data.setFlag(0);
        String dataClassId = "";
        //MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
        Enumeration<String> enumeration = request.getParameterNames();  //获取请求参数的名称
        while (enumeration.hasMoreElements()) {
            String parameterName = enumeration.nextElement();   //获取请求参数的值
            switch (parameterName) {
                case "content":
                    data.setContent(request.getParameter(parameterName));
                    break;
                case "dataClassId":
                    dataClassId = request.getParameter(parameterName);
                    break;
            }
        }
        DataClass dataClass = selectDataClass(
                userDao.selectUserInfoByUsername(user.getUsername()).getDepartment().getCode(),
                userDao.selectUserByUsername(user.getUsername()).getRole().getId(),
                "(0,1)",dataClassId).get(0);
        data.setDataClass(dataClass);
        Map<String,Object> resultMap = FileUploadUtil.upload(request);
        String src = (String)resultMap.get("src");
        StatusCode message = (StatusCode)resultMap.get("message");
        String filename = src == null ? null : src.substring(src.lastIndexOf("\\") + 1);
        data.setSrc(src);
        data.setFileName(filename);
        if(message.getnCode().equals(StatusCode.FILE_UPLOAD_SUCCESS.getnCode())){
            if(userDao.insertData(data)>0){
                Map<String,Object> map = new HashMap<>();
                map.put("content","用户上传了一个文件！");
                map.put("action","insert");
                map.put("operationUser",userDao.selectUserByUsername(user.getUsername()).getUser());
                map.put("operatedUser",userDao.selectUserByUsername(user.getUsername()).getUser());
                insertLog(map);
                return StatusCode.FILE_UPLOAD_SUCCESS;
            }else{
                return StatusCode.FILE_UPLOAD_ERROR;
            }
        }else{
            return message;
        }
    }

    /**
     * 新增资料类型(申请/直接添加)
     * @param dataClass 资料类型
     * @param departmentCode 院系编码
     * @param operationUser 操作用户
     * @return 状态码
     */
    public StatusCode insertDataClass(DataClass dataClass,String departmentCode,User operationUser){
        List<DataClass> dataClassList = selectDataClass(departmentCode,"","(0,1,2)","");
        List<String> list = new ArrayList<>();
        for (DataClass d: dataClassList) {
            if(d!=null){
                list.add(d.getName());
            }
        }
        if(!list.contains(dataClass.getName())) {
            if (userDao.insertDataClass(dataClass) > 0) {
                Map<String,Object> map = new HashMap<>();
                map.put("action","insert");
                map.put("operationUser",operationUser);
                map.put("operatedUser",dataClass.getUser());
                if(dataClass.getFlag()==0){
                    map.put("content","用户申请新增类目！");
                    insertLog(map);
                    return StatusCode.APPLY_SUCCESS;
                }else if (dataClass.getFlag()==1){
                    map.put("content","管理员新增了一条类目！");
                    insertLog(map);
                    return StatusCode.INSERT_SUCCESS;
                }
            } else {
                return StatusCode.APPLY_ERROR;
            }
        }else{
            return StatusCode.DATA_CLASS_ERROR;
        }
        return StatusCode.INSERT_ERROR;
    }

    public Integer logicalDeleteDataByIds(List<String> idList, Map<String,Object> map){
        StringBuffer sb = new StringBuffer();
        String[] strArr = idList.toArray(new String[idList.size()]);
        String str = Arrays.toString(strArr);
        sb.append("(");
        sb.append(str.substring(1,str.length()-1));
        sb.append(")");
        Map<String,Object> m = new HashMap<>();
        m.put("ids",sb.toString());
        int count = userDao.logicalDeleteDataByIds(m);
        if(count>0){
            map.put("content","用户逻辑删除了"+count+"份资料！");
            map.put("action","logicalDelete");
            insertLog(map);
        }
        return count;
    }

    /**
     * 用户更新密码
     * @param user 用户对象
     * @return 状态码
     */
    public StatusCode updatePassword(User user,User operationUser){
        if((userDao.selectUserByUsername(user.getUsername())).getUser().getPassword().equals(user.getPassword())){
            return StatusCode.NEW_PASSWORD_EQUALS_OLD;
        }else {
            String password = user.getPassword();
            user = userDao.selectUserByUsername(user.getUsername()).getUser();
            user.setPassword(password);
            if (userDao.updatePassword(user) > 0) {
                Map<String,Object> map = new HashMap<>();
                map.put("action","update");
                map.put("content","用户更新了密码");
                map.put("operationUser",operationUser);
                map.put("operatedUser",userDao.selectUserByUsername(user.getUsername()).getUser());
                insertLog(map);
                return StatusCode.UPDATE_SUCCESS;
            } else {
                return StatusCode.UPDATE_ERROR;
            }
        }
    }

    /**
     * 用户更新个人信息
     * @param userInfo 用户信息
     * @return 状态码
     */
    public StatusCode updateUserInfo(UserInfo userInfo,User operationUser){
        if(!userInfo.equals(userDao.selectUserInfoByUsername(userInfo.getUser().getUsername()))) {
            if (userDao.updateUserInfo(userInfo) > 0) {
                Map<String,Object> map = new HashMap<>();
                map.put("action","update");
                map.put("content","用户更新了个人信息");
                map.put("operationUser",operationUser);
                map.put("operatedUser",userDao.selectUserByUsername(userInfo.getUser().getUsername()).getUser());
                insertLog(map);
                return StatusCode.UPDATE_SUCCESS;
            } else {
                return StatusCode.UPDATE_ERROR;
            }
        }else{
            return StatusCode.UPDATE_NOT;
        }
    }

    /**
     * 用户登录功能
     * @param username 用户名
     * @param password 密码
     * @return Map
     */
    public Map<String, Object> userLogin(String username,String password){
        Map<String,Object> map = new HashMap<>();
        UserRole userRole = userDao.selectUserByUsername(username);
        if(userRole != null){
            if(userRole.getUser().getPassword().equals(password)){
                Map<String,Object> m = new HashMap<>();
                m.put("action","login");
                m.put("content","用户登录了");
                m.put("operationUser",userRole.getUser());
                m.put("operatedUser",userRole.getUser());
                insertLog(m);
                map.put("StatusCode",StatusCode.LOGIN_SUCCESS);
                map.put("userRole",userRole);
            }else{
                map.put("StatusCode",StatusCode.PASSWORD_ERROR);
            }
        }else{
            map.put("StatusCode",StatusCode.NOT_USER);
        }
        return map;
    }

    /**
     * 查询本院公告(roleId为空表示查看所有公告)
     * @param departmentCode 院系编码
     * @param roleId 角色ID
     * @return List
     */
    public List<SystemNotice> selectSystemNotice(String departmentCode,String roleId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentCode",departmentCode);
        map.put("roleId",roleId);
        return userDao.selectSystemNotice(map);
    }

    /**
     * 查询本院公共资料类型,如果roleId为空则查询本院所有公共资料类型
     * @param departmentCode 院系编码
     * @param roleId 角色ID
     * @param flag 备注
     * @param dataClassId 资料类型ID
     * @return List
     */
    public List<DataClass> selectDataClass(String departmentCode,String roleId,String flag,String dataClassId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentCode",departmentCode);
        map.put("roleId",roleId);
        map.put("flag",flag);
        map.put("dataClassId",dataClassId);
        return userDao.selectDataClass(map);
    }

    /**
     * 根据用户名查询用户资料
     * @param username 用户名
     * @return UserInfo
     */
    public UserInfo selectUserInfoByUsername(String username){
        return userDao.selectUserInfoByUsername(username);
    }

    /**
     * 查询用户自己的资料
     * @param username 用户名
     * @return List
     */
    public List<Data> selectDataByUsername(String username,String dataClassId){
        Map<String,Object> map = new HashMap<>();
        map.put("username",username);
        map.put("dataClassId",dataClassId);
        return userDao.selectDataByParams(map);
    }

    /**
     * 根据ID查询资料类型下的子分类
     * @param dataClassId 类型ID
     * @return list
     */
    public  List<ClassType> selectClassTypesByDataClassId(String dataClassId){
        return userDao.selectClassTypesByDataClassId(dataClassId);
    }

    /**
     * 查询所有院系
     * @return list
     */
    public List<Department> selectAllDepartment(){
        return userDao.selectAllDepartment();
    }

    /**
     * 根据院系编码查询院系
     * @param departmentCode 院系编码
     * @return Department
     */
    public Department selectDepartmentByCode(String departmentCode){
        return userDao.selectDepartmentByCode(departmentCode);
    }

}
