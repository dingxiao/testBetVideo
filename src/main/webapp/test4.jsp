<%@ page import="com.psd.bettest.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String url = "http://www.bet.com/videoplayer/jcr:content.token.json";
Map<String,String> map = TestH2.test("");
//String inputName = (String) request.getAttribute("inputName");
String cmd = (String) request.getParameter("cmd");
String key = (String) request.getParameter("key");
String value = (String) request.getParameter("value");
if (cmd == null){
    cmd = "read";
}
Map<String,String> map2;//  = new HashMap<String,String>();
String rt = "none";
if (cmd.equalsIgnoreCase("insert") && key != null){
    rt = TestH2.insert(key, value);
    cmd = "after " + cmd + ", return is " + rt;
}
if (cmd.equalsIgnoreCase("create") && key != null){
    rt = TestH2.create(key);
    cmd = "after " + cmd + ", return is " + rt;
}
if (cmd.equalsIgnoreCase("query") && key != null){
    map2 = TestH2.query(key);
    request.setAttribute("map22", map2);
    cmd = "after " + cmd + ", return is below";
}
else{
    request.setAttribute("map22", map);
}
String iframeTemplate = "iframe_ima3.html?video=https%3A%2F%2Fcp162205-f.akamaihd.net%2Fi%2Fvideohub%2Fbgr%2F2013%2Ffull%2Fbetcom_bbgr13001_act1_cc_%2C448x252_450%2C624x352_800%2C640x360_1200%2C640x360_1800%2C1280x720_2600%2C.mp4.csmil%2Fmaster.m3u8%3Fhdnea%3D{TOKEN}&amp;adTag=http%3A%2F%2Fad.doubleclick.net%2Fpfadx%2Fbet.com%2FVideo%3Bn%3Dthe-full-show%3Bsub%3Dblackgirlsrock%3Bprod%3D%3Bsz%3D250x250%3Bshow%3Dblackgirlsrock%3Bembedshow%3D%26lt%3Bparameters.betembedshow%26gt%3B%3Bembedn%3D%26lt%3Bparameters.betembedn%26gt%3B%3Btile%3D4%3Bct%3Dindivmediapage%3Bloc%3D4%3Banum%3D1%3Bdomainname%3Dwww.bet.com%3Bord%3D1422367502208%3Bprog%3Dfullepisode&amp;autoPlay=false&amp;poster=http%3A%2F%2Fwww.bet.com%2Fcontent%2Fdam%2Fbetcom%2Fimages%2F2013%2F11%2FShows%2FBobby-Jones-Gospel%2Fbgr13_fullshow2.jpg&amp;omnitureTracking=prop5%3DBlack%2BGirls%2BRock%26eVar5%3DBlack%2BGirls%2BRock%26prop6%3Dunknown%26eVar6%3Dunknown%26eVar17%3Dvideo%253Ablackgirlsrock%253A2013%253Aexclusives%253Athe-full-show%26prop48%3D2013%26eVar48%3D2013%26prop49%3Dunknown%26eVar49%3Dunknown%26prop39%3D0FullEpisode%26eVar39%3D0FullEpisode%26prop45%3Dunknown%26eVar45%3Dunknown%26prop31%3D9%26prop13%3Dvideo%26prop54%3Dunknown%26eVar54%3Dunknown%26prop55%3D11%2F04%2F13%26eVar55%3D11%2F04%2F13%26prop56%3Dunknown%26eVar56%3Dunknown%26prop57%3DArts%2Band%2BCulture%26eVar57%3DArts%2Band%2BCulture%26prop58%3Dlong%26eVar58%3Dlong%26mediaName%3DBlack%2BGirls%2BRock%253A%2BBlack%2BGirls%2BRock%2521%2B2013%2BFull%2BShow";
request.setAttribute("cmd", cmd);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Save or query values h2</title>
</head>
<body>
<h2> query or insert value to h2</h2>
<div> <c:out value="${cmd}"></c:out></div>
 <form action="test4.jsp" method="post">
  cmd: <input type="text" name="cmd" size="136" value="insert"> <br />
  video param: <input type="text" name="value"  size="130" value="https%3A%2F%2Fcp162205-f.akamaihd.net%2Fi%2Fvideohub%2Fbgr%2F2013%2Ffull%2Fbetcom_bbgr13001_act1_cc_%2C448x252_450%2C624x352_800%2C640x360_1200%2C640x360_1800%2C1280x720_2600%2C.mp4.csmil%2Fmaster.m3u8%3Fhdnea%3D{TOKEN}&amp;adTag=http%3A%2F%2Fad.doubleclick.net%2Fpfadx%2Fbet.com%2FVideo%3Bn%3Dthe-full-show%3Bsub%3Dblackgirlsrock%3Bprod%3D%3Bsz%3D250x250%3Bshow%3Dblackgirlsrock%3Bembedshow%3D%26lt%3Bparameters.betembedshow%26gt%3B%3Bembedn%3D%26lt%3Bparameters.betembedn%26gt%3B%3Btile%3D4%3Bct%3Dindivmediapage%3Bloc%3D4%3Banum%3D1%3Bdomainname%3Dwww.bet.com%3Bord%3D1422367502208%3Bprog%3Dfullepisode&amp;autoPlay=false&amp;poster=http%3A%2F%2Fwww.bet.com%2Fcontent%2Fdam%2Fbetcom%2Fimages%2F2013%2F11%2FShows%2FBobby-Jones-Gospel%2Fbgr13_fullshow2.jpg&amp;omnitureTracking=prop5%3DBlack%2BGirls%2BRock%26eVar5%3DBlack%2BGirls%2BRock%26prop6%3Dunknown%26eVar6%3Dunknown%26eVar17%3Dvideo%253Ablackgirlsrock%253A2013%253Aexclusives%253Athe-full-show%26prop48%3D2013%26eVar48%3D2013%26prop49%3Dunknown%26eVar49%3Dunknown%26prop39%3D0FullEpisode%26eVar39%3D0FullEpisode%26prop45%3Dunknown%26eVar45%3Dunknown%26prop31%3D9%26prop13%3Dvideo%26prop54%3Dunknown%26eVar54%3Dunknown%26prop55%3D11%2F04%2F13%26eVar55%3D11%2F04%2F13%26prop56%3Dunknown%26eVar56%3Dunknown%26prop57%3DArts%2Band%2BCulture%26eVar57%3DArts%2Band%2BCulture%26prop58%3Dlong%26eVar58%3Dlong%26mediaName%3DBlack%2BGirls%2BRock%253A%2BBlack%2BGirls%2BRock%2521%2B2013%2BFull%2BShow"><br>
  video name: <input type="text" name="key" size="130" value="rock"><br>
  <input type="submit" value="Submit">
</form> 

<table>
<c:forEach items="${requestScope.map22}" var="emp">
<tr><td><c:out value="${emp.key}"></c:out></td>
<td><c:out value="${emp.value}"></c:out></td>

</c:forEach>
</table>

</body>
</html>