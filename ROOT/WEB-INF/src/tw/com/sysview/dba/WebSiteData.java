/*
 * 撰寫日期：2008/2/11
 * 程式名稱：WebSiteData.java
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

import sysview.zhiren.function.SvNumber;
import sysview.zhiren.function.SvString;

public class WebSiteData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String serno = null;
    private String websitedn = null;
    private String websitename = null;
    private String islanguage = null;
    private String createdate = null;
    private String updatedate = null;
    private String startusing = null;
    private String pubunitdn = null;
    private String pubunitname = null;
    private String postname = null;
    
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
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getIslanguage() {
		return islanguage;
	}
	public void setIslanguage(String islanguage) {
		this.islanguage = islanguage;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
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

	//新增資料(WebSite)
    public boolean create()
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
    	
    	//找最大序號 start
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	try
    	{
    		//找最大序號 start
    		stmts = conn.prepareStatement("select max(serno) as seqno from WebSite where substring(serno,1,8) = ?" );
    		stmts.clearParameters();
    		stmts.setString(1,getNowYear());
    		rs = stmts.executeQuery();
 
    		int tempno = 0;
    		String mserno = "";
    		while ( rs.next() )
    		{
    			String mseq = rs.getString("seqno");
    			if ( mseq == null)
    			{
    				mserno = SvNumber.format( 1, "00" );
    				mserno = getNowYear() + mserno;
    			}else{
    				tempno = new Integer(mseq.substring(9,10)).intValue()+1;
    				mserno = SvNumber.format( tempno, "00" );
    				mserno = getNowYear()  + mserno; 
    			}
    			this.serno = mserno;
    		}
    		//找最大序號 end
    		
    		//inser into WebSite
    		String sql =  "insert into WebSite";
    		       sql += "(Serno,WebSiteDN,WebSiteName,IsLanguage,CreateDate,UpdateDate,StartUsing)";
    		       sql += " values(?,?,?,?,?,?,?)";
    		
    		stmts = conn.prepareStatement(sql);
    		stmts.clearParameters();
    		stmts.setString(1, serno );
    		stmts.setString(2, websitedn );
    		stmts.setString(3, websitename );
    		stmts.setString(4, islanguage );
    		stmts.setString(5, getNowYear() );
    		stmts.setString(6, getNowYear() );
    		stmts.setString(7, startusing );
    		
    		int updateRow = stmts.executeUpdate();
    		
    		if ( updateRow <= 0 )
    		{
    			errorMsg = "Insert into table(WebSite) fail.";
    			return false;
    		}	

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error(WebSite): " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
    			if ( stmts != null ) stmts.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }

	//新增修改資料(WebSiteUnit)
    public boolean createweb( String punitweb )
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
    	
    	//找最大序號 start
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	try
    	{
    		//同意易動設定
     		conn.setAutoCommit(false);
     		
    		if ( !punitweb.equals("") ) {
    			stmts = conn.prepareStatement("select * from WebSiteUnit where WebSiteDN = '" + websitedn + "'");
	    		stmts.clearParameters();
	    		
	    		rs = stmts.executeQuery();
	    		if ( rs.next() ) {
	    			String dsql = "delete WebSiteUnit where WebSiteDN = '" + websitedn + "'";
	    			
	    			stmts = conn.prepareStatement(dsql);
	    			int updateRow = stmts.executeUpdate();
	    			
	    			if ( updateRow < 0 ) {
	    				try {
	        				conn.rollback();
	        				errorMsg = "Delete table(WebSiteUnit) fail.";
	        				System.out.println(errorMsg);
	        				return false;
	     	            }catch(Exception backerr){
	     	            	System.out.println("rollback faild!");
	     	            }
	    			}
	    		}
	    		
    			String[] ary_punitweb = SvString.split(punitweb,"&");
    			for ( int i=0; i<ary_punitweb.length; i++ ) {
    				String[] ary_punit = SvString.split(ary_punitweb[i],"||");
    				//inser into WebSiteUnit
	    			String sql =  "insert into WebSiteUnit";
	    			       sql += "(PubUnitDN,PubUnitName,WebSiteDN,WebSiteName,PostName,CreateDate,UpdateDate)";
	    			       sql += " values(?,?,?,?,?,?,?)";
	    			       
	    			stmts1 = conn.prepareStatement(sql);
	    			stmts1.clearParameters();
	    			stmts1.setString(1, ary_punit[0] );
	    			stmts1.setString(2, ary_punit[1] );
	    			stmts1.setString(3, websitedn );
	    			stmts1.setString(4, websitename );
	    			stmts1.setString(5, postname );
	    			stmts1.setString(6, getNowYear() );
	    			stmts1.setString(7, getNowYear() );
	    			
	    			int updateRow1 = stmts1.executeUpdate();
	    			
	    			if ( updateRow1 <= 0 )
        			{
        				try {
        					conn.rollback();
        					errorMsg = "Insert into table(WebSiteUnit) fail.";
        					System.out.println(errorMsg);
        					return false;
        				}catch(Exception backerr){
        					System.out.println("rollback faild!");
        				}
        			}
    			}
    		}
    		
    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error(WebSite): " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
    			if ( stmts != null ) stmts.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
        
    //修改資料(WebSite)
    public boolean store()
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
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	try
    	{
    		stmts = conn.prepareStatement("select * from WebSite where WebSiteDN = '" + websitedn + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
        		//找最大序號 start
        		stmts1 = conn.prepareStatement("select max(serno) as seqno from WebSite where substring(serno,1,8) = ?" );
        		stmts1.clearParameters();
        		stmts1.setString(1,getNowYear());
        		rs1 = stmts1.executeQuery();
     
        		int tempno = 0;
        		String mserno = "";
        		while ( rs1.next() )
        		{
        			String mseq = rs1.getString("seqno");
        			if ( mseq == null)
        			{
        				mserno = SvNumber.format( 1, "00" );
        				mserno = getNowYear() + mserno;
        			}else{
        				tempno = new Integer(mseq.substring(9,10)).intValue()+1;
        				mserno = SvNumber.format( tempno, "00" );
        				mserno = getNowYear()  + mserno; 
        			}
        			this.serno = mserno;
        		}
        		//找最大序號 end
    			
        		//inser into WebSite
        		String sql =  "insert into WebSite";
        		       sql += "(Serno,WebSiteDN,WebSiteName,IsLanguage,CreateDate,UpdateDate,StartUsing)";
        		       sql += " values(?,?,?,?,?,?,?)";
        		
        		stmts2 = conn.prepareStatement(sql);
        		stmts2.clearParameters();
        		stmts2.setString(1, serno );
        		stmts2.setString(2, websitedn );
        		stmts2.setString(3, websitename );
        		stmts2.setString(4, islanguage );
        		stmts2.setString(5, getNowYear() );
        		stmts2.setString(6, getNowYear() );
        		stmts2.setString(7, startusing );
        		
        		int updateRow = stmts2.executeUpdate();
        		
        		if ( updateRow <= 0 )
        		{
        			errorMsg = "Insert into table(WebSite) fail.";
        			return false;
        		}	

        		return true;
    		}else{
        		//update WebSite
        		stmts3 = conn.prepareStatement(
        				"update WebSite set WebSiteName = ?, IsLanguage = ?, UpdateDate = ?, StartUsing = ? where WebSiteDN = ?" ); 
        		stmts3.clearParameters();    	 	
        		stmts3.setString(1, websitename );
        		stmts3.setString(2, islanguage );
        		stmts3.setString(3, getNowYear() );
        		stmts3.setString(4, startusing );
        		stmts3.setString(5, websitedn );
        		
        		int updateRow = stmts3.executeUpdate();
        		if ( updateRow <= 0 )
        		{
        			errorMsg = "Update table(WebSite) fail.";
        			return false;
        		}
          	  	return true;

    		}

    	} catch ( SQLException sqle ) {
    		errorMsg = "update data error: " + sqle.toString();
    	} finally {
    		try
    		{
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			if ( rs != null ) rs.close();
    			if ( rs1 != null ) rs1.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
    
    //查詢單筆資料(qwebsite.jsp 使用)
    public boolean load( String websitdn, String islanguage )
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
    		stmts = conn.prepareStatement("select * from WebSite where WebSiteDN = '" + websitdn + "' and IsLanguage = '" + islanguage + "'");
    		
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.websitedn = rs.getString( "WebSiteDN" );
    		this.websitename = rs.getString( "WebSiteName" );
    		this.islanguage = rs.getString( "IsLanguage" );
    		this.createdate = rs.getString( "CreateDate" );
    		this.updatedate = rs.getString( "UpdateDate" );
    		this.startusing = rs.getString( "StartUsing" );
    		
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

    //刪除資料
    public boolean remove()
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
    	ResultSet rs1 = null;
    	
    	try {
    		//同意易動設定
     		conn.setAutoCommit(false);
     		
     		//delete WebSite
    		String msql = "select * from WebSite where WebSiteDN = '" + websitedn + "'";
    		stmts = conn.prepareStatement(msql);
    		stmts.clearParameters();
    		rs = stmts.executeQuery();
    		if ( rs.next() ) {
    			String dsql = "delete WebSite where WebSiteDN = '" + websitedn + "'";
    			
    			stmts = conn.prepareStatement(dsql);
    			int updateRow = stmts.executeUpdate();
    			if ( updateRow <= 0 ) {
    				try {
        				conn.rollback();
        				errorMsg = "Delete table(WebSite) fail.";
        				System.out.println(errorMsg);
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
    			}
    		}
     		
     		//delete WebSiteUnit
    		String msql1 = "select * from WebSiteUnit where WebSiteDN = '" + websitedn + "'";
    		stmts1 = conn.prepareStatement(msql1);
    		stmts1.clearParameters();
    		rs1 = stmts1.executeQuery();
    		if ( rs1.next() ) {
    			String dsql = "delete WebSiteUnit where WebSiteDN = '" + websitedn + "'";
    			
    			stmts1 = conn.prepareStatement(dsql);
    			int updateRow = stmts1.executeUpdate();
    			if ( updateRow <= 0 ) {
    				try {
        				conn.rollback();
        				errorMsg = "Delete table(WebSiteUnit) fail.";
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
           errorMsg = "delete data error(City_news): " + sqle.toString();
       }finally{
    	   try {
    		   if ( stmts != null ) stmts.close();
    		   if ( rs != null ) rs.close();
    		   if ( stmts1 != null ) stmts1.close();
    		   if ( rs1 != null ) rs1.close();
    		   conn.close();
    	   }catch( SQLException se ) {
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }			
	
	//查詢多筆資料及筆數
    public ArrayList<Object> findByday( String islanguage )
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
    		
    		sSql.append( "select * from WebSite where IsLanguage = '" + islanguage + "'" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			WebSiteData tmpQuery = new WebSiteData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setWebsitedn( rs.getString( "WebSiteDN" ) );
    			tmpQuery.setWebsitename( rs.getString( "WebSiteName" ) );
    			tmpQuery.setIslanguage( rs.getString( "IsLanguage" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
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
	
	//查詢多筆資料及筆數(publish_add.jsp使用)
    public ArrayList<Object> findByday( String islanguage, String own, String flag )
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
    		
    		sSql.append( "select * from WebSite where IsLanguage = '" + islanguage + "'" );
    		if ( own.equals("") ) {
    			sSql.append( " and StartUsing = 'Y'" );
    		}
    		if ( !flag.equals("") ) {
    			sSql.append( " and Flag is null" );
    		}
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			WebSiteData tmpQuery = new WebSiteData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setWebsitedn( rs.getString( "WebSiteDN" ) );
    			tmpQuery.setWebsitename( rs.getString( "WebSiteName" ) );
    			tmpQuery.setIslanguage( rs.getString( "IsLanguage" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
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
    
    //查詢單筆資料(node.jsp 使用)
    public boolean load( String websitdn )
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
    		stmts = conn.prepareStatement("select * from WebSite where WebSiteDN = '" + websitdn + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.websitedn = rs.getString( "WebSiteDN" );
    		this.websitename = rs.getString( "WebSiteName" );
    		this.islanguage = rs.getString( "IsLanguage" );
    		this.createdate = rs.getString( "CreateDate" );
    		this.updatedate = rs.getString( "UpdateDate" );
    		this.startusing = rs.getString( "StartUsing" );
    		
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
	
	//查詢多筆資料及筆數(node.jsp 使用查WebSiteUnit)
    public ArrayList<Object> findByweb( String websitdn )
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
    		
    		sSql.append( "select * from WebSiteUnit where WebSiteDN = '" + websitdn + "'" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			WebSiteData tmpQuery = new WebSiteData();
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setWebsitedn( rs.getString( "WebSiteDN" ) );
    			tmpQuery.setWebsitename( rs.getString( "WebSiteName" ) );
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
     	                				     		        		
    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }	
    
}
