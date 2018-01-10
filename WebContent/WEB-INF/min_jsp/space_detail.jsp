<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%@taglib prefix="jl" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"> 
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <script src="common.js" type="text/javascript"></script>
 	<script>
 		$(document).ready(function(){
 			if("${bookmark}"!=""){
 				$("#btn_bookmark").html("북마크해제");
 			}
 			if("${code }"==20001){
 				alert("본인만 삭제가 가능합니다.");
 			}
 			
 			$("#btn_bookmark").on("click",function(){
 				if($(this).html()=="북마크등록"){
 					var url=$(this).attr("add");
 					ajaxGet(url,function(rt){
 						$("#btn_bookmark").html("북마크해제");
 					});
 				}else{
 					var url=$(this).attr("del");
 					ajaxGet(url,function(rt){
 						$("#btn_bookmark").html("북마크등록");
 					});
 				}
 			});
 			$(".collapsed").on("click",function(){
 				
 				//후기가 있으면 작성 못하게 하는거 & 후기 없으면 안불러 오게 해야함
 				var space_qna_no = $(this).attr("no");
 				ajaxGet("find_space_qna_reple.do?space_qna_no="+space_qna_no,function(rt){
 					if(rt.length>5) {
 						$("#qna_reple_add").hide();
 						var qna_reple = window.eval("("+rt+")");
 	 					var html = "<table>";
 	 					html += "<tr>";
 	 					html += "<td>제목</td>";
 	 					html += "<td>" + qna_reple.qna_reple_title +"</td>";
 	 					html +="</tr>";
 	 					html += "<tr>";
 	 					html += "<td>내용</td>";
 	 					html += "<td>" + qna_reple.qna_reple_content+"</td>";
 	 					html += "</tr>";
 	 					html+="</table>"
 						$("#qna_reple"+space_qna_no).html(html);
 					} else {
 						
 					}
 					
 				},
 				function(){alert(2);},
 				function(){alert(3);}
 				);
 			});
 		});
 	</script>
</head>
<body>
	<div class="container">
	<h1>공간 상세 페이지</h1>
		<div>
			<table>
				<tr>
					<th><h1>공간 소개</h1></th>
				</tr>
				<tr>
					<td>공간 이름</td>
					<td>${space.space_title }</td>
				</tr>
				<tr>
					<td>공간 카테고리</td>
					<td>${s_category }</td>
				</tr>
				<tr>
					<td><img src="thumbnail/${space.space_thumb_img }"/></td>
				</tr>
				<tr>
					<td>공간 소개</td>
					<td>${space.space_content }</td>
				</tr>
				<tr>
					<td>이용 시간</td>
					<td>${space.open_time } ~ ${space.close_time }</td>
				</tr>
			</table>
		</div>
		
		<hr/>
		<div>
			<table>
				<tr>
					<td>예약 인원</td>
					<td>최소 ${space.min_people } 명~ 최대 ${space.max_people } 명</td>
				</tr>
				<tr>
					<td>가격</td>
					<td>${space.price } 원 /시간</td>
				</tr>
			</table>
			<button class="btn btn-default btn-sm" data-toggle="modal" data-target="#call">전화</button>
			<a href="space_reservation.do?space_no=${space.space_no }"><button class="btn btn-default btn-sm">예약하기</button></a>
			<button class="btn btn-default btn-sm" id="btn_bookmark" add="add_bookmark.do?space_no=${space.space_no }&user_id=${user_id}" del="del_bookmark.do?space_no=${space.space_no }&user_id=${user_id}">북마크등록</button>
		</div>
		
		<div>
		<hr/>
		
		<!-- space q&a 부분 -->
		<div class="col-xs-6">
			<h1>QnA</h1>
			<jl:forEach var="space_qna" items="${list_space_qna }">
				<div class="panel-group" id="accordion${space_qna.space_qna_no }">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								제목 :
								<a data-toggle="collapse" data-parent="#accordion${space_qna.space_qna_no }" href="#collapse${space_qna.space_qna_no }" no="${space_qna.space_qna_no }" class="collapsed">
									 ${space_qna.space_qna_title } <br/>
								</a>
								작성자: ${space_qna.user_id }
							</h4>
						</div>
					</div>
				
				<div id="collapse${space_qna.space_qna_no }" Class="panel-collpase collapse">
					<div class="panel-body">
						<table>
							<tr> 
								<td>내용</td>
								<td>${space_qna.space_qna_content }</td>
							</tr>
							<tr>
								<td>작성 시간</td>
								<td>${space_qna.the_time }</td>
							</tr>
						</table>
							<jl:if test="${user_id eq space_qna.user_id }">
								<a href="#qna_mod" data-toggle="modal">질문 수정</a>
								<a href="#qna_del" data-toggle="modal">질문 삭제</a>
								
								<!-- qna 삭제 모달 -->
								<div class="modal fade" id="qna_del" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">
													<span aria-hidden="true">&times;</span>
													<span class="sr-only">Close</span>
												</button>
												<h4 class="modal-title">주의</h4>
											</div>
											<div class="modal-body">
												<h2>정말 삭제하시겠습니까?</h2>
											</div>
											<div class="modal-footer">
												<a href="delete_space_qna.do?space_qna_no=${space_qna.space_qna_no }&space_no=${space_qna.space_no}" data-toggle="modal">
													<button type="button" class="btn btn-default">질문 삭제</button>
												</a>
												<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
											</div>
										</div>
									</div>
								</div>
								<!-- qna 삭제 모달 끝 -->
								
								<!-- qna 수정 모달 -->
								<div class="modal fade" id="qna_mod" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">
													<span aria-hidden="true">&times;</span>
													<span class="sr-only">Close</span>
												</button>
												<h4 class="modal-title">QnA 수정</h4>
											</div>
											<form method="POST" action="mod_space_qna.do">
												<div class="modal-body">
													<div class="form-group">
														<label for="mod_space_qna_title">제목</label>
														<input type="text" name="space_qna_title" id="mod_space_qna_title" class="form-control" value="${space_qna.space_qna_title }">
													</div>
													<div class="form-group">
														<label for="mod_space_qna_content">내용</label>
														<textarea name="space_qna_content" id="mod_space_qna_content" class="form-control">${space_qna.space_qna_content }</textarea>
													</div>
													<input type="hidden" name="user_id" value="${user_id }">
													<input type="hidden" name="space_no" value="${space.space_no }">
													<input type="hidden" name="space_qna_no" value="${space_qna.space_qna_no }">
												</div>
												<div class="modal-footer">
													<input type="submit" class="btn btn-default" value="질문 수정">
													<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
												</div>
											</form>
										</div>
									</div>
								</div>
								<!-- qna 수정 모달 끝 -->
							
								
							</jl:if>
								<div id="qna_reple${space_qna.space_qna_no }"></div>
								<jl:forEach var="vo" items="${host }">
									<jl:if test="${vo.crn eq space.crn }">
										<div id="qna_reple_add">
											<form method="POST" action="add_space_qna_reple.do">
												<input type="hidden" name="space_qna_no" value="${space_qna.space_qna_no }">
												<input type="hidden" name="space_no" value="${space_qna.space_no }">
												<input type="hidden" name="user_id" value="${user_id }">
												<table>
												
												<tr>
													<td>제목</td>
													<td><input type="text" name="space_qna_reple_title"></td>
												</tr>
												<tr>
													<td>내용</td>
													<td><textarea row="5" col="30" name="space_qna_reple_content"></textarea></td>
												</tr>
												</table>
												<input type="submit">
											</form>
										</div>
									</jl:if>
								</jl:forEach>
					</div>
				</div>
				</div>
			</jl:forEach>
			<!-- space q&a 쓰는 곳 -->
			
			<form method="POST" action="add_space_qna.do">
			<table>
				
				<tr><th>질문 하기</th></tr>
				<tr>
					<td>제목</td>
					<td><input type="text" name="space_qna_title"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="space_qna_content" rows="5" cols="30"></textarea></td>
				</tr>
				
			</table>
			
			<input type="hidden" name="user_id" value="${user_id }">
			<input type="hidden" name="space_no" value="${space.space_no }">
			<input type="submit"  class="btn btn-default" value="질문 제출">
			</form>
		</div>
			
		
		<!-- 후기 -->
		<div class="col-xs-6">
			<h1>후기</h1>
			<jl:forEach var="review" items="${list_review }">
				<div class="panel-group" id="accordion${review.review_no }">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								제목 :
								<a data-toggle="collapse" data-parent="#accordion${review.review_no }" href="#collapse_review${review.review_no }" class="collapsed">
									 ${review.review_title } <br/>
								</a>
								작성자: ${review.user_id }
							</h4>
						</div>
					</div>
				
				<div id="collapse_review${review.review_no }" Class="panel-collpase collapse">
					<div class="panel-body">
						<div class="col-xs-4"><img src="review_img/${review.review_img }" width="150" height="60" alt="썸네일"></div>
						<div class="col-xs-8">
							<table>
								<tr> 
									<td>내용</td>
									<td>${review.review_content }</td>
									<td>평점</td>
									<td>${review.review_score }</td>
								</tr>
								<tr>
									<td>작성 시간</td>
									<td>${review.the_time }</td>
								</tr>
								
							</table>
							<jl:if test="${user_id eq review.user_id }">
								<a href="#review_del" data-toggle="modal">후기 삭제</a>
								
								<!-- 후기 삭제 모달 -->
								<div class="modal fade" id="review_del" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">
													<span aria-hidden="true">&times;</span>
													<span class="sr-only">Close</span>
												</button>
												<h4 class="modal-title">주의</h4>
											</div>
											<div class="modal-body">
												<h2>정말 삭제하시겠습니까?</h2>
											</div>
											<div class="modal-footer">
												<a href="del_review.do?review_no=${review.review_no }&space_no=${review.space_no}" data-toggle="modal">
													<button type="button" class="btn btn-default">후기 삭제</button>
												</a>
												<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
											</div>
										</div>
									</div>
								</div>
								<!-- 모달 끝 -->
								
							</jl:if>
						</div>
					</div>
				</div>
				</div>
			</jl:forEach>
			
			
				<form method="POST" action="review_add.do">
					<input type="hidden" name="user_id" value="${user_id }">
					<input type="hidden" name="space_no" value="${space.space_no }">
					<input type="submit" value="후기 작성" class="btn btn-default">
				</form>

			
		</div>
		
		<!--  모달들 모음  -->
		
		<!-- 전화번호 모달 -->
		<div class="modal fade" id="call" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">전화번호</h4>
					</div>
					<div class="modal-body">
						<h2>${space.space_call }</h2>
						<p>전화 하실 때 MSSPACE보고 문의 드립니다. 라고 말하시면 더욱 친절하게 대해주실거에요~</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		
	</div>
	</div>
	

	
</body>
</html>