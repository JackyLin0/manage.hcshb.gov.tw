/*
 * 撰寫日期：2007/10/11
 * 程式名稱：UsersData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsersData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String uid = null;
    private String employno = null;    
    private String cn = null;
    private String department_id = null;
    private String userkeyword = null;
    private String carlicense = null;
    private String email = null;
    private String unitdn = null;
    private String unitname = null;
    private String department_name = null;
    
	public String getDepartment_name() {
		return department_name;
	}
	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}
	public String getUnitdn() {
		return unitdn;
	}
	public void setUnitdn(String unitdn) {
		this.unitdn = unitdn;
	}
	public String getUnitname() {
		return unitname;
	}
	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}
	public String getCarlicense() {
		return carlicense;
	}
	public void setCarlicense(String carlicense) {
		this.carlicense = carlicense;
	}
	public String getCn() {
		return cn;
	}
	public void setCn(String cn) {
		this.cn = cn;
	}
	public String getDepartment_id() {
		return department_id;
	}
	public void setDepartment_id(String department_id) {
		this.department_id = department_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmployno() {
		return employno;
	}
	public void setEmployno(String employno) {
		this.employno = employno;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUserkeyword() {
		return userkeyword;
	}
	public void setUserkeyword(String userkeyword) {
		this.userkeyword = userkeyword;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	
	//新增資料(人員)
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
    	
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		stmts = conn.prepareStatement("select * from Users where Uid = '" + uid + "'" );
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( rs.next() )
    		{
    			//update
        		stmts1 = conn.prepareStatement(
        				"update Users set EmployNo = ?, Cn = ?, Department_id = ?, UnitDN = ?, UnitName = ?, Carlicense = ?, Email = ? where Uid = ?" ); 
        		stmts1.clearParameters();
        		stmts1.setString(1, employno );        		
        		stmts1.setString(2, cn );
        		stmts1.setString(3, department_id );
        		stmts1.setString(4, unitdn );
        		stmts1.setString(5, unitname );
        		stmts1.setString(6, employno );
        		stmts1.setString(7, email );
        		stmts1.setString(8, uid );
    		}else{
    			//insert
        		String sql =  "insert into Users ";
        		       sql += "(Uid,EmployNo,Cn,Department_id,UnitDN,UnitName,UserKeyword,Carlicense,Email)";
        		       sql += " values(?,?,?,?,?,?,?,?,?)";
        		       
        		stmts1 = conn.prepareStatement(sql);
        		
        		stmts1.clearParameters();
        		stmts1.setString(1, uid );
        		stmts1.setString(2, employno );
        		stmts1.setString(3, cn );
        		stmts1.setString(4, department_id );
        		stmts1.setString(5, unitdn );
        		stmts1.setString(6, unitname );
        		stmts1.setString(7, userkeyword );
        		stmts1.setString(8, carlicense );
        		stmts1.setString(9, email );
    		}
    		
    		int updateRow = stmts1.executeUpdate();
    		
    		if ( updateRow < 0 )
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
    		
    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
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
    	
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);
     		

    		stmts = conn.prepareStatement("select * from Users where Uid = '" + uid + "'" );
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( rs.next() )
    		{
    			//刪除資料
         		String dsql = "delete Users where Uid = '" + uid + "'";
         		
         		stmts = conn.prepareStatement(dsql);
         		int updateRow = stmts.executeUpdate();
         		if ( updateRow < 0 )
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
    		   if ( stmts != null ) stmts.close();
    		   conn.close();
    	   }catch( SQLException se ) {
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }          		
    
    //查詢單筆資料(login.jsp使用)
    public boolean load( String uid )
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
    		stmts = conn.prepareStatement("select * from Users where Uid = '" + uid + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.uid = rs.getString( "Uid" );
    		this.employno = rs.getString( "EmployNo" );
    		this.cn = rs.getString( "Cn" );
    		this.department_id = rs.getString( "Department_id" );
    		this.userkeyword = rs.getString( "UserKeyword" );
    		this.carlicense = rs.getString( "Carlicense" );
    		this.email = rs.getString( "Email" );
    		
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
    
    //查詢單筆資料
    public boolean loadunit( String dn )
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
    		stmts = conn.prepareStatement("select * from transid where DN = '" + dn + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.department_name = rs.getString( "department_name" );
    		
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
