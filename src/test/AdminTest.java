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
    }

}
