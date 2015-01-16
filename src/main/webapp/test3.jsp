<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page import="com.psd.bettest.*" %>
<%
String url = "http://www.bet.com/videoplayer/jcr:content.token.json";
String token = GetUrlData.getUrlJson(url, "token");
//String inputName = (String) request.getAttribute("inputName");
String useIframe = (String) request.getParameter("use");
if (useIframe == null){
    useIframe = "no";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Test token</title>
</head>
<body>
Test BET video via html5.<br>
    <script>
    var useIframe = "<%=useIframe %>"; 
    var iframeTemplate = "iframe_ima33.html?video=https%3A%2F%2Fcp162205-f.akamaihd.net%2Fi%2Fvideohub%2F106andpark%2F2014%2F12%2Fclip%2Fbetcom_bpty140001_intv_kcamp_%2C448x252_450%2C624x352_800%2C640x360_1200%2C640x360_1800%2C1280x720_2600%2C.mp4.csmil%2Fmaster.m3u8%3Fhdnea%3D{TOKEN}&amp;adTag=http%3A%2F%2Fad.doubleclick.net%2Fpfadx%2Fbet.com%2FVideo%3Bn%3Dk-camp-106-and-party%3Bsub%3D106andpark%3Bprod%3D%3Bsz%3D250x250%3Bshow%3D106andpark%3Bembedshow%3D%26lt%3Bparameters.betembedshow%26gt%3B%3Bembedn%3D%26lt%3Bparameters.betembedn%26gt%3B%3Btile%3D4%3Bct%3Dindivmediapage%3Bloc%3D4%3Banum%3D1%3Bdomainname%3Dwww.bet.com%3Bord%3D1421095280920%3Bprog%3Dclip&amp;autoPlay=false&amp;poster=http%3A%2F%2Fwww.bet.com%2Fcontent%2Fdam%2Fbetcom%2Fimages%2F2014%2F12%2FShows%2F106-Park-12-11-12-20%2F123114-shows-106-park-new-years-party-K-Camp.jpg&amp;omnitureTracking=prop5%3D106%2B%2526%2BPark%26eVar5%3D106%2B%2526%2BPark%26prop6%3Dunknown%26eVar6%3Dunknown%26eVar17%3Dvideo%253A106andpark%253A106-party%253A2014%253Ak-camp-106-and-party%26prop48%3D2014%26eVar48%3D2014%26prop49%3Dunknown%26eVar49%3Dunknown%26prop39%3D1TVClip%26eVar39%3D1TVClip%26prop45%3Dunknown%26eVar45%3Dunknown%26prop31%3D1%26prop13%3Dvideo%26prop54%3Dunknown%26eVar54%3Dunknown%26prop55%3D01%2F01%2F15%26eVar55%3D01%2F01%2F15%26prop56%3DGuest%2BRewind%26eVar56%3DGuest%2BRewind%26prop57%3Dunknown%26eVar57%3Dunknown%26prop58%3Dshort%26eVar58%3Dshort%26mediaName%3D106%2B%2526%2BPark%253A%2BGuest%2BRewind%253A%2BK%2BCamp%2BPreps%2Bto%2BDominate%2B2015";
    iframeTemplate = "iframe_ima33.html?video=https%3A%2F%2Fcp162205-f.akamaihd.net%2Fi%2Fvideohub%2Frhoh%2F2015%2Ffull-episodes%2Fbetcom_hd_brho14310_act1_cc_%2C448x252_450%2C624x352_800%2C640x360_1200%2C640x360_1800%2C1280x720_2600%2C.mp4.csmil%2Fmaster.m3u8%3Fhdnea%3D{TOKEN}&amp;adTag=http%3A%2F%2Fad.doubleclick.net%2Fpfadx%2Fbet.com%2FVideo%3Bn%3Depisode-310-model-behavior%3Bsub%3Dthe-real-husbands-of-hollywood%3Bprod%3D%3Bsz%3D250x250%3Bshow%3Dreal_husbands_of_hollywood%3Bembedshow%3D%26lt%3Bparameters.betembedshow%26gt%3B%3Bembedn%3D%26lt%3Bparameters.betembedn%26gt%3B%3Btile%3D4%3Bct%3Dindivmediapage%3Bloc%3D4%3Banum%3D1%3Bdomainname%3Dwww.bet.com%3Bord%3D1421419086149%3Bprog%3Dfullepisode&amp;autoPlay=false&amp;poster=http%3A%2F%2Fwww.bet.com%2Fcontent%2Fdam%2Fbetcom%2Fimages%2F2015%2F01%2FShows%2FRHOH%2Fbrho14310_full.JPG&amp;omnitureTracking=prop5%3DReal%2BHusbands%2BOf%2BHollywood%26eVar5%3DReal%2BHusbands%2BOf%2BHollywood%26prop6%3Dunknown%26eVar6%3Dunknown%26eVar17%3Dvideo%253Athe-real-husbands-of-hollywood%253Aseason-3%253Afull-episodes%253Aepisode-310-model-behavior%26prop48%3D3%26eVar48%3D3%26prop49%3D10%26eVar49%3D10%26prop39%3D0FullEpisode%26eVar39%3D0FullEpisode%26prop45%3Dunknown%26eVar45%3Dunknown%26prop31%3D4%26prop13%3Dvideo%26prop54%3Dunknown%26eVar54%3Dunknown%26prop55%3D01%2F14%2F15%26eVar55%3D01%2F14%2F15%26prop56%3DFull%2BEpisode%26eVar56%3DFull%2BEpisode%26prop57%3DComedy%26eVar57%3DComedy%26prop58%3Dlong%26eVar58%3Dlong%26mediaName%3DReal%2BHusbands%2BOf%2BHollywood%253A%2BFull%2BEpisode%253A%2BModel%2BBehavior";

        var token = encodeURIComponent("<%=token %>");
        var iframeSource = iframeTemplate.replace("{TOKEN}", token);
        console.log('Final URL: ' + iframeSource);
        console.log('Token: ' + '<?php echo $obj->token; ?>');
        var iframe = document.createElement('iframe');
        iframe.src = iframeSource;
        iframe.frameborder = 0;
        iframe.scrolling = "no";
        iframe.style.width = "100%";
        iframe.style.height = "480px";
        document.body.appendChild(iframe);

    </script>

</body>
</html>