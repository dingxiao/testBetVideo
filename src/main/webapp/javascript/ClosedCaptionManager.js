/**

@description	Fetches and display closed captions on an HTML5 video element
@author			sgchipman@gmail.com
@version		20130609.1
@dependency		PlaylistManager.js, xml2json.js, MediaRSS.js
*/

var ClosedCaptionManager = function(ccURL, videoPlayer) {

	var _data;
	var _captions = [];
	
	this.videoPlayer = videoPlayer;
	
	var Caption = function(data) {
		var _data = data;
		var _id;
		
		this.__defineGetter__("begin", function() {
			return this.toSeconds(this.data._begin);
		});
		
		this.__defineGetter__("end", function() {
			return this.toSeconds(this.data._end);
		});
		
		this.__defineGetter__("text", function() {
			return this.data.span.__text;
		});
		
		this.__defineGetter__("data", function() {
			return _data;
		});
	
		this.__defineSetter__("data", function(value) {
			_data = value;
		});
		
		this.__defineGetter__("id", function() {
			return _id;
		});
		
		this.__defineSetter__("id", function(value) {
			_id = value;
		});
		
		this.toSeconds = function(timeString) {
            var arr = timeString.split(":");
            switch(arr.length) {
                case 1:
                    return parseInt(arr[0],10);
                    break;
                case 2:
                    var m = parseInt(arr[0],10) * 60;
                    return m + parseInt(arr[1],10);
                    break;
                default:
                    var h = parseInt(arr[0],10) * 3600;
                    var m = parseInt(arr[1],10) * 60;
                    return h + m + parseInt(arr[2],10);
                    break;
            };
        };
	};
	
	this.onFetchCCData = function(response) {
		var response = x2js.xml2json(x2js.parseXmlString(response));
		this.data = response.tt.body.div.p;
		//console.info("cc data:", this.data);
		for(var i = 0, len = this.data.length; i < len; i++) {
			var cc = new Caption(this.data[i]);
			cc.id = "closed-caption-" + i;
			_captions.push(cc);
		}
	};

	this.onTimeUpdated = function(event) {
		if(this.videoPlayer.getAttribute("data-content-type") !== "feature") {
			this.container.style.display = "none";
			return;
		} else {
			this.container.style.display = "block";
		}
		
		var offset = 0;
		if(playlistManager) {
		    if(playlistManager.videos[playlistManager.playlistIndex].scenes) {
		    	offset = playlistManager.videos[playlistManager.playlistIndex].scenes[playlistManager.sceneIndex].startTimeInSeconds || 0
		    }
		}
		
		var time = event.target.currentTime + offset;
		for(var i = 0, len = this.captions.length; i < len; i++) {
			var caption = this.captions[i];
			if(time > caption.begin && time < caption.end) {
				if(!document.getElementById(caption.id)) {
					var p = document.createElement("p");
					p.innerHTML = caption.text;
					p.setAttribute("id", caption.id);
					this.container.appendChild(p);
				}
			}
			if(time > caption.end && document.getElementById(caption.id)) {
				this.container.removeChild(document.getElementById(caption.id));
			}
		}
	};
	
	this.__defineGetter__("captions", function() {
		return _captions;
	});
	
	this.__defineGetter__("data", function() {
		return _data;
	});
	
	this.__defineSetter__("data", function(value) {
		_data = value;
	});

	this.container = document.createElement("div");
	this.container.className = "closed-captions";
	this.videoPlayer.parentNode.appendChild(this.container);
	MediaRSS.util.addEventListenerWithScope(this.videoPlayer,"timeupdate",this.onTimeUpdated,this);
	PlayListManager.util.xhr(ccURL, "", "GET", this.onFetchCCData, null, this);

}