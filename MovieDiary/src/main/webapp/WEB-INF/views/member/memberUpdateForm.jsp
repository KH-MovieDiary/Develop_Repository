<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
    /* 1. 전체 레이아웃 및 공통 요소 */
    .innerOuter {
        max-width: 650px;
        background: #ffffff;
        padding: 50px;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.05);
        margin: 50px auto;
    }

    .form-control {
        width: 100%; 
        border: 1px solid #e1e1e1;
        height: 48px;
        border-radius: 8px;
        padding: 0 15px; /* 패딩 추가 */
    }

    /* 2. 아이디 입력 영역 및 확인 버튼 */
    .id-wrapper {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    #inputId {
        flex: 1;
        max-width: 75%; /* 버튼 공간 확보를 위해 너비 조절 */
    }

    /* 3. 버튼 공통 디자인 (깔끔한 스타일) */
    .custom-btn {
        height: 40px;
        width : 100px;
        padding: 0 20px;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        white-space: nowrap; /* 글자 줄바꿈 방지 */
    }

    /* 메인 버튼 (아이디 확인, 회원가입) */
    #idCheckbtn, #nickNameCheckbtn, .btn-primary {
        background-color: #343a40;
        color: white;
        min-width: 110px;
    }
    #idCheckbtn:hover, .btn-primary:not(:disabled):hover {
        background-color: #212529;
    }

    /* 회원가입 버튼 비활성화 상태 */
    .btn-primary:disabled {
        background-color: #e1e1e1;
        color: #999;
        cursor: not-allowed;
    }

    /* 초기화 버튼 */
    .btn-danger {
        background-color: #fff;
        border: 1px solid #dc3545;
        color: #dc3545;
    }
    .btn-danger:hover {
        background-color: #dc3545;
        color: #fff;
    }

    /* 하단 버튼 배치 */
    .btns {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 30px;
    }

    /* 4. 이메일 정렬 */
    .email-wrapper {
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .email-wrapper input, .email-wrapper select {
        flex: 1;
    }
    .at-symbol {
        color: #999;
        font-weight: bold;
    }

    /* 5. 장르 그리드 (3x6 레이아웃) */
    .genre-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 10px;
        margin-top: 10px;
    }

    .genre-grid input[type="checkbox"] {
        display: none;
    }

    .genre-grid input[type="checkbox"] + label {
        display: block;
        padding: 12px 10px;
        text-align: center;
        border: 1px solid #e1e1e1;
        border-radius: 8px;
        background-color: #ffffff;
        color: #555;
        cursor: pointer;
        font-size: 14px;
        transition: all 0.2s ease;
        margin: 0;
    }

    .genre-grid label:hover {
        background-color: #f8f9fa;
        border-color: #d1d1d1;
    }

    .genre-grid input[type="checkbox"]:checked + label {
        background-color: #e9ecef;
        border-color: #ced4da;
        color: #blue;
        font-weight: 600;
        box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);
    }
    
	/* 7. 성별 라디오 버튼 스타일 (장르 선택 스타일과 동일하게) */
	.gender-wrapper {
	    display: flex;
	    gap: 20px;
	    margin-top: 10px;
	}
	
	.gender-wrapper input[type="radio"] {
	    display: none;
	}
	
	.gender-wrapper label {
	    flex: 1;
	    height: 48px;
	    display: inline-flex;
	    align-items: center;
	    justify-content: center;
	    border: 1px solid #e1e1e1;
	    border-radius: 8px;
	    cursor: pointer;
	    font-size: 14px; /* 장르와 크기 통일 */
	    color: #555;
	    transition: all 0.2s ease;
	    background-color: #ffffff;
	    margin: 0;
	}
	
	.gender-wrapper label:hover {
	    background-color: #f8f9fa;
	    border-color: #d1d1d1;
	}
	
	/* 장르 체크박스(:checked)와 동일한 색상값 적용 */
	.gender-wrapper input[type="radio"]:checked + label {
	    background-color: #e9ecef;
	    border-color: #ced4da;
	    color: #212529;
	    font-weight: 600;
	    box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);
	}
    
    
    
    
    

    /* 6. 프로필 사진 및 파일 선택 */
    #titleImgArea {
        width: 150px;
        height: 150px;
        border: 2px dashed #ddd;
        border-radius: 50%;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: #f9f9f9;
        margin: 15px 0;
    }

    #titleImg {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .custom-file {
        display: inline-block;
    }

    .custom-file-input {
        display: none;
    }

    .custom-file-label {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        background-color: #6c757d;
        color: white;
        height: 40px;
        padding: 0 20px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 500;
        transition: background 0.2s;
    }

    .custom-file-label:hover {
        background-color: #5a6268;
    }
    
    /* 읽기 전용(readonly) 입력창 스타일 */
	.form-control[readonly] {
	    background-color: #f1f3f5 !important; /* 연한 회색 배경 */
	    color: #868e96;                       /* 글자색을 약간 흐리게 */
	    cursor: not-allowed;                  /* 금지 표시 커서 */
	    border: 1px solid #dee2e6;            /* 선명도 조절 */
	    box-shadow: none;                     /* 그림자 제거 */
	}
	
	/* 포커스 방지 (클릭해도 파란 테두리가 안 생기게 함) */
	.form-control[readonly]:focus {
	    border-color: #dee2e6;
	    outline: none;
	    box-shadow: none;
	}
	
</style>
   


</head>
<body>

	
	<div class="content">
		<div class="innerOuter">
			<h2>회원가입</h2>
			<br>
			
			<form action="update.me" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="userId">아이디 (수정불가)</label>
				        <input type="text" class="form-control" name="userId" value="${loginUser.userId}" readonly>
					<br><br>
					
					
					<label for="nickName">닉네임 (수정불가)</label> 
					    <input type="text" class="form-control" id="nickName" value="${loginUser.nickName}" name="nickName" readonly>
					<br><br>
					
					
					
					<label for="birthday">* 생년월일</label>
    				<input type="date" class="form-control" id="birthday" name="birthday" value="${loginUser.birthday}" required> 
					<br><br>
					
					
					<label for="emailId">* 이메일</label>
					<div class="email-wrapper">
				    <c:set var="emailParts" value="${fn:split(loginUser.email, '@')}" />
				    <input type="text" class="form-control" id="emailId" value="${emailParts[0]}" required>
				    <span class="at-symbol">@</span>
				    
				    <input type="text" class="form-control" id="emailDomain" value="${emailParts[1]}" 
				           ${(emailParts[1] == 'naver.com' || emailParts[1] == 'gmail.com' || emailParts[1] == 'daum.net') ? 'readonly' : ''} required>
				    
				    <select class="form-control" id="domainSelector" onchange="changeDomain(this);">
				        <option value="" ${!(emailParts[1] == 'naver.com' || emailParts[1] == 'gmail.com' || emailParts[1] == 'daum.net') ? 'selected' : ''}>직접입력</option>
				        <option value="naver.com" ${emailParts[1] == 'naver.com' ? 'selected' : ''}>naver.com</option>
				        <option value="gmail.com" ${emailParts[1] == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
				        <option value="daum.net" ${emailParts[1] == 'daum.net' ? 'selected' : ''}>daum.net</option>
				    </select>
					</div>
					<input type="hidden" name="email" id="fullEmail" value="${loginUser.email}">
				    
				    <p><span>성별</span>
					<div class="gender-wrapper">
					    <input type="radio" name="gender" id="male" value="M" 
					           ${loginUser.gender eq 'M' ? 'checked' : ''} required>
					    <label for="male">남성</label>
					    
					    <input type="radio" name="gender" id="female" value="F" 
					           ${loginUser.gender eq 'F' ? 'checked' : ''}>
					    <label for="female">여성</label>
					</div>
					<br>
				        
			        <div class="form-group">
				    <label>선호 장르 (최대 5개 선택 가능)</label>
				    <div class="genre-grid">
				        <input type="checkbox" name="favoriteGenre" id="family" value="10751" ${fn:contains(loginUser.favoriteGenre, '10751') ? 'checked' : ''}><label for="family">가족</label>
				        <input type="checkbox" name="favoriteGenre" id="horror" value="27" ${fn:contains(loginUser.favoriteGenre, '27') ? 'checked' : ''}><label for="horror">공포</label>
				        <input type="checkbox" name="favoriteGenre" id="mystery" value="9648" ${fn:contains(loginUser.favoriteGenre, '9648') ? 'checked' : ''}><label for="mystery">미스터리</label>
				        <input type="checkbox" name="favoriteGenre" id="adventure" value="12" ${fn:contains(loginUser.favoriteGenre, '12') ? 'checked' : ''}><label for="adventure">모험</label>
				        <input type="checkbox" name="favoriteGenre" id="music" value="10402" ${fn:contains(loginUser.favoriteGenre, '10402') ? 'checked' : ''}><label for="music">음악</label>
				        <input type="checkbox" name="favoriteGenre" id="tvMovie" value="10770" ${fn:contains(loginUser.favoriteGenre, '10770') ? 'checked' : ''}><label for="tvMovie">TV영화</label>
				        <input type="checkbox" name="favoriteGenre" id="documentary" value="99" ${fn:contains(loginUser.favoriteGenre, '99') ? 'checked' : ''}><label for="documentary">다큐멘터리</label>
				        <input type="checkbox" name="favoriteGenre" id="drama" value="18" ${fn:contains(loginUser.favoriteGenre, '18') ? 'checked' : ''}><label for="drama">드라마</label>
				        <input type="checkbox" name="favoriteGenre" id="romance" value="10749" ${fn:contains(loginUser.favoriteGenre, '10749') ? 'checked' : ''}><label for="romance">로맨스</label>
				        <input type="checkbox" name="favoriteGenre" id="crime" value="80" ${fn:contains(loginUser.favoriteGenre, '80') ? 'checked' : ''}><label for="crime">범죄</label>
				        <input type="checkbox" name="favoriteGenre" id="war" value="10752" ${fn:contains(loginUser.favoriteGenre, '10752') ? 'checked' : ''}><label for="war">전쟁</label>
				        <input type="checkbox" name="favoriteGenre" id="history" value="36" ${fn:contains(loginUser.favoriteGenre, '36') ? 'checked' : ''}><label for="history">역사</label>
				        <input type="checkbox" name="favoriteGenre" id="western" value="37" ${fn:contains(loginUser.favoriteGenre, '37') ? 'checked' : ''}><label for="western">서부</label>
				        <input type="checkbox" name="favoriteGenre" id="thriller" value="53" ${fn:contains(loginUser.favoriteGenre, '53') ? 'checked' : ''}><label for="thriller">스릴러</label>
				        <input type="checkbox" name="favoriteGenre" id="sf" value="878" ${fn:contains(loginUser.favoriteGenre, '878') ? 'checked' : ''}><label for="sf">SF</label>
				        <input type="checkbox" name="favoriteGenre" id="animation" value="16" ${fn:contains(loginUser.favoriteGenre, '16') ? 'checked' : ''}><label for="animation">애니메이션</label>
				        <input type="checkbox" name="favoriteGenre" id="comedy" value="35" ${fn:contains(loginUser.favoriteGenre, '35') ? 'checked' : ''}><label for="comedy">코미디</label>
				        <input type="checkbox" name="favoriteGenre" id="fantasy" value="14" ${fn:contains(loginUser.favoriteGenre, '14') ? 'checked' : ''}><label for="fantasy">판타지</label>
				    </div>
				</div>
					
					<br><br>
					
					<div class="form-group">
				    <label for="picture">프로필 사진</label> &nbsp;&nbsp;
				    <div class="custom-file">
				        <input type="file" class="custom-file-input" id="picture" name="uploadFile" accept="image/*" onchange="loadImg(this);">
				        <label class="custom-file-label" for="picture">파일을 선택하세요</label>
				    </div>
				    
				    <input type="hidden" name="picture" value="${loginUser.picture}">
				    
				    <div id="titleImgArea" style="margin-top: 10px; ${not empty loginUser.picture ? 'border:none;' : ''}">
					    <img id="titleImg" width="150" height="150" border="1" 
					         src="${not empty loginUser.picture ? loginUser.picture : ''}"
					         style="${not empty loginUser.picture ? 'display:block;' : 'display:none;'}">
					</div>
					
					</div>
				</div>
				<br><br>
	
				<label for="inputPwd">* 비밀번호</label>
				<div id="resultDiv" style="font-size:0.8em; display:none; margin-top:5px;"></div>
				<input type="password" class="form-control" id="inputPwd" name="userPwd" placeholder="정보 수정을 위해 비밀번호를 입력하세요" required> 
				<br><br>
				
				<div class="btns">
                    <button type="submit" class="custom-btn btn-primary">정보수정</button>
                </div>

			</form>
		</div>
	</div>
					
					
					

	<script>
	
	function changeDomain(selectElement) {
	    const domainInput = document.getElementById("emailDomain");
	    domainInput.value = selectElement.value;

	    if (selectElement.value === "") {
	    	domainInput.readOnly = false;
	        domainInput.focus();
	    } else { // 도메인 선택 시
	        domainInput.readOnly = true;
	    }

	    $(domainInput).trigger("change");
	}
	
	
	$(function() {
	    let isPwdValid = false; 
	    const $submitBtn = $(".btns button[type=submit]");
	    const $requiredInputs = $("input[required]:not(#inputPwd)");
	    const $resultDiv = $("#resultDiv");

	    // 이메일 결합 함수
	    function combineEmail() {
	        const emailId = $("#emailId").val().trim();
	        const emailDomain = $("#emailDomain").val().trim();
	        if(emailId !== "" && emailDomain !== "") {
	            $("#fullEmail").val(emailId + "@" + emailDomain);
	        }
	    }

	    // 이메일 입력 시마다 체크
	    $("#emailId, #emailDomain").on("input change", function() {
	        combineEmail();
	        checkFormValidity();
	    });

	    // 비밀번호 체크 로직 (change + focusout)
	    $("#inputPwd").on("focusout change", function() {
	        const userPwd = $(this).val();

	        if(userPwd === "") {
	            isPwdValid = false;
	            $resultDiv.hide();
	            checkFormValidity();
	            return;
	        }

	        $.ajax({
	            url: "checkPwd.me",
	            type: "post",
	            data: { userPwd: userPwd },
	            success: function(result) {
	                // [오타 수정 완료] $resultDiv.text.text -> $resultDiv.text
	                if (result === "true") {
	                    $resultDiv.text("✓ 비밀번호가 확인되었습니다.").css({"color":"green", "display":"block"});
	                    isPwdValid = true;
	                } else {
	                    $resultDiv.text("✕ 비밀번호가 일치하지 않습니다.").css({"color":"red", "display":"block"});
	                    isPwdValid = false;
	                }
	                checkFormValidity(); 
	            },
	            error: function() {
	                console.log("비밀번호 체크 통신 실패");
	            }
	        });
	    });
	    
	    
	    $("input[name='favoriteGenre']").on("change", function() {
	        const maxSelection = 5;
	        const selectedCount = $("input[name='favoriteGenre']:checked").length;

	        if (selectedCount > maxSelection) {
	            alert("장르는 최대 " + maxSelection + "개까지만 선택할 수 있습니다.");
	            $(this).prop("checked", false); // 방금 선택한 것을 취소
	        }
	    });
	    

	    // 유효성 전체 검사
	    function checkFormValidity() {
	        let allFilled = true;
	        
	        // 1. 필수 입력창 빈칸 체크
	        $requiredInputs.each(function() {
	            if ($(this).val().trim() === "") {
	                allFilled = false;
	                return false;
	            }
	        });

	        // 2. 이메일 완성 여부
	        const fullEmail = $("#fullEmail").val();
	        if(!fullEmail || fullEmail.indexOf('@') == -1) allFilled = false;

	        // 3. 최종 확인 (비밀번호 일치 여부 포함)
	        if (allFilled && isPwdValid) {
	            $submitBtn.prop("disabled", false);
	        } else {
	            $submitBtn.prop("disabled", true);
	        }
	    }

	    // 초기 실행
	    checkFormValidity();
	});
	
	// 프로필 사진 미리보기 함수
    function loadImg(inputFile) {
        // inputFile.files[0] 에 선택한 파일 정보가 담겨 있음
        if (inputFile.files && inputFile.files[0]) {
            const reader = new FileReader();

            // 파일을 읽어들이는 작업이 완료되면 실행
            reader.onload = function(e) {
                const $img = document.getElementById("titleImg");
                $img.src = e.target.result; // 읽어들인 파일 경로(Base64)를 src에 대입
                $img.style.display = "block";
                
                // 사진이 들어오면 점선 테두리 제거
                document.getElementById("titleImgArea").style.border = "none";
            };

            // 선택한 파일을 데이터 URL(미리보기용 주소)로 읽기
            reader.readAsDataURL(inputFile.files[0]);

            // 파일명 라벨에 표시하기
            const fileName = inputFile.files[0].name;
            const label = inputFile.nextElementSibling; // custom-file-label 선택
            if (label && label.classList.contains('custom-file-label')) {
                label.innerText = fileName;
            }
        } else {
            // 선택 취소 시 기본 이미지로 되돌리거나 숨김 처리
            document.getElementById("titleImg").src = "";
            document.getElementById("titleImg").style.display = "none";
            document.getElementById("titleImgArea").style.border = "2px dashed #ddd";
        }
    }


	</script>
					
					
					
					

					

</body>
</html>