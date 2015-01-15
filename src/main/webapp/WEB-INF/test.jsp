<%@ page import="com.psd.bettest.*" %>
<%
String url = "http://www.bet.com/videoplayer/jcr:content.token.json";
String token = GetUrlData.getUrlJson(url, "token");
%>
<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Test token</title>
</head>
<body>
Test get token.<br>

token=<%=token %>
</body>
</html>