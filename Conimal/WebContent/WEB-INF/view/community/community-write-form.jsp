<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
	<%@ include file="../include/head.jsp" %>
</head>
<style>
</style>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	var tags = [];
	var tagNames = [];
	$(function() {
		$("#tag").on("keypress", function(e) {
			if(e.key === "Enter" || e.keyCode == 32) {
				var input_text = $("#tag").val();

				// input_text를 tagNames[]로 for문 돌려서 비교하여 같으면 중복
				for(var i = 0; i < tagNames.length; i++) {
					if(tagNames[i] == input_text) {
						console.log(tagNames[i] + "==" + input_text);
						$("#tag").val("");
						alert("중복입니다.");
						return;
					}
				}
				// 태그 중복 확인
				tagCheck(input_text);
				e.preventDefault();
			}
			console.log("Enter");
		})
	})
	var tagCheck = function(tag) {
		var url = $(location).attr('pathname') + "/checkTag";
		$.ajax({
			type : 'get',
			url : url + "?tag_name=" + tag,
			dataType : 'json'
		}).done(function(data) {
			console.log(data);

			// 배열에 tag_idx 입력
			var idx = data.tag_idx;
			var name = data.tag_name;
			var html = "<span class='hashTag' data-idx=" + idx + ">" + "#" + name + "<a href='javascript:;'>X</a>" + "</span>";

			// 서버에 보낼 배열 넣기
			tags.push(idx);
			// input enter 눌렀을 때 input에 있는 value의 text와
			// 배열에 있는 text를 비교해서 있으면 중복 알림, 없으면 ajax
			tagNames.push(name);
			// hidden input에 넣기 
			$("#rdTag").val(tags);

			// 태그 붙이기 
			$("#tag-list").append(html);
			// input 비우기 
			$("#tag").val("");
		}).fail(function() {
			alert("실패입니다.");
		});
		$("#tag-list").on("click", ".hashTag", function() {
			var idx = $(this).attr("idx");
			tags[idx] = "";
			$(this).parent().remove();
		});
	}
</script>
<script>
	var stored_files = [];
	var select_divs = "";
	$(function() {
		select_divs = $("#selectFiles");

		$("#files").on("change", preview);

		$("#img").on("click", removeFile);

		form = $("form[name=writeCom]")[0];
		form.onsubmit = function(e) {
			e.preventDefault();
			var formData = new FormData(form);
			for (var i = 0; i < stored_files.length; i++) {
				formData.append("files", stored_files[i]);
			}
			formData.append("#rdTag", tags);
			$.ajax({
				url : "community-write-form",
				type : "post",
				enctype : "multipart/form-data",
				contentType : false,
				processData : false,
				data : formData,
				success : function() {
					location.href = "/community/community-list";
				}
			})
		}
	})

	function preview(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		filesArr.forEach(function(f) {

			if(!f.type.match("image.*")) {
				return;
			}
			stored_files.push(f);

			var reader = new FileReader();
			reader.onload = function(e) {
				var html = "<span class='preview'>";
				html += "<img src=\'" + e.target.result + "\' width='100' height='70' id='img'";
				html += "</span>";
				select_divs.append(html);
			}
			console.log("preview success!");
			reader.readAsDataURL(f);
		});
	}
	function removeFile(e) {
		console.log("e : " + e);
		var file = $(this).data("file");
		for(var i = 0; i < stored_files.length; i++) {
			if(stored_files[i].name === file) {
				stored_files.splice(i, 1);
				break;
			}
		}
		$(this).parent().remove();
	}
</script>
<body>
	<%@ include file="../include/header.jsp" %>
	<div class = "page-container">
		<form method="post" enctype="multipart/form-data" name="writeCom">
		<div class="community-container">
		
			<div class="community-intro">
				<h3 class="title">커뮤니티</h3>
			</div>
			
				<input type="hidden" name="user_idx" value="1" readonly />
				<input type="text" class="marB_20" id="cm-title" name="title" placeholder="제목을 입력하세요"/>
				
				<textarea class="community-contents marB_20" id="cm-contents" name="content" placeholder="내용을 입력하세요"></textarea>
				
				<input type="hidden" value="" id="rdTag">
				<input class="community-tags marB_20" type="text" id="tag" name="tag" placeholder="태그를 입력하세요"/>
				<div id="tag-list"></div>
				
				<div class="marB_60">
					<input type="file" class="form-control community-files marR_10" id="files" name="file" multiple/>
					<span class="row" id="selectFiles"></span>
				</div>
				
				<div class="txt-center">
					<button type="submit" class="btn" id="upload-btn">업로드</button>
				</div>
			
		</div>
		</form>
		
	</div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>
