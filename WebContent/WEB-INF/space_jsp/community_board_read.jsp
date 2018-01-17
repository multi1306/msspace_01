<%@ page contentType="text/html;charset=utf-8" pageEncoding="euc-kr"%><%@
taglib prefix="jl" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);

</style>
<script src="common.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



<script>

$(document).ready(function() {

		/* �������� �� find_reple() �̺�Ʈ ���� */
		find_reple();
		
		/* �⺻ ���â �ݱ� ��ư ���� �� �� */
		$("#basic_modal_Yes").on("click",function(){
			$("#modal").modal("hide");
		});
		/* ��� ���� ���â �ݱ� ��ư Ŭ�� ���� �� */
		$("#del_modal_No").on("click",function(){
			$("#del_modal").modal("hide");
		});
		
		//�ۻ���
		$("#btnDel").on("click",function(){
			$("#deltext").modal("show");
			$("#del_text_modal_Yes").on("click",function(){
				$("#deltext").modal("hide");
				$("#basic_mobody").html("<h4>���� ���� �Ǿ����ϴ�.</h4>");
				$("#modal").modal("show");
				
				$("#modal").on("hidden.bs.modal",function(){
					$("#textDelform").submit();
				});
			});
			$("#del_text_modal_No").on("click",function(){
				$("#deltext").modal("hide");
			});
		});
		//�ۻ�����
	
	
	    $("#btnClose").on("click",function(){
	    	$("#repleModal").modal("hide");
	    });

		/* ��� ���� �񵿱� ó�� */
		$(document).on("click",".modReple",function() {
			$("#com_board_reple_no").val($(this).attr("xyz"));
			$("#content").val($("#" + $(this).attr("abcd")).text());
			$("lblcontent").text("�۹�ȣ :" + $(this).attr("xyz"));
			$("#repleModal").modal("show");
			
			$("#btnMod").on("click",function(){
				var formData = $("#reple_form").serialize();
				$.ajax({
					type : "POST",
					url : "community_board_replemod.do",
					data : formData,
					success	: function(rt) {
						$("#repleModal").modal("hide");
						if(rt=="ok"){
							$("#basic_mobody").html("<h4>����� ���� �Ǿ����ϴ�.</h4>");
							$("#modal").modal("show");
							$("#modal").on("hidden.bs.modal",function(){
								$("#modal").modal("hide");
								$("#com_board_reple_content").val("");
								find_reple();
							});
						}else if(rt=="no"){
							$("#basic_mobody").text("<h4>��� ���� ó���� ���� �Ǿ����ϴ�.</h4>");
							$("#modal").modal("show");
							$("#modal").on("hidden.bs.modal",function(){
								$("#modal").modal("hide");
								find_reple();
							});
						}
				    }
				});	
			});
		});

	    $(".abcd").on("click",function(e){
	           alert();
	    });
	    /* ��� ���� �񵿱� ó�� */
    
		/* ��� ���� �κ� �񵿱� ó�� */
		$(document).on("click",".delRe",function(){
 			var com_board_reple_no = $(this).attr("aa");
			var com_board_no = $(this).attr("bb");
			$("#del_modal").modal("show");
			$("#del_modal_Yes").on("click",function(){
				var url = "community_board_repledel.do?com_board_reple_no="+com_board_reple_no+"&com_board_no="+com_board_no;
				ajaxGet(url,function(rt){
					$("#del_modal").modal("hide");
					if(rt=="ok"){
						$("#basic_mobody").html("<h4>����� ���� �Ǿ����ϴ�.</h4>");
						$("#modal").modal("show");
						$("#modal").on("hidden.bs.modal",function(){
							$("#modal").modal("hide");
							find_reple();
						});
					}else if(rt=="no"){
						$("#basic_mobody").html("<h4>��� ���� ó���� ���� �Ǿ����ϴ�.</h4>");
						$("#ft").html("");
						$("#modal").modal("show");
						$("#modal").on("hidden.bs.modal",function(){
							$("#modal").modal("hide");
							find_reple();
						});
					}
				});
			});
			$("#modal-del-No").on("click",function(){
				$("#modal").modal("hide");
			}); 
		});
		/* ��� ���� �κ� �񵿱� ó�� */
	
		//��õ
		$("#btnrecom").on("click",function(){
			var dc = "?dc=" + new Date().getTime();
			var url = "community_board_recom.do" + dc	+ "&user_id=aav&com_board_no=${vo.com_board_no}";
			ajaxGet(url, function(rt) {
				if (rt == -1) {
					$("#basic_mobody").html("<h4>�̹� ��õ�ϼ̽��ϴ�.</h4>");
					$("#modal").modal("show");
				} 
				else {
					$("#basic_mobody").html("<h4>��õ �Ǿ����ϴ�.</h4>");
					$("#modal").modal("show");
					e("recomCount").innerHTML = rt;
				}
			});
		});
		//��õ��
		
		/* ��� ��� �κ� �񵿱� ó�� */
		$("#submit_btn").on("click",function(){
			var formData = $("#add_reple_frm").serialize();
			$.ajax({
				type : "POST",
				url : "community_board_addreple.do",
				data : formData,
				success	: function(rt) {
					if(rt=="ok"){
						$("#basic_mobody").html("<h4>����� ��� �Ǿ����ϴ�.</h4>");
						$("#modal").modal("show");
						$("#modal").on("hidden.bs.modal",function(){
							$("#modal").modal("hide");
							$("#com_board_reple_content").val("");
							find_reple();
						});
					}else if(rt=="no"){
						$("#basic_mobody").html("<h4>��� ó���� ���� �Ǿ����ϴ�.</h4>");
						$("#modal").modal("show");
						$("#modal").on("hidden.bs.modal",function(){
							$("#modal").modal("hide");
							find_reple();
						});
					}
			    }
			});	
		});
		/* ��� ��� �κ� �񵿱� ó�� */
	})
	
	/* ��� ��ȸ �񵿱� ó�� */
	function find_reple(){
			var url = "community_board_read_reple.do?com_board_no="+${vo.com_board_no};
		 	ajaxGet(url,function(rt){
			 	if(rt!=''){
				 	var list = window.eval("("+rt+")");
				 	var html = "<tr><th>NO</th><th>CONTENT</th><th>TIME</th><th>USERID</th></tr>";
				 	for( var i = 0 ; i < list.data.length ; i++ ){
				 		html += "<tr><td>"+list.data[i].com_board_reple_no+"</td>";
				 		html += "<td> <span id='rb_"+list.data[i].com_board_reple_no+"'>"+list.data[i].com_board_reple_content+"</span>";
						if('${user_id == list.data[i].user_id}'){
				 			html += " <input type='button' class='modReple' value='����' abcd='rb_"+list.data[i].com_board_reple_no+"' xyz='"+list.data[i].com_board_reple_no+"' />";
					 		html += " <input type='button' class='delRe' value='����' aa='"+list.data[i].com_board_reple_no+"' bb='"+list.data[i].com_board_no+"'/></td></tr>";
						}
				 	}//end for
	                $('#reple_tr').html(html);
			 	}else{
			 		$('#reple_tr').html("");
			 	}
		 	});
		}
	/* ��� ��ȸ �񵿱� ó�� */
</script>


</head>
<body>
	<div class="jumbotron" style="background-color: green"> 
		<h1>�����Խ��� �ۺ��� </h1>
	</div>
	<table class="table ">
<!--  �����̺�-->
		<tr>
			<td >NO : ${vo.com_board_no} </td>
			
			<td colspan="2"> ���� : ${vo.com_board_title}</td>
			
		</tr>
		
		<tr>
			<td >ID : ${vo.user_id} </td>
			<td colspan="2">VIEW : ${vo.view_count} LIKE : <div id="recomCount">${vo.recom_count}</div></td>
		</tr>
		
		<tr>
			<td colspan="3">${vo.com_board_content}</td>
		</tr>
		<tr>
		<td colspan="6" align="center"></td>
		</tr>
		
		
		
		<!-- ������̺� -->
		<!-- ��� ����Ʈ�� �߰��� ���� -->
		<table class="table" id="reple_tr">
		
		</table>
	</table>

<!--  �ۼ���-->
	<form action="community_board_mod.do" method="POST">
		<input type="hidden" name="com_board_no" value="${vo.com_board_no}" /> 
		<input type="hidden" name="com_board_title" value="${vo.com_board_title}" /> 
		<input type="hidden" name="user_id" value="${vo.user_id}" /> 
		<input type="hidden" name="com_board_content" value="${vo.com_board_content}" /> 
		<jl:if test="${vo.user_id eq user_id}"><input type="submit" id="mod"  class="btn btn-primary" value="�� �����ϱ�" />
		</jl:if>
	</form>
<!--  �ۼ����� -->	


<!--  �ۻ���-->	
	<form action="community_board_del.do" method="POST" id="textDelform">
		<input type="hidden" name="com_board_no" value="${vo.com_board_no}" /> 
		<jl:if test="${vo.user_id eq user_id}"><input type="button" id="btnDel" class="btn btn-primary" value="�� �����ϱ�" />
		</jl:if>
	</form>
<!--  �ۻ����� -->	
	
	
<!-- ��õ��ư -->
	<input type="button" id="btnrecom"  class="btn btn-primary" value="��õ��ư" />
	
<!--  ����߰� -->
	<form id="add_reple_frm">
		���: <input type="text" id="com_board_reple_content" name="com_board_reple_content" size="30"/> 
		<input type="hidden" name="com_board_no" value="${vo.com_board_no}"/> 
		<input type="hidden" name="user_id" value="${vo.user_id}" /> 
		<input id="submit_btn" type="button" class="btn btn-primary" value="��۴ޱ�!" />
	</form>
<!--  ����߰��� -->	
	
	
<!-- ��޺κ� -->
			
	<!-- ��� ���� modalâ ���� -->
	<form id="reple_form">
		<div id="repleModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div id="mohead" class="modal-header" align="center"><h4>��ۼ���</h4></div>
					<div id="mobody" class="modal-body" align="center">
						<textarea id="content" name='com_board_reple_content'class='form-control' rows='7'></textarea>
					</div>
					<div id="ft" class="modal-footer">
						<button type='button' class='btn btn-default' id='btnMod'>����</button>
						<button type='button' class='btn btn-primary' id='btnClose'>���</button>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" id="com_board_no" value="${vo.com_board_no}" name="com_board_no" />
		<input id="com_board_reple_no" type="hidden" name="com_board_reple_no" />
	</form>
	<!-- ��� ���� modalâ �� -->
	<!-- ��� ���� modalâ ���� -->
	<div id="del_modal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="mohead" class="modal-header" align="center"><h4>��� ����</h4></div>
				<div id="mobody" class="modal-body" align="center">
					<h4>����� �����Ͻðڽ��ϱ�?</h4>
				</div>
				<div id="ft" class="modal-footer">
					<button type='button' class='btn btn-default' id='del_modal_Yes'>����</button>
					<button type='button' class='btn btn-primary' id='del_modal_No'>���</button>
				</div>
			</div>
		</div>
	</div>
	<input id="del_board_reple_no" name='c_board_reple_no' type='hidden'/>
	<input id="del_board_no" name='c_board_no' type='hidden'/>
	<!-- ��� ���� modalâ �� -->

	<!-- �⺻ modalâ ���� -->
	<div id="modal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="basic_mobody" class="modal-body" align="center">
				</div>
				<div id="basic_ft" class="modal-footer">
					<button type='button' class='btn btn-default' id='basic_modal_Yes'>�ݱ�</button>
				</div>
			</div>
		</div>
	</div>
	<!-- �⺻ modalâ �� -->
	
	<!-- �ۻ�������� -->
	<div id="deltext" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="mohead" class="modal-header" align="center"><h4>�� ����</h4></div>
				<div id="mobody" class="modal-body" align="center">
					<h4>���� �����Ͻðڽ��ϱ�?</h4>
				</div>
				<div id="ft" class="modal-footer">
					<button type='button' class='btn btn-default' id='del_text_modal_Yes'>����</button>
					<button type='button' class='btn btn-primary' id='del_text_modal_No'>���</button>
				</div>
			</div>
		</div>
	</div>
	<!-- �ۻ��������-->


	<!-- �ۻ��� ��� Ȯ�� �� -->
	<div class="modal fade" id="modaldel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">��</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">�˸�</h4>
				</div>
				<div class="modal-body">�ÿ��ϰ� �����Ǿ����ϴ�</div>
				<div class="modal-footer">
					<button id="modalmodclose"type="button" class="btn btn-default" data-dismiss="modal">�ݱ�</button>
				</div>
			</div>
		</div>
	</div>
	<!-- �ۻ��� ��� Ȯ�� ���� -->



</body>
</html>

