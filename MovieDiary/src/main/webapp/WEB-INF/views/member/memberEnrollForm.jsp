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
					<input type="text" class="form-control" id="inputPwd" placeholder="비밀번호를 입력하세요" name="userPwd" required> <br><br>
					
					<label for="checkPwd">*비밀번호 확인 : </label>
					<input type="text" class="form-control" id="checkPwd" placeholder="비밀번호를 한번 더 입력하세요" required> <br><br>
				
					<label for="nickName">*별명 : </label>
					<input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요" name="nickName"> <br><br>
				
				
				
				</div>
			
			
			
			
			
			</form>
		</div>
	</div>

</body>
</html>