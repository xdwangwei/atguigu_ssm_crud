package com.ww.crud.test;

import com.ww.crud.mapper.DepartmentMapper;
import com.ww.crud.mapper.EmployeeMapper;
import com.ww.crud.pojo.Department;
import com.ww.crud.pojo.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.lang.ref.PhantomReference;
import java.util.UUID;

/**
 * @Author: wangwei
 * @Description:
 *
 *  使用Spring的单元测试
 *      1. 导入spring-test.jar
 *      2. 使用注解@ContextConfiguration指定sprinf配置文件位置
 *      3. @RunWith指定单元测试模块
 *      4. 就可以ioc容器实现注入
 * @Time: 2019/9/18 星期三 22:49
 **/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"})
public class TestMapper {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    /**
     * batchSqlSession 为 在spring容器了配置了executorType为batch的
     *  org.mybatis.spring.SqlSessionTemplate 为了测试批量操作
     *  运行项目时将此配置注释或将batch改为batch,因为支持批量操作的session不能获取
     *  插入、删除、更新操作影响的行数
     *  如果未配置，就不会使用自定义的SqlSession，默认的session的executorType为simple
     */
    // @Autowired
    // private SqlSession batchSqlSession;

    @Test
    public void testDepartmentMapper(){
        // ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:spring-mybatis.xml");
        // DepartmentMapper departmentMapper = ac.getBean(DepartmentMapper.class);
        // System.out.println(departmentMapper);
        //
        // Department dept = new Department();
        // dept.setName("销售部");
        // departmentMapper.insertSelective(dept);
        // dept.setName("技术部");
        // departmentMapper.insertSelective(dept);

        // employeeMapper.insertSelective(new Employee(null,"夏天淼","M","xtm@www.com",1));
        // Employee employee = employeeMapper.selectByPrimaryKeyWithDept(3111);
        // System.out.println(employee.getEmail()+"  "+employee.getDepartment().getName());

/*        EmployeeMapper mapper1 = batchSqlSession.getMapper(EmployeeMapper.class);
        long start = System.currentTimeMillis();
        for (int i = 0; i < 1000 ; i++) {
            String uname = UUID.randomUUID().toString().substring(0,4)+i;
            mapper1.insertSelective(new Employee(null,uname,"M",uname+"@www.com",1));
        }
        long stop1 = System.currentTimeMillis();
        System.out.println("batchSqlSession批量插入用时："+(stop1-start));*/

    }
    
}
