/*
 * 撰寫日期：2008/2/21
 * 程式名稱：BusinessData.java
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

public class BusinessData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //OrganizeBusiness
    private String serno = null;
    private String pubunitdn = null;
    private String pubunitname = null;
    private String content = null;
    
    //OrganizeDuty
    private String unitdn = null;
    private String unitname = null;
    private String detailno = null;
    private String subject = null;
    private String content1 = null;
    private String postname = null;
    private String updatedate = null;
    
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContent1() {
		return content1;
	}
	public void setContent1(String content1) {
		this.content1 = content1;
	}
	public String getDetailno() {
		return detailno;
	}
	public void setDetailno(String detailno) {
		this.detailno = detailno;
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
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	ResultSet rs1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		stmts = conn.prepareStatement("select * from OrganizeBusiness where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( rs.next() )
    		{
    			stmts = conn.prepareStatement(
        				"update OrganizeBusiness set Content = ?, PostName = ?, UpdateDate = ? where Serno = ? and PubUnitDN = ?" );
        		stmts.clearParameters();    	 	
        		stmts.setString(1, content );
        		stmts.setString(2, postname );
        		stmts.setString(3, getNowYear() );
        		stmts.setString(4, serno );
        		stmts.setString(5, pubunitdn );
        		
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
    		}else{
    			//找最大序號 start(業務簡介)
        		stmts2 = conn.prepareStatement("select max(serno) as seqno from OrganizeBusiness where substring(serno,1,8) = ?" );
        		stmts2.clearParameters();
        		stmts2.setString(1,getNowYear());
        		rs1 = stmts2.executeQuery();
     
        		int tempno = 0;
        		String mserno1 = "";
        		while ( rs1.next() )
        		{
        			String mseq = rs1.getString("seqno");
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
        		
        		//insert OrganizeBusiness(業務簡介)
        		String sql =  "insert into OrganizeBusiness";
        		       sql += "(Serno,PubUnitDN,PubUnitName,Content,PostName,CreateDate,UpdateDate)";
        		       sql += " values(?,?,?,?,?,?,?)";
        		       
        		stmts3 = conn.prepareStatement(sql);
        		
        		stmts3.clearParameters();
        		stmts3.setString(1, serno );
        		stmts3.setString(2, pubunitdn );
        		stmts3.setString(3, pubunitname );
        		stmts3.setString(4, content );
        		stmts3.setString(5, postname );
        		stmts3.setString(6, getNowYear() );
        		stmts3.setString(7, getNowYear() );
        		
        		int updateRow = stmts3.executeUpdate();
        		
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
    		}
    		
    		//業務職掌
    		String[] ary_unitdn = SvString.split(unitdn,"||");
    		String[] ary_unitname = SvString.split(unitname,"||");
    		String[] ary_subject = SvString.split(subject,"||");
    		String[] ary_content1 = SvString.split(content1,"||");

     		//先刪除資料
     		String dsql = "delete OrganizeDuty where PubUnitDN = '" + pubunitdn + "'";
     		
     		stmts1 = conn.prepareStatement(dsql);
     		int updateRow2 = stmts1.executeUpdate();
			if ( updateRow2 < 0 ) 
			{
    			try {
    				conn.rollback();
    				errorMsg = "Delete table fail.";
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}
    		for ( int i=0; i<ary_unitdn.length; i++ ) {
    			//找最大序號 start
        		stmts1 = conn.prepareStatement("select max(serno) as seqno from OrganizeDuty where substring(serno,1,8) = ?" );
        		stmts1.clearParameters();
        		stmts1.setString(1,getNowYear());
        		rs = stmts1.executeQuery();
     
        		int tempno1 = 0;
        		String mserno2 = "";
        		while ( rs.next() )
        		{
        			String mseq = rs.getString("seqno");
        			if ( mseq == null)
        			{
        				mserno2 = SvNumber.format( 1, "0000" );
        				mserno2 = getNowYear() + mserno2;
        			}else{
        				tempno1 = new Integer(mseq.substring(8,12)).intValue()+1;
        				mserno2 = SvNumber.format( tempno1, "0000" );
        				mserno2 = getNowYear()  + mserno2; 
        			}
        			this.serno = mserno2;
        		}
        		//找最大序號 end
        		
        		//insert OrganizeDuty
        		String[] ary_subject1 = SvString.split(ary_subject[i],"&");
        		String[] ary_content2 = SvString.split(ary_content1[i],"&");
        		for ( int j=0; j<ary_subject1.length; j++ ) {
        			String sql1 =  "insert into OrganizeDuty";
        			       sql1 += "(Serno,PubUnitDN,PubUnitName,UnitDN,UnitName,DetailNo,Subject,Content,PostName,CreateDate,UpdateDate)";
        			       sql1 += " values(?,?,?,?,?,?,?,?,?,?,?)";
        			       
        			stmts = conn.prepareStatement(sql1);
        			
        			stmts.clearParameters();
        			stmts.setString(1, serno );
        			stmts.setString(2, pubunitdn );
        			stmts.setString(3, pubunitname );
        			stmts.setString(4, ary_unitdn[i] );
        			stmts.setString(5, ary_unitname[i] );
        			stmts.setInt(6, (j+1) );
        			if ( ary_subject1[j].equals("a") )
        				ary_subject1[j] = "";
        			stmts.setString(7, ary_subject1[j] );
        			if ( ary_content2[j].equals("a") )
        				ary_content2[j] = "";
        			stmts.setString(8, ary_content2[j] );
        			stmts.setString(9, postname );
        			stmts.setString(10, getNowYear() );
        			stmts.setString(11, getNowYear() );
        			
        			int updateRow1 = stmts.executeUpdate();
        			
        			if ( updateRow1 < 0 )  {
        				try {
        					conn.rollback();
        					errorMsg = "Insert into table fail.";
        					System.out.println(errorMsg);
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
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();    			
    			if ( rs1 != null ) rs1.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }

	//查詢多筆資料及筆數
    public ArrayList<Object> findByday( String punit, String unitdn )
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
    		
    		sSql.append( "select * from OrganizeDuty where PubUnitDN = '" + punit + "' and UnitDN = '" + unitdn + "'" );
    		sSql.append( " order by DetailNo" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			BusinessData tmpQuery = new BusinessData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setUnitdn( rs.getString( "UnitDN" ) );
    			tmpQuery.setUnitname( rs.getString( "UnitName" ) );
    			tmpQuery.setDetailno( rs.getString( "DetailNo" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setContent( rs.getString( "Content" ) );
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
        
    //查詢單筆資料
    public boolean load( String punit )
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
    		stmts = conn.prepareStatement("select * from OrganizeBusiness where PubUnitDN = '" + punit + "'");
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
    		this.content = rs.getString( "Content" );
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

	//查詢多筆資料及筆數(查詢有業務執掌資料單位，圖片管理使用business101_pic.jsp)
    public ArrayList<Object> findByday( String pubunitdn )
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
    		
    		sSql.append( "select distinct Serno,PubUnitDN,PubUnitName,UnitDN,UnitName from OrganizeDuty where PubUnitDN = '" + pubunitdn + "'" );
    		sSql.append( " order by UnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			BusinessData tmpQuery = new BusinessData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setUnitdn( rs.getString( "UnitDN" ) );
    			tmpQuery.setUnitname( rs.getString( "UnitName" ) );
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
        
    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    

}
