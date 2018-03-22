package com.snut_tdms.interceptor;

import com.snut_tdms.model.vo.Page;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.Properties;

/**
 * Created by huankai on 2018/3/22.
 */
@Intercepts({@Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class})})
public class PageInterceptor implements Interceptor {
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        StatementHandler statementHandler = (StatementHandler) invocation.getTarget();
        MetaObject metaObject = MetaObject.forObject(statementHandler, SystemMetaObject.DEFAULT_OBJECT_FACTORY, SystemMetaObject.DEFAULT_OBJECT_WRAPPER_FACTORY);
        MappedStatement mappedStatement = (MappedStatement) metaObject.getValue("delegate.mappedStatement");
        // 配置文件中SQL语句的ID
        String id = mappedStatement.getId();
        BoundSql boundSql = statementHandler.getBoundSql();
        if (id.matches(".+ByPage$")) {
            Map<?, ?> parameter = (Map<?, ?>) boundSql.getParameterObject();   //获取查询参数
            if (parameter.get("page") != null) {   //如果查询方法以ByPage结尾且查询参数page不为null才做分页查询
                // 原始的SQL语句
                String sql = boundSql.getSql();
                // 查询总条数的SQL语句
                String countSql = "select count(*) from (" + sql + ") AS a";
                Connection connection = (Connection) invocation.getArgs()[0];
                PreparedStatement countStatement = connection.prepareStatement(countSql);
                ParameterHandler parameterHandler = (ParameterHandler) metaObject.getValue("delegate.parameterHandler");
                parameterHandler.setParameters(countStatement);
                ResultSet rs = countStatement.executeQuery();
                Page page = (Page) parameter.get("page");
                if (rs.next()) {
                    page.setTotalNumber(rs.getInt(1));
                }
                // 改造后带分页查询的SQL语句
                String pageSql = sql + " limit " + page.getDbIndex() + "," + page.getDbNumber();
                metaObject.setValue("delegate.boundSql.sql", pageSql);
            }
        }
        return invocation.proceed();
    }

    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    @Override
    public void setProperties(Properties properties) {
    }

}
