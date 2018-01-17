<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="euc-kr"%>
<%@taglib prefix="jl" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<style type="text/css">
	
		.jumbotron{
			text-align:center;
		}
		
	</style>
	<script src="common.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script>
	$(document).ready(function() {
	$("#btnClose").on("click", function() {
		$("#QnaModal").modal("hide");

	});

	$("#ee").on("click",function(){
		$("#text_add_modal").modal("show");
		$("#text_add_modal_Yes").on("click",function(){
			$("#text_add_modal").modal("hide");
			$("#basic_mobody").html("<h4>QnA�� ��ϵǾ����ϴ�.</h4>");
			$("#basic_modal").modal("show");
			$("#basic_modal").on("hidden.bs.modal",function(){
				$("#qna_submit").submit();
			});
			
		});
		$("#text_add_modal_No").on("click",function(){
			$("#text_add_modal").modal("hide");
		});
	});
	
/* 	$("#status-modal").on("hidden.bs.modal",function(){
        location.href="space_detail.do?space_no="+${space.space_no};
     }); */
	
	$("#btnQnASub").on("click", function() {
		$("#completeModal").modal("show");
		
	});
	
	$("#completeModal").on("hidden.bs.modal",function(){
		location.href="community_qna_list.do";
		$("#qna_submit").submit();
	});
	
	});
	</script>
</head>
<body>
	<div id="i" class="jumbotron panel-primary">
		<h1>QnA</h1>
	</div>
	
	<form action="community_qna_add2.do" method="POST" id="qna_submit">
		<input type="hidden" name="user_id" value="${user_id}"/>
		���� : <input type="text" name="com_qna_title"/><br/>
		���� : <textarea name="com_qna_content" rows="7" cols="63"></textarea>
		<br/>
		<input type="button" value="QnA�ۼ�" class="btn btn-info btn-sm" data-toggle="modal"  id="ee"/>
	</form>
	
	<form action="community_qna_list.do" method="POST">
		<input type="submit" value="���" class="btn btn-info btn-sm"/>
	</form>
	
	<!-- �⺻ modalâ ���� -->
	<div id="basic_modal" class="modal fade" role="dialog">
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
	<!-- �� ���� modalâ ���� -->
	<div id="text_add_modal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div id="mohead" class="modal-header" align="center"><h4>�� ���</h4></div>
				<div id="mobody" class="modal-body" align="center">
				<h4>QnA�� ��� �Ͻðڽ��ϱ�?</h4>
				</div>
				<div id="ft" class="modal-footer">
					<button type='button' class='btn btn-default' id='text_add_modal_Yes'>���</button>
					<button type='button' class='btn btn-primary' id='text_add_modal_No'>���</button>
				</div>
			</div>
		</div>
	</div>
	<!-- �� ���� modalâ �� -->	
	
	
	<!-- ���� �� �ڵ� -->
	<!-- 		<div class="modal fade" id="QnaModal" role="dialog">
		    <div class="modal-dialog">
		      Modal content
		      <div class="modal-content" >
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body">
		          <p>QnA�� �ۼ� �Ͻðڽ��ϱ�?</p>
		        </div>
		        <div class="modal-footer">
		        <input type="button" class="btn btn-primary btn-sm" data-dismiss="modal" id="btnClose" value="�ݱ�">
		        <input type="button" class="btn btn-primary btn-sm" data-dismiss="modal" id="btnQnASub" value="�ۼ�">
		        </div>
		      </div>
		    </div>
		</div> -->
<!-- 	<div class="modal fade" id="completeModal" role="dialog">
		    <div class="modal-dialog">
		      Modal content
		      <div class="modal-content" >
		        <div class="modal-header">
		          <button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>
		        <div class="modal-body">
		          <p>QnA �ۼ� �Ϸ�!</p>
		        </div>
		         <div class="modal-footer">
		        <input type="button" class="btn btn-primary btn-sm" data-dismiss="modal" value="Ȯ��">
		        </div>
		      </div>
		    </div>
		</div> -->
</body>
</html>