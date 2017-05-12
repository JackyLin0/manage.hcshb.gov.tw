/*
 * 撰寫日期：2010/6/26
 * 程式名稱：MetaClassData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.metatag;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MetaClassData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    private int serno = 0;
    private String category = null;
    private String classno1 = null;
    private String classcname = null;
    private String classename = null;
    private String startusing = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    private String classno2 = null;
    private String classno3 = null;
	public int getSerno() {
		return serno;
	}
	public void setSerno(int serno) {
		this.serno = serno;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getClassno1() {
		return classno1;
	}
	public void setClassno1(String classno1) {
		this.classno1 = classno1;
	}
	public String getClasscname() {
		return classcname;
	}
	public void setClasscname(String classcname) {
		this.classcname = classcname;
	}
	public String getClassename() {
		return classename;
	}
	public void setClassename(String classename) {
		this.classename = classename;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getClassno2() {
		return classno2;
	}
	public void setClassno2(String classno2) {
		this.classno2 = classno2;
	}
	public String getClassno3() {
		return classno3;
	}
	public void setClassno3(String classno3) {
		this.classno3 = classno3;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	
	//查詢多筆資料及筆數(查詢第一層分類)
    public ArrayList<Object> findByone( String tablename, String category, String startusing )
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
    		
    		sSql.append( "select * from " + tablename + " where Category = '" + category + "'" );

    		if ( startusing != null && !startusing.equals("null") && !startusing.equals("") ) {
    			sSql.append( " and StartUsing = '" + startusing + "'" );
    		}
    		sSql.append( " order by Serno" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			MetaClassData tmpQuery = new MetaClassData();
    			tmpQuery.setSerno( rs.getInt( "Serno" ) );
    			tmpQuery.setCategory( rs.getString( "Category" ) );
    			tmpQuery.setClassno1( rs.getString( "ClassNo1" ) );
    			tmpQuery.setClasscname( rs.getString( "ClassCName" ) );
    			tmpQuery.setClassename( rs.getString( "ClassEName" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setPostname( rs.getString( "PostName" ) );
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
	
	//查詢多筆資料及筆數(查詢第二層分類)
    public ArrayList<Object> findBytwo( String tablename, String category, String classno1, String startusing )
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
    		
    		sSql.append( "select * from " + tablename + " where Category = '" + category + "' and ClassNo1 = '" + classno1 + "'" );

    		if ( startusing != null && !startusing.equals("null") && !startusing.equals("") ) {
    			sSql.append( " and StartUsing = '" + startusing + "'" );
    		}
    		sSql.append( " order by Serno" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			MetaClassData tmpQuery = new MetaClassData();
    			tmpQuery.setSerno( rs.getInt( "Serno" ) );
    			tmpQuery.setCategory( rs.getString( "Category" ) );
    			tmpQuery.setClassno1( rs.getString( "ClassNo1" ) );
    			tmpQuery.setClassno2( rs.getString( "ClassNo2" ) );
    			tmpQuery.setClasscname( rs.getString( "ClassCName" ) );
    			tmpQuery.setClassename( rs.getString( "ClassEName" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setPostname( rs.getString( "PostName" ) );
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

	//查詢多筆資料及筆數(查詢第三層分類)
    public ArrayList<Object> findBythree( String tablename, String category, String classno1, String classno2, String startusing )
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
    		
    		sSql.append( "select * from " + tablename + " where Category = '" + category + "' and ClassNo1 = '" + classno1 + "' and ClassNo2 = '" + classno2 + "'" );

    		if ( startusing != null && !startusing.equals("null") && !startusing.equals("") ) {
    			sSql.append( " and StartUsing = '" + startusing + "'" );
    		}
    		sSql.append( " order by Serno" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			MetaClassData tmpQuery = new MetaClassData();
    			tmpQuery.setSerno( rs.getInt( "Serno" ) );
    			tmpQuery.setCategory( rs.getString( "Category" ) );
    			tmpQuery.setClassno1( rs.getString( "ClassNo1" ) );
    			tmpQuery.setClassno2( rs.getString( "ClassNo2" ) );
    			tmpQuery.setClassno3( rs.getString( "ClassNo3" ) );
    			tmpQuery.setClasscname( rs.getString( "ClassCName" ) );
    			tmpQuery.setClassename( rs.getString( "ClassEName" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setPostname( rs.getString( "PostName" ) );
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

}
