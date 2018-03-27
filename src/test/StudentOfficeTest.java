import com.snut_tdms.service.DeanOfficeService;
import com.snut_tdms.service.StudentOfficeService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import static org.junit.Assert.assertNotNull;

/**
 * 学办测试类
 * Created by huankai on 2018/3/22.
 */
public class StudentOfficeTest {
    private StudentOfficeService studentOfficeService;

    @Before
    public void init() {
        ApplicationContext aCtx = new FileSystemXmlApplicationContext("classpath:spring-mybatis.xml");
        StudentOfficeService studentOfficeService = (StudentOfficeService) aCtx.getBean("studentOfficeService");
        assertNotNull(studentOfficeService);
        this.studentOfficeService = studentOfficeService;
    }

    @Test
    public void testData() {
        System.out.print("");
    }

}
