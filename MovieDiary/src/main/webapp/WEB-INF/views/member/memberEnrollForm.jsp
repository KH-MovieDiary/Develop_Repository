<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	
	<div class="content">
		<br><br>
		<div class="innerOuter">
			<h2>회원가입</h2>
			<br>
			
			<form action="${contextRoot }/insert.me" method="post">
				<div class="form-group">
					<label for="inputId">*아이디 : </label> 
					<input type="text" class="form-control" id="inputId" placeholder="아이디를 입력하세요" name="userId" required> <button>중복확인</button> <br><br>
				
					<label for="inputPwd">*비밀번호 : </label>
					<input type="password" class="form-control" id="inputPwd" placeholder="비밀번호를 입력하세요" name="userPwd" required> <br><br>
					
					<label for="checkPwd">*비밀번호 확인 : </label>
					<input type="password" class="form-control" id="checkPwd" placeholder="비밀번호를 한번 더 입력하세요" required> <br><br>
				
					<label for="nickName">*별명 : </label>
					<input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요" name="nickName"> <br><br>
					
					<label for="email">*이메일 : </label>
					<div class="input-group">
				        <input type="text" class="form-control" id="emailId" name="emailId" required>
				        
				        <div class="input-group-append">
				            <span class="input-group-text">@</span>
				        </div>
				        
				        <input type="text" class="form-control" id="emailDomain" name="emailDomain" placeholder="도메인 선택" required>
				        
				        <select class="form-control" id="domainSelector" onchange="changeDomain(this);">
				            <option value="">직접입력</option>
				            <option value="naver.com">naver.com</option>
				            <option value="gmail.com">gmail.com</option>
				            <option value="daum.net">daum.net</option>
				            <option value="hanmail.net">hanmail.net</option>
				        </select>
				        <br><br>
				        
			        <div class="form-group">
				    <label>* 선호하는 장르 (중복 선택 가능)</label> <br>
				    <div class="genre-container">
				        <div class="custom-control custom-checkbox custom-control-inline">
				            <input type="checkbox" class="custom-control-input" id="genre1" name="favoriteGenre" value="로맨스">
				            <label class="custom-control-label" for="genre1">로맨스</label>
				        </div>
				        <div class="custom-control custom-checkbox custom-control-inline">
				            <input type="checkbox" class="custom-control-input" id="genre2" name="favoriteGenre" value="액션">
				            <label class="custom-control-label" for="genre2">액션</label>
				        </div>
				        <div class="custom-control custom-checkbox custom-control-inline">
				            <input type="checkbox" class="custom-control-input" id="genre3" name="favoriteGenre" value="코미디">
				            <label class="custom-control-label" for="genre3">코미디</label>
				        </div>
				        <div class="custom-control custom-checkbox custom-control-inline">
				            <input type="checkbox" class="custom-control-input" id="genre4" name="favoriteGenre" value="SF">
				            <label class="custom-control-label" for="genre4">SF</label>
				        </div>
				        <div class="custom-control custom-checkbox custom-control-inline">
				            <input type="checkbox" class="custom-control-input" id="genre5" name="favoriteGenre" value="공포">
				            <label class="custom-control-label" for="genre5">공포</label>
				        </div>
				        <div class="custom-control custom-checkbox custom-control-inline">
				            <input type="checkbox" class="custom-control-input" id="genre6" name="favoriteGenre" value="애니메이션">
				            <label class="custom-control-label" for="genre6">애니메이션</label>
				        </div>
				        <div class="custom-control custom-checkbox custom-control-inline">
				            <input type="checkbox" class="custom-control-input" id="genre7" name="favoriteGenre" value="뮤지컬">
				            <label class="custom-control-label" for="genre7">뮤지컬</label>
				        </div>
				    </div>
					</div>
					
					<br><br>
					
					<div class="form-group">
				    <label for="picture">프로필 사진</label>
				    <div class="custom-file">
				        <input type="file" class="custom-file-input" id="picture" name="picture" accept="image/*" onchange="loadImg(this);">
				        <label class="custom-file-label" for="picture">파일을 선택하세요</label>
				    </div>
				    
				    <div id="titleImgArea" style="margin-top: 10px;">
				        <img id="titleImg" width="150" height="150" border="1" style="display:none;">
				    </div>
					</div>

	<script>
	    // 파일을 선택했을 때 미리보기와 파일명을 보여주는 자바스크립트
	    function loadImg(inputFile) {
	        if (inputFile.files.length == 1) { // 파일이 선택된 경우
	            const reader = new FileReader();
	            reader.readAsDataURL(inputFile.files[0]); // 파일을 읽어들임
	
	            reader.onload = function(e) {
	                // 미리보기 이미지 태그에 주소 넣기
	                document.getElementById("titleImg").src = e.target.result;
	                document.getElementById("titleImg").style.display = "block";
	                
	                // 파일명을 라벨에 표시하기
	                const fileName = inputFile.files[0].name;
	                const label = inputFile.nextElementSibling;
	                label.innerText = fileName;
	            };
	        }
	    }
	</script>
					
					
					
					

					</div>
				
				
				
				</div>
			
			
			
			
			
			</form>
		</div>
	</div>

</body>
</html>