import com.snut_tdms.model.po.*;
import com.snut_tdms.service.TeacherService;
import com.snut_tdms.service.UserService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import static org.junit.Assert.assertNotNull;

/**
 * 教师测试类
 * Created by huankai on 2018/3/22.
 */
public class TeacherTest {
    private TeacherService teacherService;

    @Before
    public void init() {
        ApplicationContext aCtx = new FileSystemXmlApplicationContext("classpath:spring-mybatis.xml");
        TeacherService teacherService = (TeacherService) aCtx.getBean("teacherService");
        assertNotNull(teacherService);
        this.teacherService = teacherService;
    }

    @Test
    public void testData() {
        System.out.print("");
    }

}
