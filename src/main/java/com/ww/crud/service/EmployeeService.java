package com.ww.crud.service;

import com.github.pagehelper.PageInfo;
import com.ww.crud.pojo.Employee;

import java.util.List;

/**
 * @Author: wangwei
 * @Description:
 * @Time: 2019/9/19 星期四 00:32
 **/
public interface EmployeeService {
    /**
     * 查出所有员工信息
     * @return
     */
    List<Employee> getAll();

    /**
     * 获取指定页及指定数量的员工信息
     * @return
     */
    PageInfo<Employee> getPageEmps(Integer pageNumber,Integer pageSize);

    /**
     * 保存员工信息
     * @param employee
     * @return
     */
    int save(Employee employee);

    /**
     * 检查此用户名是否存在
     * @param empName
     * @return
     */
    boolean checkNameExit(String empName);

    /**
     * 根据id查询出此员工信息
     * @param id
     * @return
     */
    Employee getEmpById(Integer id);

    /**
     * 更新员工信息
     * @param employee
     * @return
     */
    int updateEmp(Employee employee);

    /**
     * 根据id删除此员工
     * @param id
     * @return
     */
    int delEmpById(Integer id);

    /**
     * 传入的是以"-"连接起来的id,就执行批量删除
     * @param ids
     * @return
     */
    int delEmpBatch(String ids);
}
