/*
 * 撰寫日期：2007/2/11
 * 程式名稱：DSData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DSData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //table department_ldap
    private String depid = null;
    private String name = null;
    private String parent_node = null;
    private String sysdnlevel = null;
    private String dn = null;
    private String ou = null;
    
    //table people_ldap
    private String uid = null;
    private String id = null;
    private String eipemail = null;
    
	public String getDepid() {
		return depid;
	}
	public void setDepid(String depid) {
		this.depid = depid;
	}
	public String getDn() {
		return dn;
	}
	public void setDn(String dn) {
		this.dn = dn;
	}
	public String getEipemail() {
		return eipemail;
	}
	public void setEipemail(String eipemail) {
		this.eipemail = eipemail;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOu() {
		return ou;
	}
	public void setOu(String ou) {
		this.ou = ou;
	}
	public String getParent_node() {
		return parent_node;
	}
	public void setParent_node(String parent_node) {
		this.parent_node = parent_node;
	}
	public String getSysdnlevel() {
		return sysdnlevel;
	}
	public void setSysdnlevel(String sysdnlevel) {
		this.sysdnlevel = sysdnlevel;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}	
	
	//自TransUnit table 尋找轉入的單位(department_ldap)
    public ArrayList<Object> findByunit()
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
    		
    		sSql.append( "select * from TransUnit order by depid" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			DSData tmpQuery = new DSData();
    			tmpQuery.setDepid( rs.getString( "depid" ) );
    			tmpQuery.setName( rs.getString( "name" ) );
    			tmpQuery.setParent_node( rs.getString( "parent_node" ) );
    			tmpQuery.setSysdnlevel( rs.getString( "sysdnlevel" ) );
    			tmpQuery.setDn( rs.getString( "dn" ) );
    			tmpQuery.setOu( rs.getString( "ou" ) );
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
    
    //查詢單筆資料
    public boolean load( String depid, String dn )
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
    		stmts = conn.prepareStatement("select * from department_ldap where depid = '" + depid + "' and dn = '" + dn + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.depid = rs.getString( "depid" );
    		this.name = rs.getString( "name" );
    		this.parent_node = rs.getString( "parent_node" );
    		this.sysdnlevel = rs.getString( "sysdnlevel" );
    		this.dn = rs.getString( "dn" );
    		this.ou = rs.getString( "ou" );
    		
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
	
	//自people_ldip尋找轉入的人員
    public ArrayList<Object> findBypersonal()
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
    		
    		sSql.append( "select * from people_ldap as p,TransUnit as t where p.depid = t.depid order by dn" );
    		
    		stmts = conn.prepareStatement( sSql.toString(),
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
	                   ResultSet.CONCUR_READ_ONLY );
    		
    		stmts.clearParameters();
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			DSData tmpQuery = new DSData();
    			tmpQuery.setUid( rs.getString( "uid" ) );
    			tmpQuery.setId( rs.getString( "id" ) );
    			tmpQuery.setName( rs.getString( "name" ) );
    			tmpQuery.setDepid( rs.getString( "depid" ) );
    			tmpQuery.setEipemail( rs.getString( "eipemail" ) );
    			tmpQuery.setDn( rs.getString( "dn" ) );
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
    
    //查詢單筆資料
    public boolean loadp( String dn, String uid )
    {
    	Connection conn = null;
    	
    	try
    	{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		System.out.println("errorMsg="+errorMsg);
    		return false;
    	}
    	
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	try
    	{
    		stmts = conn.prepareStatement("select * from query_ldap where dn = '" + dn + "' and uid = '" + uid + "'");
    		stmts.clearParameters();
    		this.id="select * from query_ldap where dn = '" + dn + "' and uid = '" + uid + "'";
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.depid = rs.getString( "depid" );
    		this.uid = rs.getString( "uid" );
    		this.dn = rs.getString( "dn" );
    		
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
