<%--
  Created by IntelliJ IDEA.
  User: wangwei
  Date: 2019/9/18
  Time: 17:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
	<title>SSM-CRUD</title>
	<%--引入jquery--%>
	<script src="${ctx}/static/js/jquery-3.4.1.js"></script>
	<%--引入bootstrap的css全局样式--%>
	<link href="${ctx}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
	<%--引入bootstrap的js插件--%>
	<script src="${ctx}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<%--
		Bootstrap 提供了栅格系统，栅格系统用于通过一系列的行（row）与列（column）的组合来创建页面布局
		行（row）必须包含在类 .container，你的内容应当放置于“列（column）”内，并且，只有“列（column）”可以作为行（row）”的直接子元素
		系统会自动分为最多12列，栅格系统中的列是通过指定1到12的值来表示其跨越的范围
	--%>
	<div class="container">
		<%--第一行 标题--%>
		<div class="row">
			<div class="col-md-12">
				<h1>Atguigu-SSM-CRUD</h1>
			</div>
		</div>
		<%--第二行 增加 删除 按钮--%>
		<div class="row">
			<div class="col-md-4 col-md-offset-10">
				<button class="btn btn-success" id="emp_add_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all">删除</button>
			</div>
		</div>
		<%--第三行 表格--%>	
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
					<tr>
						<th><input type="checkbox" id="checkbox_all"/></th>
						<th>#</th>
						<th>姓名</th>
						<th>性别</th>
						<th>邮箱</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<%--第四行 底部导航栏--%>
		<div class="row">
			<%--页面信息--%>
			<div class="col-md-6" id="page_info_area"></div>
			<%--页面导航--%>
			<div class="col-md-6" id="nav_info_area"></div>
		</div>
	</div>
	
	<%--引入添加员工信息页面--%>
	<jsp:include page="emp_add.jsp"/>
	<%--引入修改员工信息页面--%>
	<jsp:include page="emp_edit.jsp"/>
	
	<script>
		var totalPage; // 保存总记录数
		var currentPage; // 保存当前页号
		<%--页面加载完成后，发起ajax请求，获取json数据--%>
		$(function () {
			ajax_to_page(1);
		});
		/**
		 * 发送ajax请求，获取指定页数据
		 * @param pageNum
		 */
		function ajax_to_page(pageNum) {
			$.ajax({
				url:"${ctx}/emps/json",
				type:"GET",
				data:"pageNumber="+pageNum,
				// result是服务器返回结果(InfoDTO对象)
				success:function (result) {
					// console.log(result);
					totalPage = result.dataMap.pageInfo.total;
					currentPage = result.dataMap.pageInfo.pageNum;
					// 1.解析并显示员工信息
					build_emps_table(result);
					// 2.解析并显示分页信息
					build_page_info(result);
					// 2.解析并显示导航信息
					build_nav_info(result);
				}
			});
		}

		/**
		 * 将获取的json数据解析并显示到table员工信息部分
		 * @param result
		 */
		function build_emps_table(result) {
			// 清空上一页的显示数据
			$("table tbody").empty();
			// 清除th行的全选框选中状态
			$("#checkbox_all").prop("checked", false);
			
			// 取出InfoDTO对象中的员工列表
			var emps = result.dataMap.pageInfo.list;
			// 遍历集合emps, 对于每一条记录，执行回调函数
			// 每一条记录，是一个员工信息，将其信息封装到一个tr中，添加到表格中
			$.each(emps,function (index,item) {
				// 每一个属性字段放在一个td里面
				var checkboxTd = $("<td></td>").append($("<input type='checkbox' class='checkbox_single'></input>"));
				var idTd = $("<td></td>").append(item.id);
				var nameTd = $("<td></td>").append(item.name);
				var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.name);
/*				<button class="btn btn-info btn-sm">
						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
						编辑
				</button>   */
				var btnEdit = $("<button></button>").addClass("btn btn-info btn-sm btn_edit")
						.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
						.append("编辑");
				// 自定义一个属性，用于保存当前记录(员工)的id号,便于之后的修改查询传值
				btnEdit.attr("emp_id",item.id);
/*				<button class="btn btn-danger btn-sm">
						<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						删除
				</button>*/
				var btnDel = $("<button></button>").addClass("btn btn-danger btn-sm btn_del")
						.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
						.append("删除");
				// 自定义一个属性，用于保存当前记录(员工)的id号,便于之后的删除传值
				btnDel.attr("emp_id",item.id);
				// 所有td组成一个tr
				var operateTd = $("<td></td>").append(btnEdit).append(" ").append(btnDel);
				var itemTr = $("<tr></tr>").append(checkboxTd).append(idTd).append(nameTd).append(genderTd).append(emailTd).append(deptNameTd).append(operateTd);
				// 将此tr加到table tbody里面
				itemTr.appendTo($("table tbody"));
			});
		}

		/**
		 * 将获取的json数据解析并显示到table分页信息部分
		 * @param result
		 */
		function build_page_info(result) {
			// 清空上一页的显示数据
			$("#page_info_area").empty();
			var pageInfo = result.dataMap.pageInfo;
			var page_info = '当前第 <span class="label label-default">'+pageInfo.pageNum+'</span> 页，\
							共 <span class="label label-default">'+pageInfo.pages+'</span> 页，\
							共 <span class="label label-default">'+pageInfo.total+'</span> 条记录'
			$("#page_info_area").append(page_info);
		}

		/**
		 * 将获取的json数据解析并显示到table导航信息部分
		 * @param result
		 */
		function build_nav_info(result) {
			// 清空上一页的显示数据
			$("#nav_info_area").empty();
			
			var pageInfo = result.dataMap.pageInfo;
			// 每个导航数字 1 2 3都在li标签里面，所有li在一个ul里面，ul在nav里面
			var ul = $("<ul></ul>").addClass("pagination");
			var nav = $("<nav></nav>").attr("aria-label","Page navigation");
			// 首页li
			var firstLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
			// 上一页li
			var prevLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&laquo;"));
			// 绑定事件（不在第一页时，点击首页和上一页才发送请求）
			if(pageInfo.hasPreviousPage == true){
				firstLi.click(function () {
					ajax_to_page(1);
				});
				prevLi.click(function () {
					ajax_to_page(pageInfo.pageNum-1);
				});
			}
			ul.append(firstLi).append(prevLi);
			
			// 遍历此次pageInfo中的导航页，并构建li标签，添加到ul
			$.each(pageInfo.navigatepageNums,function (index,item) {
				var navLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
				// 遍历到当前显示的页，就高亮，且不能点击
				if(pageInfo.pageNum == item){
					navLi.addClass("active");
				}else {
					// 绑定单击事件
					navLi.click(function () {
						// 传入页号，获取数据
						ajax_to_page(item);
					});
				}
				ul.append(navLi);
			})
			
			// 下一页li
			var nextLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&raquo;"));
			// 尾页li
			var lastLi = $("<li></li>").append($("<a></a>").attr("href","#").append("尾页"));
			// 绑定事件（不在最后页时，点击尾页和下一页才发送请求）
			if(pageInfo.hasNextPage == true){
				nextLi.click(function () {
					ajax_to_page(pageInfo.pageNum+1);
				});
				lastLi.click(function () {
					ajax_to_page(pageInfo.pages);
				});
			}
			ul.append(nextLi).append(lastLi);
			// 将ul添加到nav
			nav.append(ul);
			// 将构造好的nav添加到table tbody
			nav.appendTo($("#nav_info_area"));
		}

		/**
		 * 获取所有可选的部门信息，显示在指定的下拉列表中
		 */
		function getDepts(elemSelector) {
			// 清空上一次的内容
			$(elemSelector).empty();
			$.ajax({
				url:"${ctx}/dept/list",
				type:"GET",
				success:function (result) {
					$.each(result.dataMap.depts,function (index, item) {
						var option = $("<option></option>").append(item.name).attr("value",item.id);
						$(elemSelector).append(option);
					});
				}
			});
		}

		/**
		 * 重置表单，并清空其子标签之前的样式
		 */
		function form_reset(formElementId) {
			$(formElementId)[0].reset();
			// document.getElementById(formElementId).reset();
			// 清空输入框的校验状态类
			$(formElementId).find("*").removeClass("has-error has-success");
			// // 清空校验信息显示的span的内容
			$(formElementId).find(".help-block").text("");
		}
		
		/**
		 * 使用bootstrap样式显示给元素显示校验结果
		 * Bootstrap 对表单控件的校验状态，如 error、warning 和 success 状态，都定义了样式。
		 * 使用时，添加 .has-warning、.has-error 或 .has-success 类到这些控件的父元素
		 */
		function show_validate_msg(element,status,msg) {
			// 先清除上一次的校验状态及显示的校验信息
			var parent = $(element).parent();
			parent.removeClass("has-error has-success");
			var msg_span = $(element).next("span");
			msg_span.text("");
			if(status == "success"){
				parent.addClass("has-success");
			}else if(status == "error"){
				parent.addClass("has-error");
			}
			msg_span.text(msg);
		}

	</script>
</body>
</html>
