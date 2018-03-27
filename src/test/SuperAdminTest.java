import com.snut_tdms.service.DeanOfficeService;
import com.snut_tdms.service.SuperAdminService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import static org.junit.Assert.assertNotNull;

/**
 * 教务处测试类
 * Created by huankai on 2018/3/22.
 */
public class SuperAdminTest {
    private SuperAdminService superAdminService;

    @Before
    public void init() {
        ApplicationContext aCtx = new FileSystemXmlApplicationContext("classpath:spring-mybatis.xml");
        SuperAdminService superAdminService = (SuperAdminService) aCtx.getBean("superAdminService");
        assertNotNull(superAdminService);
        this.superAdminService = superAdminService;
    }

    @Test
    public void testData() {
        System.out.print("");
    }

}
