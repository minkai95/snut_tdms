import com.snut_tdms.model.po.Department;
import com.snut_tdms.model.po.User;
import com.snut_tdms.model.po.UserInfo;
import com.snut_tdms.service.UserService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import static org.junit.Assert.assertNotNull;

/**
 * Created by huankai on 2018/3/22.
 */
public class UserTest {
    private UserService userService;

    @Before
    public void init() {
        ApplicationContext aCtx = new FileSystemXmlApplicationContext("classpath:spring-mybatis.xml");
        UserService userService = (UserService) aCtx.getBean("userService");
        assertNotNull(userService);
        this.userService = userService;
    }

    @Test
    public void testData() {
        User user =new User("123","1111","11",0);
        Department department = new Department("001","管理学院");
        UserInfo userInfo = new UserInfo(user,"张三","男","155999999","sadsa@qq.com",department);
        System.out.print(userService.userLogin("123","1111"));
    }

}
