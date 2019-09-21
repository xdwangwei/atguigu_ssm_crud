<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<!-- 员工信息添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_add_form">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="name" id="emp_add_name" placeholder="张三" onblur="nameExit()">
                            <span id="helpBlock2" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="email" id="emp_add_email" placeholder="zhangsan@atguigu.com">
                            <span id="helpBlock2" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="deptId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<script>
    /**
     * 为用户名输入框验证输入内容，并显示校验信息)
     */
    function checkName (nameElementSelector) {
        var name = $(nameElementSelector).val();
        var nameRex = /(^[a-zA-Z0-9_]{3,10}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if(!nameRex.test(name)){
            // alert("用户名必须是3-10位字母下划线和数字的组合或者2-5位中文！")
            show_validate_msg(nameElementSelector,"error","用户名必须是3-10位字母下划线和数字的组合或者2-5位中文");
            return false;
        }else {
            show_validate_msg(nameElementSelector,"success","");
            return true;
        }
    }

    /**
     * 为指定的邮箱输入框添加失去焦点时的事件函数(验证输入内容，并显示校验信息)
     */
    function checkEmail (emailElemSelector) {
        var email = $(emailElemSelector).val();
        var emailRex = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!emailRex.test(email)){
            // alert("邮箱格式不正确！")
            show_validate_msg(emailElemSelector,"error","邮箱格式不正确");
            return false;
        }else {
            show_validate_msg(emailElemSelector,"success","");
            return true;
        }
        /**
         * 未邮箱输入框添加失去焦点事件
         */
        $("#emp_add_email").blur(function () {
            // 验证输入的邮箱格式是否正确
            checkEmail("#emp_add_email");
        });
    }

    /**
     * 校验用户输入的表单数据是否合理
     */
    function validate_form_data() {
        // 校验用户名
        // 校验邮箱
        return checkName("#emp_add_name")&&checkEmail("#emp_add_email");
    }
    
    /**
     *  发送ajax请求，校验此用户名是否已存在
     */
    function nameExit() {
        var name = $("#emp_add_name").val().trim();
        // 防止未输入时，就去发送请求
        if(name != " " && name.length>0){
            $.ajax({
                url:"${ctx}/emps/check",
                type:"POST",
                data:"name="+name,
                success:function (result) {
                    if(result.code == "200"){
                        // 当前用户名不存在，给input标签添加一个属性值
                        show_validate_msg("#emp_add_name","success","用户名可用");
                        $("#emp_add_name").attr("isExit","false");
                    }else {
                        show_validate_msg("#emp_add_name","error","用户名已存在");
                        $("#emp_add_name").attr("isExit","true");
                    }
                }
            })
        }
    }
    
    /**
     * 检查用户名是否可用
     */
    function checkNameAvailable() {
        // 手动触发input框失去焦点函数，以保证下面获取的值不是上次的值，而是重新发送ajax请求后设置的值
        nameExit();
        var isExit = $("#emp_add_name").attr("isExit");
        if(isExit == "false"){
            return true;
        }else 
            return false;
    }

    /**
     * 为员工信息新增按钮绑定点击事件
     */
    $("#emp_add_btn").click(function () {
        // 打开模态框前，清空上一次的填写信息
        // jquery没有reset()方法，此处$('#empAddModal form')确定不到form表单
        // form_reset("emp_add_form");
        // document.getElementById("emp_add_form").reset();
        // 查出部门列表信息，显示在下拉列表中
        getDepts("#empAddModal select");
        // 打开用于新增的模态框，并设置属性，点击其他地方时此模态框不会关闭
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    /**
     * 为模态框中员工信息保存按钮绑定点击事件
     */
    $("#emp_save_btn").click(function () {
        // alert($("#empAddModal form").serialize());
        // 1. 前端校验数据合理性
        if(!validate_form_data()){
            // 校验失败，直接返回，不发送请求
            return false;
        }
        // 2.检查用户名是否重复
        if(!checkNameAvailable()) {
            return false;
        }
        // 3.发送保存请求
        $.ajax({
            url:"${ctx}/emps/save",
            type:"POST",
            // jquery提供的将表单数据序列化，作为ajax传输时的参数
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                // alert(result.msg);
                // 保存成功
                if(result.code == "200"){
                    // 保存成功后，关闭模态框，清除上一次的数据，跳转到最后一页
                    $('#empAddModal').on('hidden.bs.modal', function () {
                        form_reset("#emp_add_form");
                    });
                    $('#empAddModal').modal('hide');
                    ajax_to_page(totalPage);
                }else{
                    // 取出错误信息
                    var errorMap = result.dataMap.errorMap;
                    // 判断出错的字段，并显示在相应标签
                    // email字段不为undefined说明后端校验邮箱出错
                    if(errorMap.email != undefined){
                        show_validate_msg("#emp_add_email","error",errorMap.email);
                    }
                    if(errorMap.name != undefined){
                        show_validate_msg("#emp_add_name","error",errorMap.name);
                    }
                }
            }
        });


    });
</script>

