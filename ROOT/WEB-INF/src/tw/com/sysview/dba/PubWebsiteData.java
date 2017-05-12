/*
 * 撰寫日期：2008/2/16
 * 程式名稱：PubWebsiteData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PubWebsiteData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //PublishAP、PublishData
    private String aplistdn = null;
    private String aplistname = null;
    private String aplisttable = null;
    private String pubwebsitedn = null;
    private String pubwebsitename = null;
    private String websitedn = null;
    private String websitename = null;
    private String flag = null;
    private String isexamine = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    
    //多向發布分類檔
    private String serno = null;
    private String pubunitdn = null;
    private String pubunitname = null;
    private String classname = null;
    
    private String mserno = null;
    private String mclassname = null;
    
	public String getMclassname() {
		return mclassname;
	}
	public void setMclassname(String mclassname) {
		this.mclassname = mclassname;
	}
	public String getMserno() {
		return mserno;
	}
	public void setMserno(String mserno) {
		this.mserno = mserno;
	}
	public String getAplistdn() {
		return aplistdn;
	}
	public void setAplistdn(String aplistdn) {
		this.aplistdn = aplistdn;
	}
	public String getAplistname() {
		return aplistname;
	}
	public void setAplistname(String aplistname) {
		this.aplistname = aplistname;
	}
	public String getAplisttable() {
		return aplisttable;
	}
	public void setAplisttable(String aplisttable) {
		this.aplisttable = aplisttable;
	}
	public String getClassname() {
		return classname;
	}
	public void setClassname(String classname) {
		this.classname = classname;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getIsexamine() {
		return isexamine;
	}
	public void setIsexamine(String isexamine) {
		this.isexamine = isexamine;
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
	public String getPubwebsitedn() {
		return pubwebsitedn;
	}
	public void setPubwebsitedn(String pubwebsitedn) {
		this.pubwebsitedn = pubwebsitedn;
	}
	public String getPubwebsitename() {
		return pubwebsitename;
	}
	public void setPubwebsitename(String pubwebsitename) {
		this.pubwebsitename = pubwebsitename;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
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
	
	//查詢多筆資料及筆數(尋找登入者的單位，設定欲發布之站台)
    public ArrayList<Object> findByday( String tablename, String pubwebsitedn, String aplistdn, String flag )
    {
    	Connection conn = null;
    	try
    	{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return null;
    	}
       
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	try
    	{
    		StringBuffer sSql = new StringBuffer();
    		
    		sSql.append( "select * from " + tablename + " where AplistDN = '" + aplistdn + "' and PubWebSiteDN = '" + pubwebsitedn + "' and Flag = '" + flag + "' order by WebSiteDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PubWebsiteData tmpQuery = new PubWebsiteData();
    			tmpQuery.setAplistdn( rs.getString( "AplistDN" ) );
    			tmpQuery.setAplistname( rs.getString( "AplistName" ) );
    			tmpQuery.setPubwebsitedn( rs.getString( "PubWebsiteDN" ) );
    			tmpQuery.setPubwebsitename( rs.getString( "PubWebsiteName" ) );
    			tmpQuery.setWebsitedn( rs.getString( "WebSiteDN" ) );
    			tmpQuery.setWebsitename( rs.getString( "WebSiteName" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
    			tmpQuery.setIsexamine( rs.getString( "isexamine" ) );
    			tmpQuery.setUpdatedate( rs.getString( "updatedate" ) );
    			result.add( tmpQuery );
    		}
    		
    		if ( result.size() > 0 )
    		{
    		   allrecordCount = result.size();
    		   return result;
    		}
       
    		errorMsg = "No such as row.";
    	} catch ( SQLException sqle ) {
    		errorMsg = "find from table error: " + sqle.toString();
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
    	return null;
    }	        
    
    //查詢單筆資料(尋找AP的 tablename)
    public boolean load( String tablename, String aplistdn )
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
    		stmts = conn.prepareStatement("select * from " + tablename + " where AplistDN = '" + aplistdn + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.aplistdn = rs.getString( "AplistDN" );
    		this.aplistname = rs.getString( "AplistName" );
    		this.aplisttable = rs.getString( "Aplisttable" );
    		
    		return true;
    	} catch ( SQLException sqle ) {
    		errorMsg = "Query into table error(WebSite): " + sqle.toString();
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
	
	//查詢多筆資料及筆數(尋找站台之分類檔)
    public ArrayList<Object> findByday( String tablename, String websitedn )
    {
    	Connection conn = null;
    	try
    	{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return null;
    	}
       
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	try
    	{
    		StringBuffer sSql = new StringBuffer();
    		
    		sSql.append( "select * from " + tablename + " where WebSiteDN = '" + websitedn + "'" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PubWebsiteData tmpQuery = new PubWebsiteData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setWebsitedn( rs.getString( "WebSiteDN" ) );
    			tmpQuery.setWebsitename( rs.getString( "WebSiteName" ) );
    			tmpQuery.setClassname( rs.getString( "ClassName" ) );
    			result.add( tmpQuery );
    		}
    		
    		if ( result.size() > 0 )
    		{
    		   allrecordCount = result.size();
    		   return result;
    		}
       
    		errorMsg = "No such as row.";
    	} catch ( SQLException sqle ) {
    		errorMsg = "find from table error: " + sqle.toString();
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
    	return null;
    }	        
	
	//查詢多筆資料及筆數(此序號之發布站台)
    public ArrayList<Object> findByclass( String tablename, String serno )
    {
    	Connection conn = null;
    	try
    	{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return null;
    	}
       
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	try
    	{
    		StringBuffer sSql = new StringBuffer();
    		
    		sSql.append( "select * from " + tablename + " where Serno = '" + serno + "'" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PubWebsiteData tmpQuery = new PubWebsiteData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setMserno( rs.getString( "Mserno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
    			tmpQuery.setWebsitedn( rs.getString( "WebSiteDN" ) );
    			tmpQuery.setWebsitename( rs.getString( "WebSiteName" ) );
    			result.add( tmpQuery );
    		}
    		
    		if ( result.size() > 0 )
    		{
    		   allrecordCount = result.size();
    		   return result;
    		}
       
    		errorMsg = "No such as row.";
    	} catch ( SQLException sqle ) {
    		errorMsg = "find from table error: " + sqle.toString();
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
    	return null;
    }	
    
}
