/*
 * 撰寫日期：2008/2/16
 * 程式名稱：PublishData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import sysview.zhiren.function.SvString;

public class PublishData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //PublishAP
    private String aplistdn = null;
    private String aplistname = null;
    private String aplisttable = null;
    private String aplistown = null;
    private String aplistattribute = null;

    //publishdata
    private String pubwebsitedn = null;
    private String pubwebsitename = null;
    private String websitedn = null;
    private String websitename = null;
    private String flag = null;
    private String isexamine = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
        
	public String getAplistattribute() {
		return aplistattribute;
	}
	public void setAplistattribute(String aplistattribute) {
		this.aplistattribute = aplistattribute;
	}
	public String getAplistown() {
		return aplistown;
	}
	public void setAplistown(String aplistown) {
		this.aplistown = aplistown;
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
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}

	//查詢多筆資料及筆數(尋找多向發布AP)
    public ArrayList<Object> findByAP( String tablename, String aplistdn )
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
    		
    		sSql.append( "select * from " + tablename + " where 1=1" );
    		
    		if ( aplistdn != null && !aplistdn.equals("") )  {
    			sSql.append( " and AplistDN = '" + aplistdn + "'" );
    		}
    		sSql.append( " order by AplistDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PublishData tmpQuery = new PublishData();
    			tmpQuery.setAplistdn( rs.getString( "AplistDN" ) );
    			tmpQuery.setAplistname( rs.getString( "AplistName" ) );
    			tmpQuery.setAplisttable( rs.getString( "AplistTable" ) );
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
	
	//查詢多筆資料及筆數
    public ArrayList<Object> findByday( String tablename, String aplistdn, String flag )
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
    		
    		sSql.append( "select * from " + tablename + " where AplistDN = '" + aplistdn + "' and Flag = '" + flag + "'" );

    		sSql.append( " order by WebSiteDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PublishData tmpQuery = new PublishData();
    			tmpQuery.setAplistdn( rs.getString( "AplistDN" ) );
    			tmpQuery.setAplistname( rs.getString( "AplistName" ) );
    			tmpQuery.setPubwebsitedn( rs.getString( "PubWebSiteDN" ) );
    			tmpQuery.setPubwebsitename( rs.getString( "PubWebSiteName" ) );
    			tmpQuery.setWebsitedn( rs.getString( "WebSiteDN" ) );
    			tmpQuery.setWebsitename( rs.getString( "WebSiteName" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
    			tmpQuery.setIsexamine( rs.getString( "IsExamine" ) );
    			tmpQuery.setPostname( rs.getString( "PostName" ) );
    			tmpQuery.setCreatedate( rs.getString( "CreateDate" ) );
    			tmpQuery.setUpdatedate( rs.getString( "UpdateDate" ) );
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

    //資料發布設定
    public boolean createpub( String tablename )
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
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		String msql = "select * from " + tablename + " where AplistDN = '" + aplistdn + "'";
 			msql = msql + " and PubWebSiteDN = '" + pubwebsitedn + "' and Flag = '" + flag + "'";
 			
 			stmts = conn.prepareStatement(msql);
    		stmts.clearParameters();
    		rs = stmts.executeQuery();
    		
    		if ( rs.next() ) {
    			//刪除資料
    			String dsql = "delete from " + tablename + " where AplistDN = '" + aplistdn + "'";
    			dsql = dsql + " and PubwebsiteDN = '" + pubwebsitedn + "' and Flag = '" + flag + "'";
     						
    			stmts2 = conn.prepareStatement(dsql);
    			int updateRow2 = stmts2.executeUpdate();
    			if ( updateRow2 < 0 ) 
    			{
        			try {
        				conn.rollback();
        				errorMsg = "Delete table fail.";
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
        		}
    		}

     		String[] ary_websitedn = SvString.split(websitedn,"||");
     		String[] ary_websitename = SvString.split(websitename,"||");
     		String[] ary_isexamine = null;
     		if ( flag.equals("R") ) {
     			ary_isexamine = SvString.split(isexamine,"||");
     		}
     		for ( int i=0; i<ary_websitedn.length; i++ ) {
     			//insert
     			String sql =  "insert into " + tablename;
     			       sql += "(AplistDN,AplistName,PubWebSiteDN,PubWebSiteName,WebSiteDN,WebSiteName,Flag,IsExamine,PostName,CreateDate,UpdateDate)";
     			       sql += " values(?,?,?,?,?,?,?,?,?,?,?)";
     			       
            	stmts1 = conn.prepareStatement(sql);
            	
            	stmts1.clearParameters();
            	stmts1.setString(1, aplistdn );
            	stmts1.setString(2, aplistname );
            	stmts1.setString(3, pubwebsitedn );
            	stmts1.setString(4, pubwebsitename );
            	stmts1.setString(5, ary_websitedn[i] );
            	stmts1.setString(6, ary_websitename[i] );
            	stmts1.setString(7, flag );
            	if ( flag.equals("R") ) {
            		stmts1.setString(8, ary_isexamine[i] );
            	}else
            		stmts1.setString(8, "" );
            	stmts1.setString(9, postname );
            	stmts1.setString(10, getNowYear() );
            	stmts1.setString(11, getNowYear() );
            	
            	int updateRow1 = stmts1.executeUpdate();
            	
            	if ( updateRow1 < 0 )
            	{
            		try {
            			conn.rollback();
            			errorMsg = "Insert into table fail.";
            			System.out.println(errorMsg);
            			return false;
            		}catch(Exception backerr){
            			System.out.println("rollback faild!");
            		}
            	}
     		}
     		
     		conn.commit();
       	  	conn.setAutoCommit(true);
    		
    		return true;
  
       }catch( SQLException sqle ) { 
           errorMsg = "delete data error: " + sqle.toString();
       }finally{
    	   try {
    		   if ( stmts != null ) stmts.close();
    		   if ( rs != null ) rs.close();
    		   if ( stmts1 != null ) stmts1.close();
    		   if ( stmts2 != null ) stmts2.close();
    		   conn.close();
    	   }catch( SQLException se ) {
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }          		
    
    //查詢單筆資料
    public boolean load( String tablename, String aplistdn, String pubwebsitedn, String websitedn, String flag )
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
    		String msql = "select IsExamine from " + tablename + " where AplistDN = '" + aplistdn + "' and WebSiteDN = '" + websitedn + "' and Flag = '" + flag + "'";
    		if ( !pubwebsitedn.equals("") ) 
    			msql = msql + " and PubWebSiteDN = '" + pubwebsitedn + "'";
    		
    		stmts = conn.prepareStatement(msql);
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.isexamine = rs.getString( "IsExamine" );
    		
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
    	
    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    
        
}
