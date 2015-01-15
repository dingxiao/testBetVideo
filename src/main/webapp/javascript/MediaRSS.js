
/**

@description    Parser & models for Media RSS feeds.
@author         sgchipman@gmail.com
@version        20130413.1
@dependency     xml2json.js
@dependency     vast.js
*/


/**
    @constructor
    @param {Object} data - data from an MRSS feed
    @param {Instance} delegate - optional class that has a mrssDataAvailable method. If not defined or delegate doesn't have the method, an MRSSDataAvailable event will be broadcast when the SMIL data has been fetched and parsed
*/

var MediaRSS = function(data,delegate,videoPlayer) {
    var _data = data;
    var _cuepoints;
    var _content;
    var _delegate = delegate;
    var _scenes = [];
    var _videoPlayer = videoPlayer;
    
    this.onFetchRSS = function(response,data,instance) {
        _data = x2js.xml2json(x2js.parseXmlString(response)).rss.channel;
        if(instance.playlistMRSSUrl) {
            MediaRSS.util.xhr(proxyURL + instance.playlistMRSSUrl,"","GET",this.onFetchMRSS,{},instance);
        } else {
            if(instance.delegate && instance.delegate.mrssDataAvailable) {
                instance.delegate.mrssDataAvailable(instance);
            } else {
                MediaRSS.util.dispatchEvent("MRSSDataAvailable");    
            }
        }
    };   
    
    this.fetchSMILForScene = function(sceneIndex) {
        var scene = this.scenes[sceneIndex];
        if(!scene) {
            if(playlistManager.sceneIndex > playlistManager.videos.length) {
            	MediaRSS.util.dispatchEvent("endOfScenes");
            } else {
                console.log("fetchSMILForScene: bad scene index.");
            }
            return;
        }
        var uri = scene.uri;
        MediaRSS.util.xhr(proxyURL + uri,"","GET",this.onFetchSMILForScene,{},this);
    };
    
    this.onFetchSMILForScene = function(response,data,instance) {
        var _smilData = x2js.xml2json(x2js.parseXmlString(response));
        console.info("smil data: ", _smilData);
        MediaRSS.util.dispatchEvent("smilDataAvailable", {"smil":new instance.smil(_smilData.smil)});
       // console.info("smilData = ", _smilData);
    };
    
    this.onFetchMRSS = function(response,data,instance) {
        var _smilData = x2js.xml2json(x2js.parseXmlString(response));
        instance.smil = new instance.smil(_smilData);
        if(instance.delegate && instance.delegate.mrssDataAvailable) {
            instance.delegate.mrssDataAvailable(instance);
        } else {
            MediaRSS.util.dispatchEvent("MRSSDataAvailable");    
        }
    };
    
    this.__defineGetter__("delegate", function() {
        return _delegate;
    });
    
    this.__defineGetter__("omnitureTracking", function() {
        return this.data.omnitureTracking.__cdata;
    });
    
    this.__defineGetter__("thumbnail", function() {
        return this.data.content.thumbnail._url;
    });
    
    this.__defineGetter__("closedCaptionURI", function() {
    	return this.data.closedCaption.__text;
    });
    
    this.smil = function(data) {
        var _data = data;
        var _sources;
        
        this.__defineGetter__("base", function() {
            return this.data.head.meta._base;
        });
        
        this.__defineGetter__("data", function() {
            return _data;
        });
        
        this.__defineGetter__("sources", function() {
            if(_sources) {
                return _sources;
            } else {
                _sources = [];
                for(var i = 0, len = this.data.body["switch"].video_asArray.length; i < len; i++) {
                    var obj = {
                        "src": this.base + this.data.body["switch"].video_asArray[i]._src,
                        "bitrate": this.data.body["switch"].video_asArray[i]["_system-bitrate"]
                    };
                    _sources.push(obj);
                }
                return _sources;
            }
        });
       
    };
    
    this.cuePoint = function(data) {
        var _data = data;
        var _fired = false;
        var _timeInSeconds = null;
        var _vast = null;
        
        this.__defineGetter__("data", function() {
            return _data;
        });
        
        this.__defineGetter__("fired", function() {
            return _fired;
        });
        
        this.__defineSetter__("fired", function(value) {
            if(typeof value !== "boolean") {
                console.log("non-boolean type sent to \"fired\" - setting to false.");
                value = false;
            }
            _fired = value;
        });
        
        this.__defineGetter__("format", function() {
            return this.data.cuePointData.format;
        });
        
        this.__defineGetter__("time", function() {
            return this.data.cuePointTime.__text;
        });
        
        this.__defineSetter__("time", function(value) {
            this.data.cuePointTime.__text = value;
        });
        
        this.__defineGetter__("timeInSeconds", function() {
            if(_timeInSeconds) {
                return _timeInSeconds;
            } else {
                _timeInSeconds = this.toSeconds();
                return _timeInSeconds;
            }
        });
        
        this.__defineGetter__("type", function() {
            return this.data.cuePointData.type;
        });
        
        this.__defineGetter__("uri", function() {
            return this.data.cuePointData.uri || null;
        });
        
        this.__defineGetter__("vast", function() {
            return _vast;
        });
        
        this.toMilliseconds = function() {
            return this.toSeconds() * 1000;
        };
        
        this.toSeconds = function() {
            var arr = this.time.split(":");
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
        
        this.fetchVast = function(uri) {
            MediaRSS.util.xhr(uri,"","GET",this.onFetchVast,{},this);
        };
        
        this.onFetchVast = function(response,data,instance) {
        	//console.log(response);
            if(typeof response === "string") {
                var json = x2js.xml2json(x2js.parseXmlString(response));
                //console.info("vast json:",json);
                try {
                    _vast = new VastManager(json.VAST,_videoPlayer);
                    if(_vast.isWrapper) {   
                        instance.fetchVast(_vast.data.Ad.Wrapper.VASTAdTagURI.__cdata);
                    }
                } catch(err) {  
                    console.log("MediaRSS.onFetchVast error: " + err.message);
                    _vast = null;
                }
            } else {
                // TODO: fetch error
            }
        };
        
        if(this.type === "ad") {
            switch(this.format) {
                case "VAST 2.0":
                default:
                    this.fetchVast(this.uri);
                    break;
            }
        }
    };
    
    this.scene = function(data) {
        var _data = data;
        
        this.__defineGetter__("data", function() {
            return _data;
        });
        
        this.__defineGetter__("endTime", function() {
            return this.data.sceneEndTime;
        });
        
        this.__defineGetter__("startTime", function() {
            return this.data.sceneStartTime;
        });
        
        this.__defineGetter__("title", function() {
            return this.data.sceneTitle;
        });
        
        this.__defineGetter__("uri", function() {
            return this.data.sceneUriHTML5.__text;
        });
        
        this.__defineGetter__("startTimeInSeconds", function() {
        	var arr = this.startTime.split(":");
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
        });
    };
    
    this.__defineGetter__("creator", function() {
        return this.data.creator.__text;
    });
    
    this.__defineGetter__("cuePoints", function() {
        if(_cuepoints) {
            return _cuepoints;
        }
        _cuepoints = [];
        var cp = this.data.cuePoints.cuePoint;
        for(var i = 0, len = cp.length; i < len; i++) {
            _cuepoints.push(new this.cuePoint(cp[i]));
        }
        return _cuepoints;
    });
    
    this.__defineGetter__("date", function() {
        return this.data.date.__text;
    });
    
    this.__defineGetter__("data",function() {
        return _data;
    });

    this.__defineGetter__("description",function() {
        return this.data.description || "";
    });
    
    this.__defineGetter__("item", function() {
        return this.data.item || [];
    });
    
    this.__defineGetter__("link", function() {
        return this.data.link;
    });
    
    this.__defineGetter__("playlistMRSSUrl", function() {
        return decodeURIComponent(this.data.playlistMrssUrl);
    });
    
    this.__defineGetter__("pubDate", function() {
        return this.data.pubDate || "";
    });
    
    this.__defineGetter__("scenes", function() {
        if(_scenes.length) {
            return _scenes;
        } else {
            if(this.item.length == 0) {
                var s = this.data.scenes.scene;
                for(var i = 0, len = s.length; i < len; i++) {
                    _scenes.push(new this.scene(s[i]));
                }
            } else {
                
            }
            
            return _scenes;
        }
    });
    
    this.__defineGetter__("title", function() {
        return this.data.title || "";
    });
    
//    console.log(proxyURL + url);
//    MediaRSS.util.xhr(proxyURL + url,"","GET",this.onFetchRSS,{},this);    
    //console.log(this.playlistMRSSUrl);
   /* if(this.playlistMRSSUrl) {
        console.log("fetching an mrss url - " + this.playlistMRSSUrl);
        MediaRSS.util.xhr(proxyURL + this.playlistMRSSUrl,"","GET",this.onFetchMRSS,{},this);
    }*/

};

MediaRSS.util = {
    /**
    Allows you to add event listeners to elements/window and define the scope you need.
    I.E., "this" can be the instance of the object, not the target.
    @param {HTMLElement} element - what to add the listener to
    @param {String} eventName - the event to listen for
    @param {Function} eventHandler - the event listener
    @param {Object} scope - the scope to use. i.e., "this" if you want the scope to refer to an object instance and not the event target
    */
    addEventListenerWithScope: function(element,eventName,eventHandler,scope) {
        if(typeof eventHandler === "undefined") {
            throw new Error("Invalid event handler passed to addEventListenerWithScope.");
        }
        var scopedEventHandler = function(e) { 
            eventHandler.apply(scope, [e]); 
        };
        element.addEventListener(eventName,scopedEventHandler,false);
    },
    
            
    dispatchEvent: function(eventName,eventData) {
		var event = document.createEvent("Event");
		event.initEvent(eventName);
		event.data = eventData;
		window.dispatchEvent(event);
	},
	
	 /**
        Performs an XMLHttpRequest
        @param {String} uri - The URI for the request
        @param {String} params - Key/Value pairs as foo=bar&boo=baz
        @param {Function OR String} callback - optional method to pass the response to
        @param {Object} callbackData - additional data to pass to the callback
        @param {Constructor} instance - the object instance that owns the request
        */
        
        xhr:function(uri,params,method,callback,callbackData,instance) {
            var req = new XMLHttpRequest();
            if(typeof callback !== "undefined") {
                req.callback = callback;
            }
            if(typeof callbackData !== "undefined") {
                req.callbackData = callbackData;
            }
            if(typeof instance !== "undefined") {
                req.instance = instance;
            }
            req.open(method,uri,true);
            try {
                req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            } catch(err) { }
            req.onreadystatechange = function() {
                if(this.readyState === 4) {
                    if(this.status === 200) {
                        if(this.callback){
                            if(typeof this.callback === "string") {
                                eval(this.callback + "(" + this.responseText + "," + this.callbackData + "," + instance + ")");   
                            } else {
                                this.callback(this.responseText,this.callbackData,instance);
                            }
                        }
                    } else {
                        if(this.callback) {
                            this.callback("{\"statusCode\":500}");
                        }
                    }
                }
            };
            req.send(params);
        }
}

