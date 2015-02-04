<%@ page import="com.psd.bettest.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String url = "http://www.bet.com/videoplayer/jcr:content.token.json";


%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Home page</title>
</head>
<body>
<h2>BET video with ad configured on DFP</h2>
This link will give you full episode video Black girl rock with ad configured on DFP
<a href="test2.jsp">test rock</a>
<br/>
Next link gives Real husband with ad configured on DFP
<a href="test2.jsp?video=real">test real</a>
<br/>

<h2> test BET video with ad configured using mRSS</h2>
This link will give you full episode video Black girl rock with ad configured using mRSS
<a href="test.jsp">test rock</a>
<br/>
Next link gives Real husband with ad configured using mRSS
<a href="test.jsp?video=real">test real</a>
<br />

<h2>Universal player for all platforms, integrated with Flash and html5</h2>
This link will give you full episode video Black girl rock on all platforms with ad configured on DFP
<a href="betall.jsp">test rock</a>

<h2>direct to bet page</h2>
<a href="http://www.bet.com/video/blackgirlsrock/2013/exclusives/the-full-show.html">full show</a>
</body>
</html>
