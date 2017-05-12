/*
 * 撰寫日期：2008/3/16
 * 程式名稱：EpaperMailData.java
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

public class EpaperMailData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //電子報訂戶資料
    private String name = null;
    private String email = null;
    private String sex = null;
    private String birthday = null;
    private String edu = null;
    private String occupation = null;
    private String fond = null;
    private String createdate = null;
    private String ip = null;
    private String language = null;
    
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getEdu() {
		return edu;
	}
	public void setEdu(String edu) {
		this.edu = edu;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFond() {
		return fond;
	}
	public void setFond(String fond) {
		this.fond = fond;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOccupation() {
		return occupation;
	}
	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	
	//查詢多筆資料及筆數
    public ArrayList<Object> findByday( String email )
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
    		
    		sSql.append( "select * from EpaperMailData where 1=1" );
    		
    		if ( email != null && !email.equals("") )  {
    			sSql.append( " and Email like '%" + email + "%'" );
    		}
    		
    		sSql.append( " order by CreateDate desc,Serno desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperMailData tmpQuery = new EpaperMailData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setName( rs.getString( "Name" ) );
    			tmpQuery.setEmail( rs.getString( "Email" ) );
    			tmpQuery.setSex( rs.getString( "Sex" ) );
    			tmpQuery.setBirthday( rs.getString( "Birthday" ) );
    			tmpQuery.setEdu( rs.getString( "Edu" ) );
    			tmpQuery.setOccupation( rs.getString( "Occupation" ) );
    			tmpQuery.setFond( rs.getString( "Fond" ) );
    			tmpQuery.setCreatedate( rs.getString( "CreateDate" ) );
    			tmpQuery.setIp( rs.getString( "Ip" ) );
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
    public boolean load( String serno )
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
    		stmts = conn.prepareStatement("select * from EpaperMailData where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.name = rs.getString( "Name" );
    		this.email = rs.getString( "Email" );
    		this.sex = rs.getString( "Sex" );
    		this.birthday = rs.getString( "Birthday" );
    		this.edu = rs.getString( "Edu" );
    		this.occupation = rs.getString( "Occupation" );
    		this.fond = rs.getString( "Fond" );
    		this.createdate = rs.getString( "CreateDate" );
    		    		
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

	//修改資料
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
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		//update
    		stmts = conn.prepareStatement(
    			"update EpaperMailData set Email = ?,  Name = ?, Sex = ?, Birthday = ?, Edu = ?, Occupation = ?, Fond = ? where Serno = ?");
    		   		
    		stmts.setString(1, email );
    		stmts.setString(2, name );
    		stmts.setString(3, sex );
    		stmts.setString(4, birthday );
    		stmts.setString(5, edu );
    		stmts.setString(6, occupation );
    		stmts.setString(7, fond );
    		stmts.setString(8, serno );
    		    		
    		int updateRow = stmts.executeUpdate();
    		
    		if ( updateRow < 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Insert into table fail(EpaperMailData).";
    				System.out.println(errorMsg);
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}
    		
    		//網站維運統計共用參數(WebSiteLog)
    		if ( !createlog(conn,language) )  {
    			try {
    				conn.rollback();
    				errorMsg = "Insert into table fail(WebSiteLog).";
    				System.out.println(errorMsg);
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
    		try {
    			if ( stmts != null ) stmts.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
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
    	    	
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);

     		String[] ary_mserno = SvString.split(serno,"||");
     		
     		for ( int i=0; i<ary_mserno.length; i++ ) {
     			String msql = "select * from EpaperMailData where Serno = '" + ary_mserno[i] + "'";
     			stmts = conn.prepareStatement(msql);
        		stmts.clearParameters();
        		rs = stmts.executeQuery();
        		
        		if ( rs.next() ) {
        			System.out.println("pubunitname="+pubunitname);
        			this.setSerno(rs.getString( "Serno" ));
        			this.setPubunitdn(pubunitdn);
        			this.setPubunitname(pubunitname);
        			this.setSubject(rs.getString( "Email" ));
        			//網站維運統計共用參數(WebSiteLog)        			
            		if ( !createlog(conn,language) )
            		{
            			try {
            				conn.rollback();
            				errorMsg = "Insert into table(Log) fail.";
            				System.out.println(errorMsg);
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            	return false;
         	            }
            		}

        			//刪除資料
        			String dsql = "delete EpaperMailData where Serno = '" + ary_mserno[i] + "'";
        			
        			stmts1 = conn.prepareStatement(dsql);
        			int updateRow = stmts1.executeUpdate();
        			if ( updateRow <= 0 ) 
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
