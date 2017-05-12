/*
 * 撰寫日期：2007/12/30
 * 程式名稱：UnitManagerData.java
 * 功能：單位網站權限設定
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UnitManagerData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //DepartmentManager
    private String serno = null;
    private String managerunitdn = null;
    private String managerunitname = null;
    private String managerperdn = null;
    private String managerpername = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    
    //WebSiteUnit
    private String pubunitdn = null;
    private String pubunitname = null;
    private String websitedn = null;
    private String websitename = null;
    
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
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getManagerperdn() {
		return managerperdn;
	}
	public void setManagerperdn(String managerperdn) {
		this.managerperdn = managerperdn;
	}
	public String getManagerpername() {
		return managerpername;
	}
	public void setManagerpername(String managerpername) {
		this.managerpername = managerpername;
	}
	public String getManagerunitdn() {
		return managerunitdn;
	}
	public void setManagerunitdn(String managerunitdn) {
		this.managerunitdn = managerunitdn;
	}
	public String getManagerunitname() {
		return managerunitname;
	}
	public void setManagerunitname(String managerunitname) {
		this.managerunitname = managerunitname;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
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
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
    
    //查詢單筆資料(尋找登入者是否為網站管理者)
    public boolean load( String pubunitdn, String logindn )
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
    		String sSql = "select * from DepartmentManager where ManagerUnitDN = '" + pubunitdn + "'";
    		if ( !logindn.equals("") )
    			sSql = sSql + " and ManagerPerDN = '" + logindn + "'";
    		
    		stmts = conn.prepareStatement(sSql);
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.managerunitdn = rs.getString( "ManagerUnitDN" );
    		this.managerunitname = rs.getString( "ManagerUnitName" );
    		this.managerperdn = rs.getString( "ManagerPerDN" );
    		this.managerpername = rs.getString( "ManagerPerName" );
    		this.postname = rs.getString( "PostName" );
    		this.updatedate = rs.getString( "UpdateDate" );
    		
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
    
    //查詢單筆資料(尋找該單位之網站DN)
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
    		String sSql = "select * from WebSiteUnit where PubUnitDN = '" + pubunitdn + "'";
    		
    		stmts = conn.prepareStatement(sSql);
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.pubunitdn = rs.getString( "PubUnitDN" );
    		this.pubunitname = rs.getString( "PubUnitName" );
    		this.websitedn = rs.getString( "WebSiteDN" );
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
