/*
 * 撰寫日期：2008/3/8
 * 程式名稱：ExamineData.java
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

public class ExamineData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //poster
    private String mserno = null;
    private String mclassname = null;
    private String websitedn = null;
    private String pubwebsitedn = null;
    private String pubwebsitename = null;
    private String websitename = null;
    private String websiteexam = null;
    
    //data
    private String posterdate = null;
    private String closedate = null;
    private String pubunitname = null;
    private String secsubject = null;
    private String content = null;
    private String relateurl = null;
    private String relatename = null;
    private String startusing = null;
    
    //News
    private int fsort = 0;
    private String liaisonper = null;
    private String liaisontel = null;
    private String liaisonemail = null;
    private String language = null;
    
	public String getClosedate() {
		return closedate;
	}
	public void setClosedate(String closedate) {
		this.closedate = closedate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getFsort() {
		return fsort;
	}
	public void setFsort(int fsort) {
		this.fsort = fsort;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getLiaisonemail() {
		return liaisonemail;
	}
	public void setLiaisonemail(String liaisonemail) {
		this.liaisonemail = liaisonemail;
	}
	public String getLiaisonper() {
		return liaisonper;
	}
	public void setLiaisonper(String liaisonper) {
		this.liaisonper = liaisonper;
	}
	public String getLiaisontel() {
		return liaisontel;
	}
	public void setLiaisontel(String liaisontel) {
		this.liaisontel = liaisontel;
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
	public String getPosterdate() {
		return posterdate;
	}
	public void setPosterdate(String posterdate) {
		this.posterdate = posterdate;
	}
	public String getPubunitname() {
		return pubunitname;
	}
	public void setPubunitname(String pubunitname) {
		this.pubunitname = pubunitname;
	}
	public String getPubwebsitedn() {
		return pubwebsitedn;
	}
	public void setPubwebsitedn(String pubwebsitedn) {
		this.pubwebsitedn = pubwebsitedn;
	}
	public String getPubwebsitename() {
		return pubwebsitename;
	}
	public void setPubwebsitename(String pubwebsitename) {
		this.pubwebsitename = pubwebsitename;
	}
	public String getRelatename() {
		return relatename;
	}
	public void setRelatename(String relatename) {
		this.relatename = relatename;
	}
	public String getRelateurl() {
		return relateurl;
	}
	public void setRelateurl(String relateurl) {
		this.relateurl = relateurl;
	}
	public String getSecsubject() {
		return secsubject;
	}
	public void setSecsubject(String secsubject) {
		this.secsubject = secsubject;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
	}
	public String getWebsitedn() {
		return websitedn;
	}
	public void setWebsitedn(String websitedn) {
		this.websitedn = websitedn;
	}
	public String getWebsiteexam() {
		return websiteexam;
	}
	public void setWebsiteexam(String websiteexam) {
		this.websiteexam = websiteexam;
	}
	public String getWebsitename() {
		return websitename;
	}
	public void setWebsitename(String websitename) {
		this.websitename = websitename;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}

	//查詢多筆資料及筆數(尋找待審核資料)
    public ArrayList<Object> findByday( String tablename, String table, String websitedn, String qexamine )
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
    		
    		sSql.append( "select * from " + tablename + " where WebSiteDN = '" + websitedn + "' and PubWebSiteDN in(select WebSiteDN from " + table + " where PubWebSiteDN = '" + websitedn + "' and Flag = 'R' and IsExamine = 'Y')" );
    		if ( qexamine.equals("N") )
    			sSql.append( " and WebSiteExam = '0'" );
    		if ( qexamine.equals("Y") )
    			sSql.append( " and WebSiteExam <> '0'" );
    		sSql.append( " order by UpdateDate desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			ExamineData tmpQuery = new ExamineData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setMserno( rs.getString( "Mserno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
    			tmpQuery.setPubwebsitedn( rs.getString( "PubWebSiteDN" ) );
    			tmpQuery.setPubwebsitename( rs.getString( "PubWebSiteName" ) );
    			tmpQuery.setWebsitedn( rs.getString( "WebSiteDN" ) );
    			tmpQuery.setWebsitename( rs.getString( "WebSiteName" ) );
    			tmpQuery.setWebsiteexam( rs.getString( "WebSiteExam" ) );
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
    
    //查詢單筆資料(標題、發布單位、發布日期)
    public boolean load( String tablename, String serno )
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
    		this.subject = rs.getString( "Subject" );
    		this.pubunitdn = rs.getString( "PubUnitDN" );
    		this.pubunitname = rs.getString( "PubUnitName" );
    		this.posterdate = rs.getString( "PosterDate" );
    		
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
    public boolean loadnews( String tablename, String serno )
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
    		this.subject = rs.getString( "Subject" );
    		this.secsubject = rs.getString( "SecSubject" );
    		this.content = rs.getString( "Content" );
    		this.posterdate = rs.getString( "PosterDate" );
    		this.startusing = rs.getString( "StartUsing" );
    		this.closedate = rs.getString( "CloseDate" );
    		this.relateurl = rs.getString( "RelateUrl" );
    		this.relatename = rs.getString( "RelateName" );
    		
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
    public boolean store( String tablename )
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
    				"update " + tablename + " set WebSiteExam = ?, PostName = ?, UpdateDate = ? where Serno = ? and WebSiteDN = ?" ); 
    		stmts.clearParameters();
    		stmts.setString(1, websiteexam );
    		stmts.setString(2, postname );
    		stmts.setString(3, getNowYear() );
    		stmts.setString(4, serno );
    		stmts.setString(5, websitedn );
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
    
    //修改資料(for 新聞局審核主網新聞)
    public boolean storenews( String tablename )
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
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//update News
    		stmts = conn.prepareStatement(
    			"update News set Subject = ?,SecSubject = ?, Content = ?, PosterDate = ?, RelateUrl = ?, " + 
    			"RelateName = ?, StartUsing = ?, LiaisonPer = ?, LiaisonTel = ?, LiaisonEmail = ?, PostName = ?, UpdateDate = ? where Serno = ? and PubUnitDN = ?");
    		
    		stmts.clearParameters();    	 	
    		stmts.setString(1, subject );
    		stmts.setString(2, secsubject );
    		stmts.setString(3, content );
    		stmts.setString(4, posterdate );
    		stmts.setString(5, relateurl );
    		stmts.setString(6, relatename );
    		stmts.setString(7, startusing );
    		stmts.setString(8, liaisonper );
    		stmts.setString(9, liaisontel );
    		stmts.setString(10, liaisonemail );
    		stmts.setString(11, postname );
    		stmts.setString(12, getNowYear() );
    		stmts.setString(13, serno );
    		stmts.setString(14, pubunitdn );
    		
    		int updateRow = stmts.executeUpdate();
    		
    		if ( updateRow <= 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Update table fail(News).";
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
    		
    		//update審核
    		stmts1 = conn.prepareStatement(
    				"update " + tablename + " set WebSiteExam = ?, PostName = ?, UpdateDate = ? where Serno = ? and WebSiteDN = ?" ); 
    		stmts1.clearParameters();
    		stmts1.setString(1, websiteexam );
    		stmts1.setString(2, postname );
    		stmts1.setString(3, getNowYear() );
    		stmts1.setString(4, serno );
    		stmts1.setString(5, websitedn );
    		
    		int updateRow1 = stmts1.executeUpdate();
    		
    		if ( updateRow1 <= 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Update table fail(Exam).";
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
    			if ( stmts1 != null ) stmts1.close();
      			conn.close();
      		} catch ( SQLException se ) {
      			errorMsg = "close Statment or connection error: " + se.toString();
      		}
      	}
      	return false;
    }
    
    //查詢單筆資料(查詢該筆資料是否已審核)
    public boolean loadexam( String tablename, String websitedn, String serno )
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
    		stmts = conn.prepareStatement("select * from " + tablename + " where Serno = '" + serno + "' and WebSiteDN = '" + websitedn + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.mserno = rs.getString( "Mserno" );
    		this.mclassname = rs.getString( "Mclassname" );
    		this.pubwebsitedn = rs.getString( "PubWebSiteDN" );
    		this.pubwebsitename = rs.getString( "PubWebSiteName" );
    		this.websitedn = rs.getString( "WebSiteDN" );
    		this.websitename = rs.getString( "WebSiteName" );
    		this.websiteexam = rs.getString( "WebSiteExam" );
    		
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
    
    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    
                              
}
