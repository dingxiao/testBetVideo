
/**

    Manages MRSS playlists
    
    @author         sgchipman@gmail.com
    @version        20130413.1
    @dependency     xml2json.js, MediaRSS.js
    
*/

var PlayListManager = function(mrssURI,videoPlayer) {
    var _data;
    var _mrss = [];
    var _playlistIndex = 0;
    var _sceneIndex = 0;
    var _videoPlayer = videoPlayer;
    
    this.onFetchMRSS = function(response,data,instance) {
        _data = x2js.xml2json(x2js.parseXmlString(response)).rss.channel;
        console.info("mrss data is :" , _data);
        if(typeof _data.item.length === "undefined") {
            // item is an object
            _mrss.push(new MediaRSS(_data.item,null,_videoPlayer));
        } else {
            // item is an array
            for(var i = 0, len = _data.item.length; i < len; i++) {
                if(!_data.item[i].hasOwnProperty("scenes")) continue;
                var mrss = new MediaRSS(_data.item[i],null,_videoPlayer);
               // console.log(mrss.scenes[0].uri);
                _mrss.push(mrss);
            }
            
        }
        MediaRSS.util.dispatchEvent("playlistReady");
    };
    
    this.__defineGetter__("playlistIndex", function() {
        return _playlistIndex;
    });
    
    this.__defineSetter__("playlistIndex", function(value) {
        _playlistIndex = value;
        // TODO: move to next video?
    });
    
    this.__defineSetter__("sceneIndex", function(value) {
        _sceneIndex = value;
    });
    
    this.__defineGetter__("sceneIndex", function() {
        return _sceneIndex;
    });
    
    this.__defineGetter__("videos", function() {
        return _mrss;
    });
    
    PlayListManager.util.xhr(mrssURI, "", "GET", this.onFetchMRSS, null, this);
};

// TODO: this is in too many places.
PlayListManager.util = {
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
};