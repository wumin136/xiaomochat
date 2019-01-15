<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<link href="js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/lang/zh_CN.js"></script>

<!-- Table -->
<table class="easyui-datagrid" id="deviceList" title="操作流水记录"
       data-options="singleSelect:false,collapsible:true,pagination:true,rownumbers:true,
       	url:'deviceList/list',method:'get',pageSize:30, fitColumns:true,toolbar:toolbar_device">
    <thead>
        <tr>
        	<th data-options="field:'ck',checkbox:true">
			</th>
        	<th data-options="field:'deviceId',width:100,align:'center'">
				用户编号
			</th>
            <th data-options="field:'deviceName',width:100,align:'center'">
				用户名称
			</th>
            <th data-options="field:'devicePurchaseDate',width:130,align:'center',formatter:TAOTAO.formatDateTime">
				交互时间
			</th>
            <th data-options="field:'deviceKeeper',width:100,align:'center',formatter:formatDeviceKeeper_deviceList">
				动作记录
			</th>
        </tr>
    </thead>
</table>

<!-- Toolbar -->
<div  id="toolbar_device" style=" height: 22px; padding: 3px 11px; background: #fafafa;">

	<c:forEach items="${sessionScope.sysPermissionList}" var="per" >
		<c:if test="${per=='deviceList:delete'}">
			<div style="float: left;">
				<a href="#" class="easyui-linkbutton" plain="true" icon="icon-cancel" onclick="device_delete()">删除</a>
			</div>
		</c:if>
	</c:forEach>

	<div class="datagrid-btn-separator"></div>  
	
	<div style="float: left;">  
		<a href="#" class="easyui-linkbutton" plain="true" icon="icon-reload" onclick="device_reload()">刷新</a>  
	</div>  
	
    <div id="search_device" style="float: right;">
        <input id="search_text_device" class="easyui-searchbox"  
            data-options="searcher:doSearch_device,prompt:'请输入...',menu:'#menu_device'"  
            style="width:250px;vertical-align: middle;">
        </input>
        <div id="menu_device" style="width:120px"> 
			<div data-options="name:'deviceId'">用户编号</div>
			<div data-options="name:'deviceName'">用户名称</div>
			<div data-options="name:'devicePurchaseDate'">交互时间</div>
			<div data-options="name:'deviceKeeper'">动作记录</div>
		</div>     
    </div>  

</div>

<script>
function doSearch_device(value,name){ //用户输入用户名,点击搜素,触发此函数  
	if(value == null || value == ''){
		$("#deviceList").datagrid({
	        title:'操作流水记录', singleSelect:false, collapsible:true, pagination:true, rownumbers:true, method:'get',
			nowrap:true, toolbar:"toolbar_device", url:'deviceList/list', method:'get', loadMsg:'数据加载中......',
			fitColumns:true,//允许表格自动缩放,以适应父容器
	        columns : [ [ 
				{field : 'ck', checkbox:true },
				{field : 'deviceId', width : 100, align:'center', title : '用户编号'},
				{field : 'deviceName', width : 100, align : 'center', title : '用户名称'},
				{field : 'devicePurchaseDate', width : 130, title : '交互时间', align:'center',
					formatter:TAOTAO.formatDateTime},
				{field : 'deviceKeeper', width : 100, title : '动作记录', align:'center',
					formatter:formatDeviceKeeper_deviceList}
	        ] ],  
	    });
	}else{
		$("#deviceList").datagrid({
            title:'操作流水记录', singleSelect:false, collapsible:true, pagination:true, rownumbers:true, method:'get',
            nowrap:true, toolbar:"toolbar_device", url:'deviceList/list', method:'get', loadMsg:'数据加载中......',
            fitColumns:true,//允许表格自动缩放,以适应父容器
            columns : [ [
                {field : 'ck', checkbox:true },
                {field : 'deviceId', width : 100, align:'center', title : '用户编号'},
                {field : 'deviceName', width : 100, align : 'center', title : '用户名称'},
                {field : 'devicePurchaseDate', width : 130, title : '交互时间', align:'center',
                    formatter:TAOTAO.formatDateTime},
                {field : 'deviceKeeper', width : 100, title : '动作记录', align:'center',
                    formatter:formatDeviceKeeper_deviceList}
            ] ],
	    });
	}
}

	/*********************************** Toolbar function ***********************************/
	function getDeviceSelectionsIds(){
		var deviceList = $("#deviceList");
		var sels = deviceList.datagrid("getSelections");
		var ids = [];
		for(var i in sels){
			ids.push(sels[i].deviceId);
		}
		ids = ids.join(","); 
		return ids;
	}

    
    function device_delete(){
    	$.get("deviceList/delete_judge",'',function(data){
       		if(data.msg != null){
                $.messager.confirm('确认','确定删除ID为 '+ids+' 的设备吗？',function(r){
                    if (r){
                        var params = {"ids":ids};
                        $.post("deviceList/delete_batch",params, function(data){
                            if(data.status == 200){
                                $.messager.alert('提示','删除设备成功!',undefined,function(){
                                    $("#deviceList").datagrid("reload");
                                });
                            }
                        });
                    }
                });
       		}else{
       			var ids = getDeviceSelectionsIds();
    	    	if(ids.length == 0){
    	    		$.messager.alert('提示','未选中设备!');
    	    		return ;
    	    	}
    	    	$.messager.confirm('确认','确定删除ID为 '+ids+' 的设备吗？',function(r){
    	    	    if (r){
    	    	    	var params = {"ids":ids};
    	            	$.post("deviceList/delete_batch",params, function(data){
    	        			if(data.status == 200){
    	        				$.messager.alert('提示','删除设备成功!',undefined,function(){
    	        					$("#deviceList").datagrid("reload");
    	        				});
    	        			}
    	        		});
    	    	    }
    	    	});
       		}
       	});
    }
    
    function device_reload(){
    	$("#deviceList").datagrid("reload");
    }

/*********************************** Toolbar function ***********************************/

var deviceNoteEditor ;

//根据index拿到该行值
function onDeviceClickRow(index) {
    var rows = $('#deviceList').datagrid('getRows');
    return rows[index];

}

/************************************ DeviceType Relative Object ************************************/
//格式化设备种类
function formatDeviceType_deviceList(value, row, index){
    if(value !=null && value != ''){
        return "<a href=javascript:openDeviceType_deviceList("+index+")>"+row.deviceTypeName+"</a>";
    }else{
        return "无";
    }
};
/* DeviceType Relative Object */

//打开设备种类对话框
function  openDeviceType_deviceList(index){
    var row = onDeviceClickRow(index);
    $("#deviceTypeInfo_deviceList").dialog({
        onOpen :function(){
            $.get("deviceType/get/"+row.deviceTypeId,'',function(data){
                //回显数据
                data.deviceTypeWarranty = TAOTAO.formatDateTime(data.deviceTypeWarranty);
                $("#deviceTypeInfo_deviceList").form("load", data);
            });
        }
    }).dialog("open");
};

//提交设备种类信息
function submitDeviceTypeEditForm_deviceList(){
    $.get("deviceType/edit_judge",'',function(data){
        if(data.msg != null){
            $.messager.alert('提示', data.msg);
        }else{
            if(!$('#deviceTypeEditForm_deviceList').form('validate')){
                $.messager.alert('提示','表单还未填写完成!');
                return ;
            }
            $.post("deviceType/update_all",$("#deviceTypeEditForm_deviceList").serialize(), function(data){
                if(data.status == 200){
                    $.messager.alert('提示','修改设备种类信息成功!','info',function(){
                        $("#deviceTypeInfo_deviceList").dialog("close");
                    });
                }else{
                    $.messager.alert('错误','修改设备种类信息失败!');
                }
            });
        }
    });
}

//提交设备保管人信息
function submitDeviceKeeperEditForm_deviceList(){
    $.get("employee/edit_judge",'',function(data){
        if(data.msg != null){
            $.messager.alert('提示', data.msg);
        }else{
            if(!$('#deviceKeeperEditForm_deviceList').form('validate')){
                $.messager.alert('提示','表单还未填写完成!');
                return ;
            }
            $.post("employee/update_all",$("#deviceKeeperEditForm_deviceList").serialize(), function(data){
                if(data.status == 200){
                    $.messager.alert('提示','修改保管人信息成功!','info',function(){
                        $("#deviceKeeperInfo_deviceList").dialog("close");
                    });
                }else{
                    $.messager.alert('错误','修改保管人信息失败!');
                }
            });
        }
    });
}
/************************************ DeviceType Relative Object ************************************/

/************************************ DeviceKeeper Relative Object ************************************/
//格式化保管人信息
function formatDeviceKeeper_deviceList(value, row, index){
    if(value !=null && value != ''){
        return "<a href=javascript:openDeviceKeeper_deviceList("+index+")>"+row.deviceKeeper+"</a>";
    }else{
        return "无";
    }
};

//打开保管人信息对话框
function  openDeviceKeeper_deviceList(index){
    var row = onDeviceClickRow(index);
    $("#deviceKeeperInfo_deviceList").dialog({
        onOpen :function(){
            $.get("employee/get/"+row.deviceKeeperId,'',function(data){
                //回显数据
                data.birthday = TAOTAO.formatDateTime(data.birthday);
                data.joinDate = TAOTAO.formatDateTime(data.joinDate);
                data.departmentId=data.department.departmentId;
                data.departmentName=data.department.departmentName;
                $("#deviceKeeperInfo_deviceList").form("load", data);
            });
        }
    }).dialog("open");
};

//提交设备保管人信息
function submitDeviceTypeEditForm_deviceList(){
    $.get("deviceType/edit_judge",'',function(data){
        if(data.msg != null){
            $.messager.alert('提示', data.msg);
        }else{
            if(!$('#deviceTypeEditForm_deviceList').form('validate')){
                $.messager.alert('提示','表单还未填写完成!');
                return ;
            }
            $.post("deviceType/update_all",$("#deviceTypeEditForm_deviceList").serialize(), function(data){
                if(data.status == 200){
                    $.messager.alert('提示','修改设备种类信息成功!','info',function(){
                        $("#deviceTypeInfo_deviceList").dialog("close");
                    });
                }else{
                    $.messager.alert('错误','修改设备种类信息失败!');
                }
            });
        }
    });
}
/************************************ DeviceKeeper Relative Object ************************************/

/************************************ NoteRelative Object ************************************/
//格式化设备介绍
function formatDeviceNote(value, row, index){
    if(value !=null && value != ''){
        return "<a href=javascript:openDeviceNote("+index+")>"+"设备介绍"+"</a>";
    }else{
        return "无";
    }
}

function  openDeviceNote(index){
    var row = onDeviceClickRow(index);
    $("#deviceNoteDialog").dialog({
        onOpen :function(){
            $("#deviceNoteForm [name=deviceId]").val(row.deviceId);
            deviceNoteEditor = TAOTAO.createEditor("#deviceNoteForm [name=note]");
            deviceNoteEditor.html(row.note);
        },
        onBeforeClose: function (event, ui) {
            // 关闭Dialog前移除编辑器
            KindEditor.remove("#deviceNoteForm [name=note]");
        }
    }).dialog("open");
};

function updateDeviceNote(){
    $.get("deviceList/edit_judge",'',function(data){
        if(data.msg != null){
            $.messager.alert('提示', data.msg);
        }else{
            deviceNoteEditor.sync();
            $.post("deviceList/update_note",$("#deviceNoteForm").serialize(), function(data){
                if(data.status == 200){
                    $("#deviceNoteDialog").dialog("close");
                    $("#deviceList").datagrid("reload");
                    $.messager.alert("操作提示", "更新设备介绍成功！");
                }else{
                    $.messager.alert("操作提示", "更新设备介绍失败！","error");
                }
            });
        }
    });
}
/************************************ NoteRelative Object ************************************/
</script>