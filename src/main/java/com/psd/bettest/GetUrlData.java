package com.psd.bettest;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;

public class GetUrlData {
    public static String getUrlJson(String url, String key) {

        String jsonString = callURL(url);
        System.out.println("\n\njsonString: " + jsonString);
         
        try {
            InputStream urlStream = new ByteArrayInputStream(jsonString.getBytes(StandardCharsets.UTF_8));
            JsonReader jsonReader = Json.createReader(urlStream);
            JsonObject jsonObject = jsonReader.readObject();
            
            //we can close IO resource and JsonReader now
            jsonReader.close();
            urlStream.close();
            return jsonObject.getString(key);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
}
    
    public static String callURL(String myURL) {
        System.out.println("Requested URL:" + myURL);
        StringBuilder sb = new StringBuilder();
        URLConnection urlConn = null;
        InputStreamReader in = null;
        try {
            URL url = new URL(myURL);
            urlConn = url.openConnection();
            if (urlConn != null)
                urlConn.setReadTimeout(60 * 1000);
            if (urlConn != null && urlConn.getInputStream() != null) {
                in = new InputStreamReader(urlConn.getInputStream(), StandardCharsets.UTF_8); //Charset.defaultCharset());
                BufferedReader bufferedReader = new BufferedReader(in);
                if (bufferedReader != null) {
                    int cp;
                    while ((cp = bufferedReader.read()) != -1) {
                        sb.append((char) cp);
                    }
                    bufferedReader.close();
                }
            }
            in.close();
        } catch (Exception e) {
            throw new RuntimeException("Exception while calling URL:"+ myURL, e);
        }
         
        return sb.toString();
   }

}
