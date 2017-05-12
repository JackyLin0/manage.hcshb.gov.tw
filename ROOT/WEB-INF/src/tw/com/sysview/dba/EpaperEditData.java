/*
 * 撰寫日期：2008/3/16
 * 程式名稱：EpaperSendData.java
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

public class EpaperEditData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //EpaperSendMaste(電子報主檔)
    private String periodical = null;
    private String senddate = null;
    private String createdate = null;
    private String updatedate = null;
    private String flag = null;
    private String imgserno = null;
    
    //EpaperSendDetail(電子報明細檔)
    private String ESerno = null;
    private String subject = null;
    private String startdate = null;
    private String enddate = null;
    
    //EpaperDta_view
    private String mserno = null;
    private String mclassname = null;
    
    //EpaperSendFile(電子報圖片檔)
    private String serverfile = "";
    private String clientfile = "";
    private String expfile = "";
    
    private String epaperclass = null;
    private String language = null;
    
    private String allclassname = null;
    private String allcontent = null;
    private String allstartdate = null;
    private String allenddate = null;
    private String oldeserno = null;
    private String oldtablename = null;
    
	public String getImgserno() {
		return imgserno;
	}
	public void setImgserno(String imgserno) {
		this.imgserno = imgserno;
	}
	public String getClientfile() {
		return clientfile;
	}
	public void setClientfile(String clientfile) {
		this.clientfile = clientfile;
	}
	public String getExpfile() {
		return expfile;
	}
	public void setExpfile(String expfile) {
		this.expfile = expfile;
	}
	public String getServerfile() {
		return serverfile;
	}
	public void setServerfile(String serverfile) {
		this.serverfile = serverfile;
	}
	public String getOldeserno() {
		return oldeserno;
	}
	public void setOldeserno(String oldeserno) {
		this.oldeserno = oldeserno;
	}
	public String getOldtablename() {
		return oldtablename;
	}
	public void setOldtablename(String oldtablename) {
		this.oldtablename = oldtablename;
	}
	public String getAllenddate() {
		return allenddate;
	}
	public void setAllenddate(String allenddate) {
		this.allenddate = allenddate;
	}
	public String getAllstartdate() {
		return allstartdate;
	}
	public void setAllstartdate(String allstartdate) {
		this.allstartdate = allstartdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getAllclassname() {
		return allclassname;
	}
	public void setAllclassname(String allclassname) {
		this.allclassname = allclassname;
	}
	public String getAllcontent() {
		return allcontent;
	}
	public void setAllcontent(String allcontent) {
		this.allcontent = allcontent;
	}
	public String getESerno() {
		return ESerno;
	}
	public void setESerno(String serno) {
		ESerno = serno;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getEpaperclass() {
		return epaperclass;
	}
	public void setEpaperclass(String epaperclass) {
		this.epaperclass = epaperclass;
	}
	public String getMclassname() {
		return mclassname;
	}
	public void setMclassname(String mclassname) {
		this.mclassname = mclassname;
	}
	public String getMserno() {
		return mserno;
	}
	public void setMserno(String mserno) {
		this.mserno = mserno;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getPeriodical() {
		return periodical;
	}
	public void setPeriodical(String periodical) {
		this.periodical = periodical;
	}
	public String getSenddate() {
		return senddate;
	}
	public void setSenddate(String senddate) {
		this.senddate = senddate;
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
	
	//查詢多筆資料及筆數(查詢已建立之期刊主檔)
    public ArrayList<Object> findByday( String keyword, String sdate1, String sdate2 )
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
    		
    		sSql.append( "select * from EpaperSendMaster where 1=1" );
    		
    		if ( keyword != null && !keyword.equals("") )  {
    			sSql.append( " and (Subject like '%" + keyword + "%')" );
    		}
    		sSql.append( " and Periodical >= '" + sdate1 + "' and Periodical <= '" + sdate2 + "'" );
    		
    		sSql.append( " order by Periodical desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperEditData tmpQuery = new EpaperEditData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setPeriodical( rs.getString( "Periodical" ) );
    			tmpQuery.setSenddate( rs.getString( "SendDate" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
    			tmpQuery.setCreatedate( rs.getString( "CreateDate" ) );
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
	
	//查詢多筆資料及筆數(查詢有資料之類別-for add使用)
    public ArrayList<Object> findByclass()
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
    		
    		sSql.append( "select distinct(Mserno) as mserno,Mclassname from EpaperData_view where EpaperFlag is null" );
    		
    		sSql.append( " order by Mserno desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperEditData tmpQuery = new EpaperEditData();
    			tmpQuery.setMserno( rs.getString( "mserno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
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

	//新增資料(insert EpaperSendMaster-for add使用)
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
    	ResultSet rs2 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		stmts = conn.prepareStatement("select * from EpaperSendMaster where Periodical = '" + periodical + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( rs.next() )
    		{
    			if ( rs.getString( "SendDate" ) != null && !rs.getString( "SendDate" ).equals("null") ) {
    				errorMsg = "此期刊已存在，請使用修改方式！";
    				return false;
    			}
    			this.serno = rs.getString( "Serno" );
    			//update
        		stmts1 = conn.prepareStatement(
        			"update EpaperSendMaster set PubUnitDN = ?, PubUnitName = ?, Subject = ?, PostName = ?, UpdateDate = ? where Periodical = ?");
        		   		
        		stmts1.setString(1, pubunitdn );
        		stmts1.setString(2, pubunitname );
        		stmts1.setString(3, subject );
        		stmts1.setString(4, postname );
        		stmts1.setString(5, getNowYear() );
        		stmts1.setString(6, periodical );
        		
        		int updateRow1 = stmts1.executeUpdate();
        		
        		if ( updateRow1 < 0 )
        		{
        			try {
        				conn.rollback();
        				errorMsg = "Insert into table fail(EpaperSendMaster).";
        				System.out.println(errorMsg);
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
        		}
        		
        		//刪除資料(刪除EpaperEditClass)
    			String dsql = "delete EpaperSendClass where Serno = '" + rs.getString( "Serno" ) + "'";
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
        		
    		}else{
    			//找最大序號 start
        		stmts2 = conn.prepareStatement("select max(serno) as seqno from EpaperSendMaster where substring(serno,1,8) = ?" );
        		stmts2.clearParameters();
        		stmts2.setString(1,getNowYear());
        		rs2 = stmts2.executeQuery();
     
        		int tempno = 0;
        		String mserno1 = "";
        		while ( rs2.next() )
        		{
        			String mseq = rs2.getString("seqno");
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
        		
        		//insert EpaperSendMaster
        		String sql =  "insert into EpaperSendMaster";
        		       sql += "(Serno,PubUnitDN,PubUnitName,Subject,Periodical,Flag,PostName,CreateDate,UpdateDate)";
        		       sql += " values(?,?,?,?,?,?,?,?,?)";
        		
        		stmts3 = conn.prepareStatement(sql);
        		
        		stmts3.clearParameters();
        		stmts3.setString(1, serno );
        		stmts3.setString(2, pubunitdn );
        		stmts3.setString(3, pubunitname );
        		stmts3.setString(4, subject );
        		stmts3.setString(5, periodical );
        		stmts3.setString(6, "未派送" );
        		stmts3.setString(7, postname );
        		stmts3.setString(8, getNowYear() );
        		stmts3.setString(9, getNowYear() );
        		
        		int updateRow3 = stmts3.executeUpdate();
        		
        		if ( updateRow3 < 0 )
        		{
        			try {
        				conn.rollback();
        				errorMsg = "Insert into table fail(EpaperSendMaster).";
        				System.out.println(errorMsg);
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
        		}
    		}
    		
    		String[] ary_epaperclass = SvString.split(epaperclass,"&");
    		for ( int i=0; i<ary_epaperclass.length; i++ ) {
        		String[] ary_mserno = SvString.split(ary_epaperclass[i],"||");
    			//insert EpaperSendClass
        		String msql =  "insert into EpaperSendClass";
        		       msql += "(Serno,Mserno,Mclassname,PostName,CreateDate,UpdateDate)";
        		       msql += " values(?,?,?,?,?,?)";
        		
        		stmts4 = conn.prepareStatement(msql);
        		
        		stmts4.clearParameters();
        		stmts4.setString(1, serno );
        		stmts4.setString(2, ary_mserno[0] );
        		stmts4.setString(3, ary_mserno[1] );
        		stmts4.setString(4, postname );
        		stmts4.setString(5, getNowYear() );
        		stmts4.setString(6, getNowYear() );
        		
        		int updateRow4 = stmts4.executeUpdate();
        		
        		if ( updateRow4 < 0 )
        		{
        			try {
        				conn.rollback();
        				errorMsg = "Insert into table fail(InformationItem).";
        				System.out.println(errorMsg);
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
        		}
    		}
    		
    		//網站維運統計共用參數(WebSiteLog)
    		if ( !createlog(conn,language) )  {
    			try {
    				conn.rollback();
    				errorMsg = "Insert into table fail(WebSiteLog).";
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
    			if ( rs2 != null ) rs2.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			if ( stmts4 != null ) stmts4.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
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
    		stmts = conn.prepareStatement("select * from EpaperSendMaster where Serno = '" + serno + "'");
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
    		this.subject = rs.getString( "Subject" );
    		this.senddate = rs.getString( "SendDate" );
    		this.imgserno = rs.getString( "ImgSerno" );
    		this.periodical = rs.getString( "Periodical" );
    		
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
	
	//查詢多筆資料及筆數(查詢選用之類別)
    public ArrayList<Object> findByclass( String serno )
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
    		
    		sSql.append( "select * from EpaperSendClass where Serno = '" + serno + "'" );
    		
    		sSql.append( " order by Mserno desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperEditData tmpQuery = new EpaperEditData();
    			tmpQuery.setSerno( rs.getString( "serno" ) );
    			tmpQuery.setMserno( rs.getString( "MSerno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
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
	
	//查詢多筆資料及筆數(未被電子報引用資料)
    public ArrayList<Object> findByday( String mserno )
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
    		
    		sSql.append( "select * from EpaperData_view where Serno not in(select ESerno from EpaperSendDetail) and Mserno = '" + mserno + "'" );
    		
    		sSql.append( " order by Serno desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperEditData tmpQuery = new EpaperEditData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setMserno( rs.getString( "Mserno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setTablename( rs.getString( "TableName" ) );
    			
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
    public boolean loadclass( String serno )
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
    		stmts = conn.prepareStatement("select ClassName from EpaperClass where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.mclassname = rs.getString( "classname" );
    		
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

	//新增資料(insert EpaperSendDetail)
    public boolean createdetail()
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
    	
    	Connection conn1 = null;
    	try
    	{
    		//連結資料庫
    		conn1 = tw.com.sysview.dba.DbConnection.getConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	} 
    	
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		stmts = conn.prepareStatement("select * from EpaperSendDetail where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( rs.next() )
    		{
    			//刪除資料(刪除EpaperEditDetail)
    			String dsql = "delete EpaperSendDetail where Serno = '" + serno + "'";
    			stmts1 = conn.prepareStatement(dsql);
    			int updateRow1 = stmts1.executeUpdate();
    			if ( updateRow1 <= 0 ) 
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
			
    		String[] ary_allclassname = SvString.split(allclassname,"&");
    		String[] ary_allcontent = SvString.split(allcontent,"&");
    		String[] ary_startdate = SvString.split(allstartdate,"&");
    		String[] ary_enddate = SvString.split(allenddate,"&");
    		for ( int i=0; i<ary_allclassname.length; i++ ) {
    			String[] ary_classname = SvString.split(ary_allclassname[i],"||");
    			String[] ary_mcontent = SvString.split(ary_allcontent[i],"||");
    			String mstartdate = "";
    			String menddate = "";
    			if ( !ary_startdate[i].equals("a") )
    				mstartdate = ary_startdate[i];
    			if ( !ary_enddate[i].equals("a") )
    				menddate = ary_enddate[i];
    			
    			for ( int j=0; j<ary_mcontent.length; j++ ) {
    				String[] ary_content = new String[2];
    				if ( ary_mcontent[j].equals("a") ) {
    					ary_content[0] = serno;
    					ary_content[1] = "";
    				}else{
    					ary_content = SvString.split(ary_mcontent[j],"|");
    				}
    				
    				String mtablename = getTableName(ary_content[0],ary_classname[0]);
    				if ( mtablename == null || mtablename.equals("null") ) {
    					if ( ary_content[0].equals(serno) )
    						mtablename = "Activities";
    				}
    				//insert EpaperSendDetail
            		String sql =  "insert into EpaperSendDetail";
            		       sql += "(Serno,Eserno,Mserno,Mclassname,Subject,TableName,StartDate,EndDate)";
            		       sql += " values(?,?,?,?,?,?,?,?)";
            		
            		stmts2 = conn.prepareStatement(sql);
            		
            		stmts2.clearParameters();
            		stmts2.setString(1, serno );
            		stmts2.setString(2, ary_content[0] );
            		stmts2.setString(3, ary_classname[0] );
            		stmts2.setString(4, ary_classname[1] );
            		stmts2.setString(5, ary_content[1] );
            		stmts2.setString(6, mtablename );
            		stmts2.setString(7, mstartdate );
            		stmts2.setString(8, menddate );
            		
            		int updateRow2 = stmts2.executeUpdate();
            		
            		if ( updateRow2 < 0 )
            		{
            			try {
            				conn.rollback();
            				errorMsg = "Insert into table fail(EpaperSendDetail).";
            				System.out.println(errorMsg);
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            }
            		}

            		//update(EpaperFlag='Y')
            		if ( !mtablename.equals("Activities") ) {
            			stmts3 = conn1.prepareStatement(
                    			"update " + mtablename + " set EpaperFlag = ? where Serno = ?");
                    	
            			stmts3.setString(1, "Y" );
            			stmts3.setString(2, ary_content[0] );
            			
            			int updateRow3 = stmts3.executeUpdate();
            			if ( updateRow3 < 0 )  {
            				try {
            					conn1.rollback();
            					errorMsg = "update table fail(EpaperSendMaster).";
            					System.out.println(errorMsg);
            					return false;
            				}catch(Exception backerr){
            					System.out.println("rollback faild!");
            				}
            			}
            		}
    			}
    		}
    		
    		//update(派送日期)
    		stmts4 = conn.prepareStatement(
    			"update EpaperSendMaster set SendDate = ?, ImgSerno = ? where Serno = ? and Periodical = ?");
    		   		
    		stmts4.setString(1, senddate );
    		stmts4.setString(2, imgserno );
    		stmts4.setString(3, serno );
    		stmts4.setString(4, periodical );
    		
    		int updateRow4 = stmts4.executeUpdate();
    		
    		if ( updateRow4 < 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "update table fail(EpaperSendMaster).";
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
    		System.out.println("errorMsg="+errorMsg);
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			if ( stmts4 != null ) stmts4.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
    
    //取tablename
    private String getTableName( String serno, String mserno )
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
    	
    	String mtablename = "";
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	try
    	{
    		stmts = conn.prepareStatement("select TableName from EpaperData_View where Serno = '" + serno + "' and Mserno = '" + mserno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return null;
    		}
    		mtablename = rs.getString( "TableName" );
    		
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
    	return mtablename;
    }
	
	//查詢多筆資料及筆數(查詢全部類別-for mdy使用)
    public ArrayList<Object> findByallclass( String mserno )
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
    		String[] ary_mserno = SvString.split(mserno,"||");
    		sSql.append( "select distinct(Mserno) as mserno,Mclassname from EpaperData_view where" );
    		for ( int i=0; i<ary_mserno.length; i++ ) {
    			if ( i == 0 ) {
    				sSql.append( " ( Mserno = '" + ary_mserno[i] + "'" );
    			}else{
    				sSql.append( " or Mserno = '" + ary_mserno[i] + "'" );
    			}
    		}
    		sSql.append( " or EpaperFlag is null )" );
    		
    		sSql.append( " order by Mserno desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperEditData tmpQuery = new EpaperEditData();
    			tmpQuery.setMserno( rs.getString( "mserno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
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

	//修改資料(insert EpaperSendMaster-for mdy使用)
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
    	
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		stmts = conn.prepareStatement("select * from EpaperSendMaster where Periodical = '" + periodical + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( rs.next() )
    		{
    			this.serno = rs.getString( "Serno" );
    			//update
        		stmts1 = conn.prepareStatement(
        			"update EpaperSendMaster set PubUnitDN = ?, PubUnitName = ?, Subject = ?, PostName = ?, UpdateDate = ? where Periodical = ?");
        		   		
        		stmts1.setString(1, pubunitdn );
        		stmts1.setString(2, pubunitname );
        		stmts1.setString(3, subject );
        		stmts1.setString(4, postname );
        		stmts1.setString(5, getNowYear() );
        		stmts1.setString(6, periodical );
        		
        		int updateRow1 = stmts1.executeUpdate();
        		
        		if ( updateRow1 < 0 )
        		{
        			try {
        				conn.rollback();
        				errorMsg = "Insert into table fail(EpaperSendMaster).";
        				System.out.println(errorMsg);
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
        		}
        		
        		//刪除資料(刪除EpaperEditClass)
    			String dsql = "delete EpaperSendClass where Serno = '" + this.serno + "'";
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
    			
    			String[] ary_epaperclass = SvString.split(epaperclass,"&");
        		for ( int i=0; i<ary_epaperclass.length; i++ ) {
            		String[] ary_mserno = SvString.split(ary_epaperclass[i],"||");
            		
        			//insert EpaperSendClass
            		String msql =  "insert into EpaperSendClass";
            		       msql += "(Serno,Mserno,Mclassname,PostName,CreateDate,UpdateDate)";
            		       msql += " values(?,?,?,?,?,?)";
            		
            		stmts3 = conn.prepareStatement(msql);
            		
            		stmts3.clearParameters();
            		stmts3.setString(1, serno );
            		stmts3.setString(2, ary_mserno[0] );
            		stmts3.setString(3, ary_mserno[1] );
            		stmts3.setString(4, postname );
            		stmts3.setString(5, getNowYear() );
            		stmts3.setString(6, getNowYear() );
            		
            		int updateRow3 = stmts3.executeUpdate();
            		
            		if ( updateRow3 < 0 )
            		{
            			try {
            				conn.rollback();
            				errorMsg = "Insert into table fail(InformationItem).";
            				System.out.println(errorMsg);
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            }
            		}
        		}
        		
        		//網站維運統計共用參數(WebSiteLog)
        		if ( !createlog(conn,language) )  {
        			try {
        				conn.rollback();
        				errorMsg = "Insert into table fail(WebSiteLog).";
        				return false;
        			}catch(Exception backerr){
        				System.out.println("rollback faild!");
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
	
	//查詢多筆資料及筆數(search EpaperSendDetail-for mdy使用)
    public ArrayList<Object> findBydetail( String serno, String mserno )
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
    		
    		sSql.append( "select * from EpaperSendDetail where Serno = '" + serno + "' and Mserno = '" + mserno + "'" );
    		
    		sSql.append( " order by Serno desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperEditData tmpQuery = new EpaperEditData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setESerno( rs.getString( "ESerno" ) );
    			tmpQuery.setMserno( rs.getString( "Mserno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setTablename( rs.getString( "TableName" ) );
    			tmpQuery.setStartdate( rs.getString( "StartDate" ) );
    			tmpQuery.setEnddate( rs.getString( "EndDate" ) );
    			
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
	
	//查詢多筆資料及筆數(search EpaperData_view-for mdy使用)
    public ArrayList<Object> findBydetail1( String mserno, String eserno )
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
    		String[] ary_eserno = SvString.split(eserno,"||");
    		sSql.append( "select * from EpaperData_View where " );
    		for ( int i=0; i<ary_eserno.length; i++ ) {
    			if ( i == 0 ){
    				sSql.append( " (Serno = '" + ary_eserno[i] + "'" );
    			}else{
    				sSql.append( " or Serno = '" + ary_eserno[i] + "'" );
    			}
    		}
    		sSql.append( " or Serno not in(select ESerno from EpaperSendDetail))" );
    		sSql.append( " and Mserno = '" + mserno + "'" );
    		sSql.append( " order by Serno desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperEditData tmpQuery = new EpaperEditData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setMserno( rs.getString( "Mserno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setTablename( rs.getString( "TableName" ) );
    			
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

	//修改資料(insert EpaperSendDetail)
    public boolean storedetail()
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

		Connection conn1 = null;
    	try
    	{
    		//連結資料庫
    		conn1 = tw.com.sysview.dba.DbConnection.getConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}  
    	
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;   
    	PreparedStatement stmts4 = null;
    	PreparedStatement stmts5 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);

			if ( oldeserno != null && !oldeserno.equals("null") && !oldeserno.equals("") ) {	    	
				String[] ary_oldeserno = SvString.split(oldeserno,"||");
				String[] ary_oldtablename = SvString.split(oldtablename,"||");
				
				for ( int i=0; i<ary_oldeserno.length; i++ ) {					
					//update(EpaperFlag='null')
            		if ( !ary_oldtablename[i].equals("Activities") ) {
            			String eserno1 = ary_oldeserno[i];
            			String mtablename = ary_oldtablename[i];
            			stmts5 = conn1.prepareStatement(
                    			"update " + mtablename + " set EpaperFlag = ? where Serno = ?");
                    	
            			stmts5.setString(1, null );
            			stmts5.setString(2, eserno1 );
            			
            			int updateRow5 = stmts5.executeUpdate();
            			if ( updateRow5 < 0 )  {
            				try {
            					conn1.rollback();
            					errorMsg = "Insert into table fail.";
            					System.out.println(errorMsg);
            					return false;
            				}catch(Exception backerr){
            					System.out.println("rollback faild!");
            				}
            			}
            		}
				}
			}
			
     		stmts = conn.prepareStatement("select * from EpaperSendDetail where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( rs.next() )
    		{
    			//刪除資料(刪除EpaperEditDetail)
    			String dsql = "delete EpaperSendDetail where Serno = '" + serno + "'";
    			stmts1 = conn.prepareStatement(dsql);
    			int updateRow1 = stmts1.executeUpdate();
    			if ( updateRow1 <= 0 ) 
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
    		String[] ary_allclassname = SvString.split(allclassname,"&");
    		String[] ary_allcontent = SvString.split(allcontent,"&");
    		String[] ary_startdate = SvString.split(allstartdate,"&");
    		String[] ary_enddate = SvString.split(allenddate,"&");
    		for ( int i=0; i<ary_allclassname.length; i++ ) {
    			String[] ary_classname = SvString.split(ary_allclassname[i],"||");
    			String[] ary_mcontent = SvString.split(ary_allcontent[i],"||");
    			String mstartdate = "";
    			String menddate = "";
    			if ( !ary_startdate[i].equals("a") )
    				mstartdate = ary_startdate[i];
    			if ( !ary_enddate[i].equals("a") )
    				menddate = ary_enddate[i];
    			
    			for ( int j=0; j<ary_mcontent.length; j++ ) {
    				String[] ary_content = new String[2];
    				if ( ary_mcontent[j].equals("a") ) {
    					ary_content[0] = serno;
    					ary_content[1] = "";
    				}else{
    					ary_content = SvString.split(ary_mcontent[j],"|");
    				}
    				
    				String mtablename = getTableName(ary_content[0],ary_classname[0]);
    				if ( mtablename == null || mtablename.equals("null") ) {
    					if ( ary_content[0].equals(serno) )
    						mtablename = "Activities";
    				}
    				//insert EpaperSendDetail
            		String sql =  "insert into EpaperSendDetail";
            		       sql += "(Serno,Eserno,Mserno,Mclassname,Subject,TableName,StartDate,EndDate)";
            		       sql += " values(?,?,?,?,?,?,?,?)";
            		
            		stmts2 = conn.prepareStatement(sql);
            		
            		stmts2.clearParameters();
            		stmts2.setString(1, serno );
            		stmts2.setString(2, ary_content[0] );
            		stmts2.setString(3, ary_classname[0] );
            		stmts2.setString(4, ary_classname[1] );
            		stmts2.setString(5, ary_content[1] );
            		stmts2.setString(6, mtablename );
            		stmts2.setString(7, mstartdate );
            		stmts2.setString(8, menddate );
            		
            		int updateRow2 = stmts2.executeUpdate();
            		
            		if ( updateRow2 < 0 )
            		{
            			try {
            				conn.rollback();
            				errorMsg = "Insert into table fail(EpaperSendMaster).";
            				System.out.println(errorMsg);
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            }
            		}

            		//update(EpaperFlag='Y')
            		if ( !mtablename.equals("Activities") ) {
            			stmts3 = conn1.prepareStatement(
                    			"update " + mtablename + " set EpaperFlag = ? where Serno = ?");
                    	
            			stmts3.setString(1, "Y" );
            			stmts3.setString(2, ary_content[0] );
            			
            			int updateRow3 = stmts3.executeUpdate();
            			if ( updateRow3 < 0 )  {
            				try {
            					conn1.rollback();
            					errorMsg = "Insert into table fail.";
            					System.out.println(errorMsg);
            					return false;
            				}catch(Exception backerr){
            					System.out.println("rollback faild!");
            				}
            			}
            		}
    			}
    		}
    		
    		//update(派送日期)
    		stmts4 = conn.prepareStatement(
    			"update EpaperSendMaster set SendDate = ?, ImgSerno = ? where Serno = ? and Periodical = ?");
    		   		
    		stmts4.setString(1, senddate );
    		stmts4.setString(2, imgserno );
    		stmts4.setString(3, serno );
    		stmts4.setString(4, periodical );
    		
    		int updateRow4 = stmts4.executeUpdate();
    		
    		if ( updateRow4 < 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Insert into table fail(EpaperSendMaster).";
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
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			if ( stmts4 != null ) stmts4.close();
    			if ( stmts5 != null ) stmts5.close();
    			conn.close();
    			conn1.close();
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
    	ResultSet rs3 = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);

     		String[] ary_mserno = SvString.split(serno,"||");
     		
     		for ( int i=0; i<ary_mserno.length; i++ ) {
     			String msql = "select * from " + tablename + " where Serno = '" + ary_mserno[i] + "'";
     			stmts = conn.prepareStatement(msql);
        		stmts.clearParameters();
        		rs = stmts.executeQuery();
        		
        		if ( rs.next() ) {
        			this.setSerno(rs.getString( "Serno" ));
        			this.setPubunitdn(rs.getString( "PubUnitDN" ));
        			this.setPubunitname(rs.getString( "PubUnitName" ));
        			this.setSubject(rs.getString( "Subject" ));
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

        			//刪除資料(delete EpaperSendMaster)
        			String dsql = "delete EpaperSendMaster where Serno = '" + ary_mserno[i] + "'";
        			
        			stmts1 = conn.prepareStatement(dsql);
        			int updateRow = stmts1.executeUpdate();
        			if ( updateRow <= 0 ) 
        			{
            			try {
            				conn.rollback();
            				errorMsg = "Delete table fail(EpaperSendMaster).";
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            }
            		}

        			//刪除資料(delete EpaperSendClass)
        			String dsql1 = "delete EpaperSendClass where Serno = '" + ary_mserno[i] + "'";
        			
        			stmts2 = conn.prepareStatement(dsql1);
        			int updateRow2 = stmts2.executeUpdate();
        			if ( updateRow2 <= 0 ) 
        			{
            			try {
            				conn.rollback();
            				errorMsg = "Delete table fail(EpaperSendClass).";
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            }
            		}
        			
        			//修改資料
        			String msql1 = "select * from EpaperSendDetail where Serno = '" + ary_mserno[i] + "'";
         			stmts3 = conn.prepareStatement(msql1);
            		stmts3.clearParameters();
            		rs3 = stmts3.executeQuery();
            		
            		String oldeserno = "";
            		String oldtablename = "";
            		while ( rs3.next() ) {
            			if ( oldeserno.equals("") ) {
            				oldeserno = rs3.getString( "ESerno" );
            				oldtablename = rs3.getString( "TableName" );
            			}else{
            				oldeserno = oldeserno + "||" + rs3.getString( "ESerno" );
            				oldtablename = oldtablename + "||" + rs3.getString( "TableName" );
            			}
            		}
            		
            		if ( !oldeserno.equals("") ) {
            			PreparedStatement stmts5 = null;
        				Connection conn1 = null;
        		    	try
        		    	{
        		    		//連結資料庫
        		    		conn1 = tw.com.sysview.dba.DbConnection.getConnection();
        		    	} catch ( Exception e ) {
        		    		errorMsg = "Get DataSource or Connection error: " + e.toString();
        		    		return false;
        		    	}    	
        		    	
                		String[] ary_oldeserno = SvString.split(oldeserno,"||");
        				String[] ary_oldtablename = SvString.split(oldtablename,"||");
        				for ( int j=0; j<ary_oldeserno.length; j++ ) {
        					//update(EpaperFlag='Y')
                    		if ( !ary_oldtablename[j].equals("Activities") ) {
                    			String eserno1 = ary_oldeserno[j];
                    			String mtablename = ary_oldtablename[j];
                    			stmts5 = conn1.prepareStatement(
                            			"update " + mtablename + " set EpaperFlag = ? where Serno = ?");
                            	
                    			stmts5.setString(1, null );
                    			stmts5.setString(2, eserno1 );
                    			
                    			int updateRow5 = stmts5.executeUpdate();
                    			
                    			if ( updateRow5 < 0 )  {
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
        				if ( stmts5 != null ) stmts5.close();
        				conn1.close();
            		}

        			//刪除資料(delete EpaperSendDetail)
        			String dsql4 = "delete EpaperSendDetail where Serno = '" + ary_mserno[i] + "'";
        			
        			stmts4 = conn.prepareStatement(dsql4);
        			int updateRow4 = stmts4.executeUpdate();
        			if ( updateRow4 < 0 ) 
        			{
            			try {
            				conn.rollback();
            				errorMsg = "Delete table fail(EpaperSendClass).";
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
    		   if ( rs3 != null ) rs3.close();
    		   if ( stmts != null ) stmts.close();
    		   if ( stmts1 != null ) stmts1.close();
    		   if ( stmts2 != null ) stmts2.close();
    		   if ( stmts3 != null ) stmts3.close();
    		   if ( stmts4 != null ) stmts4.close();
    		   conn.close();
    	   }catch( SQLException se ) {
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }          		
	
	//查詢多筆資料及筆數(查詢電子報logo圖片檔)
    public ArrayList<Object> findBylogoimg()
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
    		
    		sSql.append( "select * from EpaperSendFile order by Serno desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperEditData tmpQuery = new EpaperEditData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setClientfile( rs.getString( "ClientFile" ) );
    			tmpQuery.setServerfile( rs.getString( "ServerFile" ) );
    			tmpQuery.setExpfile( rs.getString( "ExpFile" ) );
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
