/*
 * 撰寫日期：2008/2/17
 * 程式名稱：DownFileData.java
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

public class DownFileData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //資料檔
    private String secsubject = null;
    private String content = null;
    private String posterdate = null;
    private String closedate = null;
    private String startusing = null;
    private String relateurl = null;
    private String relatename = null;
    private int fsort = 0;
    private String liaisonper = null;
    private String liaisontel = null;
    private String liaisonemail = null;
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
        
    private String serverfile = null;
    private String imagemagick = null;
    private String smediafile = null;
    
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public String getImagemagick() {
		return imagemagick;
	}
	public void setImagemagick(String imagemagick) {
		this.imagemagick = imagemagick;
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
	public String getServerfile() {
		return serverfile;
	}
	public void setServerfile(String serverfile) {
		this.serverfile = serverfile;
	}
	public String getSmediafile() {
		return smediafile;
	}
	public void setSmediafile(String smediafile) {
		this.smediafile = smediafile;
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
    		       sql += "(Serno,PubUnitDN,PubUnitName,Subject,SecSubject,Content,PosterDate,CloseDate,StartUsing,RelateUrl,RelateName,Fsort,LiaisonPer,LiaisonTel,LiaisonEmail,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		      
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, pubunitdn );
    		stmts2.setString(3, pubunitname );
    		stmts2.setString(4, subject );
    		stmts2.setString(5, secsubject );
    		stmts2.setString(6, content );
    		stmts2.setString(7, posterdate );
    		stmts2.setString(8, closedate );
    		stmts2.setString(9, startusing );
    		stmts2.setString(10, relateurl );    		
    		stmts2.setString(11, relatename );
    		stmts2.setInt(12, fsort );
    		stmts2.setString(13, liaisonper );
    		stmts2.setString(14, liaisontel );
    		stmts2.setString(15, liaisonemail );
    		stmts2.setString(16, postname );
    		stmts2.setString(17, getNowYear() );
    		stmts2.setString(18, getNowYear() );
    		
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
    public ArrayList<Object> findByday( String tablename, String keyword, String punit, String sdate1, String sdate2, String tablename1 )
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
    			sSql.append( " and (Subject like '%" + keyword + "%' or SecSubject like '%" + keyword + "%' or Content like '%" + keyword + "%')" );
    		}
    			
    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and PubUnitDN like '%" + mpunit[0] + "%'" );
    		}
    			
    		sSql.append( " and PosterDate >= '" + sdate1 + "' and PosterDate <= '" + sdate2 + "'" );

    		sSql.append( " order by UpdateDate desc,Serno desc,PubUnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			DownFileData tmpQuery = new DownFileData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setSecsubject( rs.getString( "SecSubject" ) );
    			tmpQuery.setContent( rs.getString( "Content" ) );
    			tmpQuery.setPosterdate( rs.getString( "PosterDate" ) );
    			tmpQuery.setClosedate( rs.getString( "CloseDate" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setRelateurl( rs.getString( "RelateUrl" ) );
    			tmpQuery.setRelatename( rs.getString( "RelateName" ) );
    			tmpQuery.setFsort( rs.getInt( "Fsort" ) );
    			tmpQuery.setLiaisonper( rs.getString( "LiaisonPer" ) );
    			tmpQuery.setLiaisonemail( rs.getString( "LiaisonTel" ) );
    			tmpQuery.setLiaisonemail( rs.getString( "LiaisonEmail" ) );
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
    		this.content = rs.getString( "Content" );
    		this.posterdate = rs.getString( "PosterDate" );
    		this.closedate = rs.getString( "CloseDate" );
    		this.relateurl = rs.getString( "RelateUrl" );
    		this.relatename = rs.getString( "RelateName" );
    		this.startusing = rs.getString( "StartUsing" );
    		this.fsort = rs.getInt( "Fsort" );
    		this.liaisonper = rs.getString( "LiaisonPer" );
    		this.liaisontel = rs.getString( "LiaisonTel" );
    		this.liaisonemail = rs.getString( "LiaisonEmail" );
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
    			"update " + ary_aptable[1] + " set Subject = ?,SecSubject = ?, Content = ?, PosterDate = ?, CloseDate = ?, " + 
    			"StartUsing = ?, RelateUrl = ?, RelateName = ?, Fsort = ?, Liaisonper = ?, LiaisonTel = ?, LiaisonEmail = ?, PostName = ?, UpdateDate = ? where Serno = ? and PubUnitDN = ?");
    		stmts2.clearParameters();    	 	
    		stmts2.setString(1, subject );
    		stmts2.setString(2, secsubject );
    		stmts2.setString(3, content );
    		stmts2.setString(4, posterdate );
    		stmts2.setString(5, closedate );
    		stmts2.setString(6, startusing );
    		stmts2.setString(7, relateurl );
    		stmts2.setString(8, relatename );
    		stmts2.setInt(9, fsort );
    		stmts2.setString(10, liaisonper );
    		stmts2.setString(11, liaisontel );
    		stmts2.setString(12, liaisonemail );
    		stmts2.setString(13, postname );
    		stmts2.setString(14, getNowYear() );
    		stmts2.setString(15, serno );
    		stmts2.setString(16, pubunitdn );
    		
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
    public boolean remove( String table )
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
    	ResultSet rs1 = null;
    	PreparedStatement stmts = null;
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

            		//加入 FK需先刪除檔案table，再刪除資料table
            		String msql1 = "select * from " + table + " where Serno = '" + ary_mserno[i] + "'";
            		
         			stmts3 = conn.prepareStatement(msql1);
            		stmts3.clearParameters();
            		rs1 = stmts3.executeQuery();
            		if ( rs1.next() ) {
            			String dsql = "delete " + table + " where Serno = '" + ary_mserno[i] + "'";
            			stmts4 = conn.prepareStatement(dsql);
            			int updateRow = stmts4.executeUpdate();
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
		
	//查詢多筆資料及筆數(刪除檔案)
    public ArrayList<Object> findBydel( String tablename, String serno )
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
    		
    		sSql.append( "select * from " + tablename + " where Serno = '" + serno + "' order by Detailno" );
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			DownFileData tmpQuery = new DownFileData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
    			tmpQuery.setServerfile( rs.getString( "ServerFile" ) );
    			tmpQuery.setImagemagick( rs.getString( "ImageMagick" ) );
    			tmpQuery.setSmediafile( rs.getString( "SMediaFile" ) );
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
