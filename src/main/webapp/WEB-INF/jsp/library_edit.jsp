<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="js/kindeditor-4.1.10/themes/default/default.css" type="text/css" rel="stylesheet">

<link href="css/uploadfile.css" rel="stylesheet">
<script src="js/jquery.uploadfile.js"></script>
<script src="js/malsup.github.iojquery.form.js"></script>

<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/kindeditor-all-min.js"></script>
<script type="text/javascript" charset="utf-8" src="js/kindeditor-4.1.10/lang/zh_CN.js"></script>
<div style="padding:10px 10px 10px 10px">
    <form id="orderEditForm" class="orderForm" method="post">
        <input type="hidden" name="orderId"/>
        <table cellpadding="5">
            <tr>
                <td>聊天库名称:</td>
                <td>
                    <input id="custom" class="easyui-combobox" name="customId"  panelHeight="auto"
                           data-options="required:true,valueField:'customId',textField:'customName',
						   url:'custom/get_data', editable:false" />
                </td>
            </tr>
            <tr>
                <td>聊天库类别:</td>
                <td>
                    <select id="cc" class="easyui-combobox" name="status" panelHeight="auto"
                            data-options="required:true, width:150, editable:false">
                        <option value="寒暄问候">寒暄问候</option>
                        <option value="学习情况">学习情况</option>
                        <option value="日常交友">日常交友</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>所属范畴:</td>
                <td>
                    <select class="easyui-combobox" name="status" panelHeight="auto" data-options="required:true,
		            		width:150, editable:false">
                        <option value="日常聊天">日常聊天</option>
                        <option value="专业聊天">专业聊天</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>聊天库文件:</td>
                <td>
                    <div id="orderEditFileUploader">上传文件</div>
                    <input id="orderEditFile" type="hidden" name="file"/>
                </td>
            </tr>
        </table>
    </form>
    <div style="padding:5px">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitOrderEditForm()">提交</a>
    </div>
</div>
<script type="text/javascript">

    var orderEditEditor ;
    $(function(){
        //实例化富文本编辑器
        orderEditEditor = TAOTAO.createEditor("#orderEditForm [name=note]");
    });
    //同步kindeditor中的内容
    orderEditEditor.sync();

    function submitOrderEditForm(){
        if(!$('#orderEditForm').form('validate')){
            $.messager.alert('提示','表单还未填写完成!');
            return ;
        }
        orderEditEditor.sync();

        $.post("order/update_all",$("#orderEditForm").serialize(), function(data){
            if(data.status == 200){
                $.messager.alert('提示','修改订单成功!','info',function(){
                    $("#orderEditWindow").window('close');
                    $("#orderList").datagrid("reload");
                });
            }else{
                $.messager.alert('提示',data.msg);
            }
        });
    }
</script>
