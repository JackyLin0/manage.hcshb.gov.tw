/*
 * 撰寫日期：2007/12/20
 * 程式名稱：DepartmentManagerData.java
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

public class DepartmentManagerData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String serno = null;
    private String managerunitdn = null;
    private String managerunitname = null;
    private String managerperdn = null;
    private String managerpername = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getManagerperdn() {
		return managerperdn;
	}
	public void setManagerperdn(String managerperdn) {
		this.managerperdn = managerperdn;
	}
	public String getManagerpername() {
		return managerpername;
	}
	public void setManagerpername(String managerpername) {
		this.managerpername = managerpername;
	}
	public String getManagerunitdn() {
		return managerunitdn;
	}
	public void setManagerunitdn(String managerunitdn) {
		this.managerunitdn = managerunitdn;
	}
	public String getManagerunitname() {
		return managerunitname;
	}
	public void setManagerunitname(String managerunitname) {
		this.managerunitname = managerunitname;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
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

	//新增資料
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
    	ResultSet rs1 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		//查詢該單位是否已有管理者
     		stmts1 = conn.prepareStatement("select * from DepartmentManager where ManagerUnitDN = '" + managerunitdn + "'");
    		stmts1.clearParameters();
    		
    		rs1 = stmts1.executeQuery();
    		if ( rs1.next() )
    		{
    			String unit = rs1.getString("ManagerUnitName");
    			String name = rs1.getString("ManagerPerName");
    			errorMsg = "該單位【" + unit + "】已有管理者【" +name + "】，請使用修改方式。";
    			return false;
    		}
     		
    		//找最大序號 start
    		stmts = conn.prepareStatement("select max(serno) as seqno from DepartmentManager where substring(serno,1,8) = ?" );
    		stmts.clearParameters();
    		stmts.setString(1,getNowYear());
    		rs = stmts.executeQuery();
 
    		int tempno = 0;
    		String mserno1 = "";
    		while ( rs.next() )
    		{
    			String mseq = rs.getString("seqno");
    			if ( mseq == null)
    			{
    				mserno1 = SvNumber.format( 1, "0000" );
    				mserno1 = getNowYear() + mserno1;
    			}else{
    				tempno = new Integer(mseq.substring(8,12)).intValue()+1;
    				mserno1 = SvNumber.format( tempno, "0000" );
    				mserno1 = getNowYear()  + mserno1; 
    			}
    			this.serno = mserno1;
    		}
    		//找最大序號 end
    		
    		//insert
    		String sql =  "insert into DepartmentManager";
    		       sql += "(Serno,ManagerUnitDN,ManagerUnitName,ManagerPerDN,ManagerPerName,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?)";
    		       
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, managerunitdn );
    		stmts2.setString(3, managerunitname );
    		stmts2.setString(4, managerperdn );
    		stmts2.setString(5, managerpername );
    		stmts2.setString(6, postname );
    		stmts2.setString(7, getNowYear() );
    		stmts2.setString(8, getNowYear() );
    		
    		int updateRow = stmts2.executeUpdate();
    		
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
    			if ( rs1 != null ) rs1.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			if ( stmts2 != null ) stmts2.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
    				
	//查詢多筆資料及筆數
    public ArrayList findByday( String tablename, String keyword, String punit )
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
    		
    		if ( keyword != null && !keyword.equals("") )  {
    			sSql.append( " and (ManagerPerName like '%" + keyword + "%')" );
    		}
    			
    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and ManagerUnitDN like '%" + mpunit[0] + "%'" );
    		}
    		
    		sSql.append( " order by Serno,UpdateDate desc,ManagerUnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList result = new ArrayList();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			DepartmentManagerData tmpQuery = new DepartmentManagerData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setManagerunitdn( rs.getString( "ManagerUnitDN" ) );
    			tmpQuery.setManagerunitname( rs.getString( "ManagerUnitName" ) );
    			tmpQuery.setManagerperdn( rs.getString( "ManagerperDN" ) );
    			tmpQuery.setManagerpername( rs.getString( "ManagerPerName" ) );
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
    
    //查詢單筆資料(以序號查詢)
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
    		stmts = conn.prepareStatement("select * from DepartmentManager where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.serno = rs.getString( "Serno" );
    		this.managerunitdn = rs.getString( "ManagerUnitDN" );
    		this.managerunitname = rs.getString( "ManagerUnitName" );
    		this.managerperdn = rs.getString( "ManagerPerDN" );
    		this.managerpername = rs.getString( "ManagerPerName" );
    		this.postname = rs.getString( "PostName" );
    		this.updatedate = rs.getString( "UpdateDate" );
    		
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
    
    //查詢單筆資料(以單位查詢)
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
    		stmts = conn.prepareStatement("select * from DepartmentManager where ManagerPerDn = '" + dn + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.serno = rs.getString( "Serno" );
    		this.managerunitdn = rs.getString( "ManagerUnitDN" );
    		this.managerunitname = rs.getString( "ManagerUnitName" );
    		this.managerperdn = rs.getString( "ManagerPerDN" );
    		this.managerpername = rs.getString( "ManagerPerName" );
    		this.postname = rs.getString( "PostName" );
    		this.updatedate = rs.getString( "UpdateDate" );
    		
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
    	
    	//找最大序號 start
    	PreparedStatement stmts = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//update
    		stmts = conn.prepareStatement(
    			"update DepartmentManager set ManagerPerDN = ?, ManagerPerName = ?, PostName = ?, UpdateDate = ? where Serno = ? and ManagerUnitDN = ?");
    		   		
    		stmts.setString(1, managerperdn );
    		stmts.setString(2, managerpername );
    		stmts.setString(3, postname );
    		stmts.setString(4, getNowYear() );
    		stmts.setString(5, serno );
    		stmts.setString(6, managerunitdn );
    		
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
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);     		

     		String[] ary_mserno = SvString.split(serno,"||");
     		for ( int i=0; i<ary_mserno.length; i++ ) {
     			String msql = "select * from DepartmentManager where Serno = '" + ary_mserno[i] + "'";
     			stmts = conn.prepareStatement(msql);
        		stmts.clearParameters();
        		rs = stmts.executeQuery();
        		
        		if ( rs.next() ) {
        			//刪除資料
        			String dsql = "delete DepartmentManager where Serno = '" + ary_mserno[i] + "'";
        			
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
		
    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    
             
}
