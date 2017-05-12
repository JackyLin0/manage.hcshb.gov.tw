/*
 * 撰寫日期：2008/12/5
 * 程式名稱：ActivityViewData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ActivityViewData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //ActivityColumn
    private String serno = null;
    private String fieldname = null;
    private String attribute = null;
    private String fieldvalue = null;
    private String fieldlength = null;    
    private String flag = null;
    private String createdate = null;
    private String postname = null;
    private String updatedate = null;
    
    //ActivityRecord
    private String activityserno = null;
    private int serialnum = 0;
    private String fieldserno = null;
    private String isneed = null;
    
	public String getActivityserno() {
		return activityserno;
	}
	public void setActivityserno(String activityserno) {
		this.activityserno = activityserno;
	}
	public String getAttribute() {
		return attribute;
	}
	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getFieldlength() {
		return fieldlength;
	}
	public void setFieldlength(String fieldlength) {
		this.fieldlength = fieldlength;
	}
	public String getFieldname() {
		return fieldname;
	}
	public void setFieldname(String fieldname) {
		this.fieldname = fieldname;
	}
	public String getFieldserno() {
		return fieldserno;
	}
	public void setFieldserno(String fieldserno) {
		this.fieldserno = fieldserno;
	}
	public String getFieldvalue() {
		return fieldvalue;
	}
	public void setFieldvalue(String fieldvalue) {
		this.fieldvalue = fieldvalue;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getIsneed() {
		return isneed;
	}
	public void setIsneed(String isneed) {
		this.isneed = isneed;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
	}
	public int getSerialnum() {
		return serialnum;
	}
	public void setSerialnum(int serialnum) {
		this.serialnum = serialnum;
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

	//查詢多筆資料及筆數(尋找該活動的報名表欄位)
    public ArrayList<Object> findByrecord( String activityserno )
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
    		
    		sSql.append( "select FieldSerno,IsNeed from ActivityRecord where ActivitySerno = '" + activityserno + "' order by SerialNum" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			ActivityViewData tmpQuery = new ActivityViewData();
    			tmpQuery.setFieldserno( rs.getString( "FieldSerno" ) );
    			tmpQuery.setIsneed( rs.getString( "IsNeed" ) );
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

    //查詢單筆資料(尋找此欄位相關資訊)
    public boolean load( String fieldserno )
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
    		stmts = conn.prepareStatement("select * from ActivityColumn where Serno = '" + fieldserno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.serno = rs.getString( "Serno" );
    		this.fieldname = rs.getString( "FieldName" );
    		this.attribute = rs.getString( "Attribute" );
    		this.fieldvalue = rs.getString( "FieldValue" );
    		this.fieldlength = rs.getString( "FieldLength" );
    		this.flag = rs.getString( "Flag" );
    		    		
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
