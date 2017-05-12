/*
 * 撰寫日期：2008/2/16
 * 程式名稱：WebSiteUnitData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WebsiteUnitData {

	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String pubunitdn = null;
    private String pubunitname = null;
    private String websitedn = null;
    private String websitename = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
	}
	public String getPubunitdn() {
		return pubunitdn;
	}
	public void setPubunitdn(String pubunitdn) {
		this.pubunitdn = pubunitdn;
	}
	public String getPubunitname() {
		return pubunitname;
	}
	public void setPubunitname(String pubunitname) {
		this.pubunitname = pubunitname;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getWebsitedn() {
		return websitedn;
	}
	public void setWebsitedn(String websitedn) {
		this.websitedn = websitedn;
	}
	public String getWebsitename() {
		return websitename;
	}
	public void setWebsitename(String websitename) {
		this.websitename = websitename;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
    
    //查詢單筆資料
    public boolean load( String pubunitdn )
    {
    	Connection conn = null;
    	try
    	{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}
    	
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	try
    	{
    		stmts = conn.prepareStatement("select * from WebSiteUnit where PubUnitDN = '" + pubunitdn + "' and WebSiteDN in(select WebSiteDN from WebSite where Flag is null)");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.pubunitdn = rs.getString( "PubUnitDN" );
    		this.pubunitname = rs.getString( "PubUnitName" );
    		this.websitedn = rs.getString( "websiteDN" );
    		this.websitename = rs.getString( "WebSiteName" );
    		
    		return true;
    	} catch ( SQLException sqle ) {
    		errorMsg = "Query into table error: " + sqle.toString();
    	} finally {
    		try
    		{
    			if ( rs != null ) rs.close();
    			if ( stmts != null ) stmts.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close ResultSet or Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }		
   
}
