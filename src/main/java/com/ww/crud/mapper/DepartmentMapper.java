package com.ww.crud.mapper;

import com.ww.crud.pojo.Department;
import com.ww.crud.pojo.DepartmentExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DepartmentMapper {

    List<Department> selectAll();
    
}