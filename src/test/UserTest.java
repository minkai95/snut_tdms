import com.snut_tdms.model.po.*;
import com.snut_tdms.service.UserService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.assertNotNull;

/**
 * 用户测试类
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

        List<String> list = new ArrayList<>();
        list.add("5");
        list.add("6");
        list.add("7");
        list.add("8");
        Map<String,Object> map = new HashMap<>();
        User operationUser = new User("123","111","11",1);
        User operatedUser = new User("123","111","11",1);
        map.put("action","delete");
        map.put("operationUser",operationUser);
        map.put("operatedUser",operatedUser);
        map.put("description","上传错了！");
        System.out.print(userService.selectClassTypesByDataClassId("7"));
    }

}
