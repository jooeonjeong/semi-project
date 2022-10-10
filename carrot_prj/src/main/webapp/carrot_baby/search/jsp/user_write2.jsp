<%@page import="userVO.CatVO"%>
<%@page import="userVO.LocVO"%>
<%@page import="java.util.List"%>
<%@page import="userDAO.PostDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 형식 지정 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 사이즈 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../../common/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="../../common/css/user_wrap_container.css"/>
<link rel="stylesheet" type="text/css" href="../css/user_write.css"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
var cnt = 2;
var minAppend=1;
$(function() {	
	$("#pushBtn").click(function() {
		//유효성 검사.
		chkNull();
	});//click
	
/* 	upload.addEventListener('click', () => imgUpload.click()); */
	
	$("#free").change (function() {
		var st = this.checked;
		if(st){
			$("#price").prop("readonly",true);
			$("#price").css("background", "#ccc");
			$("#price").val("0");
		} else{
			$("#price").prop("readonly", false);
			$("#price").css("background", "none");
		}//end else
		
	});//change
	
	$("#btnAdd").click(function() {
		/* if(){
			alert("썸내일을 등록");
			return;
		} */
		//$("#inputWrap").last().append("<div>a</div>");//자식으로 삽입
		//$("#inputWrap").first().append("<div>a</div>");
		var outDiv = "<div><label>사진" + cnt + "<label>" 
		+ " <input type = 'file' name = 'post_img"+ ++cnt +"' class='inputBox' onchange='readURL1(this);'/></div>";
		$("#inputWrap").append(outDiv);
		++minAppend;
	});
	$("#btnRemove").click(function() {
		if(minAppend == 1){
			alert("더 이상 삭제하실 수 없습니다.");
			return;
		}
		$("#inputWrap div").last().remove();
		cnt--;
		if( cnt == -1 ){ cnt = 0; };
		--minAppend;
	});
	
});//ready

function chkNull(){
	 //구 입력
	if($("#category_loc").val()==0){
		alert("지역구를 선택하세요.");
		$("#categorly_loc").focus();
		return;
	}
	
	if($("#category_pd").val()==0){
		alert("상품 카테고리를 선택하세요.");
		$("#categorly_pd").focus();
		return;
	}
	
	if($("#price").val().trim()==""){
		alert("가격을 입력해주세요.");
		$("#price").focus();
		return;
	}
	
	if($("#title").val().trim()==""){
		alert("제목을 작성해주세요.");
		$("#title").focus();
		return;
	}
	
	if($("#contents").val().trim()==""){
		alert("내용을 작성해주세요.");
		$("#contents").focus();
		return;
	}
	var thu = $("#post_img1").val();
	if(!thu){
		alert("파일을 첨부해 주세요");
		return;
	}
	
	$("input[name=count]").attr("value",cnt);
	
	$("#writePost").submit();
	/* document.location.href="user_search.jsp"; */
}//chkNull

function readURL(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function(e) {
	      document.getElementById('preview').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	  } else {
	    document.getElementById('preview').src = "";
	  }
	}
	
function readURL1(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function(e) {
	      document.getElementById('preview1').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	  } else {
	    document.getElementById('preview1').src = "";
	  }
	}

</script>
</head>
<body>
<%
String user_id =(String)session.getAttribute("user_id");
if(user_id==null){
user_id = "test10";
session.setAttribute("user_id", user_id);
}
%>
<%
		//PostDAO와 연결
		PostDAO pDAO = PostDAO.getInstance();
		//VO 리스트로 받기
		List<LocVO> lVOList = pDAO.selectLoc();
		List<CatVO> pCatList = pDAO.selectCat();
		
		pageContext.setAttribute("lVOList", lVOList);
		pageContext.setAttribute("cVOList", pCatList);
		
%>
<div class="wrap">
<!-- header -->
<%@ include file="../../mainhome/jsp/user_login_header.jsp" %>
<!-- header end-->

<!-- container -->
<div class="container">
	<div class="write-wrap">
		<h1 class="write-title">중고거래 글쓰기</h1>
		<div class="write">
		<form name="writePost" id="writePost"  action="user_write_process.jsp" enctype="multipart/form-data" method="post">
			<div class="write-sel-wrap">
						<div class="write-sel-wrap-text">서울특별시</div>
						<select id="category_loc"name="category_loc" class="write-select" >
							<option value="0">동네를 선택하세요</option>
						<c:forEach var="lVO" items="${ lVOList }">
									<option value="${lVO.gu_idx}">${lVO.gu}</option>
							</c:forEach>
						</select>
			</div>
			<div class="write-sel-wrap">
						<div class="write-sel-wrap-text">카테고리</div>
						<select id ="category_pd" name="category_pd" class="write-select">
							<option value="0">카테고리를 선택하세요</option>
							<c:forEach var="cVO" items="${ cVOList }">
									<option value="${cVO.category_idx}">${cVO.category}</option>
							</c:forEach>
						</select>
			</div>
			<div class="write-sel-wrap">
						<div class="write-sel-wrap-text">판매가격</div>
						<div class="write-sel-wrap-right">
						<c:if test=""></c:if>
							<div class="checkbox-share-wrap">
								<input type="checkbox" name="free" id= "free" value="Y"class="checkbox-share">
								<span class="checkbox-share-txt">나눔</span>
							</div>
							<div class="checkbox-price-wrap">
								<input type="text" name="price"  id = "price" class="checkbox-price-input" style= "text-align:right" 
											oninput = "this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="8">
								<span class="checkbox-price-txt">원</span>
							</div>
						</div>
			</div>
			<div class="write-center-wrap">
				<input type="text" name="title" id="title" class="write-title-input" placeholder="제목을 입력해주세요">
				<div class="img-wrap">
					<div class="write-imgs-upload-wrap">
					<input type="hidden" name="count" value=""/>
					<div id = "inputWrap">
					<input type = "button" value = "추가" class = "inputBtn" id = "btnAdd" />
					<input type = "button" value = "삭제" class = "inputBtn" id = "btnRemove" />
					<div>
					<label>대표사진</label>
					<input type="file" name="post_img1" class="inputBox" onchange="readURL(this);" id="post_img1"/>
					<br/>
					<img id="preview" />
					</div>
					<div>
					<br/>
					<img id="preview1" />
					<label>사진 1</label>
					<input type="file" name="post_img2" class="inputBox" onchange="readURL1(this);"/>
					</div>
					</div>
					</div>
				</div>
				<textarea rows="30" name="contents" id="contents" class="contents-txtarea" placeholder="내용을 입력해주세요" ></textarea>
			</div>
		    </form>
			<div class="register-write">
					<button type="button" id="pushBtn" class="report-btn">등록하기</button>
			</div>
		</div>
	</div>
</div>
<!-- container end -->

<!-- footer -->
<%@ include file="../../common/jsp/footer.jsp" %>
<!-- footer end -->

</div>

</body>
</html>