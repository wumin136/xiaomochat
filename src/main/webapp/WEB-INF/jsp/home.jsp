<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@page import="org.apache.shiro.session.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/jsp/commons/common_js.jsp"%>
<%@ include file="/WEB-INF/jsp/commons/common_css.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>智能聊天客服机器人系统</title>
<style type="text/css">
.content {
	padding: 10px 10px 10px 10px;
}
.divNorth{
	background:url('/image/TitleBackground.jpg') no-repeat center center;
	background-size:100% 100%;
}
</style>
</head>
<body class="easyui-layout">

	<!-- North Title -->
	<div class="divNorth" style="height:100px;" data-options="region:'north'" >
		<table id="_TableHeader" width="100%" border="0" cellpadding="0"
		cellspacing="0" class="bluebg">
		<tbody>
			<tr>
				<td valign="top">
					<div style="position:relative;">
						<div style="text-align:right;font-size:15px;margin:2px 0 0 0;">
							<span style="display:inline-block;font-size:20px;color:#c1dff7;margin:0 0 8px 0;">
								华中科技大学软件学院
							</span><br/>
							
							<span style="color:#c1dff7">
								${activeUser.rolename}:
							</span>
							<span style="color:#c1dff7">
								${activeUser.username}
							</span>
						    &nbsp;<a href="logout" style="text-decoration:none;color:#A9C3D6"> 退出</a>&nbsp;  &nbsp;
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	
	<!-- <div data-options="region:'west',title:'功能菜单',split:true"
		style="width:213px;"> -->
	<div id="HomeFuncAccordion" class="easyui-accordion" style="width:213px;"
		data-options="region:'west',title:'功能菜单',split:false">
		<div title="功能搜索"
			data-options="iconCls:'icon-search',collapsed:false,collapsible:false"
			style="padding:10px;">
			<input id="HomeFuncSearch" class="easyui-searchbox" 
				data-options={prompt:'请输入想要搜索的功能'}
				searcher="doSearch" 
				style="width:178px;height:25px;">
			<!---------------------------------------------------->
			<!-- http://www.jeasyui.net/demo/408.html#  ExpandTo-->
			<!---------------------------------------------------->
		</div>

		<div title="用户管理" data-options="selected:true" style="padding:10px;">
			<ul id="scheduleMonitor" class="easyui-tree" data-options="animate:true,lines:true">
				<li><span>用户管理</span>

					<ul>
						<li id=11 data-options="attributes:{'url':'user/find'}">用户信息列表</li>
					</ul>
					<ul>
						<li id=12 data-options="attributes:{'url':'record/find'}">操作流水记录</li>
					</ul>
					<ul>
						<li id=13 data-options="attributes:{'url':'activeRank/find'}">活跃度排名</li>
					</ul>
				</li>
			</ul>
		</div>

		<div title="知识库管理" data-options="selected:true" style="padding:10px">
			<ul id="deviceMonitor" class="easyui-tree" data-options="animate:true,lines:true">
				<li><span>知识库管理</span>
					<ul>
						<li id=21 data-options="attributes:{'url':'library/find'}">聊天库管理</li>
                        <!--
						<li id=22 data-options="attributes:{'url':'material/find'}">专业知识库</li>
						-->
					</ul></li>
			</ul>
		</div>

		<c:if test="${activeUser.rolename == '超级管理员' }">
			<div title="系统管理" style="padding:10px;">

				<ul id="sysManager" class="easyui-tree"
					data-options="animate:true,lines:true">
					<li><span>系统管理</span>
						<ul>
							<li data-options="attributes:{'url':'manager/find'}">管理员管理</li>
						</ul>
						<ul>
							<li data-options="attributes:{'url':'role/find'}">角色管理</li>
						</ul>
					</li>
				</ul>
			</div>
		</c:if>

	</div>

	<!-- </div> -->
	<div id="MainPage" data-options="region:'center',title:''">
		<div id="tabs" class="easyui-tabs">
			<div title="首页" style="padding:20px;"></div>
		</div>
	</div>
	
	<script type="text/javascript">

		var allItem = [
						["用户管理","用户信息列表","操作流水记录","活跃度排名"],
						["知识库管理","聊天库管理"]
					  ];
					  
		function isContains(str, substr) {
		    return new RegExp(substr).test(str);
		}
		
		//HomeFuncSearch
		function doSearch(value){
			var subItem;
			var ifElseContain = false;
			for (var i = 0; i < allItem.length; i++) {
				for (var j = 0; j < allItem[i].length; j++) {
					subItem = allItem[i][j];
					if(isContains(subItem,value) && value!=""){
						ifElseContain=true;
						if(j==0){
							switch(i){
								case 0 : 
									$('#HomeFuncAccordion').accordion('select',allItem[0][0]);
									var node = $('#scheduleMonitor').tree('find',11);
									$('#scheduleMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 1 :
									$('#HomeFuncAccordion').accordion('select',allItem[1][0]);
									var node = $('#deviceMonitor').tree('find',21);
									$('#deviceMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 2 :
									$('#HomeFuncAccordion').accordion('select',allItem[2][0]);
									var node = $('#technologyMonitor').tree('find',31);
									$('#technologyMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 3 :
									$('#HomeFuncAccordion').accordion('select',allItem[3][0]);
									var node = $('#materialMonitor').tree('find',41);
									$('#materialMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 4 :
									$('#HomeFuncAccordion').accordion('select',allItem[4][0]);
									var node = $('#qualifyMonitor').tree('find',51);
									$('#qualifyMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 5 :
									$('#HomeFuncAccordion').accordion('select',allItem[5][0]);
									var node = $('#employeeMonitor').tree('find',61);
									$('#employeeMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								default:
									break; 
							}
						}else if(j>0){
							var k = (i+1)*10+j;
							switch(i){
								case 0 : 
									$('#HomeFuncAccordion').accordion('select',allItem[0][0]);
									var node = $('#scheduleMonitor').tree('find',k);
									$('#scheduleMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 1 :
									$('#HomeFuncAccordion').accordion('select',allItem[1][0]);
									var node = $('#deviceMonitor').tree('find',k);
									$('#deviceMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 2 :
									$('#HomeFuncAccordion').accordion('select',allItem[2][0]);
									var node = $('#technologyMonitor').tree('find',k);
									$('#technologyMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 3 :
									$('#HomeFuncAccordion').accordion('select',allItem[3][0]);
									var node = $('#materialMonitor').tree('find',k);
									$('#materialMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 4 :
									$('#HomeFuncAccordion').accordion('select',allItem[4][0]);
									var node = $('#qualifyMonitor').tree('find',k);
									$('#qualifyMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								case 5 :
									$('#HomeFuncAccordion').accordion('select',allItem[5][0]);
									var node = $('#employeeMonitor').tree('find',k);
									$('#employeeMonitor').tree('expandTo', node.target).tree('select', node.target);
									break;
								default:
									break; 
							}
							
						}
						break;
					}
				}
				if(ifElseContain==true){
					break;
				}
			}
		}  
		
		$(function() {
			/* Schedule Manager Tree onClick Event */
			$('#scheduleMonitor').tree({
				onClick : function(node) {
					if ($('#scheduleMonitor').tree("isLeaf", node.target)) {
						var tabs1 = $("#tabs");
						var tab1 = tabs1.tabs("getTab", node.text);
						if (tab1) {
							tabs1.tabs("select", node.text);
						} else {
							tabs1.tabs('add', {
								title : node.text,
								href : node.attributes.url,
								closable : true,
								bodyCls : "content"
							});
						}
					}
				}
			});
	
			/* Device Manager Tree onClick Event */
			$('#deviceMonitor').tree({
				onClick : function(node) {
					/* debugger; */
					if ($('#deviceMonitor').tree("isLeaf", node.target)) {
						var tabs2 = $("#tabs");
						var tab2 = tabs2.tabs("getTab", node.text);
						if (tab2) {
							tabs2.tabs("select", node.text);
						} else {
							tabs2.tabs('add', {
								title : node.text,
								href : node.attributes.url,
								closable : true,
								bodyCls : "content"
							});
						}
					}
				}
			});
			
			/* Material Manager Tree onClick Event */
			$('#materialMonitor').tree({
				onClick : function(node) {
					if ($('#materialMonitor').tree("isLeaf", node.target)) {
					var tabs2 = $("#tabs");
						var tab2 = tabs2.tabs("getTab", node.text);
						if (tab2) {
							tabs2.tabs("select", node.text);
						} else {
							tabs2.tabs('add', {
								title : node.text,
								href : node.attributes.url,
								closable : true,
								bodyCls : "content"
							});
						}
					}
				}
			});
			
			/* qualify Manager Tree onClick Event */
			$('#qualifyMonitor').tree({
				onClick : function(node) {
					if ($('#qualifyMonitor').tree("isLeaf", node.target)) {
						var tabs1 = $("#tabs");
						var tab1 = tabs1.tabs("getTab", node.text);
						if (tab1) {
							tabs1.tabs("select", node.text);
						} else {
							tabs1.tabs('add', {
								title : node.text,
								href : node.attributes.url,
								closable : true,
								bodyCls : "content"
							});
						}
					}
				}
			});
			
			/* Technology Manager Tree onClick Event */
			$('#technologyMonitor').tree({
				onClick : function(node) {
					if ($('#technologyMonitor').tree("isLeaf", node.target)) {
						var tabs3 = $("#tabs");
						var tab3 = tabs3.tabs("getTab", node.text);
						if (tab3) {
							tabs3.tabs("select", node.text);
						} else {
							tabs3.tabs('add', {
								title : node.text,
								href : node.attributes.url,
								closable : true,
								bodyCls : "content"
							});
						}
					}
				}
			});
			
			/* Device Manager Tree onClick Event */
			$('#employeeMonitor').tree({
				onClick : function(node) {
					/* debugger; */
					if ($('#deviceMonitor').tree("isLeaf", node.target)) {
						var tabs2 = $("#tabs");
						var tab2 = tabs2.tabs("getTab", node.text);
						if (tab2) {
							tabs2.tabs("select", node.text);
						} else {
							tabs2.tabs('add', {
								title : node.text,
								href : node.attributes.url,
								closable : true,
								bodyCls : "content"
							});
						}
					}
				}
			});
			
			/* Sys Manager Tree onClick Event */
			$('#sysManager').tree({
				onClick : function(node) {
					if ($('#sysManager').tree("isLeaf", node.target)) {
						var tabs3 = $("#tabs");
						var tab3 = tabs3.tabs("getTab", node.text);
						if (tab3) {
							tabs3.tabs("select", node.text);
						} else {
							tabs3.tabs('add', {
								title : node.text,
								href : node.attributes.url,
								closable : true,
								bodyCls : "content"
							});
						}
					}
				}
			});
						
	});
		
	</script>
</body>
</html>