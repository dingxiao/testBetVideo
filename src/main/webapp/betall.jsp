<%@ page language="java" contentType="text/html; charset=US-ASCII" pageEncoding="US-ASCII"%>
<%@ page import="com.psd.bettest.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String url = "http://www.bet.com/videoplayer/jcr:content.token.json";
String token = GetUrlData.getUrlJson(url, "token");
//String inputName = (String) request.getAttribute("inputName");
String useIframe = (String) request.getParameter("use");
if (useIframe == null){
    useIframe = "no";
}
String videoParam = "";
String video = (String) request.getParameter("video");
if (video != null){
    Map<String, String> map2 = TestH2.query(video);
    if (map2 != null && !map2.isEmpty()){
        request.setAttribute("videoParam", map2.get(video));
        videoParam = map2.get(video);
    }
    else{
        request.setAttribute("videoParam", "");
        
    }
    
}
if (video == null){
    video = "rock";
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>BET Universal Player</title>
	<meta name="generator" content="TextMate http://macromates.com/">
	<meta name="author" content="Derek Wischusen">
	
	<!-- get js from  http://www.bet.com/video/blackgirlsrock/2013/exclusives/the-full-show.html on 1/30/2015-->

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    
<script type="text/javascript" src="http://serve.a-widget.com/kickFlash/scripts/swfobject2.js?2"></script>

<script type="text/javascript">

var mrssMediaUrl = 'http://www.bet.com/content/betcom/video/blackgirlsrock/2013/exclusives/the-full-show/_jcr_content/leftcol/videoplayer.mrss?pt=FullPage&type=FullPage;';
//var videoParam = 'https://cp162205-f.akamaihd.net/i/videohub/bgr/2013/full/betcom_bbgr13001_act1_cc_,448x252_450,624x352_800,640x360_1200,640x360_1800,1280x720_2600,.mp4.csmil/master.m3u8?hdnea=st=1422629752~exp=1422716152~acl=/*~hmac=1816822998b2d083c66d895a3aa568ce0250ade0cbb8c191aa726efe31a73543';
//videoParam = encodeURIComponent(videoParam);
var videoParam = "<%=videoParam %>"; 
var video = "<%=video %>"; 
if (videoParam.indexOf("http") >= 0){
    //video is already encodede
    iframeTemplate = "iframe.html?video=" + videoParam;
     console.log('got video from db:' + videoParam);
}
else{
    iframeTemplate = "iframe_ima3.html?video=https%3A%2F%2Fcp162205-f.akamaihd.net%2Fi%2Fvideohub%2Fbgr%2F2013%2Ffull%2Fbetcom_bbgr13001_act1_cc_%2C448x252_450%2C624x352_800%2C640x360_1200%2C640x360_1800%2C1280x720_2600%2C.mp4.csmil%2Fmaster.m3u8%3Fhdnea%3D{TOKEN}&amp;adTag=http%3A%2F%2Fad.doubleclick.net%2Fpfadx%2Fbet.com%2FVideo%3Bn%3Dthe-full-show%3Bsub%3Dblackgirlsrock%3Bprod%3D%3Bsz%3D250x250%3Bshow%3Dblackgirlsrock%3Bembedshow%3D%26lt%3Bparameters.betembedshow%26gt%3B%3Bembedn%3D%26lt%3Bparameters.betembedn%26gt%3B%3Btile%3D4%3Bct%3Dindivmediapage%3Bloc%3D4%3Banum%3D1%3Bdomainname%3Dwww.bet.com%3Bord%3D1422367502208%3Bprog%3Dfullepisode&amp;autoPlay=false&amp;poster=http%3A%2F%2Fwww.bet.com%2Fcontent%2Fdam%2Fbetcom%2Fimages%2F2013%2F11%2FShows%2FBobby-Jones-Gospel%2Fbgr13_fullshow2.jpg&amp;omnitureTracking=prop5%3DBlack%2BGirls%2BRock%26eVar5%3DBlack%2BGirls%2BRock%26prop6%3Dunknown%26eVar6%3Dunknown%26eVar17%3Dvideo%253Ablackgirlsrock%253A2013%253Aexclusives%253Athe-full-show%26prop48%3D2013%26eVar48%3D2013%26prop49%3Dunknown%26eVar49%3Dunknown%26prop39%3D0FullEpisode%26eVar39%3D0FullEpisode%26prop45%3Dunknown%26eVar45%3Dunknown%26prop31%3D9%26prop13%3Dvideo%26prop54%3Dunknown%26eVar54%3Dunknown%26prop55%3D11%2F04%2F13%26eVar55%3D11%2F04%2F13%26prop56%3Dunknown%26eVar56%3Dunknown%26prop57%3DArts%2Band%2BCulture%26eVar57%3DArts%2Band%2BCulture%26prop58%3Dlong%26eVar58%3Dlong%26mediaName%3DBlack%2BGirls%2BRock%253A%2BBlack%2BGirls%2BRock%2521%2B2013%2BFull%2BShow";
	
}
var token = encodeURIComponent("<%=token %>");
var iframeSource = iframeTemplate.replace("{TOKEN}", token);

var mvpdDefaultMrssUrl = 'http://www.bet.com/content/betcomprivate/video/mvpd/holiday_greeting.mrss';
var mvpdDefaultM3u8Link = 'https://cp162205-f.akamaihd.net/i/videohub/viacom/video_error_,512x288_750_m30,.mp4.csmil/master.m3u8?hdnea=st=1422629752~exp=1422716152~acl=/*~hmac=1816822998b2d083c66d895a3aa568ce0250ade0cbb8c191aa726efe31a73543';
var mvpdMrssMapping = '{"count":0}';
mrssMediaUrl = encodeURIComponent(mrssMediaUrl);
var timestampDart = Number(new Date());
</script>

<script type="text/javascript">
function get_aamCookie(c_name) {
    var i, x, y, ARRcookies = document.cookie.split(";");
    for (i = 0; i < ARRcookies.length; i++) {
        x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
        y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
        x = x.replace(/^\s+|\s+$/g, "");
        if (x == c_name) {
            return unescape(y);
        }
    }
}
var aamBetdfpValue = get_aamCookie('betdfp');
var aamUuidValue = get_aamCookie('aam_uuid') + ';';

//AamGpt Code. A JavaScript function that reads Audience Management cookie data and sends that information to Google Publisher Tags.
var AamGpt = {
    strictEncode: function(str){
        return encodeURIComponent(str).replace(/[!'()]/g, escape).replace(/\*/g, "%2A");
    },
    getCookie: function(c_name)
    {
        var i,x,y,c=document.cookie.split(";");
        for (i=0;i<c.length;i++)
        {
            x=c[i].substr(0,c[i].indexOf("="));
            y=c[i].substr(c[i].indexOf("=")+1);
            x=x.replace(/^\s+|\s+$/g,"");
            if (x==c_name)
            {
                return unescape(y);
            }
        }
    },
    getKey: function(c_name){
        var c=this.getCookie(c_name);
        c=this.strictEncode(c);
        if(typeof c != "undefined" && c.match(/\w+%3D/)){
            var cList=c.split("%3D");
            if(typeof cList[0] != "undefined" && cList[0].match(/\w+/))
            {
                return cList[0];
            }
        }
    },
    getValues: function(c_name){
        var c=this.getCookie(c_name);
        c=this.strictEncode(c);
        if(typeof c != "undefined" && c.match(/\w+%3D\w+/)){
            var cList=c.split("%3D");
            if(typeof cList[1] != "undefined" && cList[1].match(/\w+/))
            {
                var vList=cList[1].split("%2C");
                if(typeof vList[0] != "undefined")
                {
                    return vList;
                } else {
                    return null;
                }
            } else {
                return null;
            }
        } else {
            return null;
        }
    }
};
function bq_onVideoEnd() {
    try {
        bq_goToNextPage();
    } catch (e) {}    

    try {
        playNext();
    } catch (e) {}
}

var embedPage = "the-full-show";
var embedShowTags = "blackgirlsrock";
var eVar17Param = "video%3Ablackgirlsrock%3A2013%3Aexclusives%3Athe-full-show";  
var domainName = window.location.host;
var refUrl = window.location.href;

//need to apply 3x encoding to refUrl (from BETCQ-16538 requirements)
refUrl = encodeURIComponent(encodeURIComponent(encodeURIComponent(refUrl)));
//limit 800 characters for this value (from BETCQ-16538 requirements). Can be changed fast and easily.
refUrl = refUrl.substring(0, 800);
//and one additional encoding for flashvars values
refUrl = encodeURIComponent(refUrl);
var flashvars = {
        affiliateSiteId: "176704",
        widgetId:502288, 
        width: "628",
        height: "386",
        revision: "18",
        mediaURL: mrssMediaUrl,
        betord: timestampDart,
        aamBetdfpValue: aamBetdfpValue,
        aamUuidValue : aamUuidValue,
        js: "1",
        betembedn: embedPage,
        betembedshow: embedShowTags,
        eVar17: eVar17Param,
        domainname: domainName,
        refUrl: refUrl
        
};
 var attributes = {
        id: "kickWidget_176704_502288",
        name: "kickWidget_176704_502288"
};          
var params = {
        menu:"false",
        allowFullScreen:"true", 
        allowscriptAccess:"always",
        wmode:"transparent",
        movie:"http://serve.a-widget.com/service/getWidgetSwf.kickAction",
        pluginspage:"http%3A//www.adobe.com/go/getflashplayer",
        align:"middle",                   
        quality:"high",                                      
        bgcolor:"#FFFFFF"                    
};
var expressInstallURL = "http://serve.a-widget.com/kickFlash/scripts/expressInstall2.swf?2";
var swfURL = "http://serve.a-widget.com/service/getWidgetSwf.kickAction";            
var attributes_={id :"kickWidget_mediasuite_oirt8k67", name:"kickWidget_mediasuite_oirt8k67"};

// Hotfix:
// Mock timestamp parameters "&lt;parameters.betord&gt;" and "[timestamp]" are replaced for the real timestamp for HTML5 player.
// [TODO] Need further investigation of what that mock parameters are and how they should be used in HTML5 player.
// Or it is just copypast from flash player and that parameters are not supported in HTML5 player. In that case
// adParam ad link generation should be adjusted.
var adParam = encodeURIComponent("http://ad.doubleclick.net/pfadx/bet.com/Video;n=the-full-show;sub=blackgirlsrock;prod=;sz=250x250;show=blackgirlsrock;embedshow=&lt;parameters.betembedshow&gt;;embedn=&lt;parameters.betembedn&gt;;tile=4;ct=indivmediapage;loc=4;anum=1;domainname=&lt;parameters.domainname&gt;;ord=&lt;parameters.betord&gt;;prog=fullepisode".replace("&lt;parameters.betord&gt;", timestampDart).replace("&lt;parameters.domainname&gt;", domainName).replace("[timestamp]", timestampDart));
var posterParam = encodeURIComponent("http://www.bet.com/content/dam/betcom/images/2013/11/Shows/Bobby-Jones-Gospel/bgr13_fullshow2.jpg");
var omnitureTrackingParam = encodeURIComponent("prop5=Black+Girls+Rock&eVar5=Black+Girls+Rock&prop6=unknown&eVar6=unknown&eVar17=video%3Ablackgirlsrock%3A2013%3Aexclusives%3Athe-full-show&prop48=2013&eVar48=2013&prop49=unknown&eVar49=unknown&prop39=0FullEpisode&eVar39=0FullEpisode&prop45=unknown&eVar45=unknown&prop31=9&prop13=video&prop54=unknown&eVar54=unknown&prop55=11/04/13&eVar55=11/04/13&prop56=unknown&eVar56=unknown&prop57=Arts+and+Culture&eVar57=Arts+and+Culture&prop58=long&eVar58=long&mediaName=Black+Girls+Rock%3A+Black+Girls+Rock%21+2013+Full+Show");
var callback = function(e){ 
    if (e.success==false) { 
    	var inner = '<iframe src="' + iframeSource +'" height="386" width="628" frameborder="0" scrolling="no" style="border:none;overflow:hidden;width:628px;height:386px"></iframe>'; 
    	console.log('got video html:' + inner)
        document.getElementById("bq_videoPlayer").innerHTML = inner;
    } 
};

        
function playVideo(){   
    swfobject.embedSWF(swfURL, "bq_videoPlayer", "628","386",
             "10", expressInstallURL, flashvars, params, attributes, callback);

     $('.error_msg').show();          
}

</script>
    
<script type="text/javascript">
    $(document).ready( function(){
        playVideo();
    });
</script>
    
</head>
<body>
	<!-- Put this <div> anywhere in the <body> of your page where you want the widget to show up. -->
	<div id="bq_videoPlayer"></div>
</body>
</html>
