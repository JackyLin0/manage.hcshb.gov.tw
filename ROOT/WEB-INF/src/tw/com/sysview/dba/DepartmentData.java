/*
 * 撰寫日期：2007/10/11
 * 程式名稱：DepartmentData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DepartmentData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String ou = null;
    private String dn = null;
    private String chinesetitle = null;
    private String englishtitle = null;
    private String japantitle = null;
    private String department_level = null;
    
	public String getDepartment_level() {
		return department_level;
	}
	public void setDepartment_level(String department_level) {
		this.department_level = department_level;
	}
	public String getChinesetitle() {
		return chinesetitle;
	}
	public void setChinesetitle(String chinesetitle) {
		this.chinesetitle = chinesetitle;
	}
	public String getDn() {
		return dn;
	}
	public void setDn(String dn) {
		this.dn = dn;
	}
	public String getEnglishtitle() {
		return englishtitle;
	}
	public void setEnglishtitle(String englishtitle) {
		this.englishtitle = englishtitle;
	}
	public String getJapantitle() {
		return japantitle;
	}
	public void setJapantitle(String japantitle) {
		this.japantitle = japantitle;
	}
	public String getOu() {
		return ou;
	}
	public void setOu(String ou) {
		this.ou = ou;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	
	//新增資料(單位)
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
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		stmts = conn.prepareStatement("select * from Department where DN = '" + dn + "'" );
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( rs.next() )
    		{
    			//update
        		stmts = conn.prepareStatement(
        				"update Department set ChineseTitle = ? where DN = ?" ); 
        		stmts.clearParameters();    	 	
        		stmts.setString(1, chinesetitle );        		
        		stmts.setString(2, dn );
    		}else{
    			//insert
        		String sql =  "insert into Department";
        		       sql += "(OU,DN,ChineseTitle,EnglishTitle,JapanTitle,Department_level)";
        		       sql += " values(?,?,?,?,?,?)";
        		       
        		stmts = conn.prepareStatement(sql);
        		
        		stmts.clearParameters();
        		stmts.setString(1, ou );
        		stmts.setString(2, dn );
        		stmts.setString(3, chinesetitle );
        		stmts.setString(4, englishtitle );
        		stmts.setString(5, japantitle );
        		stmts.setString(6, department_level );
    		}
    		
    		int updateRow = stmts.executeUpdate();
    		
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
     		

    		stmts = conn.prepareStatement("select * from Department where DN = '" + dn + "'" );
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( rs.next() )
    		{
    			//刪除資料
         		String dsql = "delete Department where DN = '" + dn + "'";
         		
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
	    
}
