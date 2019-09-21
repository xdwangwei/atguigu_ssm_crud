package com.ww.crud.controller;

import com.github.pagehelper.PageInfo;
import com.ww.crud.pojo.Department;
import com.ww.crud.pojo.Employee;
import com.ww.crud.pojo.InfoDTO;
import com.ww.crud.service.DepartmentService;
import com.ww.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @Author: wangwei
 * @Description:
 * @Time: 2019/9/18 星期三 17:46
 **/
@Controller
@RequestMapping("/dept")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;
    
    /**
     * 返回json数据
     * @return
     */
    @ResponseBody
    @RequestMapping("/list")
    public InfoDTO getDepts(){
        List<Department> depts = departmentService.getAll();
        return InfoDTO.success().addData("depts",depts);
    }
}
