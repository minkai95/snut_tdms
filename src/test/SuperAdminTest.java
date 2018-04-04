import com.snut_tdms.model.po.Department;
import com.snut_tdms.model.po.User;
import com.snut_tdms.service.DeanOfficeService;
import com.snut_tdms.service.SuperAdminService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import java.util.ArrayList;
import java.util.List;

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
        List<Department> list = new ArrayList<>();
        list.add(new Department("ysxy","艺术学院"));
        list.add(new Department("jfxy","经法学院"));
        list.add(new Department("001","机械学院"));
        List<String> list2 = new ArrayList<>();
        list2.add("ysxy");
        list2.add("jfxy");
        list2.add("jxxy");
        System.out.println(superAdminService.updateDepartmentByCode(new Department("001","管理学院1"),new User("123","456","",1)));
    }

}
