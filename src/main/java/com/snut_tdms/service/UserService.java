package com.snut_tdms.service;

import com.snut_tdms.controller.UserController;
import com.snut_tdms.dao.UserDao;
import com.snut_tdms.model.po.*;
import com.snut_tdms.model.vo.*;
import com.snut_tdms.util.*;
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
        String operatedId = (String) map.get("operatedId");
        String operatedType = (String) map.get("operatedType");
        Timestamp time = new Timestamp(System.currentTimeMillis());
        User operationUser =null;
        if (map.get("operationUser")!=null && ((User) map.get("operationUser")).getUsername()!=null) {
            operationUser = userDao.selectUserByUsername(((User) map.get("operationUser")).getUsername()).getUser();
        }
        String description = null;
        if(map.containsKey("description")) {
            description = (String) map.get("description");
        }
        if(userDao.insertLog(new Log(id,content,action,time,operationUser,operatedId,operatedType,description))>0){
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
        data.setTypeContents(request.getParameter("typeContentStr"));
        DataClass dataClass = selectDataClassById(dataClassId);
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
                map.put("action", LogActionType.INSERT.getnCode());
                map.put("operationUser",userDao.selectUserByUsername(user.getUsername()).getUser());
                map.put("operatedId",id);
                map.put("operatedType", OperatedType.FILE.getnCode());
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
        List<DataClass> dataClassList = selectDataClass(departmentCode,"(0,1,2)","",null);
        List<String> list = new ArrayList<>();
        for (DataClass d: dataClassList) {
            if(d!=null){
                list.add(d.getName());
            }
        }
        if(!list.contains(dataClass.getName())) {
            if (userDao.insertDataClass(dataClass) > 0) {
                Map<String,Object> map = new HashMap<>();
                map.put("action",LogActionType.INSERT.getnCode());
                map.put("operationUser",operationUser);
                map.put("operatedId",dataClass.getId());
                map.put("operatedType",OperatedType.FILE_TYPE.getnCode());
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
     * 彻底删除文件
     * @param dataList 要删除的文件
     * @param description 删除描述(原因)
     * @return 单个文件删除成功返回true，否则返回false
     */
    public StatusCode deleteFile(List<Data> dataList,String description,User operationUser) {
        Map<String,Object> map = new HashMap<>();
        int count = 0;
        int deleteSuf = 0;
        for (Data data:dataList) {
            List<String> idList = new ArrayList<>();
            idList.add(data.getId());
            map.put("action",LogActionType.DELETE.getnCode());
            map.put("operationUser",operationUser);
            map.put("operatedId",data.getId());
            map.put("operatedType",OperatedType.FILE.getnCode());
            map.put("description",description);
            count += deleteDataByIds(idList,map);
            File file = new File(data.getSrc()+"\\"+data.getFileName());
            // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
            if (file.exists() & file.isFile() & file.delete()) {
                deleteSuf++;
            }
        }
        if (deleteSuf==0){
            return StatusCode.DELETE_ERROR_NOT_FILE;
        }else if (deleteSuf>0 && count>0){
            return StatusCode.DELETE_SUCCESS;
        }else {
            return StatusCode.DELETE_ERROR;
        }
    }

    /**
     * 通过id删除资料
     * @param idList id列表
     * @param map 插入日志的数据
     * @return 成功删除条数
     */
    private Integer deleteDataByIds(List<String> idList, Map<String,Object> map){
        List<Data> dataList = new ArrayList<>();
        for (String id:idList) {
            if (selectDataById(id)!=null){
                dataList.add(selectDataById(id));
            }
        }
        int count = 0;
        for (Data data:dataList) {
            int flag = data.getDataClass().getFlag();
            Map<String,Object> params = new HashMap<>();
            params.put("id",data.getId());
            params.put("deleteTime",new Timestamp(System.currentTimeMillis()));
            if (userDao.deleteDataById(params)>0) {
                ++count;
                if (flag == 2) {
                    map.put("content", selectUserInfoByUsername(((User) map.get("operationUser")).getUsername()).getName() + "彻底删除了" + count + "份私人资料！");
                } else {
                    map.put("content", selectUserInfoByUsername(((User) map.get("operationUser")).getUsername()).getName() + "彻底删除了" + count + "份公共资料！");
                }
                insertLog(map);
            }
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
        StringBuilder sb = new StringBuilder();
        String[] strArr = idList.toArray(new String[idList.size()]);
        sb.append("(");
        int c = 0;
        for (String s:strArr) {
            if(c++>0){
                sb.append(",");
            }
            sb.append("'").append(s).append("'");
        }
        sb.append(")");
        Map<String,Object> m = new HashMap<>();
        m.put("ids",sb.toString());
        m.put("deleteTime",new Timestamp(System.currentTimeMillis()));
        map.put("content","逻辑删除了一份资料！");
        map.put("action",LogActionType.LOGICAL_DELETE.getnCode());
        map.put("operationUser",operationUser);
        map.put("operatedType",OperatedType.FILE.getnCode());
        map.put("description",description);
        int count = userDao.logicalDeleteDataByIds(m);
        if(count>0){
            for (String id: idList) {
                Data data = userDao.selectDataById(id);
                if (data != null){
                    map.put("operatedId",data.getId());
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
                map.put("action",LogActionType.UPDATE.getnCode());
                map.put("content","用户更新了密码");
                map.put("operationUser",operationUser);
                map.put("operatedId",user.getUsername());
                map.put("operatedType",OperatedType.USER.getnCode());
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
    public StatusCode updateUserInfo(UserInfo userInfo,UserRole userRole,User operationUser){
        if(!userInfo.equals(userDao.selectUserInfoByUsername(userInfo.getUser().getUsername()))
                || !userRole.equals(selectUserRoleByUsername(userInfo.getUser().getUsername()))) {
            if (userDao.updateUserInfo(userInfo) > 0 | userDao.updateUserRole(userRole)>0 | userDao.updateUser(userInfo.getUser())>0) {
                Map<String,Object> map = new HashMap<>();
                map.put("action",LogActionType.UPDATE.getnCode());
                map.put("content","更新了用户的个人信息!");
                map.put("operationUser",operationUser);
                map.put("operatedId",userInfo.getUser().getUsername());
                map.put("operatedType",OperatedType.USER.getnCode());
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
            logParams.put("action", LogActionType.UPDATE.getnCode());
            logParams.put("operationUser", operationUser);
            logParams.put("operatedId", username);
            logParams.put("operatedType", OperatedType.USER.getnCode());
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
                m.put("action",LogActionType.LOGIN.getnCode());
                m.put("content","用户登录了");
                m.put("operationUser",userRole.getUser());
                m.put("operatedId",username);
                m.put("operatedType",OperatedType.USER.getnCode());
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
    public List<NoticeHelpClass> selectSystemNotice(String departmentCode,String roleId,String noticeId,Page page){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentCode",departmentCode);
        map.put("roleId",roleId);
        map.put("noticeId",noticeId);
        map.put("page",page);
        List<NoticeHelpClass> result = new ArrayList<>();
        for (SystemNotice systemNotice: userDao.selectSystemNoticeByPage(map)) {
            result.add(new NoticeHelpClass(systemNotice,selectUserInfoByUsername(systemNotice.getUser().getUsername()),UserController.updateUserRole(selectUserRoleByUsername(systemNotice.getUser().getUsername()))));
        }
        return result;
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
    public List<Data> selectDataByParams(String username,String dataClassId,String typeContentStr,Integer dataFlag,Integer dataClassFlag,Page page){
        Map<String,Object> map = new HashMap<>();
        map = formatMap(map,typeContentStr);
        map.put("username",username);
        map.put("dataClassId",dataClassId);
        map.put("dataFlag",String.valueOf(dataFlag));
        map.put("dataClassFlag",String.valueOf(dataClassFlag));
        map.put("page",page);
        return userDao.selectDataByParamsByPage(map);
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
    public List<Department> selectAllDepartment(Page page){
        Map<String,Object> map = new HashMap<>();
        map.put("page",page);
        return userDao.selectAllDepartmentByPage(map);
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
     * 通过数据类型ID查询数据类型
     * @param dataClassId 数据类型ID
     * @return DataClass
     */
    public DataClass selectDataClassById(String dataClassId){
        return userDao.selectDataClassById(dataClassId);
    }

    /**
     * 查询用户的所有被操作的日志记录
     * @param username 用户名
     * @return list
     */
    public List<Log> selectPersonLogs(String username,String dataClassId,String action,Page page){
        Map<String,Object> map = new HashMap<>();
        map.put("username",username);
        map.put("action",action);
        map.put("dataClassId",dataClassId);
        map.put("page",page);
        return userDao.selectPersonLogsByPage(map);
    }

    /**
     * 查询不同角色的所有公共类型资料数据
     * @param departmentCode 院系编码
     * @param roleId 角色ID
     * @return List
     */
    public List<Data> selectRoleAllPublicData(String departmentCode,String roleId,String dataClassId,String typeContentStr,Page page){
        Map<String,Object> map = new HashMap<>();
        map = formatMap(map,typeContentStr);
        map.put("departmentCode",departmentCode);
        map.put("roleId",roleId);
        map.put("dataClassId",dataClassId);
        map.put("page",page);
        return userDao.selectRoleAllPublicDataByPage(map);
    }

    /**
     * 查询院系类目属性
     * @param departmentCode 院系编码
     * @return List
     */
    public List<ClassType> selectClassTypeByDepartmentCode(String departmentCode,String classTypeId){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentCode",departmentCode);
        map.put("classTypeId",classTypeId);
        return userDao.selectClassType(map);
    }

    public List<LogHelpClass> formatLog(List<Log> logList){
        List<LogHelpClass> logHelpClassList = new ArrayList<>();
        for (Log log: logList) {
            if (log.getDescription()==null || "".equals(log.getDescription())){
                log.setDescription("无");
            }
            LogHelpClass logHelpClass = new LogHelpClass();
            logHelpClass.setOperatedType(log.getOperatedType());
            switch (log.getOperatedType()){
                case "文件":
                    Data data = selectDataById(log.getOperatedId());
                    if (data!=null) {
                        data.setFileName(data.getFileName().substring(data.getFileName().lastIndexOf("_") + 1));
                        logHelpClass.setOperatedData(data);
                        logHelpClass.setOperatedDataUserInfo(selectUserInfoByUsername(data.getUser().getUsername()));
                        logHelpClass.setOperatedDataUserRole(UserController.updateUserRole(selectUserRoleByUsername(data.getUser().getUsername())));
                    }
                    break;
                case "文件类型":
                    DataClass dataClass = selectDataClassById(log.getOperatedId());
                    if (dataClass!=null) {
                        dataClass.getRole().setName(UserController.updateUserRole(new UserRole(new User(), dataClass.getRole())).getRole().getName());
                    }
                    logHelpClass.setOperatedDataClass(dataClass);
                    break;
                case "用户":
                    logHelpClass.setOperatedUserInfo(selectUserInfoByUsername(log.getOperatedId()));
                    logHelpClass.setOperatedUserRole(UserController.updateUserRole(selectUserRoleByUsername(log.getOperatedId())));
                    break;
                case "院系":
                    logHelpClass.setOperatedDepartment(selectDepartmentByCode(log.getOperatedId()));
                    break;
                case "公告":
                    logHelpClass.setNoticeHelpClass(selectSystemNotice(null,null,log.getOperatedId(),null).get(0));
                    break;
                case "类目属性":
                    if(selectClassTypeByDepartmentCode(null,log.getOperatedId()).size()>0) {
                        ClassType classType = selectClassTypeByDepartmentCode(null, log.getOperatedId()).get(0);
                        logHelpClass.setClassType(classType);
                        if (classType != null) {
                            logHelpClass.setOperatedUserInfo(selectUserInfoByUsername(classType.getUser().getUsername()));
                            logHelpClass.setOperatedUserRole(UserController.updateUserRole(selectUserRoleByUsername(classType.getUser().getUsername())));
                        }
                    }
                    break;
                case "类目属性内容":
                    if(selectTypeContentByParam(log.getOperatedId(),null).size()>0) {
                        TypeContent typeContent = selectTypeContentByParam(log.getOperatedId(),null).get(0);
                        logHelpClass.setTypeContent(typeContent);
                        if (typeContent != null) {
                            logHelpClass.setOperatedUserInfo(selectUserInfoByUsername(typeContent.getUser().getUsername()));
                            logHelpClass.setOperatedUserRole(UserController.updateUserRole(selectUserRoleByUsername(typeContent.getUser().getUsername())));
                        }
                    }
                    break;
            }
            logHelpClass.setLog(log);
            if (log.getOperationUser()!=null && selectUserInfoByUsername(log.getOperationUser().getUsername())!=null){
                logHelpClass.setOperationUserInfo(selectUserInfoByUsername(log.getOperationUser().getUsername()));
            }else {
                UserInfo userInfo = new UserInfo();
                if (log.getOperationUser()!=null && log.getOperationUser().getUsername() != null){
                    userInfo.setName("该用户已被删除!");
                    userInfo.setEmail("该用户已被删除!");
                    userInfo.setPhone("该用户已被删除!");
                }else {
                    userInfo.setName("无");
                    userInfo.setEmail("无");
                    userInfo.setPhone("无");
                }
                logHelpClass.setOperationUserInfo(userInfo);
            }
            if (log.getOperationUser()!=null && selectUserRoleByUsername(log.getOperationUser().getUsername())!=null){
                logHelpClass.setOperationUserRole(UserController.updateUserRole(selectUserRoleByUsername(log.getOperationUser().getUsername())));
            }else {
                UserRole userRole = new UserRole();
                if (log.getOperationUser()!=null && log.getOperationUser().getUsername() != null){
                    Role role = new Role();
                    role.setName("该用户已被删除!");
                    userRole.setRole(role);
                }else {
                    Role role = new Role();
                    role.setName("无");
                    userRole.setRole(role);
                }
                logHelpClass.setOperationUserRole(userRole);
            }
            logHelpClassList.add(logHelpClass);
        }
        return logHelpClassList;
    }

    /**
     * 查询本院资料类型,如果roleId为空则查询本院所有资料类型
     * @param departmentCode 院系编码
     * @param roleId 角色ID
     * @param flag 备注
     * @return List
     */
    public List<DataClass> selectDataClass(String departmentCode,String roleId,String flag,String userType){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentCode",departmentCode);
        map.put("roleId",roleId);
        map.put("flag",flag);
        map.put("userType",userType);
        return userDao.selectDataClass(map);
    }

    /**
     * 查询不同角色的文件类型
     * @param departmentCode 院系编码
     * @param roleId 角色ID
     * @return List
     */
    public List<DataClassHelpClass> selectDataClassRHelp(String departmentCode, String roleId, String flag,String userType){
        List<DataClass> dataClassList = selectDataClass(departmentCode,roleId,flag,userType);
        return formatDataClass(dataClassList);
    }

    /**
     * 分页查询不同角色的文件类型
     * @param departmentCode 院系编码
     * @param roleId 角色ID
     * @return List
     */
    public List<DataClassHelpClass> selectDataClassRHelpByPage(String departmentCode, String roleId, String flag,String userType,Page page) {
        Map<String, Object> map = new HashMap<>();
        map.put("departmentCode", departmentCode);
        map.put("roleId", roleId);
        map.put("flag", flag);
        map.put("userType", userType);
        map.put("page", page);
        List<DataClassHelpClass> result = formatDataClass(userDao.selectDataClassByPage(map));
        for (DataClassHelpClass dataClassHelpClass : result) {
            if (dataClassHelpClass.getClassTypeHelpClassList().size() > 0 && dataClassHelpClass.getClassTypeHelpClassList().get(0) != null) {
                for (int i = 0; i < dataClassHelpClass.getClassTypeHelpClassList().size(); i++) {
                    dataClassHelpClass.getClassTypeHelpClassList().get(i).getClassType().setName(dataClassHelpClass.getClassTypeHelpClassList().get(i).getClassType().getName().substring(4));
                }
            }
        }
        return result;
    }

    // 格式化DataClass
    public List<DataClassHelpClass> formatDataClass(List<DataClass> dataClassList){
        List<DataClassHelpClass> result = new ArrayList<>();
        for (DataClass dataClass: dataClassList) {
            List<ClassType> classTypeList = selectClassTypesByDataClassId(dataClass.getId());
            if (classTypeList.size()>0 && classTypeList.get(0)!= null) {
                for (int i = 0; i < classTypeList.size(); i++) {
                    classTypeList.get(i).setName("属性" + (i + 1) + ":" + classTypeList.get(i).getName());
                }
            }
            List<ClassTypeHelpClass> classTypeHelpClassList = new ArrayList<>();
            for (ClassType classType:classTypeList) {
                if (classType!=null) {
                    classTypeHelpClassList.add(new ClassTypeHelpClass(classType, selectTypeContentByParam(null, classType.getId())));
                }
            }
            UserInfo userInfo = selectUserInfoByUsername(dataClass.getUser().getUsername());
            UserRole userRole = UserController.updateUserRole(selectUserRoleByUsername(dataClass.getUser().getUsername()));
            result.add(new DataClassHelpClass(dataClass,classTypeHelpClassList,userInfo,userRole));
        }
        return result;
    }

    /**
     * 查询本院的类目属性内容
     * @param departmentCode 院系编码
     * @param classTypeId 类目属性ID
     * @param page 分页参数
     * @return List
     */
    public List<TypeContent> selectTypeContentByPage(String departmentCode,String classTypeId,Page page){
        Map<String,Object> map = new HashMap<>();
        map.put("departmentCode",departmentCode);
        map.put("page",page);
        map.put("classTypeId",classTypeId);
        return userDao.selectTypeContentByPage(map);
    }

    /**
     * 通过参数查询类目属性内容
     * @param typeContentId ID
     * @return TypeContent
     */
    public List<TypeContent> selectTypeContentByParam(String typeContentId,String classTypeId){
        Map<String,Object> map = new HashMap<>();
        map.put("typeContentId",typeContentId);
        map.put("classTypeId",classTypeId);
        return userDao.selectTypeContentByParam(map);
    }

    public Map<String,Object> formatMap(Map<String,Object> map,String typeContentStr){
        String[] typeContentArr = null;
        if (typeContentStr!=null && !"".equals(typeContentStr) && typeContentStr.length()>0){
            typeContentArr = typeContentStr.split("/");
        }
        if (typeContentArr!=null) {
            switch (typeContentArr.length) {
                case 1:
                    map.put("typeContent1", typeContentArr[0]);
                    break;
                case 2:
                    map.put("typeContent1", typeContentArr[0]);
                    map.put("typeContent2", typeContentArr[1]);
                    break;
                case 3:
                    map.put("typeContent1", typeContentArr[0]);
                    map.put("typeContent2", typeContentArr[1]);
                    map.put("typeContent3", typeContentArr[2]);
                    break;
            }
        }
        return map;
    }

    /**
     * 复制文件
     * @param savePath 源路径
     * @param newPath 新路径
     * @return 成功条数
     */
    public Integer copyFile(String savePath, String newPath){
        File file = new File(savePath);
        if (file.exists() && file.isDirectory()){
            File newFile = new File(newPath);
            Integer result = CopyFile.copy(file.listFiles(),newFile);
            CopyFile.c = 0;
            return result;
        }else {
            return 0;
        }
    }

}