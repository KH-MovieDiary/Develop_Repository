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
		<div class="innerOuter">
			<h2>회원가입</h2>
			<br>
			
			<form action="${contextRoot }/insert.me" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="inputId">*아이디 : </label> 
					<input type="text" class="form-control" id="inputId" placeholder="아이디를 입력하세요 (5자 이상)" name="userId" required> <button id="idCheckbtn">확인</button> <br><br>
					<span id="resultDiv" style="font-size:0.8em; display:none"></span>
				
					<label for="inputPwd">*비밀번호 : </label>
					<input type="password" class="form-control" id="inputPwd" placeholder="비밀번호를 입력하세요" name="userPwd" required> <br><br>
					
					<label for="checkPwd">*비밀번호 확인 : </label>
					<input type="password" class="form-control" id="checkPwd" placeholder="비밀번호를 한번 더 입력하세요" required> <br><br>
				
					<label for="nickName">*별명 : </label>
					<input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요" name="nickName"> <br><br>
					
					<label for="age"> *나이 : </label>
                    <input type="number" class="form-control" id="age" placeholder="나이를 입력하세요" name="age" value="0"> <br><br>
					
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
				    </div>
				    <br>
				    
				   
				    
				        <br>
				        
			        <div class="form-group">
				    <label>* 어떤 장르의 영화를 좋아하세요? (중복 선택 가능)</label> <br>
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
				</div>
				<br><br>
				
				<div class="btns">
                    <button type="submit" class="btn btn-primary" disabled onclick="return validate();">회원가입</button>
                    <button type="reset" class="btn btn-danger">초기화</button>
                </div>

			</form>
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
	            }
	        }
	    }
	    
	    
	    function changeDomain(selectElement) {
	        const domainInput = document.getElementById("emailDomain");
	        domainInput.value = selectElement.value; // 선택한 값을 입력창에 대입
	    }
	    
	    $(function() {
	        $("#idCheckBtn").click(function() {
	            const $userId = $("#inputId");
	            const $checkResult = $("#idCheckResult");

	            // 1. 프론트엔드 유효성 검사 (5글자 이상)
	            if ($userId.val().trim().length < 5) {
	                alert("아이디는 5글자 이상이어야 합니다.");
	                $userId.focus();
	                return;
	            }

	            // 2. Ajax를 이용한 DB 중복 확인
	            $.ajax({
	                url: "${contextRoot}/idCheck.me", // 서버 매핑 주소
	                data: { userId: $userId.val() },
	                success: function(result) {
	                    $checkResult.show();
	                    if (result === "NNNNY") { // 사용 가능한 경우 (서버 반환값 예시)
	                        $checkResult.text("사용 가능한 아이디입니다.").css("color", "blue");
	                        // 아이디를 수정하지 못하게 막거나, 체크 완료 상태를 기록할 수 있습니다.
	                    } else { // 중복된 경우
	                        $checkResult.text("이미 사용 중인 아이디입니다.").css("color", "red");
	                        $userId.val("").focus();
	                    }
	                },
	                error: function() {
	                    console.log("아이디 중복 확인 Ajax 통신 실패");
	                }
	            });
	        });
	    });
	    
	    
	    function validateForm() {
	        const userId = document.getElementById("inputId").value;
	        const userPwd = document.getElementById("inputPwd").value;
	        const checkPwd = document.getElementById("checkPwd").value;

	        // 1. 아이디 검사: 5글자 이상
	        if (userId.length < 5) {
	            alert("아이디는 5글자 이상이어야 합니다.");
	            return false;
	        }

	        // 2. 비밀번호 정규표현식: 소문자(?=.*[a-z]), 숫자(?=.*\d), 특수문자(?=.*[@$!%*?&]) 포함 8자 이상
	        const pwdRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[a-z\d@$!%*?&]{8,}$/;
	        if (!pwdRegex.test(userPwd)) {
	            alert("비밀번호는 영어 소문자, 숫자, 특수문자를 포함하여 8자 이상이어야 합니다.");
	            return false;
	        }

	        // 3. 비밀번호 확인 일치 검사
	        if (userPwd !== checkPwd) {
	            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	            return false;
	        }

	        return true; // 모든 조건 통과 시 제출 진행
	    }
	    
	</script>
					
					
					
					

					

</body>
</html>