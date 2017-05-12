/*
 * 撰寫日期：2010/5/23
 * 程式名稱：PublicInforClassData.java
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

public class PublicInforClassData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;

    private String classname = null;
    private String createdate = null;
    private String updatedate = null;
    private String language = null;
    
	public String getClassname() {
		return classname;
	}
	public void setClassname(String classname) {
		this.classname = classname;
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
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
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
    	PreparedStatement stmts = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//找最大序號 start
    		stmts = conn.prepareStatement("select max(serno) as seqno from " + tablename + " where substring(serno,1,8) = ?" );
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
    				mserno = SvNumber.format( 1, "0000" );
    				mserno = getNowYear() + mserno;
    			}else{
    				tempno = new Integer(mseq.substring(8,12)).intValue()+1;
    				mserno = SvNumber.format( tempno, "0000" );
    				mserno = getNowYear()  + mserno; 
    			}
    			this.serno = mserno;
    		}
    		//找最大序號 end
    		
    		//insert
    		String sql =  "insert into " + tablename;
    		       sql += "(Serno,PubUnitDN,PubUnitName,ClassName,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?)";
    		       
    		stmts = conn.prepareStatement(sql);
    		
    		stmts.clearParameters();
    		stmts.setString(1, serno );
    		stmts.setString(2, pubunitdn );
    		stmts.setString(3, pubunitname );
    		stmts.setString(4, classname );
    		stmts.setString(5, postname );
    		stmts.setString(6, getNowYear() );
    		stmts.setString(7, getNowYear() );
    		
    		int updateRow = stmts.executeUpdate();
    		
    		if ( updateRow <= 0 )
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
    		
    		//網站維運統計共用參數(WebSiteLog)
    		if ( !createlog(conn,language) )  {
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

	//查詢多筆資料及筆數
    public ArrayList<Object> findByday( String tablename, String classname )
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
    		
    		if ( classname != null && !classname.equals("") )
    			sSql.append( " and ClassName like '%" + classname + "%'" );

    		sSql.append( " order by UpdateDate desc,Serno,PubUnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PublicInforClassData tmpQuery = new PublicInforClassData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setClassname( rs.getString( "ClassName" ) );
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

    //查詢單筆資料
    public boolean load( String serno, String tablename )
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
    		stmts = conn.prepareStatement("select * from " + tablename + " where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.pubunitdn = rs.getString( "PubUnitDN" );
    		this.pubunitname = rs.getString( "PubUnitName" );
    		this.classname = rs.getString( "ClassName" );
    		this.postname = rs.getString( "PostName" );
    		
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
    				"update " + tablename + " set ClassName = ?, UpdateDate = ? where Serno = ?" ); 
    		stmts.clearParameters();    	 	
    		stmts.setString(1, classname );
    		stmts.setString(2, getNowYear() );
    		stmts.setString(3, serno );
    		
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
    		
    		//網站維運統計共用參數(WebSiteLog)
    		if ( !createlog(conn,language) ) {
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
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);

     		String finddata = "";
     		String[] ary_mserno = SvString.split(serno,"||");
     		for ( int i=0; i<ary_mserno.length; i++ ) {
     			String classdata = "N";
     			//判斷資料表是否存在
     			ResultSet rs2  = conn.getMetaData().getTables(null, null,  "PublicInfor", null );
     			if ( rs2.next() ) {
     				System.out.println(rs2.next());
     				//先找出此分類是否已被使用(資料檔)
         			String msql2 = "select * from PublicInfor where Mserno = '" + ary_mserno[i] + "'";     			
         			stmts = conn.prepareStatement(msql2);
            		stmts.clearParameters();
            		rs = stmts.executeQuery();
            		if ( rs.next() ) {
            			classdata = "Y";
            			if ( finddata.equals("") )
            				finddata = rs1.getString("Mclassname");
            			else
            				finddata = finddata + "，" + rs1.getString("Mclassname");
            		}
     			}
     			
     			if ( !rs2.next() || classdata.equals("N") ) {
     				String msql = "select * from " + tablename + " where Serno = '" + ary_mserno[i] + "'";
         			stmts1 = conn.prepareStatement(msql);
            		stmts1.clearParameters();
            		rs1 = stmts1.executeQuery();
            		
            		if ( rs1.next() ) {
            			this.setSerno(rs1.getString( "Serno" ));
            			this.setPubunitdn(rs1.getString( "PubUnitDN" ));
            			this.setPubunitname(rs1.getString( "PubUnitName" ));
            			this.setSubject(rs1.getString( "Classname" ));
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
            			String dsql = "delete " + tablename + " where Serno = '" + ary_mserno[i] + "'";
            			
            			stmts2 = conn.prepareStatement(dsql);
            			int updateRow2 = stmts2.executeUpdate();
            			if ( updateRow2 <= 0 ) 
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
     		}
     		
     		errorMsg = finddata;
     		conn.commit();
       	  	conn.setAutoCommit(true);
    		
    		return true;
  
       }catch( SQLException sqle ) { 
           errorMsg = "delete data error: " + sqle.toString();
       }finally{
    	   try {
    		   if ( stmts != null ) stmts.close();
    		   if ( stmts1 != null ) stmts1.close();
    		   if ( stmts2 != null ) stmts2.close();
    		   if ( rs != null ) rs.close();
    		   if ( rs1 != null ) rs1.close();
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
