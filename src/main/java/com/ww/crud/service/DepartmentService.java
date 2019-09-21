package com.ww.crud.service;

import com.github.pagehelper.PageInfo;
import com.ww.crud.pojo.Department;
import com.ww.crud.pojo.Employee;

import java.util.List;

/**
 * @Author: wangwei
 * @Description:
 * @Time: 2019/9/19 星期四 00:32
 **/
public interface DepartmentService {
    /**
     * 查出所有部门信息
     * @return
     */
    List<Department> getAll();
    
}
