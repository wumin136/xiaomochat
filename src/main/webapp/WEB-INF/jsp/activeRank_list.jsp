<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<link href="js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<table class="easyui-datagrid" id="productList" title="活跃度排名" data-options="singleSelect:false,collapsible:true,
		pagination:true,rownumbers:true,url:'product/list',method:'get',pageSize:20, fitColumns:true,
		toolbar:toolbar_product">
    <thead>
        <tr>
        	<th data-options="field:'ck',checkbox:true"></th>
        	<th data-options="field:'productId',align:'center',width:150">
				排名序号
			</th>
            <th data-options="field:'productName',align:'center',width:150">
				用户名称
			</th>
            <th data-options="field:'productType',align:'center',width:150">
				交互次数
			</th>
			<th data-options="field:'status',width:100,align:'center',formatter:TAOTAO.formatProductStatus">
				交互时长
			</th>
            <th data-options="field:'status',width:100,align:'center',formatter:TAOTAO.formatProductStatus">
				聊天数据总量
			</th>
        </tr>
    </thead>
</table>

<div  id="toolbar_product" style=" height: 22px; padding: 3px 11px; background: #fafafa;">  
	
	<c:forEach items="${sessionScope.sysPermissionList}" var="per" >
		<c:if test="${per=='product:delete' }" >
		    <div style="float: left;">  
		        <a href="#" class="easyui-linkbutton" plain="true" icon="icon-cancel" onclick="product_delete()">
					删除
				</a>
		    </div>  
		</c:if>
	</c:forEach>
	
	<div class="datagrid-btn-separator"></div>  
	
	<div style="float: left;">  
		<a href="#" class="easyui-linkbutton" plain="true" icon="icon-reload" onclick="product_reload()">
			刷新
		</a>
	</div>  
	
    <div id="search_product" style="float: right;">
        <input id="search_text_product" class="easyui-searchbox"  
            data-options="searcher:doSearch_product,prompt:'请输入排名规则...',menu:'#menu_product'"
            style="width:250px;vertical-align: middle;">
        </input>
        <div id="menu_product" style="width:120px"> 
			<div data-options="name:'productId'">排名序号</div>
			<div data-options="name:'productName'">交互次数</div>
			<div data-options="name:'productName'">交互时长</div>
			<div data-options="name:'productType'">聊天数据总量</div>
		</div>     
    </div>  

</div> 

<div id="productEditWindow" class="easyui-window" title="编辑产品" data-options="modal:true,closed:true,resizable:true,
	iconCls:'icon-save',href:'product/edit'" style="width:65%;height:80%;padding:10px;">
</div>
<div id="productAddWindow" class="easyui-window" title="添加产品" data-options="modal:true,closed:true,resizable:true,
	iconCls:'icon-save',href:'product/add'" style="width:65%;height:80%;padding:10px;">
</div>
<div id="productNoteDialog" class="easyui-dialog" title="产品介绍" data-options="modal:true,closed:true,resizable:true,
	iconCls:'icon-save'" style="width:55%;height:65%;padding:10px">
	<form id="productNoteForm" class="itemForm" method="post">
		<input type="hidden" name="productId"/>
	    <table cellpadding="5" >
	        <tr>
	            <td>备注:</td>
	            <td>
	                <textarea style="width:800px;height:450px;visibility:hidden;" name="note"></textarea>
	            </td>
	        </tr>
	    </table>
	</form>
	<div style="padding:5px">
	    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateProductNote()">保存</a>
	</div>
</div>
<script>
function doSearch_product(value,name){ //用户输入用户名,点击搜素,触发此函数  
	if(value == null || value == ''){
		$("#productList").datagrid({
	        title:'活跃度排名', singleSelect:false, collapsible:true, pagination:true, rownumbers:true, method:'get',
			nowrap:true, toolbar:"toolbar_product", url:'product/list', method:'get', loadMsg:'数据加载中......',
			fitColumns:true,//允许表格自动缩放,以适应父容器
	        columns : [ [ 
				{field : 'ck', checkbox:true },
				{field : 'productId', width : 150, align:'center', title : '排名序号'},
				{field : 'productName', width : 150, align : 'center', title : '交互次数'},
				{field : 'productType', width : 150, align : 'center', title : '交互时长'},
                {field : 'productType', width : 150, align : 'center', title : '聊天数据总量'}
	        ] ],  
	    });
	}else{
		$("#productList").datagrid({
            title:'活跃度排名', singleSelect:false, collapsible:true, pagination:true, rownumbers:true, method:'get',
            nowrap:true, toolbar:"toolbar_product", url:'product/list', method:'get', loadMsg:'数据加载中......',
            fitColumns:true,//允许表格自动缩放,以适应父容器
            columns : [ [
                {field : 'ck', checkbox:true },
                {field : 'productId', width : 150, align:'center', title : '排名序号'},
                {field : 'productName', width : 150, align : 'center', title : '交互次数'},
                {field : 'productType', width : 150, align : 'center', title : '交互时长'},
                {field : 'productType', width : 150, align : 'center', title : '聊天数据总量'}
            ] ],
        });
	}
}

	var productNoteEditor ;
	
	//更新产品要求
	function updateProductNote(){
		$.get("product/edit_judge",'',function(data){
    		if(data.msg != null){
    			$.messager.alert('提示', data.msg);
    		}else{
    			productNoteEditor.sync();
    			$.post("product/update_note",$("#productNoteForm").serialize(), function(data){
    				if(data.status == 200){
    					$("#productNoteDialog").dialog("close");
    					$("#productList").datagrid("reload");
    					$.messager.alert("操作提示", "更新产品介绍成功！");
    				}else{
    					$.messager.alert("操作提示", "更新产品介绍失败！");
    				}
    			});
    		}
    	});
	}
	
    function getProductSelectionsIds(){
    	var productList = $("#productList");
    	var sels = productList.datagrid("getSelections");
    	var ids = [];
    	for(var i in sels){
    		ids.push(sels[i].productId);
    	}
    	ids = ids.join(","); 
    	
    	return ids;
    }

    
    function product_delete(){
    	$.get("product/delete_judge",'',function(data){
       		if(data.msg != null){
                $.messager.confirm('确认','确定删除ID为 '+ids+' 的产品吗？',function(r){
                    if (r){
                        var params = {"ids":ids};
                        $.post("product/delete_batch",params, function(data){
                            if(data.status == 200){
                                $.messager.alert('提示','删除产品成功!',undefined,function(){
                                    $("#productList").datagrid("reload");
                                });
                            }
                        });
                    }
                });
       		}else{
       			var ids = getProductSelectionsIds();
            	if(ids.length == 0){
            		$.messager.alert('提示','未选中产品!');
            		return ;
            	}
            	$.messager.confirm('确认','确定删除ID为 '+ids+' 的产品吗？',function(r){
            	    if (r){
            	    	var params = {"ids":ids};
                    	$.post("product/delete_batch",params, function(data){
                			if(data.status == 200){
                				$.messager.alert('提示','删除产品成功!',undefined,function(){
                					$("#productList").datagrid("reload");
                				});
                			}
                		});
            	    }
            	});
       		}
       	});
    }
    
    function product_reload(){
    	$("#productList").datagrid("reload");
    }
    
</script>