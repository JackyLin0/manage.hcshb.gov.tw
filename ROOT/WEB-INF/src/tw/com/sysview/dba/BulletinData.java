/*
 * 撰寫日期：2008/2/16
 * 程式名稱：BulletinData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Properties;

import sysview.zhiren.function.SvNumber;
import sysview.zhiren.function.SvString;
import tw.com.sysview.upload.UploadData;

public class BulletinData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //資料檔
    private String secsubject = null;
    private String content = null;
    private String posterdate = null;
    private String postertime = null;
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
    private String modflag = null;
    private String noteflag = null;
    private String newsflag = null;
    private String sendflag = null;
    
    //多向發布檔
    private String mserno = null;
    private String mclassname = null;
    private String websitedn = null;
    private String websitename = null;    
    
    private String serverfile = null;
    private String imagemagick = null;
    private String smediafile = null;
    
    //檔案搬移路徑
    private String olddocpath = null;
	private String newdocpath = null;
	private String oldpicpath = null;
	private String newpicpath = null;

    
	public String getNoteflag() {
		return noteflag;
	}
	public void setNoteflag(String noteflag) {
		this.noteflag = noteflag;
	}
	public String getModflag() {
		return modflag;
	}
	public void setModflag(String modflag) {
		this.modflag = modflag;
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
	public String getPostertime() {
		return postertime;
	}
	public void setPostertime(String postertime) {
		this.postertime = postertime;
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
	public String getNewsflag() {
		return newsflag;
	}
	public void setNewsflag(String newsflag) {
		this.newsflag = newsflag;
	}
	public String getSendflag() {
		return sendflag;
	}
	public void setSendflag(String sendflag) {
		this.sendflag = sendflag;
	}
	public String getOlddocpath() {
		return olddocpath;
	}
	public void setOlddocpath(String olddocpath) {
		this.olddocpath = olddocpath;
	}
	public String getNewdocpath() {
		return newdocpath;
	}
	public void setNewdocpath(String newdocpath) {
		this.newdocpath = newdocpath;
	}
	public String getOldpicpath() {
		return oldpicpath;
	}
	public void setOldpicpath(String oldpicpath) {
		this.oldpicpath = oldpicpath;
	}
	public String getNewpicpath() {
		return newpicpath;
	}
	public void setNewpicpath(String newpicpath) {
		this.newpicpath = newpicpath;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}

	//新增資料
    public boolean create( String path ) throws FileNotFoundException, IOException
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
    		       sql += "(Serno,PubUnitDN,PubUnitName,Subject,SecSubject,Content,PosterDate,PosterTime,CloseDate,StartUsing,RelateUrl,RelateName,Fsort,LiaisonPer,LiaisonTel,LiaisonEmail,PostName,CreateDate,CreateTime,UpdateDate,MODFlag,NoteFlag,NewsFlag)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		      
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, pubunitdn );
    		stmts2.setString(3, pubunitname );
    		stmts2.setString(4, subject );
    		stmts2.setString(5, secsubject );
    		stmts2.setString(6, content );
    		stmts2.setString(7, posterdate );
    		stmts2.setString(8, postertime );
    		stmts2.setString(9, closedate );
    		stmts2.setString(10, startusing );
    		stmts2.setString(11, relateurl );
    		stmts2.setString(12, relatename );
    		stmts2.setInt(13, fsort );
    		stmts2.setString(14, liaisonper );
    		stmts2.setString(15, liaisontel );
    		stmts2.setString(16, liaisonemail );
    		stmts2.setString(17, postname );
    		stmts2.setString(18, getNowYear() );
    		stmts2.setString(19, getNowTime() );
    		stmts2.setString(20, getNowYear() );
    		stmts2.setString(21, modflag );
    		stmts2.setString(22, noteflag);
    		stmts2.setString(23, newsflag == null ? "N" : newsflag);
    		
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
     	    		//發布至縣府入口網
     	    		//判斷OS版本
     	    		String website_PATH = "";
     	    		if ( path.indexOf("/") == -1 )
     	    			website_PATH = path + "\\WEB-INF\\exchange.properties";
     	    		else
     	    			website_PATH = path + "/WEB-INF/exchange.properties";

     	    		Properties website = new Properties();
     	    		website.load(new FileInputStream(website_PATH) );
     	    		String mwebsitedn = website.getProperty(ary_website1[0]);
     	    		if ( mwebsitedn !=null && !mwebsitedn.equals("null") ) {
     	    			PubHsinchuData query = new PubHsinchuData();
     	    			query.create(conn,serno,ary_website1[0]);
     	    			System.out.print("addHsinchu:"+query.getErrorMsg());
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
    			BulletinData tmpQuery = new BulletinData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setSecsubject( rs.getString( "SecSubject" ) );
    			tmpQuery.setContent( rs.getString( "Content" ) );
    			tmpQuery.setPosterdate( rs.getString( "PosterDate" ) );
    			tmpQuery.setPostertime( rs.getString( "PosterTime" ) );
    			tmpQuery.setClosedate( rs.getString( "CloseDate" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setRelateurl( rs.getString( "RelateUrl" ) );
    			tmpQuery.setRelatename( rs.getString( "RelateName" ) );
    			tmpQuery.setFsort( rs.getInt( "Fsort" ) );
    			tmpQuery.setModflag( rs.getString( "MODFlag" ) );
    			tmpQuery.setNoteflag( rs.getString( "NoteFlag" ) );
    			tmpQuery.setLiaisonper( rs.getString( "LiaisonPer" ) );
    			tmpQuery.setLiaisontel( rs.getString( "LiaisonTel" ) );
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
    		this.postertime = rs.getString( "PosterTime" );
    		this.closedate = rs.getString( "CloseDate" );
    		this.startusing = rs.getString( "StartUsing" );
    		this.relateurl = rs.getString( "RelateUrl" );
    		this.relatename = rs.getString( "RelateName" );
    		this.fsort = rs.getInt( "Fsort" );
    		this.liaisonper = rs.getString( "LiaisonPer" );
    		this.liaisontel = rs.getString( "LiaisonTel" );
    		this.liaisonemail = rs.getString( "LiaisonEmail" );
    		this.postname = rs.getString( "PostName" );
    		this.updatedate = rs.getString( "UpdateDate" );
    		this.modflag = rs.getString( "MODFlag" );
    		this.noteflag = rs.getString( "NoteFlag" );
    		this.newsflag = rs.getString( "NewsFlag" ) == null ? "N" : rs.getString( "NewsFlag" );
    		
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
    public boolean store( String path ) throws FileNotFoundException, IOException
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
    			"update " + ary_aptable[1] + " set Subject = ?, SecSubject = ?, Content = ?, PosterDate = ?, PosterTime = ?, CloseDate = ?, StartUsing = ?, " + 
    			"RelateUrl = ?, RelateName = ?, Fsort = ?, LiaisonPer = ?, LiaisonTel = ?, LiaisonEmail = ?, PostName = ?, UpdateDate = ?, MODFlag = ?, NoteFlag = ?, NewsFlag =? where Serno = ? and PubUnitDN = ?");
    		stmts2.clearParameters();  
    		
    		stmts2.setString(1, subject );
    		stmts2.setString(2, secsubject );
    		stmts2.setString(3, content );
    		stmts2.setString(4, posterdate );
    		stmts2.setString(5, postertime );
    		stmts2.setString(6, closedate );
    		stmts2.setString(7, startusing );
    		stmts2.setString(8, relateurl );
    		stmts2.setString(9, relatename );
    		stmts2.setInt(10, fsort );
    		stmts2.setString(11, liaisonper );
    		stmts2.setString(12, liaisontel );
    		stmts2.setString(13, liaisonemail );
    		stmts2.setString(14, postname );
    		stmts2.setString(15, getNowYear() );
    		stmts2.setString(16, modflag );
    		stmts2.setString(17, noteflag );
    		stmts2.setString(18, newsflag == null ? "N" : newsflag );
    		stmts2.setString(19, serno );
    		stmts2.setString(20, pubunitdn );
    		
    		int updateRow2 = stmts2.executeUpdate();
    		
    		if ( updateRow2 <= 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Update table fail1212.";
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
     	    		//發布至縣府入口網
     	    		//判斷OS版本
     	    		String website_PATH = "";
     	    		if ( path.indexOf("/") == -1 )
     	    			website_PATH = path + "\\WEB-INF\\exchange.properties";
     	    		else
     	    			website_PATH = path + "/WEB-INF/exchange.properties";

     	    		Properties website = new Properties();
     	    		website.load(new FileInputStream(website_PATH) );
     	    		String mwebsitedn = website.getProperty(ary_website1[0]);
     	    		if ( mwebsitedn !=null && !mwebsitedn.equals("null") ) {
     	    			PubHsinchuData query = new PubHsinchuData();
     	    			query.create(conn,serno,ary_website1[0]);
     	    			System.out.print("mdyHsinchu:"+query.getErrorMsg());
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
    
    
    //修改資料
    public boolean storesend( String path ) throws FileNotFoundException, IOException
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
    	PreparedStatement stmts4 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		String[] ary_aptable = SvString.split(aptable,"||");
     		
    		//update
    		stmts = conn.prepareStatement(
    			"update " + ary_aptable[1] + " set Subject = ?, SecSubject = ?, Content = ?, PosterDate = ?, PosterTime = ?, CloseDate = ?, StartUsing = ?, " + 
    			"RelateUrl = ?, RelateName = ?, Fsort = ?, LiaisonPer = ?, LiaisonTel = ?, LiaisonEmail = ?, PostName = ?, UpdateDate = ?, MODFlag = ?, NoteFlag = ?, NewsFlag =? where Serno = ? and PubUnitDN = ?");
    		stmts.clearParameters();  
    		
    		stmts.setString(1, subject );
    		stmts.setString(2, secsubject );
    		stmts.setString(3, content );
    		stmts.setString(4, posterdate );
    		stmts.setString(5, postertime );
    		stmts.setString(6, closedate );
    		stmts.setString(7, startusing );
    		stmts.setString(8, relateurl );
    		stmts.setString(9, relatename );
    		stmts.setInt(10, fsort );
    		stmts.setString(11, liaisonper );
    		stmts.setString(12, liaisontel );
    		stmts.setString(13, liaisonemail );
    		stmts.setString(14, postname );
    		stmts.setString(15, getNowYear() );
    		stmts.setString(16, modflag );
    		stmts.setString(17, noteflag );
    		stmts.setString(18, newsflag == null ? "Y" : newsflag );
    		stmts.setString(19, serno );
    		stmts.setString(20, pubunitdn );
    		
    		int updateRow = stmts.executeUpdate();
    		
    		if ( updateRow <= 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Update table fail1212.";
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}
    		
    		//複製一份資料 到 新聞稿
    		if( newsflag !=null && newsflag.equals("Y")) {
    			
    			
    			//找最大序號 start
        		stmts1 = conn.prepareStatement("select max(Serno) as seqno from Bulletinsend where substring(Serno,1,8) = ?" );
        		stmts1.clearParameters();
        		stmts1.setString(1,getNowYear());
        		rs = stmts1.executeQuery();
     
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
	    		String sql =  "insert into Bulletinsend ";
	    		       sql += "(Serno,PubUnitDN,PubUnitName,Subject,SecSubject,Content,PosterDate,PosterTime,CloseDate,StartUsing,RelateUrl,RelateName,Fsort,LiaisonUnit,LiaisonPer,LiaisonTel,LiaisonEmail,PostName,CreateDate,CreateTime,UpdateDate)";
	    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	    		      
	    		stmts2 = conn.prepareStatement(sql);
	    		
	    		stmts2.clearParameters();
	    		stmts2.setString(1, serno );
	    		stmts2.setString(2, pubunitdn );
	    		stmts2.setString(3, pubunitname );
	    		stmts2.setString(4, subject );
	    		stmts2.setString(5, secsubject );
	    		stmts2.setString(6, content );
	    		stmts2.setString(7, posterdate );
	    		stmts2.setString(8, postertime );
	    		stmts2.setString(9, closedate );
	    		stmts2.setString(10, startusing );
	    		stmts2.setString(11, relateurl );
	    		stmts2.setString(12, relatename );
	    		stmts2.setInt(13, fsort );
	    		stmts2.setString(14, pubunitname );
	    		stmts2.setString(15, liaisonper );
	    		stmts2.setString(16, liaisontel );
	    		stmts2.setString(17, liaisonemail );
	    		stmts2.setString(18, postname );
	    		stmts2.setString(19, getNowYear() );
	    		stmts2.setString(20, getNowTime() );
	    		stmts2.setString(21, getNowYear() );
	    		
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
	    		System.out.println("搬移相關圖片");
	    		//搬移相關圖片路徑
	    		boolean pic = copyFolder(oldpicpath,newpicpath,serno,"pic");
	    		System.out.println(pic);
	    		if(pic==false){
	    			conn.rollback();
    				errorMsg = "copyFolder fail.";
    				return false;
	    		}
	    		System.out.println("搬移相關附檔");
	    		//搬移相關附檔路徑
	    		boolean doc = copyFolder(olddocpath,newdocpath,serno,"doc");
	    		if(doc==false){
	    			conn.rollback();
    				errorMsg = "copyFolder fail.";
    				return false;
	    		}
	    		System.out.println(doc);
    		}
       		
            /**delete into Poster
             * inser into Poster
             */
    		String msql1 = "select * from " + ary_aptable[2] + " where Serno = '" + serno + "'";
    		stmts3 = conn.prepareStatement(msql1);
    		stmts3.clearParameters();
    		rs = stmts3.executeQuery();
    		if ( rs.next() ) {
    			String dsql = "delete " + ary_aptable[2] + " where Serno = '" + serno + "'";
    			
    			stmts3 = conn.prepareStatement(dsql);
    			int updateRow3 = stmts3.executeUpdate();
    			if ( updateRow3 <= 0 ) 
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
     		       
     		        stmts4 = conn.prepareStatement(msql);
     		       
     		        stmts4.clearParameters();
     		        stmts4.setString(1, serno );
     		        stmts4.setString(2, ary_classdata1[0] );
     		        stmts4.setString(3, ary_classdata1[1] );
     		        stmts4.setString(4, unitweb );
     		        stmts4.setString(5, nameweb );
     		        stmts4.setString(6, ary_website1[0] );
     		        stmts4.setString(7, ary_website1[1] );
     		        stmts4.setString(8, misexamine );
     		        stmts4.setString(9, postname );
     	    		stmts4.setString(10, getNowYear() );
     	    		stmts4.setString(11, getNowYear() );
     	    		
     	    		int updateRow4 = stmts4.executeUpdate();
     	    		
     	    		if ( updateRow4 <= 0 )
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
     	    		//發布至縣府入口網
     	    		//判斷OS版本
     	    		String website_PATH = "";
     	    		if ( path.indexOf("/") == -1 )
     	    			website_PATH = path + "\\WEB-INF\\exchange.properties";
     	    		else
     	    			website_PATH = path + "/WEB-INF/exchange.properties";

     	    		Properties website = new Properties();
     	    		website.load(new FileInputStream(website_PATH) );
     	    		String mwebsitedn = website.getProperty(ary_website1[0]);
     	    		if ( mwebsitedn !=null && !mwebsitedn.equals("null") ) {
     	    			PubHsinchuData query = new PubHsinchuData();
     	    			query.create(conn,serno,ary_website1[0]);
     	    			System.out.print("mdyHsinchu:"+query.getErrorMsg());
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
    			if ( stmts3 != null ) stmts3.close();
    			if ( stmts4 != null ) stmts4.close();
      			conn.close();
      		} catch ( SQLException se ) {
      			errorMsg = "close Statment or connection error: " + se.toString();
      		}
      	}
      	return false;
    }
    
    /**
     * 檔案複製
     * @param oldPath 舊檔案路徑
     * @param newPath 新檔案路徑
     * @param Serno	      資料編號
     * @param type    檔案型態(pic/doc)
     * @return
     */
    public boolean copyFolder(String oldPath, String newPath,String serno, String type){
    	try {            
    		  File f = new File(newPath);  
    		  if (!f.exists()) 
    		     f.mkdirs();
    		  //檔案 or 圖片
    		  File temp = null;
    		  //縮圖
    		  File tempsmall = null;
    		  UploadData uploadData = new UploadData();
    		  String mserver = "";
    		  String mclient = "";
    		  String msmallimg = "";
    		  String exp = "";
    		  ArrayList qfiles = uploadData.findByday("BulletinFile", serno, type);
    		  for (int i = 0; i < uploadData.getAllrecordCount(); i++) {
    			  UploadData qfile = ( UploadData )qfiles.get( i );
    			  if(mserver.equals(""))
    				  mserver = qfile.getServerfile();
    			  else
    				  mserver = mserver + "||" + qfile.getServerfile();
    			  
    			  if(mclient.equals(""))
    				  mclient = qfile.getClientfile();
    			  else
    				  mclient = mclient + "||" + qfile.getClientfile();
    			  
    			  if(exp.equals(""))
    				  exp = qfile.getExpfile();
    			  else 
    				  exp = exp + "||" + qfile.getExpfile();
    			  
    			  if (oldPath.endsWith(File.separator)) {
    				  temp = new File(oldPath + qfile.getServerfile());
    				  if(type.equals("pic")) {
    					  tempsmall = new File(oldPath + qfile.getImagemagick());
    					  if(msmallimg.equals(""))
    						  msmallimg = qfile.getImagemagick();
    					  else
    						  msmallimg = msmallimg + "||" + qfile.getImagemagick();
    				  }
    			  } else {
    				  temp = new File(oldPath + File.separator + qfile.getServerfile());
    				  if(type.equals("pic")) {
    					  tempsmall = new File(oldPath + File.separator + qfile.getImagemagick());
    					  if(msmallimg.equals(""))
    						  msmallimg = qfile.getImagemagick();
    					  else
    						  msmallimg = msmallimg + "||" + qfile.getImagemagick();
    				  }
    			  }
    			  if (temp.isFile()) {
    				  FileInputStream input = new FileInputStream(temp);
    				  FileOutputStream output = new FileOutputStream(newPath + "/" + (temp.getName()).toString());
    				  byte[] b = new byte[1024 * 5];
    				  int len;
    				  while ((len = input.read(b)) != -1) {
    					  output.write(b, 0, len);
    				  }
    				  output.flush();
    				  output.close();
    				  input.close();
    				 }
    			  if (tempsmall.isFile()) {
    				  FileInputStream input = new FileInputStream(tempsmall);
    				  FileOutputStream output = new FileOutputStream(newPath + "/" + (tempsmall.getName()).toString());
    				  byte[] b = new byte[1024 * 5];
    				  int len;
    				  while ((len = input.read(b)) != -1) {
    					  output.write(b, 0, len);
    				  }
    				  output.flush();
    				  output.close();
    				  input.close();
    			  }
    			  
        		  	
        		  
    		  }
    		  UploadData transData = new UploadData();
			  transData.setSerno(serno);
			  transData.setFlag(type);
			  transData.setPostname(postname);
			  transData.setClientfile(mclient);
			  transData.setServerfile(mserver);
			  transData.setExpfile(exp);
		      if(type.equals("pic")) {
		  		transData.setImagemagick(msmallimg);
//		  		System.out.println(" msmallimg:" + msmallimg);
		  	  }

		      boolean rtn =  transData.createtest("BulletinsendFile");
		      //boolean rtn=true;
		      if ( rtn == false ) {
		    	  errorMsg = "copy filedata error: "+transData.getErrorMsg();
		    	  return false;
		      } else {
		    	  return true;
		      }
    		  
    		  	 
//    		  return true;
    	}
    	catch(Exception e){
    		errorMsg = "copy filedata error: " + e.toString();
    		return false;
    		
    	}
    	   
    	
    		
    	
    }

    //刪除資料
    public boolean remove( String table, String path )
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
        			String webserno = rs.getString( "WebSerno" );
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
        			//如果有發布至縣府入口網需刪除
     	    		PubHsinchuData query = new PubHsinchuData();
     	    		query.remove(webserno);
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
    			BulletinData tmpQuery = new BulletinData();
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
    
    /**
     * 取得現在的時間(hhmm)
     */
    private String getNowTime()
    {
    	SimpleDateFormat fmt2 = new SimpleDateFormat("HHmm");
    	return fmt2.format(Calendar.getInstance().getTime());
    }
    
}
