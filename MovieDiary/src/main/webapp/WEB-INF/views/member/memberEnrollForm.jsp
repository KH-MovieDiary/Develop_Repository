<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>
    .innerOuter {
        max-width: 650px;
        background: #ffffff;
        padding: 50px;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.05);
        margin: 50px auto;
    }
    
	.id-wrapper {
	        display: flex;
	        align-items: center;
	        gap: 10px;
	        width : 100%
	    }
    
    .form-control {
        width: 100%; 
        border: 1px solid #e1e1e1;
        height: 48px;
        border-radius: 8px;
        padding: 0 15px;
		box-sizing: border-box;
    }

 
	.input-row {
	    display: flex;
	    align-items: center;
	    gap: 10px;
	    width: 100%;
	    margin-bottom: 20px; 
	}
	

	.input-row .form-control {
	    flex: 1;
	    box-sizing: border-box; 
	    width: 0; 
	}
	

	.custom-btn, .btn-spacer {
	    width: 110px !important;
	    flex-shrink: 0; 
	}
	

	.btn-spacer {
	    display: block; 
	} 
   
   
   

    /* 3. 버튼 공통 디자인 (깔끔한 스타일) */
    .custom-btn {
        height: 40px;
        width : 110px;
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
        flex-shrink: 0; /* 화면이 좁아져도 버튼 너비 유지 */
    }

    /* 메인 버튼 (아이디 확인, 회원가입) */
    #idCheckbtn, #nickNameCheckbtn, .btn-primary {
        background-color: #343a40;
        color: white;
        min-width: 110px;
    }
    #idCheckbtn:hover, #nickNameCheckbtn .btn-primary:not(:disabled):hover {
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
        color: #212529;
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
        display: none; /* 실제 파일 인풋 숨김 */
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
</style>
   


</head>
<body>

	
	<div class="content">
		<div class="innerOuter">
			<h2>회원가입</h2>
			<br>
			
			<form action="insert.me" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label for="inputId">* 아이디 (가입 후 수정불가)</label>
					<div id="resultDiv" style="font-size:0.8em; display:none"></div>
				    <div class="id-wrapper">
				        <input type="text" class="form-control" id="inputId" name="userId" placeholder="5자 이상" required>
				        <button type="button" id="idCheckbtn" class="custom-btn">아이디 확인</button>
				    </div>
				   
					<br>
					<label for="inputPwd">*비밀번호</label>
					<div id="resultDiv2" style="font-size:0.8em; display:none; margin-top:5px;"></div>
					<input type="password" class="form-control" id="inputPwd" placeholder="비밀번호를 입력하세요" name="userPwd" required> <br><br>
					
					<label for="checkPwd">*비밀번호 확인</label>
					<div id="resultDiv2_1" style="font-size:0.8em; display:none; margin-top:5px;"></div>
					<input type="password" class="form-control" id="checkPwd" placeholder="비밀번호를 한번 더 입력하세요" required> <br><br>
				
					<label for="nickName">*닉네임 (가입 후 수정불가)</label> 
					<div id="resultDiv3" style="font-size:0.8em; display:none; margin-bottom:5px;"></div>
					<div class="id-wrapper">
					    <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요" name="nickName" required>
					    <button type="button" id="nickNameCheckbtn" class="custom-btn">닉네임 확인</button>
					</div>
					<br>
					
					<label for="birthday">* 생년월일</label>
    				<input type="date" class="form-control" id="birthday" name="birthday" required> <br><br>

					
					<label for="emailId">* 이메일</label>
				    <div class="email-wrapper">
				        <input type="text" class="form-control" id="emailId" required>
				        <span class="at-symbol">@</span>
				        <input type="text" class="form-control" id="emailDomain" required>
				        <select class="form-control" id="domainSelector" onchange="changeDomain(this);">
				            <option value="">직접입력</option>
				            <option value="naver.com">naver.com</option>
				            <option value="gmail.com">gmail.com</option>
				            <option value="daum.net">daum.net</option>
				        </select>
				    </div>
				    
				    <input type="hidden" name="email" id="fullEmail">
				    <br>
				    
				    <p><span>성별</span>
					<div class="gender-wrapper">
					    <input type="radio" name="gender" id="male" value="M" required>
					    <label for="male">남성</label>
					    
					    <input type="radio" name="gender" id="female" value="F">
					    <label for="female">여성</label>
					</div>
					<br>
				        
			        <div class="form-group">
					    <label>선호 장르 (최대 5개 선택 가능)</label>
					    <div class="genre-grid">
					        <c:set var="genres" value="가족:10751,공포:27,미스터리:9648,모험:12,음악:10402,TV영화:10770,다큐멘터리:99,드라마:18,로맨스:10749,범죄:80,전쟁:10752,역사:36,서부:37,스릴러:53,SF:878,애니메이션:16,코미디:35,판타지:14" />
					        
					        <c:forTokens items="${genres}" delims="," var="genre">
					            <c:set var="g" value="${fn:split(genre, ':')}" />
					            <input type="checkbox" name="favoriteGenre" id="genre_${g[1]}" value="${g[1]}">
					            <label for="genre_${g[1]}">${g[0]}</label>
					        </c:forTokens>
					    </div>
					</div>
					
					<br><br>
					
					<div class="form-group">
				    <label for="picture">프로필 사진</label> &nbsp;&nbsp;
				    <div class="custom-file">
				        <input type="file" class="custom-file-input" id="picture" name="uploadFile" accept="image/*" onchange="loadImg(this);">
				        <label class="custom-file-label" for="picture">파일을 선택하세요</label>
				    </div>
				    
				    <div id="titleImgArea" style="margin-top: 10px;">
				        <img id="titleImg" width="150" height="150" border="1" style="display:none;">
				    </div>
					</div>
				</div>
				<br><br>
				
				<div class="btns">
                    <button type="submit" class="custom-btn btn-primary" disabled>회원가입</button>
                    <button type="reset" class="custom-btn btn-danger-custom">초기화</button>
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
	    let isIdChecked = false; // 아이디 중복 확인 통과 여부
	    let isNickNameChecked = false;
	    let isPwdValid = false;  // 비밀번호 조건 및 일치 여부
	    
	    let isPwdConditionMet = false;
	    let isPwdMatched = false;
	    
	    const $submitBtn = $(".btns button[type=submit]");
	    const $requiredInputs = $("input[required], #emailId, #emailDomain");

	    
	    function combineEmail() {
	        const emailId = $("#emailId").val().trim();
	        const emailDomain = $("#emailDomain").val().trim();
	        if(emailId !== "" && emailDomain !== "") {
	            $("#fullEmail").val(emailId + "@" + emailDomain);
	        }
	    }
	    
	    $("#emailId, #emailDomain").on("input change", function() {
	        combineEmail();
	        checkFormValidity(); // 기존에 쓰시던 전체 유효성 검사 함수
	    });
	    
	 // 장르 체크박스 선택 제한 로직
	    $("input[name='favoriteGenre']").on("change", function() {
	        const maxSelection = 5;
	        const selectedCount = $("input[name='favoriteGenre']:checked").length;

	        if (selectedCount > maxSelection) {
	            alert("장르는 최대 " + maxSelection + "개까지만 선택할 수 있습니다.");
	            $(this).prop("checked", false); // 방금 선택한 것을 취소
	        }
	    });
	    
	    
	    
	    function checkFormValidity() {
	        let allFilled = true;
	        // 필수 항목 빈칸 체크
	        $requiredInputs.each(function() {
	            if ($(this).val().trim() === "") {
	                allFilled = false;
	                return false;
	            }
	        });

	        // 모든 조건 충족 시 버튼 활성화
	        if (allFilled && isIdChecked && isNickNameChecked && isPwdValid) {
	            $submitBtn.prop("disabled", false);
	        } else {
	            $submitBtn.prop("disabled", true);
	        }
	    }
	    
	    $("#nickName").on("input",function(){
	    	isNickNameChecked = false;
	    	$("#resultDiv3").hide().text("");
	    	$(this).removeAttr("readOnly");
	    	checkFormValidity();
	    });
	    
	    //닉네임 확인 버튼 클릭 이벤트
	    $("#nickNameCheckbtn").click(function(){
	    	const $nickName = $("#nickName");
	    	const $resultDiv3 = $("#resultDiv3");
	    	const nickName = $nickName.val().trim();
	    	
	    	if(nickName === ""){
	    		alert("닉네임을 입력해주세요");
	    		return;
	    	}
	    	
	    	$resultDiv3.show();
	    	
	    	$.ajax({
	    		url : "nickCheck.me",
	    		data : {nickName : nickName},
	    		success : function(result){
		    			if (result === "NNNNY"){
		    				$resultDiv3.html("사용가능한 닉네임입니다.").css("color","green");
		    				isNickNameChecked = true;
		    				$nickName.attr("readonly", true);
		    			}else{
		    				$resultDiv3.text("이미 사용중인 닉네임입니다.").css("color","red");
		    				isNickNameChecked=false;
		    				$nickName.val("").focus();
		    			}
		    			checkFormValidity();
		    		},
	    		error : function(){
	    			console.log("닉네임 오류");
	    		}
	    	});
	    });
	    


	    function checkPasswordMatch() {
		    const pwd = $("#inputPwd").val();
		    const pwdCheck = $("#checkPwd").val();
		    const $resultDiv2 = $("#resultDiv2");
		    const $resultDiv2_1 = $("#resultDiv2_1");
		    
		    // 정규표현식: 소문자, 숫자, 특수문자 포함 8자 이상
		    const pwdRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[a-z\d@$!%*?&]{8,}$/;

		    // 1. 첫 번째 비밀번호(조건) 검사
		    if (pwd === "") {
		        $resultDiv2.hide();
		        isPwdConditionMet = false;
		    } else {
		        $resultDiv2.show();
		        if (!pwdRegex.test(pwd)) {
		            $resultDiv2.text("✕ 비밀번호는 소문자, 숫자, 특수문자 조합 8자 이상이어야 합니다.").css("color", "red");
		            isPwdConditionMet = false;
		        } else {
		            $resultDiv2.text("✓ 비밀번호 확인").css("color", "green"); // 조건 만족 시 출력
		            isPwdConditionMet = true;
		        }
		    }

		    // 2. 두 번째 비밀번호(일치) 검사
		    // 비밀번호 확인 칸에 포커스가 있거나 값이 있을 때만 검사 결과 표시
		    if (pwdCheck === "" && !$("#checkPwd").is(":focus")) {
		        $resultDiv2_1.hide();
		        isPwdMatched = false;
		    } else {
		        $resultDiv2_1.show();
		        if (pwd === "" || pwd !== pwdCheck) {
		            $resultDiv2_1.text("✕ 비밀번호가 일치하지 않습니다.").css("color", "red");
		            isPwdMatched = false;
		        } else {
	                // 상단 비밀번호 조건도 맞고, 두 값이 일치할 때
	                if(isPwdConditionMet) {
	                    $resultDiv2_1.text("✓ 비밀번호가 일치합니다.").css("color", "green");
	                    isPwdMatched = true;
	                } else {
	                    $resultDiv2_1.text("✕ 비밀번호 조건을 확인해주세요.").css("color", "red");
	                    isPwdMatched = false;
	                }
		        }
		    }

		    // 최종 상태 업데이트 및 버튼 활성화 체크
		    isPwdValid = isPwdConditionMet && isPwdMatched;
		    checkFormValidity();
		}
	    
	 // 이벤트 리스너 통합 (중복 선언 방지)
		$("#inputPwd, #checkPwd").on("input focus", function() {
		    checkPasswordMatch();
		});
	    

	    $("#inputPwd, #checkPwd").on("input", checkPasswordMatch);

	    // "아이디 확인" 버튼 클릭
	    $("#idCheckbtn").click(function() {
	        const $userId = $("#inputId");
	        const $resultDiv = $("#resultDiv");
	        const inputId = $userId.val().trim();

	        $resultDiv.show();

	        if (inputId.length < 5) {
	            $resultDiv.text("✕ 아이디는 5글자 이상 입력해야 합니다.").css("color", "red");
	            isIdChecked = false;
	            checkFormValidity();
	            return;
	        }

	        $.ajax({
	            url: "idCheck.me",
	            data: { inputId: inputId },
	            success: function(result) {
	                if (result === "NNNNY") {
	                    $resultDiv.html("✓ 사용 가능한 아이디입니다.").css("color", "green");
	                    isIdChecked = true;
	                    $userId.attr("readonly", true); // 수정 방지
	                } else {
	                    $resultDiv.text("✕ 이미 사용 중인 아이디입니다.").css("color", "red");
	                    isIdChecked = false;
	                    $userId.val("").focus();
	                }
	                checkFormValidity();
	            },
	            error: function() {
	                console.log("오류발생");
	            }
	        });
	    });
	    
	    $("#inputId").on("input", function() {
	        isIdChecked = false;
	        $("#resultDiv").hide();
	        $(this).removeAttr("readonly");
	        checkFormValidity();
	    });
	    

	    // 비밀번호 실시간 감지
	    $("#inputPwd, #checkPwd").on("input", function() {
	        checkPasswordMatch();
	    });

	    // 기타 필수 입력칸 감지
	    $requiredInputs.on("input change", function() {
	        checkFormValidity();
	    });

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