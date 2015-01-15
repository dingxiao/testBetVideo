/**
    Models & Methods for VAST 2.0 Ad Management
    @author     sgchipman@gmail.com
    @version    20130420.1
    @dependency MediaRSS.js

*/

// TODO: if VAST has a Wrapper element, it points to another VAST somewhere else? eesh ...
// TODO: if this is a wrapper, find the downstream server, and set the instance's data to its. unless its a wrapper too. omg. its VAST inception!

var VastManager = function(data,videoPlayer) {
    var _data = data;
    var _creatives = null;
    var _videoPlayer = videoPlayer;
    
    this.listeners = {
        "ended":VastManager.onPlayerEvent,
        "pause":VastManager.onPlayerEvent,
        "play":VastManager.onPlayerEvent,
        "timeupdate":VastManager.onPlayerEvent/*,
        "webkitfullscreenchange":VastManager.onPlayerEvent*/
    };
    
    this.capturedEvents = [];
    
    this.__defineGetter__("data", function() {
        return _data;
    });
    
    
    this.__defineGetter__("isWrapper", function() {
        return this.data.Ad.hasOwnProperty("Wrapper");
    });
    
    this.__defineGetter__("creatives", function() {
        if(this.isWrapper) {
            //console.log("This is a wrapper. need to fetch the downstream data");
            return [];
        }
        
        if(_creatives !== null) {
            return _creatives;
        } else {
            var c = this.data.Ad.InLine.Creatives.Creative;
            _creatives = [];
            for(var i = 0, len = c.length; i < len; i++) {
                _creatives.push(new this.creative(c[i]));
            }   
            
            return _creatives;
        }
    });
    
    this.__defineGetter__("videoPlayer", function() {
        return _videoPlayer;
    });
    
    this.__defineSetter__("videoPlayer", function(value) {
        _videoPlayer = value;
    });
    
    this.addListeners = function() {
        for(var i in this.listeners) {
            _videoPlayer.addEventListener(i,this.listeners[i],false);
        }
    };
    
    this.removeListeners = function() {
        if(_videoPlayer) {
            for(var i in this.listeners) {
                _videoPlayer.removeEventListener(i,this.listeners[i]);
            }
        }
    };
    
    this.eventTypeWasCaptured = function(eventType) {
        if(this.capturedEvents.indexOf(eventType) > -1) {
            return true;
        } else {
            this.capturedEvents.push(eventType);
            return false;
        }
    };
    
    this.creative = function(data) {
        var _data = data;
        
        this.__defineGetter__("data",function() {
            return _data;
        }); 
        
        this.__defineGetter__("duration", function() {
            return this.data.Linear.Duration;
        });
        
        this.__defineGetter__("mediaFile", function() {
            var d = this.data.Linear.MediaFiles.MediaFile;
            var obj = {
                "src": d.__cdata.trim(),
                "bitrate":d._bitrate,
                "delivery":d._delivery,
                "height":d._height,
                "id":d._id,
                "type":d._type,
                "width":d._width
            };
            return obj;
        });
        
        this.urlForEventType = function(eventType) {
            var data = this.data.Linear.TrackingEvents.Tracking;
            eventType = eventType.toLowerCase();
            for(var i = 0, len = data.length; i < len; i++) {
                var type = data[i]._event.toLowerCase();
                if(eventType === type) {
                    return data[i].__cdata;
                }
            }
            return null;
        };
    };
    
    
        
    if(_videoPlayer) {
        _videoPlayer.vastInstance = this;
        this.addListeners();
    };
   // console.log(this.data);
};

VastManager.loadPixel = function(uri) {
    var img = document.createElement("img");
    img.src = uri;
    img.width = "1";
    img.height = "1";
    document.body.appendChild(img);
};

VastManager.onPlayerEvent = function(event) {
    var player = event.target;
    var instance = player.vastInstance;
    var type = event.type.toLowerCase();
    var uri = null;
    if(type !== "timeupdate") {
        console.log(event);
    }
    switch(type) {
        case "pause":
            uri = instance.creatives[0].urlForEventType("pause");
            break;
        case "timeupdate":
            switch(Math.floor(player.currentTime)) {
                case 0:
                    if(instance.eventTypeWasCaptured("start")) return;
                    console.log("setting START event");
                    uri = instance.creatives[0].urlForEventType("start");
                    break;
                case Math.floor(player.duration):
                    if(instance.eventTypeWasCaptured("complete")) return;
                    console.log("setting COMPLETE event");
                    uri = instance.creatives[0].urlForEventType("complete");
                    break;
            }
            var percentComplete = (player.currentTime / player.duration) * 100;
            if(percentComplete >= 25 && !instance.eventTypeWasCaptured("firstQuartile")) {
                uri = instance.creatives[0].urlForEventType("firstQuartile");
            } else if(percentComplete >= 50 && !instance.eventTypeWasCaptured("midpoint")) {
                uri = instance.creatives[0].urlForEventType("midpoint");
            } else if(percentComplete >= 75 && !instance.eventTypeWasCaptured("thirdQuartile")) {
                uri = instance.creatives[0].urlForEventType("thirdQuartile");
            }
            break;
        //case "webkitfullscreenchange":
         //   uri = instance.creatives[0].urlForEventType("fullscreen");
        //    break;

    }
    
    if(uri) {
        console.info("loading ", uri);
        VastManager.loadPixel(uri);
    }
};