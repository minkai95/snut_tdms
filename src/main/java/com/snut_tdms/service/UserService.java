package com.snut_tdms.service;

import com.snut_tdms.dao.UserDao;
import com.snut_tdms.model.po.*;
import com.snut_tdms.util.FileUploadUtil;
import com.snut_tdms.util.StatusCode;
import com.snut_tdms.util.SystemUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
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
        request.setAttribute("id",id);
        User user = ((UserInfo)request.getSession().getAttribute("userInfo")).getUser();
        Data data = new Data();
        data.setId(id);
        data.setUser(userDao.selectUserByUsername(user.getUsername()).getUser());
        data.setSubmitTime(new Timestamp(System.currentTimeMillis()));
        data.setFlag(0);
        String dataClassId = (String) request.getAttribute("fileType");
        String content = request.getParameter("description");
        data.setContent(content);
        String departmentCode = userDao.selectUserInfoByUsername(user.getUsername()).getDepartment().getCode();
        DataClass dataClass = selectDataClass(departmentCode,
                null,
                null,dataClassId).get(0);
        data.setDataClass(dataClass);
        request.setAttribute("departmentCode",selectUserInfoByUsername(user.getUsername()).getDepartment().getCode());
        Map<String,Object> resultMap = FileUploadUtil.upload(request);
        StatusCode message = (StatusCode)resultMap.get("message");
        data.setSrc((String)resultMap.get("src"));
        data.setFileName(id+"_"+ resultMap.get("filename"));
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

    /**
     * 彻底删除单个文件
     * @param data 要删除的文件
     * @param description 删除描述(原因)
     * @return 单个文件删除成功返回true，否则返回false
     */
    public StatusCode deleteFile(Data data,String description,User operationUser) {
        File file = new File(data.getSrc()+"\\"+data.getFileName());
        // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
        if (file.exists() && file.isFile()) {
            Map<String,Object> map = new HashMap<>();
            map.put("action","delete");
            map.put("operationUser",operationUser);
            map.put("operatedUser",data.getUser());
            map.put("description",description);
            List<String> ids = new ArrayList<>();
            ids.add(data.getId());
            if (file.delete()&&deleteDataByIds(ids,map,data)>0) {
                System.out.println("删除文件" + data.getFileName() + "成功！");
                return StatusCode.DELETE_SUCCESS;
            } else {
                System.out.println("删除文件" + data.getFileName() + "失败！");
                return StatusCode.DELETE_ERROR;
            }
        } else {
            System.out.println("删除文件失败：" + data.getFileName() + "不存在！");
            return StatusCode.DELETE_ERROR_NOT_FILE;
        }
    }

    /**
     * 通过id删除资料
     * @param idList id列表
     * @param map 插入日志的数据
     * @return 成功删除条数
     */
    public Integer deleteDataByIds(List<String> idList, Map<String,Object> map,Data data){
        StringBuffer sb = new StringBuffer();
        String[] strArr = idList.toArray(new String[idList.size()]);
        String str = Arrays.toString(strArr);
        sb.append("(");
        int c = 0;
        for (String s:strArr) {
            sb.append("'"+s+"'");
            if(c++>0){
                sb.append(",");
            }
        }
        sb.append(")");
        Map<String,Object> m = new HashMap<>();
        m.put("ids",sb.toString());
        int flag = data.getDataClass().getFlag();
        int count = userDao.deleteDataByIds(m);
        if(count>0){
            if (flag==2) {
                map.put("content", selectUserInfoByUsername(((User) map.get("operationUser")).getUsername()).getName() + "彻底删除了" + count + "份私人资料！");
            }else {
                map.put("content", selectUserInfoByUsername(((User) map.get("operationUser")).getUsername()).getName() + "彻底删除了" + count + "份公共资料！");
            }
            insertLog(map);
        }
        return count;
    }

    /**
     * 逻辑删除文件
     * @param idList id
     * @param operationUser 操作者
     * @param description 描述
     * @return 成功删除数量
     */
    public Integer logicalDeleteDataByIds(List<String> idList,User operationUser,String description){
        Map<String,Object> map = new HashMap<>();
        StringBuffer sb = new StringBuffer();
        String[] strArr = idList.toArray(new String[idList.size()]);
        String str = Arrays.toString(strArr);
        sb.append("(");
        int c = 0;
        for (String s:strArr) {
            sb.append("'"+s+"'");
            if(c++>0){
                sb.append(",");
            }
        }
        sb.append(")");
        Map<String,Object> m = new HashMap<>();
        m.put("ids",sb.toString());
        m.put("deleteTime",new Timestamp(System.currentTimeMillis()));
        map.put("content","逻辑删除了一份资料！");
        map.put("action","logicalDelete");
        map.put("operationUser",operationUser);
        map.put("description",description);
        int count = userDao.logicalDeleteDataByIds(m);
        if(count>0){
            for (String id: idList) {
                Data data = userDao.selectDataById(id);
                if (data != null){
                    map.put("operatedUser",data.getUser());
                }
                insertLog(map);
            }
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
                map.put("content","更新了用户的个人信息!");
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
     * 重置用户密码
     * @param username 被操作者用户名
     * @param operationUser 操作者
     * @return 状态码
     */
    public StatusCode resetAdminPassword(String username,User operationUser){
        StatusCode code;
        if(selectUserInfoByUsername(username)==null){
            code = StatusCode.NOT_USER;
        }else if (userDao.resetAdminPassword(username)>0){
            code = StatusCode.UPDATE_SUCCESS;
            Map<String, Object> logParams = new HashMap<>();
            logParams.put("content", "重置了用户名:"+username+" 的用户密码!");
            logParams.put("action", "update");
            logParams.put("operationUser", operationUser);
            logParams.put("operatedUser", selectUserInfoByUsername(username).getUser());
            insertLog(logParams);
        }else{
            code = StatusCode.UPDATE_ERROR;
        }
        return code;
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
     * 查询本院资料类型,如果roleId为空则查询本院所有资料类型
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
     * 根据用户名查询用户角色
     * @param username 用户名
     * @return UserRole对象
     */
    public UserRole selectUserRoleByUsername(String username){
        return userDao.selectUserByUsername(username);
    }

    /**
     * 查询用户自己的资料(公共/私有)
     * @param username 用户名
     * @return List
     */
    public List<Data> selectDataByParams(String username,String dataClassId,Integer dataFlag,Integer dataClassFlag,String dataId){
        Map<String,Object> map = new HashMap<>();
        map.put("username",username);
        map.put("dataClassId",dataClassId);
        map.put("dataFlag",String.valueOf(dataFlag));
        map.put("dataClassFlag",String.valueOf(dataClassFlag));
        map.put("dataId",dataId);
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

    /**
     * 通过ID查询角色对象
     * @param roleId 角色ID
     * @return role
     */
    public Role selectRoleById(String roleId){
        return userDao.selectRoleById(roleId);
    }

    /**
     * 查询所有角色对象
     * @return list
     */
    public List<Role> selectAllRole(){
        return userDao.selectAllRole();
    }

    /**
     * 查询本院系各个角色资料类目总数
     * @param departmentCode 院系编码
     * @param roleId 角色ID
     * @return 数目
     */
    public Integer selectDepartmentDataClassCount(String departmentCode,String roleId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentCode",departmentCode);
        map.put("roleId",roleId);
        return userDao.selectDepartmentDataClassCount(map);
    }

    /**
     * 通过ID查询数据
     * @param dataId ID
     * @return Data
     */
    public Data selectDataById(String dataId){
        return userDao.selectDataById(dataId);
    }

    /**
     * 查询本院系所有消息公告条数
     * @param departmentCode 院系编码
     * @return 数目
     */
    public Integer selectAllNoticeCount(String departmentCode){
        return userDao.selectAllNoticeCount(departmentCode);
    }

    /**
     * 查询用户的所有被操作的日志记录
     * @param username 用户名
     * @return list
     */
    public List<Log> selectPersonLogs(String username){
        return userDao.selectPersonLogs(username);
    }
}
