<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix ="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<style>
    /* 크롬창 파란 태두리 없에는 css코드 */
    input:focus {
        outline: none;
    }
</style>
<html lang="ko">
    <body>
        <!-- ==== HEADER START ==== -->
    	<c:import url ="../../common/header.jsp"/>
    	<!-- ==== HEADER END ==== -->
            <!-- === BEGIN CONTENT === -->
            <div id="content">
                <div class="container background-white">
                    <div class="row margin-vert-30">
                        <div class="col-md-12">
                            <!-- 게시글 제목 -->
                            <h2 style="color:#33747a;"><b>${ showing.sbtitle }</b></h2>
                            <div class="row">
                                <div class="col-md-6 animate fadeIn">
                                    <div>
                                       <c:set var="fileSplit" value="${fn:split(showing.renameFileName,',')}"></c:set>
                                       <div><img src="${contextPath}/resources/showinguploadFiles/${ fileSplit[0] }" style="border-radius: 0.5em; width: 500px; height: 300px;" alt="about-me" class="margin-top-10" id="mainImg" ></div>
                                       	<div id="carousel-example-2" class="carousel slide alternative" data-ride="carousel">
									      <div class="row">
									       	<c:forEach var="picture" items="${ fileSplit }">
									        	<div class="col-md-3" style="padding:10px; border-radius: 0.5em;"><img src="${contextPath}/resources/showinguploadFiles/${ picture }" style="width:100px; height:70px; border-radius: 0.5em;" onclick="selectImg(this)"></div>
									        </c:forEach>
									      </div>
										</div>
                                    </div>
                                    <hr>
                                </div>
                                <div class="col-md-6 margin-bottom-10 animate fadeInRight" style="width: 500px;">
                                    <h3 class="padding-top-10 pull-left">${ showing.sbwriter }</h3>
                                    <div class="clearfix"></div>
                                    <h4 style="color:#EB9F28; font-size:x-large;"> <b>${ showing.sbtitle }</b></h4>
                                    <span>${ showing.sbcontent }</span>
                                    <hr>
                                    <div style="display: flex; padding-top:20px;">
                                        <i class="fa-thumbs-o-up" style="font-size:24px; cursor: pointer; margin-left: 5px;" ></i>&nbsp;&nbsp;<span>1</span>&nbsp;&nbsp;    
                                        <i class="fa-thumbs-o-down" style="font-size:24px;cursor: pointer; margin-left: 5px;"></i>&nbsp;&nbsp;<span>2</span>
                                        <!-- <p><img id="heartButton" src="resources/assets/img/thumbs/heart.png" style="width: 20px; height: 20px; cursor: pointer; margin-left: 5px;" alt="thumb-down" onclick="heartButton(this)"></p> -->
                                        
                                        <div class="col-md-9" ><i class="fa-ellipsis-h pull-right" style="font-size: 24px; cursor: pointer; margin-left: 5px; display:flex;" onclick="$('.more').css('display', 'block')"></i>
                                            <button type="button" class="btn btn-primary btn-sm pull-right more" style="display: none; cursor:pointer; margin:10px;"onclick="location.href='updateView.sb?sbId=${showing.sbid}&page=${page}'">수정하기</button>
                                            <button type="button" class="btn btn-warning btn-sm pull-right more" style="display: none; cursor:pointer; margin:10px;">신고하기</button>
                                            <button type="button" class="btn btn-danger btn-sm pull-right more" style="display: none; cursor:pointer; margin:10px;" onclick="location.href='deleteShowing.sb?sbId=${ showing.sbid }'">삭제하기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                <!-- 로그인 한 회원 -->
                                <div style="display: flex;">
                                    <p style="font-size: 25px; margin-top:15px;"><b>${ loginUser.name }</b></p>
                                    <input type="text" id="comment" onfocus="this.value=''" style=" width: 80%; border-right:0px; border-top:0px; border-left:0px; border-bottom-color: lightgray; margin-left: 15px;" value="댓글을 넣어주세요." onkeyup="comment(this);"/>
                                </div>
                                <!-- start reply board -->
                                <div id="Reply" ><!-- 댓글이 들어갑니다. --></div>
                                <!-- end reply board -->
                            </div>
                            <br>
                            <!-- end row -->
                        </div>
                    </div>
                </div>
            <!-- === END CONTENT === -->
            <!-- === BEGIN FOOTER === -->
            <c:import url ="../../common/footer.jsp"/>
            <!-- === END FOOTER === -->
    </body>
    <script>
    	// setinterval reload reply board
	    $(function(){
	        getReplyList();
	        setInterval(function(){
	           getReplyList();
	        }, 10000);
	     });
		// insert reply baord ajax ddd
        function comment(t){
			// enterkey javascrpt
            if(window.event.keyCode == 13){
            	var refBid = ${showing.sbid};
            	var rContent = t.value;
            	$.ajax({
            		url: "addReply.sb",
            		data: {rContent:rContent, refbId:refBid},
            		type: "post",
            		success: function(data){
            			console.log(data);
            			if(data == "success"){
            				getReplyList();
            			}
            		}
            	});
            	t.value = "";
            }
        }
        // selectList reply ajax
        function getReplyList(){
        	var sbId = ${ showing.sbid };
        	$.ajax({
        		url: "rList.sb",
        		data: {sbId:sbId},
        		dataType: "json",
        		success: function(data){
        			$replyBoard = $("#Reply");
        			$replyBoard.html("");
        			
        			var $div1;
        			var $div2;
        			var $div3;
        			var $span1;
        			var $span2;
        			var $img;
        			var $delete;
        			
        			console.log(data);
        			if(data.length > 0){
        				for (var i in data){
        					$div1 =  $("<div style='padding-top: 10px;  margin-top: 10px; border-radius: 0.5em;'>");
        					$div2 =  $("<div style='display: flex; padding-left:10px;'>");
        					$img =   $("<img src='resources/assets/img/user.png' style='padding-left:10px; margin-top:0px; width 40px; height:40px;'>");
        					$span1 = $("<span style='padding-left:5px;'>").text(decodeURIComponent(data[i].rWriter));
        					
        					$delete =$("<a location.href=''>");
        					
        					$span2 = $("<span style='padding-left: 15px; '>").text(data[i].rCreateDate);
        					$div3 =  $("<p style='padding-left:60px; font-size: 14px; border-radius: 0.5em;'>").text(decodeURIComponent(data[i].rContent.replace(/\+/g, " "))); 
        					
        					$div1.append($div2);
        					$div1.append($img);
        					$div1.append($span1);
        					$div1.append($span2);
        					$div1.append($div3);
        					$replyBoard.append($div1);
        				}
        			}
        		}
        	})
        }
        var heartPath = null;
        function heartButton(t){                
            console.log($(t).attr("class"));
            if($(t).attr("class") == "empty"){
            	$(t).attr("class","full");
                $(t).attr("src", "resources/assets/img/thumbs/heartRed.png") ;
            }
            else if($(t).attr("class") == "full"){
            	$(t).attr("class","empty");
                $(t).attr("src" , "resources/assets/img/thumbs/heart.png") ;
            }
        }
        // default main pic
        function selectImg(t){
            console.log(t);
            document.getElementById("mainImg").src = t.src;
        }
        
    </script>
</html>
