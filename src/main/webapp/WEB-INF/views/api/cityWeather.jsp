<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div style="font-size: 15px;" class="form-group row">
	<div>
		<span>도시</span><br> <b>${cityName} </b>
	</div>

	<c:forEach items="${weatherList }" var="vo">
		<c:if test="${vo.category == '기온'}">
			<div>
				<span>기온</span><br> <b>${vo.fcstValue} ℃ </b>
			</div>
		</c:if>
		<c:if test="${vo.category == '강수형태'}">
			<div>
				<span>강수</span>
				<c:choose>
					<c:when test="${vo.fcstValue  == 0}">
						<img src="/img/weather_0001_Layer 8.jpg">
						<br>
						<b class="fcst_st">눈,비,소나기 없음</b>
					</c:when>
					<c:when test="${vo.fcstValue  == 1}">
						<b>비</b>
					</c:when>
					<c:when test="${vo.fcstValue == 2}">
						<b>비/눈</b>
					</c:when>
					<c:when test="${vo.fcstValue == 3}">
						<b>눈</b>
					</c:when>
					<c:when test="${vo.fcstValue == 4}">
						<b>소나기</b>
					</c:when>
				</c:choose>
			</div>
		</c:if>
		<c:if test="${vo.category == '풍속'}">
			<div>
				<span>풍속</span><br> <b>${vo.fcstValue} m/s</b>
			</div>
		</c:if>
	</c:forEach>
</div>

