package com.site;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;


public class UrlTest {

	public static void main(String [] args) {

		HttpURLConnection connection = null;
		BufferedReader br = null;
	    try {
	        URL url = new URL("http://api.saramin.co.kr/job-search?");
	        connection = (HttpURLConnection) url.openConnection();
	        connection.connect();
	        br = new BufferedReader( new InputStreamReader(connection.getInputStream()));

	        String line = null;
	        while((line = br.readLine()) != null) {
	        	System.out.println(line);

	        }

	    } catch (MalformedURLException e1) {
	        e1.printStackTrace();
	    } catch (IOException e1) {
	        e1.printStackTrace();
	    } finally {
	    	try { br.close(); } catch(Exception e) {br = null;}
	        if(null != connection) { connection.disconnect(); }
	    }

	}
}
