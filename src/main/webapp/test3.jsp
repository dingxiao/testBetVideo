<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.psd.bettest.*" %>
<%
String url = "http://www.bet.com/videoplayer/jcr:content.token.json";
String token = GetUrlData.getUrlJson(url, "token");
//String inputName = (String) request.getAttribute("inputName");
String useOld = (String) request.getParameter("use");
String video = (String) request.getParameter("video");
String ad = (String) request.getParameter("ad");
String poster = (String) request.getParameter("poster");
String omniture = (String) request.getParameter("omniture");
if (useOld == null){
    useOld = "yes";
}
response.setHeader("Access-Control-Allow-Origin","*");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BET Mobile/Tablet Test - HTML5 player improvements</title>
</head>
<body>

    <script>
    var useOld = "<%=useOld %>"; 
    var video = "<%=video %>"; 
    var ad = "<%=ad %>"; 
    var poster = "<%=poster %>"; 
    var omnitureTracking = "<%=omniture %>"; 
    var iframeTemplate = "iframe_ima33.html?video=https%3A%2F%2Fcp162205-f.akamaihd.net%2Fi%2Fvideohub%2F106andpark%2F2014%2F12%2Fclip%2Fbetcom_bpty140001_intv_kcamp_%2C448x252_450%2C624x352_800%2C640x360_1200%2C640x360_1800%2C1280x720_2600%2C.mp4.csmil%2Fmaster.m3u8%3Fhdnea%3D{TOKEN}&amp;adTag=http%3A%2F%2Fad.doubleclick.net%2Fpfadx%2Fbet.com%2FVideo%3Bn%3Dk-camp-106-and-party%3Bsub%3D106andpark%3Bprod%3D%3Bsz%3D250x250%3Bshow%3D106andpark%3Bembedshow%3D%26lt%3Bparameters.betembedshow%26gt%3B%3Bembedn%3D%26lt%3Bparameters.betembedn%26gt%3B%3Btile%3D4%3Bct%3Dindivmediapage%3Bloc%3D4%3Banum%3D1%3Bdomainname%3Dwww.bet.com%3Bord%3D1421095280920%3Bprog%3Dclip&amp;autoPlay=false&amp;poster=http%3A%2F%2Fwww.bet.com%2Fcontent%2Fdam%2Fbetcom%2Fimages%2F2014%2F12%2FShows%2F106-Park-12-11-12-20%2F123114-shows-106-park-new-years-party-K-Camp.jpg&amp;omnitureTracking=prop5%3D106%2B%2526%2BPark%26eVar5%3D106%2B%2526%2BPark%26prop6%3Dunknown%26eVar6%3Dunknown%26eVar17%3Dvideo%253A106andpark%253A106-party%253A2014%253Ak-camp-106-and-party%26prop48%3D2014%26eVar48%3D2014%26prop49%3Dunknown%26eVar49%3Dunknown%26prop39%3D1TVClip%26eVar39%3D1TVClip%26prop45%3Dunknown%26eVar45%3Dunknown%26prop31%3D1%26prop13%3Dvideo%26prop54%3Dunknown%26eVar54%3Dunknown%26prop55%3D01%2F01%2F15%26eVar55%3D01%2F01%2F15%26prop56%3DGuest%2BRewind%26eVar56%3DGuest%2BRewind%26prop57%3Dunknown%26eVar57%3Dunknown%26prop58%3Dshort%26eVar58%3Dshort%26mediaName%3D106%2B%2526%2BPark%253A%2BGuest%2BRewind%253A%2BK%2BCamp%2BPreps%2Bto%2BDominate%2B2015";
    //clip
    iframeTemplate = "iframe_ima3.html?video=https%3A%2F%2Fcp162205-f.akamaihd.net%2Fi%2Fvideohub%2Fblackstarcinema%2F2014%2Fbetcom_movies14_larrychristmastrailer_final_%2C448x252_450%2C624x352_800%2C640x360_1200%2C640x360_1800%2C640x360_2600%2C.mp4.csmil%2Fmaster.m3u8%3Fhdnea%3D{TOKEN}&amp;adTag=http%3A%2F%2Fad.doubleclick.net%2Fpfadx%2Fbet.com%2FVideo%3Bn%3Dbet-star-cinema-all-videos%3Bsub%3Dbet-star-cinema%3Bprod%3D%3Bsz%3D250x250%3Bshow%3Dbetstarcinema%3Bembedshow%3D%26lt%3Bparameters.betembedshow%26gt%3B%3Bembedn%3D%26lt%3Bparameters.betembedn%26gt%3B%3Btile%3D4%3Bct%3Dbrowsevideopage%3Bloc%3D4%3Banum%3D1%3Bdomainname%3Dwww.bet.com%3Bord%3D1421269098047%3Bprog%3Dclip&amp;autoPlay=false&amp;poster=http%3A%2F%2Fwww.bet.com%2Fcontent%2Fdam%2Fbetcom%2Fshows%2FBETStarCinema%2F16by9-bet-star-cinema-logo-carousel.jpg&amp;omnitureTracking=prop5%3DBET%2BStar%2BCinema%26eVar5%3DBET%2BStar%2BCinema%26prop6%3Dunknown%26eVar6%3Dunknown%26eVar17%3Dshows%253Abet-star-cinema%253Abet-star-cinema-all-videos%26prop48%3D2014%26eVar48%3D2014%26prop49%3Dunknown%26eVar49%3Dunknown%26prop39%3D1TVClip%26eVar39%3D1TVClip%26prop45%3Dunknown%26eVar45%3Dunknown%26prop31%3D1%26prop13%3Dvideo%26prop54%3Dunknown%26eVar54%3Dunknown%26prop55%3D05%2F25%2F13%26eVar55%3D05%2F25%2F13%26prop56%3Dunknown%26eVar56%3Dunknown%26prop57%3Dunknown%26eVar57%3Dunknown%26prop58%3Dshort%26eVar58%3Dshort%26mediaName%3DBET%2BStar%2BCinema%253A%2BA%2BVery%2BLarry%2BChristmas%2BTrailer";
    //full episode
    iframeTemplate = "iframe_ima3.html?video=https%3A%2F%2Fcp162205-f.akamaihd.net%2Fi%2Fvideohub%2Frhoh%2F2015%2Ffull-episodes%2Fbetcom_hd_brho14310_act1_cc_%2C448x252_450%2C624x352_800%2C640x360_1200%2C640x360_1800%2C1280x720_2600%2C.mp4.csmil%2Fmaster.m3u8%3Fhdnea%3D{TOKEN}&amp;adTag=http%3A%2F%2Fad.doubleclick.net%2Fpfadx%2Fbet.com%2FVideo%3Bn%3Depisode-310-model-behavior%3Bsub%3Dthe-real-husbands-of-hollywood%3Bprod%3D%3Bsz%3D250x250%3Bshow%3Dreal_husbands_of_hollywood%3Bembedshow%3D%26lt%3Bparameters.betembedshow%26gt%3B%3Bembedn%3D%26lt%3Bparameters.betembedn%26gt%3B%3Btile%3D4%3Bct%3Dindivmediapage%3Bloc%3D4%3Banum%3D1%3Bdomainname%3Dwww.bet.com%3Bord%3D1421419086149%3Bprog%3Dfullepisode&amp;autoPlay=false&amp;poster=http%3A%2F%2Fwww.bet.com%2Fcontent%2Fdam%2Fbetcom%2Fimages%2F2015%2F01%2FShows%2FRHOH%2Fbrho14310_full.JPG&amp;omnitureTracking=prop5%3DReal%2BHusbands%2BOf%2BHollywood%26eVar5%3DReal%2BHusbands%2BOf%2BHollywood%26prop6%3Dunknown%26eVar6%3Dunknown%26eVar17%3Dvideo%253Athe-real-husbands-of-hollywood%253Aseason-3%253Afull-episodes%253Aepisode-310-model-behavior%26prop48%3D3%26eVar48%3D3%26prop49%3D10%26eVar49%3D10%26prop39%3D0FullEpisode%26eVar39%3D0FullEpisode%26prop45%3Dunknown%26eVar45%3Dunknown%26prop31%3D4%26prop13%3Dvideo%26prop54%3Dunknown%26eVar54%3Dunknown%26prop55%3D01%2F14%2F15%26eVar55%3D01%2F14%2F15%26prop56%3DFull%2BEpisode%26eVar56%3DFull%2BEpisode%26prop57%3DComedy%26eVar57%3DComedy%26prop58%3Dlong%26eVar58%3Dlong%26mediaName%3DReal%2BHusbands%2BOf%2BHollywood%253A%2BFull%2BEpisode%253A%2BModel%2BBehavior";
    //full with good adTag
    iframeTemplate = "iframe_ima33.html?video=https%3A%2F%2Fcp162205-f.akamaihd.net%2Fi%2Fvideohub%2Frhoh%2F2015%2Ffull-episodes%2Fbetcom_hd_brho14310_act1_cc_%2C448x252_450%2C624x352_800%2C640x360_1200%2C640x360_1800%2C1280x720_2600%2C.mp4.csmil%2Fmaster.m3u8%3Fhdnea%3D{TOKEN}&amp;adTag=http%3A%2F%2Fad.doubleclick.net%2Fpfadx%2Fbet.com%2FVideo%3Bn%3Depisode-310-model-behavior%3Bsub%3Dthe-real-husbands-of-hollywood%3Bprod%3D%3Bsz%3D250x250%3Bshow%3Dreal_husbands_of_hollywood%3Bembedshow%3D%26lt%3Bparameters.betembedshow%26gt%3B%3Bembedn%3D%26lt%3Bparameters.betembedn%26gt%3B%3Btile%3D4%3Bct%3Dindivmediapage%3Bloc%3D4%3Banum%3D1%3Bdomainname%3Dwww.bet.com%3Bord%3D1421342580822%3Bprog%3Dfullepisode&amp;autoPlay=false&amp;poster=http%3A%2F%2Fwww.bet.com%2Fcontent%2Fdam%2Fbetcom%2Fimages%2F2015%2F01%2FShows%2FRHOH%2Fbrho14310_full.JPG&amp;omnitureTracking=prop5%3DReal%2BHusbands%2BOf%2BHollywood%26eVar5%3DReal%2BHusbands%2BOf%2BHollywood%26prop6%3Dunknown%26eVar6%3Dunknown%26eVar17%3Dvideo%253Athe-real-husbands-of-hollywood%253Aseason-3%253Afull-episodes%253Aepisode-310-model-behavior%26prop48%3D3%26eVar48%3D3%26prop49%3D10%26eVar49%3D10%26prop39%3D0FullEpisode%26eVar39%3D0FullEpisode%26prop45%3Dunknown%26eVar45%3Dunknown%26prop31%3D4%26prop13%3Dvideo%26prop54%3Dunknown%26eVar54%3Dunknown%26prop55%3D01%2F14%2F15%26eVar55%3D01%2F14%2F15%26prop56%3DFull%2BEpisode%26eVar56%3DFull%2BEpisode%26prop57%3DComedy%26eVar57%3DComedy%26prop58%3Dlong%26eVar58%3Dlong%26mediaName%3DReal%2BHusbands%2BOf%2BHollywood%253A%2BFull%2BEpisode%253A%2BModel%2BBehavior";

        var token = encodeURIComponent("<%=token %>");
        var iframeSource = iframeTemplate.replace("{TOKEN}", token);
      
        if (!video) video = "https://cp162205-f.akamaihd.net/i/videohub/rhoh/2015/full-episodes/betcom_hd_brho14310_act1_cc_,448x252_450,624x352_800,640x360_1200,640x360_1800,1280x720_2600,.mp4.csmil/master.m3u8?hdnea=";
        if (!ad) ad = "http://ad.doubleclick.net/pfadx/bet.com/Video;n=episode-310-model-behavior;sub=the-real-husbands-of-hollywood;prod=;sz=250x250;show=real_husbands_of_hollywood;embedshow=&lt;parameters.betembedshow&gt;;embedn=&lt;parameters.betembedn&gt;;tile=4;ct=indivmediapage;loc=4;anum=1;domainname=www.bet.com;ord=1421342580822;prog=fullepisode";
        if (!poster) poster = "http://www.bet.com/content/dam/betcom/images/2015/01/Shows/RHOH/brho14310_full.JPG";
        if (!omnitureTracking) omnitureTracking = "prop5=Real+Husbands+Of+Hollywood&eVar5=Real+Husbands+Of+Hollywood&prop6=unknown&eVar6=unknown&eVar17=video%3Athe-real-husbands-of-hollywood%3Aseason-3%3Afull-episodes%3Aepisode-310-model-behavior&prop48=3&eVar48=3&prop49=10&eVar49=10&prop39=0FullEpisode&eVar39=0FullEpisode&prop45=unknown&eVar45=unknown&prop31=4&prop13=video&prop54=unknown&eVar54=unknown&prop55=01/14/15&eVar55=01/14/15&prop56=Full+Episode&eVar56=Full+Episode&prop57=Comedy&eVar57=Comedy&prop58=long&eVar58=long&mediaName=Real+Husbands+Of+Hollywood%3A+Full+Episode%3A+Model+Behavior";
        var videoParam = encodeURIComponent(video) + token;
        var adParam = encodeURIComponent(ad);
        var posterParam = encodeURIComponent(poster);
        var omnitureTrackingParam = encodeURIComponent(omnitureTracking);


        if (useOld == "no" && video && ad) { 
        	iframeSource= 'iframe_ima3.html?' +
           'video=' + videoParam + '&amp;adTag=' + adParam + '&amp;autoPlay=false' + '&amp;poster=' + posterParam + '&amp;omnitureTracking='+ omnitureTrackingParam;
        } 
        console.log('Final URL: ' + iframeSource);
        console.log('Token: ' + token);

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