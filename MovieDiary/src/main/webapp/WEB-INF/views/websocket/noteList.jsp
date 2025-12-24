<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이 쪽지함</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style>
    body { background-color: #f4f7f6; font-family: 'Noto Sans KR', sans-serif; }
    .note-container { max-width: 900px; margin: 50px auto; background: #fff; padding: 30px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
    .nav-tabs .nav-link { border: none; color: #666; font-weight: 500; padding: 12px 25px; }
    .nav-tabs .nav-link.active { color: #007bff; border-bottom: 3px solid #007bff; background: none; }
    .table thead th { border-top: none; background-color: #fafafa; color: #555; }
    .note-content-preview { display: inline-block; max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; vertical-align: middle; }
    .badge-received { background-color: #e7f1ff; color: #007bff; }
    .badge-sent { background-color: #f0fff4; color: #28a745; }
    .empty-msg { padding: 50px 0; text-align: center; color: #999; }
    .btn-reply { padding: 2px 10px; font-size: 12px; }
</style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container">
    <div class="note-container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="m-0"><i class="far fa-envelope-open mr-2"></i>쪽지함</h2>
            <button class="btn btn-primary btn-sm" onclick="location.href='${pageContext.request.contextPath}/reviewList.bo'">게시글로 돌아가기</button>
        </div>

        <ul class="nav nav-tabs mb-4" id="noteTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="received-tab" data-toggle="tab" href="#received" role="tab">받은 쪽지</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="sent-tab" data-toggle="tab" href="#sent" role="tab">보낸 쪽지</a>
            </li>
        </ul>

        <div class="tab-content" id="noteTabContent">
            <div class="tab-pane fade show active" id="received" role="tabpanel">
                <table class="table table-hover text-center">
                    <thead>
                        <tr>
                            <th>보낸 사람</th>
                            <th>내용</th>
                            <th>날짜</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="n" items="${receivedList}">
                            <tr>
                                <td class="font-weight-bold">${n.senderId}</td>
                                <td class="text-left">
                                    <span class="badge badge-received mr-2">받음</span>
                                    <span class="note-content-preview">${n.noteContent}</span>
                                </td>
                                <td class="small text-muted">${n.createDate}</td>
                                <td>
                                    <button class="btn btn-outline-primary btn-reply" 
                                            onclick="location.href='${pageContext.request.contextPath}/websocket/noteHandler?targetId=${n.senderId}'">답장</button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty receivedList}">
                            <tr><td colspan="4" class="empty-msg">받은 쪽지가 없습니다.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <div class="tab-pane fade" id="sent" role="tabpanel">
                <table class="table table-hover text-center">
                    <thead>
                        <tr>
                            <th>받는 사람</th>
                            <th>내용</th>
                            <th>날짜</th>
                            <th>상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="n" items="${sentList}">
                            <tr>
                                <td class="font-weight-bold">${n.receiverId}</td>
                                <td class="text-left">
                                    <span class="badge badge-sent mr-2">보냄</span>
                                    <span class="note-content-preview">${n.noteContent}</span>
                                </td>
                                <td class="small text-muted">${n.createDate}</td>
                                <td><span class="small">${n.readYn == 'Y' ? '읽음' : '안읽음'}</span></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty sentList}">
                            <tr><td colspan="4" class="empty-msg">보낸 쪽지가 없습니다.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>