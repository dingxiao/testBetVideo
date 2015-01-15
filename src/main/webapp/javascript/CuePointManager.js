/**
    Manages cuepoints for an HTML5 video player
    @author     sgchipman@gmail.com
    @version    20130331.1
    @dependency MediaRSS.js PlaylistManager.js

*/

/**
    @contructor
    @param {HTMLVideoElement} videoElement - the video element to attach listeners to
    @param {Array} cuePoints - cue points defined by a MediaRSS instance
*/
var CuePointManager = function(videoElement,cuePoints) {

    this.videoElement = videoElement;
    this.cuePoints = cuePoints;
    this.contentTypes = {
        FEATURE : "feature",
        AD : "ad"
    };
    
    this.videoElement.setAttribute("data-content-type",this.contentTypes.FEATURE);
        
    this.onTimeUpdated = function(event) {
        // don't monitor this event if the current video is not the feature
		// TODO: unhook the listener?
		if(this.videoElement.getAttribute("data-content-type") !== this.contentTypes.FEATURE) {
		    return;
		}
		
		var currentTime = this.videoElement.currentTime;
		for(var i = 0, len = this.cuePoints.length; i < len; i++) {
		    var cp = this.cuePoints[i];
		    if(cp.fired) continue;
		    var offset = 0;
		    if(playlistManager) {
		    	if(playlistManager.videos[playlistManager.playlistIndex].scenes) {
		    		offset = playlistManager.videos[playlistManager.playlistIndex].scenes[playlistManager.sceneIndex].startTimeInSeconds || 0
		    	}
		    }
		    //console.log("offset + time is " + (offset + currentTime) + " and cp is " + cp.timeInSeconds);
		    if(offset + currentTime > cp.timeInSeconds) {
		        cp.fired = true;
		        MediaRSS.util.dispatchEvent("cuePointReached",{"cuePoint":cp});
		    }
		}
    };
    
    MediaRSS.util.addEventListenerWithScope(this.videoElement,"timeupdate",this.onTimeUpdated,this);
};