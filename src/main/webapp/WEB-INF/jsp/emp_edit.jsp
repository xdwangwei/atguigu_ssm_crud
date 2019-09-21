<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<!-- 员工信息修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="emp_edit_form">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-9">
                            <p class="form-control-static" id="emp_edit_name_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" name="email" id="emp_edit_email" placeholder="zhangsan@atguigu.com">
                            <span id="helpBlock2" class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword3" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" value="M"> 男
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
                <button type="button" class="btn btn-primary" id="emp_edit_submit">修改</button>
            </div>
        </div>
    </div>
</div>
<script>
    /**
     * 查询指定id的员工信息并显示
     * @param empId
     */
    function getEmpInfo(empId) {
        $.ajax({
            url:"${ctx}/emps/get/"+empId,
            type:"GET",
            success:function (result) {
                if(result.code == "200"){
                    var emp = result.dataMap.emp;
                    $("#emp_edit_name_static").text(emp.name);
                    $("#emp_edit_email").val(emp.email);
                    // 赋值单选框(根据每个radio的value进行匹配选择)
                    $("#empUpdateModal input[name=gender]").val([emp.gender]);
                    // 赋值下拉框(根据每个option的value进行匹配选择)
                    $("#empUpdateModal select").val([emp.deptId]);
                }
            }
        });
    }

    /**
     * 给所有编辑按钮(class：.btn_edit)绑定点击事件
     * 		$(".btn_edit").click(function () {
					alert("edit");
				});
     此种方式：页面加载完成会去给具有.btn_edit类的按钮绑定事件，
     但我们的表格数据(包括操作部分的修改和删除按钮)是页面加载完后通过发送ajax请求
     获取数据，再构造出来的,因此此种方式无法给之后创建的按钮绑定上事件

     解决：
     1.在创建按钮的时候绑定事件
     2.使用.live()方法绑定事件，即便是后面才创建出来，也有效
     3.jquery高版本取消了.live()方法，提供了.on()方法，使用
     $("父元素选择器").on("事件名"，"子元素选择器", function () {
						alert("edit");
					});
     */
    /**(
     * 遍历document的全部子孙节点，给所有具有.btn_edit的按钮绑定单击事件
     */
    $(document).on("click",".btn_edit",function () {
        // alert("edit");
        // 1.查出可选的部门信息显示在下拉列表
        getDepts("#empUpdateModal select");
        // 2.查出当前员工信息并显示
        var empId = $(this).attr("emp_id");
        getEmpInfo(empId);
        // 把当前员工id传递给提交按钮
        $("#emp_edit_submit").attr("emp_id",empId);
        // 3.弹出模态框进行修改操作
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });
    
    /**(
     * 遍历document的全部子孙节点，给所有具有.btn_del的按钮绑定单击事件
     */
    $(document).on("click",".btn_del",function () {
        // 当前要删除的员工姓名
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("emp_id");
        if(confirm("你是否确定删除员工【"+empName+"】?")){
            // 发送删除员工的请求
            $.ajax({
                url:"${ctx}/emps/del/"+empId,
                type:"DELETE",
                success:function (result) {
                    if (result.code == "200"){
                        alert(result.msg);
                        // 跳转到原位置
                        ajax_to_page(currentPage);
                    }
                }
            });
        }
    });

    /**
     * 为修改提交按钮绑定单击事件
     */
    $("#emp_edit_submit").click(function () {
        // 如果邮箱格式正确，就发送更新请求(控制器要求访问方式为PUT)
        if(checkEmail("#emp_edit_email")){
            $.ajax({
                url:"${ctx}/emps/update/"+$(this).attr("emp_id"),
                /*  
                    方式一：发送POST请求，借助 HiddenHttpMethodFilter 过滤器
                        并给请求体添加参数  "&_method=PUT"  将POST请求转为PUT请求          
                    type:"POST",
                    data:$("#empUpdateModal form").serialize()+"&_method=PUT",
                    方式二：直接发送ajax PUT请求, 不用改变参数，要求配置了 HttpPutFormContentFilter 过滤器
                */
                type:"PUT",
                data:$("#empUpdateModal form").serialize(),
                success:function (result) {
                    // 修改成功
                    if(result.code == "200"){
                        // alert(result.msg);
                        // 关闭模态框
                        $("#empUpdateModal").modal("hide");
                        // 跳转到修改了的记录所在的页
                        ajax_to_page(currentPage);
                    }
                }
            });
        }
    });

    /**
     * 为table th行的全选按钮添加点击事件
     */
    $("#checkbox_all").click(function () {
        // attr()获取标签的原生属性是undefined
        // 因此对于自创建的标签，使用prop获取和操作原生属性,使用attr获取自定义属性
        // alert($(this).prop("checked"));
        // 让其他的单选框的选中状态随全选框改变
        $(".checkbox_single").prop("checked", $(this).prop("checked"));
    });
    /**
     * 为每一行的单选框绑定点击事件，当每一页的每一行都选中时，上面的全选框也要随着选中
     * 遍历document的全部子孙节点，给所有具有.checkbox_single 类的按钮绑定单击事件
     */
    $(document).on("click",".checkbox_single",function () {
        // 判断当前页选中的单选框是否等于当前页全部的单选框，若是，则全选框随之选中
        var flag = $(".checkbox_single:checked").length == $(".checkbox_single").length;
        $("#checkbox_all").prop("checked", flag);
        
    });

    /**
     * 给批量删除按钮(顶部的删除按钮)添加点击事件
     */
    $("#emp_delete_all").click(function () {
        // 获取选中的员工姓名
        var names = "";
        // 获取选中的员工id
        var ids = "";
        // 遍历选中的记录
        $.each($(".checkbox_single:checked"),function (index,item) {
            names += $(this).parents("tr").find("td:eq(2)").text()+",";
            ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        // 去除names最后一个逗号
        names = names.substring(0,names.length-1);
        // 去除ids最后一个-
        ids = ids.substring(0,ids.length-1);
        if(names.trim().length==0){
            alert("请选择要删除的员工！")
            return false;
        }
        if(confirm("你确定要删除员工【"+names+"】吗？")){
            // 发送ajax请求批量删除
            $.ajax({
                url:"${ctx}/emps/dels/"+ids,
                type:"DELETE",
                success:function (result) {
                    if(result.code == "200"){
                        alert(result.msg);
                        ajax_to_page(currentPage);
                    }
                }
            });
        }
    });
</script>

