/*
 * 撰寫日期：2010/5/23
 * 程式名稱：PublicInforData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import sysview.zhiren.function.SvNumber;
import sysview.zhiren.function.SvString;

public class PublicInforData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String mserno = null;
    private String mclassname = null;
    private String websitedn = null;
    private String websitename = null;
    private String posterdate = null;
    private String closedate = null;
    private String startusing = null;
    private String flag = null;
    private String relateurl = null;
    private String relatename = null;
    private String clientfile = null;
    private String serverfile = null;
    private String expfile = null;
    private String content = null;
    private int fsort = 0;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    
    private String language = null;
    //Menu
    private String menuserno = null;
    private String topserno = null;
    private String contlink = null;
    private String islevelcontent = null;

	public String getIslevelcontent() {
		return islevelcontent;
	}
	public void setIslevelcontent(String islevelcontent) {
		this.islevelcontent = islevelcontent;
	}
	public String getMenuserno() {
		return menuserno;
	}
	public void setMenuserno(String menuserno) {
		this.menuserno = menuserno;
	}
	public String getTopserno() {
		return topserno;
	}
	public void setTopserno(String topserno) {
		this.topserno = topserno;
	}
	public String getContlink() {
		return contlink;
	}
	public void setContlink(String contlink) {
		this.contlink = contlink;
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
	public String getMserno() {
		return mserno;
	}
	public void setMserno(String mserno) {
		this.mserno = mserno;
	}
	public String getMclassname() {
		return mclassname;
	}
	public void setMclassname(String mclassname) {
		this.mclassname = mclassname;
	}
	public String getWebsitedn() {
		return websitedn;
	}
	public void setWebsitedn(String websitedn) {
		this.websitedn = websitedn;
	}
	public String getWebsitename() {
		return websitename;
	}
	public void setWebsitename(String websitename) {
		this.websitename = websitename;
	}
	public String getPosterdate() {
		return posterdate;
	}
	public void setPosterdate(String posterdate) {
		this.posterdate = posterdate;
	}
	public String getClosedate() {
		return closedate;
	}
	public void setClosedate(String closedate) {
		this.closedate = closedate;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getRelateurl() {
		return relateurl;
	}
	public void setRelateurl(String relateurl) {
		this.relateurl = relateurl;
	}
	public String getRelatename() {
		return relatename;
	}
	public void setRelatename(String relatename) {
		this.relatename = relatename;
	}
	public String getClientfile() {
		return clientfile;
	}
	public void setClientfile(String clientfile) {
		this.clientfile = clientfile;
	}
	public String getServerfile() {
		return serverfile;
	}
	public void setServerfile(String serverfile) {
		this.serverfile = serverfile;
	}
	public String getExpfile() {
		return expfile;
	}
	public void setExpfile(String expfile) {
		this.expfile = expfile;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
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
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	
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
    		String sql =  "insert into " + tablename;
    		       sql += "(Serno,PubUnitDN,PubUnitName,Mserno,Mclassname,Subject,WebSiteDN,WebSiteName,PosterDate,CloseDate,StartUsing,Flag,MenuSerno,RelateUrl,RelateName,ClientFile,ServerFile,ExpFile,Content,Fsort,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		       
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, pubunitdn );
    		stmts2.setString(3, pubunitname );
    		stmts2.setString(4, mserno );
    		stmts2.setString(5, mclassname );
    		stmts2.setString(6, subject );
    		stmts2.setString(7, websitedn );
    		stmts2.setString(8, websitename );
    		stmts2.setString(9, posterdate );
    		stmts2.setString(10, closedate );
    		stmts2.setString(11, startusing );
    		stmts2.setString(12, flag );
    		stmts2.setString(13, menuserno );
    		stmts2.setString(14, relateurl );
    		stmts2.setString(15, relatename );
    		stmts2.setString(16, clientfile );
    		stmts2.setString(17, serverfile );
    		stmts2.setString(18, expfile );
    		stmts2.setString(19, content );
    		stmts2.setInt(20, fsort );
    		stmts2.setString(21, postname );
    		stmts2.setString(22, getNowYear() );
    		stmts2.setString(23, getNowYear() );
    		
    		int updateRow2 = stmts2.executeUpdate();
    		
    		if ( updateRow2 < 0 )
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
    public ArrayList<Object> findByday( String tablename, String keyword, String websitedn, String qclass, String sdate1, String sdate2 )
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
    		
    		sSql.append( "select * from " + tablename + " where WebSiteDN = '" + websitedn + "'" );

    		if ( keyword != null && !keyword.equals("") )  {
    			sSql.append( " and Subject like '%" + keyword + "%'" );
    		}

    		if ( qclass != null && !qclass.equals("") ) {
    			String[] ary_class = SvString.split(qclass,"-");
    			sSql.append( " and Mserno = '" + ary_class[0] + "'" );
    		}	
    		sSql.append( " and PosterDate >= '" + sdate1 + "' and PosterDate <= '" + sdate2 + "'" );

    		sSql.append( " order by UpdateDate desc,Serno desc,PubUnitDN" );
    		System.out.println(sSql.toString());
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PublicInforData tmpQuery = new PublicInforData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setMserno( rs.getString( "Mserno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setWebsitedn( rs.getString( "WebSiteDN" ) );
    			tmpQuery.setWebsitename( rs.getString( "WebSiteName" ) );
    			tmpQuery.setPosterdate( rs.getString( "PosterDate" ) );
    			tmpQuery.setClosedate( rs.getString( "CloseDate" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
    			tmpQuery.setMenuserno( rs.getString( "MenuSerno" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setRelateurl( rs.getString( "RelateUrl" ) );
    			tmpQuery.setRelatename( rs.getString( "RelateName" ) );
    			tmpQuery.setClientfile( rs.getString( "ClientFile" ) );
    			tmpQuery.setServerfile( rs.getString( "ServerFile" ) );
    			tmpQuery.setExpfile( rs.getString( "ExpFile" ) );
    			tmpQuery.setContent( rs.getString( "Content" ) );
    			tmpQuery.setFsort( rs.getInt( "Fsort" ) );
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
    		this.mserno =  rs.getString( "Mserno" );
    		this.mclassname =  rs.getString( "Mclassname" );
    		this.subject = rs.getString( "Subject" );
    		this.websitedn = rs.getString( "WebSiteDN" );
    		this.websitename = rs.getString( "WebSiteName" );    		
    		this.posterdate = rs.getString( "PosterDate" );
    		this.closedate = rs.getString( "CloseDate" );
    		this.startusing = rs.getString( "StartUsing" );
    		this.flag = rs.getString( "Flag" );
    		this.menuserno = rs.getString( "MenuSerno" );
    		this.relateurl = rs.getString( "RelateUrl" );
    		this.relatename = rs.getString( "RelateName" );
    		this.clientfile = rs.getString( "ClientFile" );
    		this.serverfile = rs.getString( "ServerFile" );
    		this.expfile = rs.getString( "ExpFile" );
    		this.content = rs.getString( "Content" );
    		this.fsort = rs.getInt( "Fsort" );
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

    	PreparedStatement stmts = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);

     		stmts = conn.prepareStatement(
	    			"update " + tablename + " set Mserno = ?, Mclassname = ?, Subject = ?, PosterDate = ?, CloseDate = ?, StartUsing = ?, Flag = ?, MenuSerno = ?, RelateUrl = ?, RelateName = ?, ClientFile = ?, ServerFile = ?, ExpFile = ?, Content = ?, Fsort = ?, PostName = ?, UpdateDate = ? where Serno = ? and PubUnitDN = ?");
	    	
     		stmts.setString(1, mserno);
     		stmts.setString(2, mclassname);
     		stmts.setString(3, subject );
     		stmts.setString(4, posterdate );
     		stmts.setString(5, closedate );
     		stmts.setString(6, startusing );
     		stmts.setString(7, flag);
     		stmts.setString(8, menuserno);
     		stmts.setString(9, relateurl );
     		stmts.setString(10, relatename );
     		stmts.setString(11, clientfile );
     		stmts.setString(12, serverfile );
     		stmts.setString(13, expfile );
     		stmts.setString(14, content );
     		stmts.setInt(15, fsort );
     		stmts.setString(16, postname );
     		stmts.setString(17, getNowYear() );
     		stmts.setString(18, serno );
     		stmts.setString(19, pubunitdn );
		    
		    int updateRow = stmts.executeUpdate();
		    
		    if ( updateRow < 0 ) {
		    	try {
		    		conn.rollback();
		    		errorMsg = "Insert into table fail.";
		    		System.out.println("aa="+errorMsg);
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
    			if ( stmts != null ) stmts.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }

    //刪除資料
    public boolean remove( String filepath )
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
            		
            		//刪除檔案
            		if ( rs.getString("ServerFile") != null && !rs.getString("ServerFile").equals("null") ) {
        				File d1 = new File(filepath,rs.getString("ServerFile"));
        			      if (d1.exists()) {
        			    	  d1.delete();
        			      }
        			}
            		
        			//刪除資料
        			String dsql = "delete " + tablename + " where Serno = '" + ary_mserno[i] + "'";
        			
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
    		   if ( stmts2 != null ) stmts2.close();
    		   conn.close();
    	   }catch( SQLException se ) {
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }          		
	
	//查詢第二層以上的資料
    public ArrayList<Object> findByday( String menutable )
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
    		
    		sSql.append( "select * from " + menutable + " where StartUsing = '1' and IsLevel > '1'" );

    		sSql.append( " order by Serno " );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PublicInforData tmpQuery = new PublicInforData();
    			tmpQuery.setMenuserno( rs.getString( "Serno" ) );
    			tmpQuery.setTopserno( rs.getString( "TopSerno" ) );
    			tmpQuery.setContlink( rs.getString( "IsLevelLink" ) );
    			tmpQuery.setIslevelcontent( rs.getString( "IsLevelContent" ) );
    			
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
