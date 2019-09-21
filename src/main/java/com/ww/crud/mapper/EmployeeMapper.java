package com.ww.crud.mapper;

import com.ww.crud.pojo.Employee;
import com.ww.crud.pojo.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer id);

    int insertSelective(Employee record);

    List<Employee> selectByExampleWithDept(EmployeeExample example);

    Employee selectByPrimaryKeyWithDept(Integer id);
    
    int updateByPrimaryKeySelective(Employee record);
    
}