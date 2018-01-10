<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="jl" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<style>
	</style>
</head>
<body>
<div class="container">

	<label>${vo.c_notice_title}</label><br/>
	<label>작성시간 : ${vo.the_time}	</label><label>작성자 : ${vo.user_id}</label>
	<label>조회수 : ${vo.view_count}</label><br/>
	<label>소개</label><textarea rows="15" cols="30" disabled="disabled">${vo.c_notice_content}</textarea><br/>
	<input id="clubMod" type="button" value="수정하기"><input id="prev" type="button" value="뒤로가기">
	<br/><hr>
	
	<form method="post" action="club_add_notice_reple.do">
		<div class="form-group" align="left">
			<label id="reple" class="l" style="width: 100px; font-size: 100%">의견쓰기 </label>
			<div class="input-group">
				<input name="c_notice_reple_content" type="text" style="height: 80px;" class="form-control"/>
				<span class="input-group-addon" style="background-color: #00C73C;">
				<input type="submit" class="btn" value="등록" style="color:white; font-weight: bold; background-color: #00C73C;"/></span>
			</div>
			<input type="hidden" name="user_id" value="${user_id}">
			<input type="hidden" name="c_notice_no" value="${vo.c_notice_no}">
		</div>
	</form>
	<br/>
	<div class="form-group" align="left">
	<hr/>
		<jl:forEach var="rvo" items="${reVO}">
			<label id="repleId" class="l" style="font-size: 120%; font-weight: bold;">${rvo.user_id } </label><br/>
			<label id="repleContent" class="l" style="font-size: 100%;">${rvo.c_notice_reple_content } </label><br/>
			<label id="repletime" class="l" style="font-size: 100%; color: gray;">${rvo.the_time } 
			<jl:if test="${user_id == rvo.user_id}">
				<a class="delRe" reNo="${rvo.c_notice_reple_no}" noticeNo="${rvo.c_notice_no}" userId="${rvo.user_id}" 
				href="#"><span class="glyphicon glyphicon-remove"></span></a>
				<a reNo="${rvo.c_notice_reple_no}"  reText="${rvo.c_notice_reple_content}" noticeNo="${rvo.c_notice_no}" userId="${rvo.user_id}" 
				class="modRe"href="#"><span class="glyphicon glyphicon-pencil"></span></a></label>
			</jl:if>
			
			<br/>
			<hr/>
		</jl:forEach>
	</div>	
	
</div>



	<!-- 댓글 수정 modal창 시작 -->
	<form id="mod_frm" method="post" action="club_mod_notice_reple.do">
		<div id="mod_modal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div id="mohead" class="modal-header"><h4>댓글수정</h4></div>
					<div id="mobody" class="modal-body" align="center">
						<textarea id="reple_content" name='c_notice_reple_content'class='form-control' rows='7'></textarea>
					</div>
					<div id="ft" class="modal-footer">
						<button type='button' class='btn btn-default' id='mod_modal_Yes'>수정</button>
						<button type='button' class='btn btn-primary' id='mod_modal_No'>취소</button>
					</div>
				</div>
			</div>
		</div>
		<input id="c_notice_reple_no" name='c_notice_reple_no' type='hidden'/>
		<input id="c_notice_no" name='c_notice_no' type='hidden'/>
	</form>
	<!-- 댓글 수정 modal창 끝 -->
	
	<!-- 댓글 삭제 modal창 시작 -->
	<form id="del_frm" method="post" action="club_del_notice_reple.do">
		<div id="del_modal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div id="mohead" class="modal-header" align="center"><h4>댓글 삭제</h4></div>
					<div id="mobody" class="modal-body" align="center">
						댓글을 삭제하시겠습니까?
					</div>
					<div id="ft" class="modal-footer">
						<button type='button' class='btn btn-default' id='del_modal_Yes'>삭제</button>
						<button type='button' class='btn btn-primary' id='del_modal_No'>취소</button>
					</div>
				</div>
			</div>
		</div>
		<input id="del_notice_reple_no" name='c_notice_reple_no' type='hidden'/>
		<input id="del_notice_no" name='c_notice_no' type='hidden'/>
	</form>
	<!-- 댓글 삭제 modal창 끝 -->
	
	<!-- 자바스크립트에서 사용할 값 -->
	<input id="club_no" type="hidden" value="${vo.club_no}">
	<input id="c_notice_no" type="hidden" value="${vo.c_notice_no}">
	<!-- 자바스크립트 import -->
	<script type="text/javascript" src="/js/club/club_notice_detail.js"></script>
	
</body>
</html>