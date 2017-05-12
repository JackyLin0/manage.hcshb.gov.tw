/*
 * 撰寫日期：2008/12/5
 * 程式名稱：ActivityExcelData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import sysview.zhiren.function.SvString;

public class ActivityExcelData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    private String excelfield = null;
    private String excelvalue = null;
    private String[] signdata = null;
    private String name = null;
    private String email = null;
    
    //Activities
    private String pubunitdn = null;
    private String pubunitname = null;
    private String subject = null;
    
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
    
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String[] getSigndata() {
		return signdata;
	}
	public void setSigndata(String[] signdata) {
		this.signdata = signdata;
	}
	public String getExcelvalue() {
		return excelvalue;
	}
	public void setExcelvalue(String excelvalue) {
		this.excelvalue = excelvalue;
	}
	public String getExcelfield() {
		return excelfield;
	}
	public void setExcelfield(String excelfield) {
		this.excelfield = excelfield;
	}
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
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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

	//查詢多筆資料及筆數
    public ArrayList<Object> findByday( String punit )
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
    		
    		sSql.append( "select Serno,Subject,PubUnitDN,PubUnitName from Activities where OnlineSign = 'Y'" );
    		
    		sSql.append( " and Serno in(select ActivitySerno from ActivityRecord)" );
    		
    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and PubUnitDN like '%" + mpunit[0] + "%'" );
    		}
    		
    		sSql.append( " order by UpdateDate desc,Serno desc,PubUnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			ActivityExcelData tmpQuery = new ActivityExcelData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
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
    			ActivityExcelData tmpQuery = new ActivityExcelData();
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

    //查詢單筆資料(尋找欄位名稱)
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
    
	//查詢多筆資料及筆數(尋找該活動的報名資料)
    public ArrayList<Object> findByexcel( String activityserno, String fsort )
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
    		
    		String sortfield = "A" + fsort;
    		
    		sSql.append( "select * from A_" + activityserno + " order by "  );
    		
    		if ( !fsort.equals("") ) {
    			sSql.append( sortfield + ","  );
    		}
    		sSql.append( "Serno"  );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		//取報名表欄位			
			String[] ary_excelfield = SvString.split(excelfield,"||");
			
    		for ( int i = 0; rs.next(); i++ )
    		{
    			String mdata = "";
    			for ( int f=0; f<ary_excelfield.length; f++ ) {
    				String mfield = "A" + ary_excelfield[f];
    				String temp_data = rs.getString( mfield );
					if ( mfield.equals("A200812030002") )
						temp_data = rs.getString( mfield ).substring(0,4) + "." + rs.getString( mfield ).substring(4,6) + "." + rs.getString( mfield ).substring(6,8);
    				if ( mdata.equals("") ) {    					
    					mdata = temp_data;
    				}else{
    					mdata = mdata + "||" + temp_data;
    				}
    			}
    			mdata = mdata + "||" + rs.getString( "Serno" );
    			ActivityExcelData tmpQuery = new ActivityExcelData();
    			tmpQuery.setExcelvalue( mdata );
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
    public String[] loadexcel( String activityserno, String serno )
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
    		//取報名表欄位			
			String[] ary_excelfield = SvString.split(excelfield,"||");
			
    		stmts = conn.prepareStatement("select * from A_" + activityserno + " where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return null;
    		}
    		
    		signdata = new String[ary_excelfield.length];
    		for ( int i=0; i<ary_excelfield.length; i++ ) {
    			String mfield = "A" + ary_excelfield[i];
    			signdata[i] = rs.getString( mfield );
    		}

    		return signdata;
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
    	return null;
    }		

    //刪除資料
    public boolean remove( String activityserno, String serno )
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
    	
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);

    		stmts = conn.prepareStatement("select * from A_" + activityserno + " where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		System.out.println("select * from A_" + activityserno + " where Serno = '" + serno + "'");
    		rs = stmts.executeQuery();
    		
    		if ( rs.next() ) {
    			this.name = rs.getString("A200812030001");
    			if ( rs.getString("A200812040009") != null && !rs.getString("A200812040009").equals("null") )
    				this.email = rs.getString("A200812040009");
    			
    			String dsql = "delete A_" + activityserno + " where Serno = '" + serno + "'";
    			
    			stmts1 = conn.prepareStatement(dsql);
    			
    			int updateRow1 = stmts1.executeUpdate();
    			if ( updateRow1 < 0 ) 
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
    		
     		conn.commit();
       	  	conn.setAutoCommit(true);
    		
    		return true;
  
       }catch( SQLException sqle ) { 
           errorMsg = "delete data error: " + sqle.toString();
       }finally{
    	   try {
    		   if ( rs != null ) rs.close();
    		   if ( stmts != null ) stmts.close();
    		   if ( stmts1 != null ) stmts1.close();
    		   conn.close();
    	   }catch( SQLException se ) {
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }          		
	    
}
