/*
 * 撰寫日期：2008/2/17
 * 程式名稱：WeblinkData.java
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

public class WeblinkData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //資料檔
    private String secsubject = null;
    private String closedate = null;
    private String startusing = null;
    private String relateurl = null;
    private String relatename = null;
    private int fsort = 0;
    private String updatedate = null;
    private String websitedata = null;
    private String webclassdata = null;
    private String aptable = null;
    private String aplistdn = null;
    private String examtable = null;
    private String language = null;
    
    //多向發布檔
    private String mserno = null;
    private String mclassname = null;
    private String websitedn = null;
    private String websitename = null;
    
	public String getSecsubject() {
		return secsubject;
	}
	public void setSecsubject(String secsubject) {
		this.secsubject = secsubject;
	}
	public String getAplistdn() {
		return aplistdn;
	}
	public void setAplistdn(String aplistdn) {
		this.aplistdn = aplistdn;
	}
	public String getAptable() {
		return aptable;
	}
	public void setAptable(String aptable) {
		this.aptable = aptable;
	}
	public String getClosedate() {
		return closedate;
	}
	public void setClosedate(String closedate) {
		this.closedate = closedate;
	}
	public String getExamtable() {
		return examtable;
	}
	public void setExamtable(String examtable) {
		this.examtable = examtable;
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
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getWebclassdata() {
		return webclassdata;
	}
	public void setWebclassdata(String webclassdata) {
		this.webclassdata = webclassdata;
	}
	public String getWebsitedata() {
		return websitedata;
	}
	public void setWebsitedata(String websitedata) {
		this.websitedata = websitedata;
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
    	
    	/*
    	 * ary_aptable[0]：分類檔
    	 * ary_aptable[1]：資料檔
    	 * ary_aptable[2]：發布站台檔
    	 * examtable：資料審核檔
    	 * aplistdn：應用系統DN
    	 */
    	String[] ary_aptable = SvString.split(aptable,"||");
    	
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
    		stmts = conn.prepareStatement("select max(Serno) as seqno from " + ary_aptable[1] + " where substring(Serno,1,8) = ?" );
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
    		
    		//inser into 資料檔
    		String sql =  "insert into " + ary_aptable[1];
    		       sql += "(Serno,PubUnitDN,PubUnitName,Subject,SecSubject,CloseDate,StartUsing,RelateUrl,RelateName,Fsort,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		      
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, pubunitdn );
    		stmts2.setString(3, pubunitname );
    		stmts2.setString(4, subject );
    		stmts2.setString(5, secsubject );
    		stmts2.setString(6, closedate );
    		stmts2.setString(7, startusing );
    		stmts2.setString(8, relateurl );
    		stmts2.setString(9, relatename );
    		stmts2.setInt(10, fsort );
    		stmts2.setString(11, postname );
    		stmts2.setString(12, getNowYear() );
    		stmts2.setString(13, getNowYear() );
    		
    		int updateRow2 = stmts2.executeUpdate();
    		
    		if ( updateRow2 <= 0 )
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
    		
            //inser into 站台檔
    		if ( !websitedata.equals("") )
    		{
    			String[] ary_website = SvString.split(websitedata,"&");
    			String[] ary_webclass = SvString.split(webclassdata,"&");
    			for ( int i=0; i<ary_website.length; i++ )
    			{
    				String[] ary_website1 = SvString.split(ary_website[i],"||");
        			String[] ary_classdata1 = SvString.split(ary_webclass[i],"||");
        			//單位站台對照檔
        			String mpubunitdn = pubunitdn;
        			String[] ary_pubunitdn = SvString.split(pubunitdn,",");
        			if ( ary_pubunitdn.length > 4 ) {
        				for ( int l=0; l<ary_pubunitdn.length-4; l++ ) {
        					mpubunitdn = SvString.right(mpubunitdn,",");
        				}
        			}
        			WebsiteUnitData qweb = new WebsiteUnitData();
        			boolean rtnunit = qweb.load(mpubunitdn);
        			String unitweb = "";
        			String nameweb = "";
        			if ( rtnunit ) {
        				unitweb = qweb.getWebsitedn();
        				nameweb = qweb.getWebsitename();
        			}else{
        				unitweb = pubunitdn;
        				nameweb = pubunitname;
        			}
        				
        			//尋找此站台接收資料是否要審核
        			PublishData qexam = new PublishData();
        			boolean rtn = qexam.load(examtable,aplistdn,ary_website1[0],unitweb,"R");
        			String misexamine = "Y";
        			if ( rtn ) {
        				if ( qexam.getIsexamine().equals("Y") )
        					misexamine = "0";
        			}        				
        			
        			String msql =  "insert into " + ary_aptable[2];
     		        msql += "(Serno,Mserno,Mclassname,PubWebSiteDN,PubWebSiteName,WebSiteDN,WebSiteName,WebSiteExam,PostName,CreateDate,UpdateDate)";
     		        msql += " values(?,?,?,?,?,?,?,?,?,?,?)";
     		       
     		        stmts1 = conn.prepareStatement(msql);
     		       
     		        stmts1.clearParameters();
     		        stmts1.setString(1, serno );
     		        stmts1.setString(2, ary_classdata1[0] );
     		        stmts1.setString(3, ary_classdata1[1] );
     		        stmts1.setString(4, unitweb );
     		        stmts1.setString(5, nameweb );
     		        stmts1.setString(6, ary_website1[0] );
     		        stmts1.setString(7, ary_website1[1] );
     		        stmts1.setString(8, misexamine );
     		        stmts1.setString(9, postname );
     	    		stmts1.setString(10, getNowYear() );
     	    		stmts1.setString(11, getNowYear() );
     	    		
     	    		int updateRow1 = stmts1.executeUpdate();
     	    		
     	    		if ( updateRow1 <= 0 )
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
    public ArrayList<Object> findByday( String tablename, String keyword, String punit, String tablename1 )
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
    			sSql.append( " and (Subject like '%" + keyword + "%' or SecSubject like '%" + keyword + "%')" );
    		}
    			
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
    			WeblinkData tmpQuery = new WeblinkData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setSecsubject( rs.getString( "SecSubject" ) );
    			tmpQuery.setClosedate( rs.getString( "CloseDate" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setRelateurl( rs.getString( "RelateUrl" ) );
    			tmpQuery.setRelatename( rs.getString( "RelateName" ) );
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
    		this.pubunitdn = rs.getString( "PubUnitDN" );
    		this.pubunitname = rs.getString( "PubUnitName" );
    		this.subject = rs.getString( "Subject" );
    		this.secsubject = rs.getString( "SecSubject" );
    		this.closedate = rs.getString( "CloseDate" );
    		this.startusing = rs.getString( "StartUsing" );
    		this.relateurl = rs.getString( "RelateUrl" );
    		this.relatename = rs.getString( "RelateName" );
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
    	
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		String[] ary_aptable = SvString.split(aptable,"||");

    		//update
    		stmts2 = conn.prepareStatement(
    			"update " + ary_aptable[1] + " set Subject = ?, SecSubject = ?, CloseDate = ?, StartUsing = ?, " + 
    			"RelateUrl = ?, RelateName = ?, Fsort = ?, PostName = ?, UpdateDate = ? where Serno = ? and PubUnitDN = ?");
    		stmts2.clearParameters();  
    		
    		stmts2.setString(1, subject );
    		stmts2.setString(2, secsubject );
    		stmts2.setString(3, closedate );
    		stmts2.setString(4, startusing );
    		stmts2.setString(5, relateurl );
    		stmts2.setString(6, relatename );
    		stmts2.setInt(7, fsort );
    		stmts2.setString(8, postname );
    		stmts2.setString(9, getNowYear() );
    		stmts2.setString(10, serno );
    		stmts2.setString(11, pubunitdn );
    		
    		int updateRow2 = stmts2.executeUpdate();
    		if ( updateRow2 <= 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Update table fail.";
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}
       		
            /**delete into Poster
             * inser into Poster
             */
    		String msql1 = "select * from " + ary_aptable[2] + " where Serno = '" + serno + "'";
    		stmts = conn.prepareStatement(msql1);
    		stmts.clearParameters();
    		rs = stmts.executeQuery();
    		if ( rs.next() ) {
    			String dsql = "delete " + ary_aptable[2] + " where Serno = '" + serno + "'";
    			
    			stmts = conn.prepareStatement(dsql);
    			int updateRow = stmts.executeUpdate();
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
    		
            //inser into 站台檔
    		if ( !websitedata.equals("") )
    		{
    			String[] ary_website = SvString.split(websitedata,"&");
    			String[] ary_webclass = SvString.split(webclassdata,"&");
    			for ( int i=0; i<ary_website.length; i++ )
    			{
    				String[] ary_website1 = SvString.split(ary_website[i],"||");
        			String[] ary_classdata1 = SvString.split(ary_webclass[i],"||");
        			//單位站台對照檔
        			String mpubunitdn = pubunitdn;
        			String[] ary_pubunitdn = SvString.split(pubunitdn,",");
        			if ( ary_pubunitdn.length > 4 ) {
        				for ( int l=0; l<ary_pubunitdn.length-4; l++ ) {
        					mpubunitdn = SvString.right(mpubunitdn,",");
        				}
        			}
        			WebsiteUnitData qweb = new WebsiteUnitData();
        			boolean rtnunit = qweb.load(mpubunitdn);
        			String unitweb = "";
        			String nameweb = "";
        			if ( rtnunit ) {
        				unitweb = qweb.getWebsitedn();
        				nameweb = qweb.getWebsitename();
        			}else{
        				unitweb = pubunitdn;
        				nameweb = pubunitname;
        			}
        				
        			//尋找此站台接收資料是否要審核
        			PublishData qexam = new PublishData();
        			boolean rtn = qexam.load(examtable,aplistdn,ary_website1[0],unitweb,"R");
        			String misexamine = "Y";
        			if ( rtn ) {
        				if ( qexam.getIsexamine().equals("Y") )
        					misexamine = "0";
        			}        				
        			
        			String msql =  "insert into " + ary_aptable[2];
     		        msql += "(Serno,Mserno,Mclassname,PubWebSiteDN,PubWebSiteName,WebSiteDN,WebSiteName,WebSiteExam,PostName,CreateDate,UpdateDate)";
     		        msql += " values(?,?,?,?,?,?,?,?,?,?,?)";
     		       
     		        stmts1 = conn.prepareStatement(msql);
     		       
     		        stmts1.clearParameters();
     		        stmts1.setString(1, serno );
     		        stmts1.setString(2, ary_classdata1[0] );
     		        stmts1.setString(3, ary_classdata1[1] );
     		        stmts1.setString(4, unitweb );
     		        stmts1.setString(5, nameweb );
     		        stmts1.setString(6, ary_website1[0] );
     		        stmts1.setString(7, ary_website1[1] );
     		        stmts1.setString(8, misexamine );
     		        stmts1.setString(9, postname );
     	    		stmts1.setString(10, getNowYear() );
     	    		stmts1.setString(11, getNowYear() );
     	    		
     	    		int updateRow1 = stmts1.executeUpdate();
     	    		
     	    		if ( updateRow1 <= 0 )
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
      		errorMsg = "update data error: " + sqle.toString();
      	} finally {
      		try
      		{
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
    	ResultSet rs1 = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);

     		String[] ary_mserno = SvString.split(serno,"||");
     		String[] ary_aptable = SvString.split(aptable,"||");
     		
     		for ( int i=0; i<ary_mserno.length; i++ ) {
     			String msql = "select * from " + ary_aptable[1] + " where Serno = '" + ary_mserno[i] + "'";
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
            		
        			//刪除資料
        			String dsql = "delete " + ary_aptable[1] + " where Serno = '" + ary_mserno[i] + "'";
        			
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
        			
        			String dsql2 = "delete " + ary_aptable[2] + " where Serno = '" + ary_mserno[i] + "'";
        			
        			stmts2 = conn.prepareStatement(dsql2);
        			int updateRow2 = stmts2.executeUpdate();
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
    		   if ( stmts1 != null ) stmts1.close();
    		   if ( stmts2 != null ) stmts2.close();
    		   if ( stmts3 != null ) stmts3.close();
    		   if ( stmts4 != null ) stmts4.close();
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
