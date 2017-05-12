/*
 * 撰寫日期：2007/10/16
 * 程式名稱：QsortData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class QsortData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private int fsort = 0;
    private String serno = null;
    private String subject = null;
    private String pubunitdn = null;
	
	public String getPubunitdn() {
		return pubunitdn;
	}

	public void setPubunitdn(String pubunitdn) {
		this.pubunitdn = pubunitdn;
	}

	public int getFsort() {
		return fsort;
	}

	public void setFsort(int fsort) {
		this.fsort = fsort;
	}

	public String getSerno() {
		return serno;
	}

	public void setSerno(String serno) {
		this.serno = serno;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public int getAllrecordCount() {
		return allrecordCount;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	//查詢多筆資料及筆數
    public ArrayList<Object> findBysort( String tablename, String pubunitdn )
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
    		
    		sSql.append( "select * from " + tablename  + " where PubUnitDN like '%" + pubunitdn + "%' order by Fsort" );

    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			QsortData tmpQuery = new QsortData();    			
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			if ( tablename.equals("HouseRegist") )
    				tmpQuery.setSubject( rs.getString( "Itemname" ) );
    			else
    				tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setFsort( rs.getInt( "Fsort" ) );
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
	
	//查詢多筆資料及筆數(排序重整)
    public ArrayList<Object> findByday( String tablename )
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
    		
    		sSql.append( "select * from " + tablename + " order by UpdateDate desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			QsortData tmpQuery = new QsortData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
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
    		System.out.println(errorMsg);
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
    
    //修改資料(排序重整)
    public boolean store( String tablename )
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
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//update
    		stmts = conn.prepareStatement(
    			"update " + tablename + " set Fsort = ? where Serno = ? and PubUnitDN = ?");
    		stmts.clearParameters();
    		stmts.setInt(1, fsort );
    		stmts.setString(2, serno );
    		stmts.setString(3, pubunitdn );
    		
    		int updateRow = stmts.executeUpdate();
    		if ( updateRow <= 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Update table fail.";
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}

    		conn.commit();
       	  	conn.setAutoCommit(true);

      	  	return true;
      	  	
      	} catch ( SQLException sqle ) {
      		errorMsg = "update data error: " + sqle.toString();
      	} finally {
      		try
      		{
    			if ( stmts != null ) stmts.close();
      			conn.close();
      		} catch ( SQLException se ) {
      			errorMsg = "close Statment or connection error: " + se.toString();
      		}
      	}
      	return false;
    }
    
}
