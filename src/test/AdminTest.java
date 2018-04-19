import com.snut_tdms.model.po.Log;
import com.snut_tdms.model.po.User;
import com.snut_tdms.service.AdminService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import static org.junit.Assert.assertNotNull;

/**
 * 用户测试类
 * Created by huankai on 2018/3/22.
 */
public class AdminTest {
    private AdminService adminService;

    @Before
    public void init() {
        ApplicationContext aCtx = new FileSystemXmlApplicationContext("classpath:spring-mybatis.xml");
        AdminService adminService = (AdminService) aCtx.getBean("adminService");
        assertNotNull(adminService);
        this.adminService = adminService;
    }

    @Test
    public void testData() {
        List<String> list = new ArrayList<>();
        list.add("5");
        list.add("6");
        list.add("7");
        list.add("8");
        User operationUser = new User("123","111","11",1);
        User operatedUser = new User("123","111","11",1);
        Map<String,Object> map = new HashMap<>();
        map.put("action","delete");
        map.put("operationUser",operationUser);
        map.put("operatedUser",operatedUser);
        map.put("description","文件不合格而被删除");
    }

}
