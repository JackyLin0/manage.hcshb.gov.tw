/*
 * 撰寫日期：2007/4/12
 * 程式名稱：GIPData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class GIPData {

    private String errorMsg = null;
    
	private String line = null;
	private String response = null;
	
	public String getLine() {
		return line;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setLine(String line) {
		this.line = line;
	}

	public String getResponse() {
		return response;
	}

	public void setResponse(String response) {
		this.response = response;
	}

    public boolean GIP( String gipurl ) throws IOException
    {
    	try
    	{
    		URL url = new URL(gipurl);
    		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
    		while ((line = br.readLine()) != null) {
    			response += line;
    		}
    		
    		if ( response.equals("0") )
    			return false;
    		
    		return true;
    		
    	} catch ( IOException ioe) {
    		System.out.println(ioe);
    	} finally {
    	}
    	return false;
    }	

}
