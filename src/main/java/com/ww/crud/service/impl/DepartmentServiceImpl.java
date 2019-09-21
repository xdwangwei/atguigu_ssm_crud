package com.ww.crud.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ww.crud.mapper.DepartmentMapper;
import com.ww.crud.mapper.EmployeeMapper;
import com.ww.crud.pojo.Department;
import com.ww.crud.pojo.Employee;
import com.ww.crud.service.DepartmentService;
import com.ww.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: wangwei
 * @Description:
 * @Time: 2019/9/19 星期四 00:33
 **/
@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getAll() {
        return departmentMapper.selectAll();
    }
    
}
