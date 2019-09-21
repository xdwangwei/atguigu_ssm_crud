package com.ww.crud.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ww.crud.mapper.EmployeeMapper;
import com.ww.crud.pojo.Employee;
import com.ww.crud.pojo.EmployeeExample;
import com.ww.crud.pojo.EmployeeExample.Criteria;
import com.ww.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author: wangwei
 * @Description:
 * @Time: 2019/9/19 星期四 00:33
 **/
@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    @Override
    public PageInfo<Employee> getPageEmps(Integer pageNumber, Integer pageSize) {
        PageHelper.startPage(pageNumber,pageSize);
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        // 5表示设置连续显示的页号数目 1 2 3 4 5
        return new PageInfo<>(employees,5);
    }

    @Override
    public int save(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    @Override
    public boolean checkNameExit(String empName) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andNameEqualTo(empName);
        return employeeMapper.countByExample(example)==0?false:true;
    }

    @Override
    public Employee getEmpById(Integer id) {
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    @Override
    public int updateEmp(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    @Override
    public int delEmpById(Integer id) {
        return employeeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int delEmpBatch(String ids) {
        String[] id_strs = ids.split("-");
        List<Integer> idList = new ArrayList();
        for (String id_str : id_strs) {
            idList.add(Integer.parseInt(id_str));
        }
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andIdIn(idList);
        return employeeMapper.deleteByExample(example);
    }
}
