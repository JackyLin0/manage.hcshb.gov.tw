/*
 * 撰寫日期：2008/2/16
 * 程式名稱：PubHsinchuData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import sysview.zhiren.function.SvNumber;

public class PubHsinchuData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
	private String serno = null;
	private String subject = null;
	public String pubunitdn = null;
	public String pubunitname = null;
	private String postname = null;
	
    //資料檔(Bulletin、Activities)
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
    
    //資料檔(Activities)
    private String sponsorunit = null;
    private String assistunit = null;
    private String actsdate = null;
    private String actstime = null;
    private String actedate = null;
    private String actetime = null;
    private String actplace = null;
    private String liaisonfax = null;
    private String onlinesign = null;
    private String islimitnum = null;
    private String limitnum = null;
    private String signupnum = null;
    
    //多向發布檔
    private String mserno = null;
    private String mclassname = null;
    private String websitedn = null;
    private String websitename = null;
    
	public String getActedate() {
		return actedate;
	}
	public void setActedate(String actedate) {
		this.actedate = actedate;
	}
	public String getActetime() {
		return actetime;
	}
	public void setActetime(String actetime) {
		this.actetime = actetime;
	}
	public String getActplace() {
		return actplace;
	}
	public void setActplace(String actplace) {
		this.actplace = actplace;
	}
	public String getActsdate() {
		return actsdate;
	}
	public void setActsdate(String actsdate) {
		this.actsdate = actsdate;
	}
	public String getActstime() {
		return actstime;
	}
	public void setActstime(String actstime) {
		this.actstime = actstime;
	}
	public String getAssistunit() {
		return assistunit;
	}
	public void setAssistunit(String assistunit) {
		this.assistunit = assistunit;
	}
	public String getIslimitnum() {
		return islimitnum;
	}
	public void setIslimitnum(String islimitnum) {
		this.islimitnum = islimitnum;
	}
	public String getLiaisonfax() {
		return liaisonfax;
	}
	public void setLiaisonfax(String liaisonfax) {
		this.liaisonfax = liaisonfax;
	}
	public String getLimitnum() {
		return limitnum;
	}
	public void setLimitnum(String limitnum) {
		this.limitnum = limitnum;
	}
	public String getOnlinesign() {
		return onlinesign;
	}
	public void setOnlinesign(String onlinesign) {
		this.onlinesign = onlinesign;
	}
	public String getSignupnum() {
		return signupnum;
	}
	public void setSignupnum(String signupnum) {
		this.signupnum = signupnum;
	}
	public String getSponsorunit() {
		return sponsorunit;
	}
	public void setSponsorunit(String sponsorunit) {
		this.sponsorunit = sponsorunit;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
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
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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

	//查詢欲新增至縣府主網資料(最新消息)
    public boolean create( Connection conn, String hserno, String websitedn )
    {
    	Connection conn1 = null;
    	try
    	{
    		//連結資料庫
    		conn1 = tw.com.sysview.dba.DbConnection.getwebConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}
    	
    	PreparedStatement stmts = null;
    	PreparedStatement pstmts = null;
    	PreparedStatement pstmts1 = null;
    	PreparedStatement pstmts2 = null;
    	PreparedStatement pstmts3 = null;
    	PreparedStatement pstmts4 = null;
    	PreparedStatement pstmts5 = null;
    	ResultSet rs = null;
    	ResultSet prs = null;
    	ResultSet prs1 = null;
    	ResultSet prs3 = null;
    	ResultSet prs4 = null;
    	try
    	{
    		//同意易動設定
     		conn1.setAutoCommit(false);
     		
    		pstmts = conn.prepareStatement("select * from Bulletin where Serno = '" + hserno + "'");
    		pstmts.clearParameters();
    		
    		prs = pstmts.executeQuery();
    		if ( !prs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		//寫到主網的序號
    		String webserno = prs.getString( "WebSerno" );
    		
    		if ( webserno == null || webserno.equals("null") ) {
    			//無資料，insert
        		//找最大序號 start(主網最大序號)
        		stmts = conn1.prepareStatement("select max(Serno) as seqno from Bulletin where substring(Serno,1,8) = ?" );
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
        			webserno = mserno;
        		}
        		//找最大序號 end
        		
    			String mclosedate = prs.getString( "CloseDate" );
        		if ( prs.getString( "StartUsing" ).equals("1") ) {
        			String mm1 = String.valueOf(Integer.parseInt(prs.getString( "PosterDate" ).substring(4,6)) + 1);
        			if ( mm1.length() == 1 ) {
        				mm1 = "0" + mm1;
        			}
        			mclosedate = prs.getString( "PosterDate" ).substring(0,4)+mm1+prs.getString( "PosterDate" ).substring(6,8);
        		}
        		
        		//inser into 資料檔
        		String sql =  "insert into Bulletin";
        		       sql += "(Serno,PubUnitDN,PubUnitName,Subject,SecSubject,Content,PosterDate,CloseDate,RelateUrl,RelateName,ShowTop,PostName,CreateDate,UpdateDate)";
        		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        		      
        		pstmts2 = conn1.prepareStatement(sql);
        		
        		pstmts2.clearParameters();
        		pstmts2.setString(1, serno );
        		pstmts2.setString(2, prs.getString( "PubUnitDN" ) );
        		pstmts2.setString(3, prs.getString( "PubUnitName" ) );
        		pstmts2.setString(4, prs.getString( "Subject" ) );
        		pstmts2.setString(5, prs.getString( "SecSubject" ) );
        		pstmts2.setString(6, prs.getString( "Content" ) );
        		pstmts2.setString(7, prs.getString( "PosterDate" ) );
        		pstmts2.setString(8, mclosedate );
        		pstmts2.setString(9, prs.getString( "RelateUrl" ) );
        		pstmts2.setString(10, prs.getString( "RelateName" ) );
        		pstmts2.setString(11, "N" );
        		pstmts2.setString(12, prs.getString( "PostName" ) );
        		pstmts2.setString(13, prs.getString( "CreateDate" ) );
        		pstmts2.setString(14, prs.getString( "UpdateDate" ) );
        		
        		int updateRow2 = pstmts2.executeUpdate();
        		
        		if ( updateRow2 <= 0 )
        		{
        			try {
        				conn1.rollback();
        				errorMsg = "Insert into table fail.";
        				System.out.println(errorMsg);
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
        		}
        		//將此序號update至衛生局table的WebSerno欄位
        		stmts = conn.prepareStatement(
        				"update Bulletin set WebSerno = ? where Serno = ?");
            	
        		stmts.clearParameters();
        		
        		stmts.setString(1, serno );
        		stmts.setString(2, hserno );
        		int updateRow = stmts.executeUpdate();
        		
        		if ( updateRow <= 0 )
        		{
        			try {
        				conn1.rollback();
        				errorMsg = "Insert into table fail.";
        				System.out.println(errorMsg);
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
        		}
        		
    		}else{
    			//update
    			String mclosedate = prs.getString( "CloseDate" );
        		if ( prs.getString( "StartUsing" ).equals("1") ) {
        			String mm1 = String.valueOf(Integer.parseInt(prs.getString( "PosterDate" ).substring(4,6)) + 1);
        			if ( mm1.length() == 1 ) {
        				mm1 = "0" + mm1;
        			}
        			mclosedate = prs.getString( "PosterDate" ).substring(0,4)+mm1+prs.getString( "PosterDate" ).substring(6,8);
        		}
        		
        		//update 資料檔
        		pstmts2 = conn1.prepareStatement(
        				"update Bulletin set Subject = ?, SecSubject = ?, Content = ?, PosterDate = ?, CloseDate = ?, " + 
    			        "RelateUrl = ?, RelateName = ?, ShowTop = ?, PostName = ?, UpdateDate = ? where Serno = ? and PubUnitDN = ?");
            	
        		pstmts2.clearParameters();
        		
        		pstmts2.setString(1, prs.getString( "Subject" ) );
        		pstmts2.setString(2, prs.getString( "SecSubject" ) );
        		pstmts2.setString(3, prs.getString( "Content" ) );
        		pstmts2.setString(4, prs.getString( "PosterDate" ) );
        		pstmts2.setString(5, mclosedate );
        		pstmts2.setString(6, prs.getString( "RelateUrl" ) );
        		pstmts2.setString(7, prs.getString( "RelateName" ) );
        		pstmts2.setString(8, "N" );
        		pstmts2.setString(9, prs.getString( "PostName" ) );
        		pstmts2.setString(10, prs.getString( "UpdateDate" ) );
        		pstmts2.setString(11, prs.getString( "WebSerno" ) );
        		pstmts2.setString(12, prs.getString( "PubUnitDN" ) );
        		
        		int updateRow2 = pstmts2.executeUpdate();
        		
        		if ( updateRow2 <= 0 )
        		{
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
    		    		
    		pstmts3 = conn.prepareStatement("select * from BulletinPoster where Serno = '" + hserno + "' and WebSiteDN = '" + websitedn + "'");
    		pstmts3.clearParameters();
    		
    		prs3 = pstmts3.executeQuery();
    		if ( !prs3.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		String msql1 = "select * from BulletinPoster where Serno = '" + webserno + "'";
    		pstmts4 = conn1.prepareStatement(msql1);
    		pstmts4.clearParameters();
    		prs4 = pstmts4.executeQuery();
    		if ( !prs4.next() ) {
    			//insert Poster檔
    			String msql =  "insert into BulletinPoster";
		               msql += "(Serno,Mserno,Mclassname,PubWebSiteDN,PubWebSiteName,WebSiteDN,WebSiteName,WebSiteExam,PostName,CreateDate,UpdateDate)";
		               msql += " values(?,?,?,?,?,?,?,?,?,?,?)";
		               
		        pstmts5 = conn1.prepareStatement(msql);
		        pstmts5.clearParameters();
		        pstmts5.setString(1, webserno );
		        pstmts5.setString(2, prs3.getString( "Mserno" ) );
		        pstmts5.setString(3, prs3.getString( "Mclassname" ) );
		        pstmts5.setString(4, prs3.getString( "PubWebSiteDN" ) );
		        pstmts5.setString(5, "新竹縣衛生局" );
		        pstmts5.setString(6, prs3.getString( "WebSiteDN" ) );
		        pstmts5.setString(7, prs3.getString( "WebSiteName" ) );
		        pstmts5.setString(8, "Y" );
		        pstmts5.setString(9, prs3.getString( "PostName" ) );
		        pstmts5.setString(10, prs3.getString( "CreateDate" ) );
		        pstmts5.setString(11, prs3.getString( "UpdateDate" ) );
		        int updateRow5 = pstmts5.executeUpdate();
		        
		        if ( updateRow5 <= 0 ) {
		        	try {
		        		conn1.rollback();
		        		errorMsg = "Insert into table fail.";
		        		System.out.println(errorMsg);
		        		return false;
		        	}catch(Exception backerr){
		        		System.out.println("rollback faild!");
		        	}
		        }     	    		     	
    		}else{
    			//update Poster檔
        		pstmts5 = conn1.prepareStatement(
        				"update BulletinPoster set Mserno = ?, Mclassname = ?, PubWebSiteDN = ?, PubWebSiteName = ?, WebSiteDN = ?, " + 
    			        "WebSiteName = ?, WebSiteExam = ?, PostName = ?, CreateDate = ?, UpdateDate = ? where Serno = ?");
            	
        		pstmts5.clearParameters();
        		
        		pstmts5.setString(1, prs3.getString( "Mserno" ) );
        		pstmts5.setString(2, prs3.getString( "Mclassname" ) );
        		pstmts5.setString(3, prs3.getString( "PubWebSiteDN" ) );
        		pstmts5.setString(4, "新竹縣衛生局" );
        		pstmts5.setString(5, prs3.getString( "WebSiteDN" ) );
        		pstmts5.setString(6, prs3.getString( "WebSiteName" ) );
        		pstmts5.setString(7, "Y" );
        		pstmts5.setString(8, prs3.getString( "PostName" ) );
        		pstmts5.setString(9, prs3.getString( "CreateDate" ) );
        		pstmts5.setString(10, prs3.getString( "UpdateDate" ) );
        		pstmts5.setString(11, webserno );
        		
        		int updateRow5 = pstmts5.executeUpdate();
        		
        		if ( updateRow5 <= 0 )
        		{
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
    		
    		conn1.commit();
       	  	conn1.setAutoCommit(true);

    		return true;

    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error(pubhsinchu): " + sqle.toString();
    		System.out.println(errorMsg);
    	} finally {
    		try {    			
    			if ( stmts != null ) stmts.close();
    			if ( pstmts != null ) pstmts.close();
    			if ( pstmts1 != null ) pstmts1.close();
    			if ( pstmts2 != null ) pstmts2.close();
    			if ( pstmts3 != null ) pstmts3.close();
    			if ( pstmts4 != null ) pstmts4.close();
    			if ( pstmts5 != null ) pstmts5.close();    			
    			if ( rs != null ) rs.close();
    			if ( prs != null ) prs.close();
    			if ( prs1 != null ) prs1.close();
    			if ( prs3 != null ) prs3.close();
    			if ( prs4 != null ) prs4.close();
    			conn1.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }

    //刪除資料(最新消息)
    public boolean remove( String webserno )
    {
    	Connection conn1 = null;
    	try
    	{
    		//連結資料庫
    		conn1 = tw.com.sysview.dba.DbConnection.getwebConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}
    	
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	ResultSet rs2 = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	try {
    		
            //同意易動設定
     		conn1.setAutoCommit(false);

     		String msql = "select * from Bulletin where Serno = '" + webserno + "'";
     		stmts = conn1.prepareStatement(msql);
     		stmts.clearParameters();
     		rs = stmts.executeQuery();
     		
     		if ( rs.next() ) {
     			String dsql = "delete Bulletin where Serno = '" + webserno + "'";
    			stmts1 = conn1.prepareStatement(dsql);
    			int updateRow1 = stmts1.executeUpdate();
    			if ( updateRow1 < 0 )  {
    				try {
        				conn1.rollback();
        				errorMsg = "Delete table fail.";
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
    			}	
     		}

     		String msql2 = "select * from BulletinPoster where Serno = '" + webserno + "'";
     		stmts2 = conn1.prepareStatement(msql2);
     		stmts2.clearParameters();
     		rs2 = stmts2.executeQuery();
     		
     		if ( rs2.next() ) {
     			String dsql = "delete BulletinPoster where Serno = '" + webserno + "'";
     			stmts2 = conn1.prepareStatement(dsql);
    			int updateRow2 = stmts2.executeUpdate();
    			if ( updateRow2 <= 0 ) 
    			{
        			try {
        				conn1.rollback();
        				errorMsg = "Delete table fail.";
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
        		}
     		}	
     		
     		conn1.commit();
       	  	conn1.setAutoCommit(true);
    		
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
    		   conn1.close();
    	   }catch( SQLException se ) {
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }          		

	//查詢欲新增至縣府主網資料(活動訊息)
    public boolean create1( Connection conn, String hserno, String websitedn )
    {
    	Connection conn1 = null;
    	try
    	{
    		//連結資料庫
    		conn1 = tw.com.sysview.dba.DbConnection.getwebConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}
    	
    	PreparedStatement stmts = null;
    	PreparedStatement pstmts = null;
    	PreparedStatement pstmts1 = null;
    	PreparedStatement pstmts2 = null;
    	PreparedStatement pstmts3 = null;
    	PreparedStatement pstmts4 = null;
    	PreparedStatement pstmts5 = null;
    	ResultSet rs = null;
    	ResultSet prs = null;
    	ResultSet prs1 = null;
    	ResultSet prs3 = null;
    	ResultSet prs4 = null;
    	try
    	{
    		//同意易動設定
     		conn1.setAutoCommit(false);
     		
    		pstmts = conn.prepareStatement("select * from Activities where Serno = '" + hserno + "'");
    		pstmts.clearParameters();
    		
    		prs = pstmts.executeQuery();
    		if ( !prs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}

    		//寫到主網的序號
    		String webserno = prs.getString( "WebSerno" );
    		
    		if ( webserno == null || webserno.equals("null") ) {
    			//無資料，insert
    			//找最大序號 start(主網最大序號)
        		stmts = conn1.prepareStatement("select max(Serno) as seqno from Activities where substring(Serno,1,8) = ?" );
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
        			webserno = mserno;
        		}
        		//找最大序號 end
        		
    			String mclosedate = prs.getString( "CloseDate" );
        		if ( prs.getString( "StartUsing" ).equals("1") ) {
        			String mm1 = String.valueOf(Integer.parseInt(prs.getString( "PosterDate" ).substring(4,6)) + 1);
        			if ( mm1.length() == 1 ) {
        				mm1 = "0" + mm1;
        			}
        			mclosedate = prs.getString( "PosterDate" ).substring(0,4)+mm1+prs.getString( "PosterDate" ).substring(6,8);
        		}
        		
        		//inser into 資料檔
        		String sql =  "insert into Activities";
 		               sql += "(Serno,PubUnitDN,PubUnitName,Subject,SecSubject,Content,SponsorUnit,AssistUnit,ActSDate,ActStime,ActEDate,ActETime,ActPlace";
 		               sql += ",Name,Tel,Fax,Email,OnLineSign,IsLimitNum,LimitNum,SignUpNum,PosterDate,CloseDate,RelateUrl,RelateName,ShowTop,PostName,CreateDate,UpdateDate)";
 		               sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
 		      
 		        pstmts2 = conn1.prepareStatement(sql);
 		        
 		        pstmts2.clearParameters();
 		        pstmts2.setString(1, serno);
 		        pstmts2.setString(2, prs.getString( "PubUnitDN" ) );
 		        pstmts2.setString(3, prs.getString( "PubUnitName" ) );
 		        pstmts2.setString(4, prs.getString( "Subject" ) );
 		        pstmts2.setString(5, prs.getString( "SecSubject" ) );
 		        pstmts2.setString(6, prs.getString( "Content" ) );
 		        pstmts2.setString(7, prs.getString( "SponsorUnit" ) );
 		        pstmts2.setString(8, prs.getString( "AssistUnit" ) );
 		        pstmts2.setString(9, prs.getString( "ActSDate" ) );
 		        pstmts2.setString(10, prs.getString( "ActSTime" ) );
 		        pstmts2.setString(11, prs.getString( "ActEDate" ) );
 		        pstmts2.setString(12, prs.getString( "ActETime" ) );
 		        pstmts2.setString(13, prs.getString( "ActPlace" ) );
 		        pstmts2.setString(14, prs.getString( "LiaisonPer" ) );
 		        pstmts2.setString(15, prs.getString( "LiaisonTel" ) );
 		        pstmts2.setString(16, prs.getString( "LiaisonFax" ) );
 		        pstmts2.setString(17, prs.getString( "LiaisonEmail" ) );
 		        pstmts2.setString(18, prs.getString( "OnLineSign" ) );
 		        pstmts2.setString(19, prs.getString( "IsLimitNum" ) );
 		        pstmts2.setString(20, prs.getString( "LimitNum" ) );
 		        pstmts2.setString(21, prs.getString( "SignUpNum" ) );
 		        pstmts2.setString(22, prs.getString( "PosterDate" ) );
 		        pstmts2.setString(23, mclosedate );
 		        pstmts2.setString(24, prs.getString( "RelateUrl" ) );
 		        pstmts2.setString(25, prs.getString( "RelateName" ) );
 		        pstmts2.setString(26, "N" );
 		        pstmts2.setString(27, prs.getString( "PostName" ) );
 		        pstmts2.setString(28, prs.getString( "CreateDate" ) );
 		        pstmts2.setString(29, prs.getString( "UpdateDate" ) );
 		        
 		        int updateRow2 = pstmts2.executeUpdate();
 		        
 		        if ( updateRow2 <= 0 ) {
 		        	try {
 		        		conn1.rollback();
 		        		errorMsg = "Insert into table fail.";
 		        		System.out.println(errorMsg);
 		        		return false;
 		        	}catch(Exception backerr){
 		        		System.out.println("rollback faild!");
 		        	}
 		        }
 		        
 		        // 將此序號update至衛生局table的WebSerno欄位
        		stmts = conn.prepareStatement(
        				"update Activities set WebSerno = ? where Serno = ?");
            	
        		stmts.clearParameters();
        		
        		stmts.setString(1, serno );
        		stmts.setString(2, hserno );
        		int updateRow = stmts.executeUpdate();
        		
        		if ( updateRow <= 0 )
        		{
        			try {
        				conn1.rollback();
        				errorMsg = "Insert into table fail.";
        				System.out.println(errorMsg);
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
        		}
        		
    		}else{
    			//update
    			String mclosedate = prs.getString( "CloseDate" );
        		if ( prs.getString( "StartUsing" ).equals("1") ) {
        			String mm1 = String.valueOf(Integer.parseInt(prs.getString( "PosterDate" ).substring(4,6)) + 1);
        			if ( mm1.length() == 1 ) {
        				mm1 = "0" + mm1;
        			}
        			mclosedate = prs.getString( "PosterDate" ).substring(0,4)+mm1+prs.getString( "PosterDate" ).substring(6,8);
        		}
        		
        		//update 資料檔
        		pstmts2 = conn1.prepareStatement(
            			"update Activities set Subject = ?,SecSubject = ?, Content = ?, SponsorUnit = ?, AssistUnit = ?, ActSDate = ?, ActSTime = ?, ActEDate = ?, ActETime = ?," + 
            			"ActPlace = ?, Name = ?, Tel = ?, Fax = ?, Email = ?, PosterDate = ?, CloseDate = ?, RelateUrl = ?, RelateName = ?, ShowTop = ?, PostName = ?, UpdateDate = ? where Serno = ? and PubUnitDN = ?");
        		
        		pstmts2.clearParameters();
        		pstmts2.setString(1, prs.getString( "Subject" ) );
 		        pstmts2.setString(2, prs.getString( "SecSubject" ) );
 		        pstmts2.setString(3, prs.getString( "Content" ) );
 		        pstmts2.setString(4, prs.getString( "SponsorUnit" ) );
 		        pstmts2.setString(5, prs.getString( "AssistUnit" ) );
 		        pstmts2.setString(6, prs.getString( "ActSDate" ) );
 		        pstmts2.setString(7, prs.getString( "ActSTime" ) );
 		        pstmts2.setString(8, prs.getString( "ActEDate" ) );
 		        pstmts2.setString(9, prs.getString( "ActETime" ) );
 		        pstmts2.setString(10, prs.getString( "ActPlace" ) );
 		        pstmts2.setString(11, prs.getString( "LiaisonPer" ) );
 		        pstmts2.setString(12, prs.getString( "LiaisonTel" ) );
 		        pstmts2.setString(13, prs.getString( "LiaisonFax" ) );
 		        pstmts2.setString(14, prs.getString( "LiaisonEmail" ) );
 		        pstmts2.setString(15, prs.getString( "PosterDate" ) );
 		        pstmts2.setString(16, mclosedate );
 		        pstmts2.setString(17, prs.getString( "RelateUrl" ) );
 		        pstmts2.setString(18, prs.getString( "RelateName" ) );
 		        pstmts2.setString(19, "N" );
 		        pstmts2.setString(20, prs.getString( "PostName" ) );
 		        pstmts2.setString(21, prs.getString( "UpdateDate" ) );
 		        pstmts2.setString(22, prs.getString( "WebSerno" ));
		        pstmts2.setString(23, prs.getString( "PubUnitDN" ) );
            		
		        int updateRow2 = pstmts2.executeUpdate();
		        if ( updateRow2 <= 0 ) {
		        	try {
		        		conn1.rollback();
		        		errorMsg = "Update table fail.";
		        		return false;
		        	}catch(Exception backerr){
		        		System.out.println("rollback faild!");
		        	}
		        }
    		} 			
    		
    		pstmts3 = conn.prepareStatement("select * from ActivityPoster where Serno = '" + hserno + "' and WebSiteDN = '" + websitedn + "'");
    		pstmts3.clearParameters();
    		
    		prs3 = pstmts3.executeQuery();
    		if ( !prs3.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		String msql1 = "select * from ActivityPoster where Serno = '" + webserno + "'";
    		pstmts4 = conn1.prepareStatement(msql1);
    		pstmts4.clearParameters();
    		prs4 = pstmts4.executeQuery();
    		if ( !prs4.next() ) {
    			//insert Poster檔
    			String msql =  "insert into ActivityPoster";
 		               msql += "(Serno,Mserno,Mclassname,PubWebSiteDN,PubWebSiteName,WebSiteDN,WebSiteName,WebSiteExam,PostName,CreateDate,UpdateDate)";
 		               msql += " values(?,?,?,?,?,?,?,?,?,?,?)";
 		       
 		        pstmts5 = conn1.prepareStatement(msql);
 		       
		        pstmts5.clearParameters();
		        
		        pstmts5.setString(1, webserno );
		        pstmts5.setString(2, prs3.getString( "Mserno" ) );
		        pstmts5.setString(3, prs3.getString( "Mclassname" ) );
		        pstmts5.setString(4, prs3.getString( "PubWebSiteDN" ) );
		        pstmts5.setString(5, "新竹縣衛生局" );
		        pstmts5.setString(6, prs3.getString( "WebSiteDN" ) );
		        pstmts5.setString(7, prs3.getString( "WebSiteName" ) );
		        pstmts5.setString(8, "Y" );
		        pstmts5.setString(9, prs3.getString( "PostName" ) );
		        pstmts5.setString(10, prs3.getString( "CreateDate" ) );
		        pstmts5.setString(11, prs3.getString( "UpdateDate" ) );
		        
		        int updateRow5 = pstmts5.executeUpdate();
		        
		        if ( updateRow5 <= 0 ) {
		        	try {
		        		conn1.rollback();
		        		errorMsg = "Insert into table fail.";
		        		System.out.println(errorMsg);
		        		return false;
		        	}catch(Exception backerr){
		        		System.out.println("rollback faild!");
		        	}
		        }     	    		     	
    		}else{
    			//update Poster檔
        		pstmts5 = conn1.prepareStatement(
        				"update ActivityPoster set Mserno = ?, Mclassname = ?, PubWebSiteDN = ?, PubWebSiteName = ?, WebSiteDN = ?, " + 
    			        "WebSiteName = ?, WebSiteExam = ?, PostName = ?, CreateDate = ?, UpdateDate = ? where Serno = ?");
            	
        		pstmts5.clearParameters();
        		
        		pstmts5.setString(1, prs3.getString( "Mserno" ) );
        		pstmts5.setString(2, prs3.getString( "Mclassname" ) );
        		pstmts5.setString(3, prs3.getString( "PubWebSiteDN" ) );
        		pstmts5.setString(4, "新竹縣衛生局" );
        		pstmts5.setString(5, prs3.getString( "WebSiteDN" ) );
        		pstmts5.setString(6, prs3.getString( "WebSiteName" ) );
        		pstmts5.setString(7, "Y" );
        		pstmts5.setString(8, prs3.getString( "PostName" ) );
        		pstmts5.setString(9, prs3.getString( "CreateDate" ) );
        		pstmts5.setString(10, prs3.getString( "UpdateDate" ) );
        		pstmts5.setString(11, webserno );
        		
        		int updateRow5 = pstmts5.executeUpdate();
        		
        		if ( updateRow5 <= 0 )
        		{
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
    		
    		conn1.commit();
       	  	conn1.setAutoCommit(true);

    		return true;

    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error(pubhsinchu): " + sqle.toString();
    		System.out.println(errorMsg);
    	} finally {
    		try {    			
    			if ( stmts != null ) stmts.close();
    			if ( pstmts != null ) pstmts.close();
    			if ( pstmts1 != null ) pstmts1.close();
    			if ( pstmts2 != null ) pstmts2.close();
    			if ( pstmts3 != null ) pstmts3.close();
    			if ( pstmts4 != null ) pstmts4.close();
    			if ( pstmts5 != null ) pstmts5.close();   
    			if ( rs != null ) rs.close();
    			if ( prs != null ) prs.close();
    			if ( prs1 != null ) prs1.close();
    			if ( prs3 != null ) prs3.close();
    			if ( prs4 != null ) prs4.close();
    			conn1.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }

    //刪除資料(活動訊息)
    public boolean remove1( String webserno )
    {
    	Connection conn1 = null;
    	try
    	{
    		//連結資料庫
    		conn1 = tw.com.sysview.dba.DbConnection.getwebConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}
    	
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	ResultSet rs2 = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	try {
    		
            //同意易動設定
     		conn1.setAutoCommit(false);

     		String msql = "select * from Activities where Serno = '" + webserno + "'";
     		stmts = conn1.prepareStatement(msql);
     		stmts.clearParameters();
     		rs = stmts.executeQuery();
     		
     		if ( rs.next() ) {
     			String dsql = "delete Activities where Serno = '" + webserno + "'";
    			stmts1 = conn1.prepareStatement(dsql);
    			int updateRow1 = stmts1.executeUpdate();
    			if ( updateRow1 < 0 )  {
    				try {
        				conn1.rollback();
        				errorMsg = "Delete table fail.";
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
    			}	
     		}

     		String msql2 = "select * from ActivityPoster where Serno = '" + webserno + "'";
     		stmts2 = conn1.prepareStatement(msql2);
     		stmts2.clearParameters();
     		rs2 = stmts2.executeQuery();
     		
     		if ( rs2.next() ) {
     			String dsql = "delete ActivityPoster where Serno = '" + webserno + "'";
     			stmts2 = conn1.prepareStatement(dsql);
    			int updateRow2 = stmts2.executeUpdate();
    			if ( updateRow2 <= 0 ) 
    			{
        			try {
        				conn1.rollback();
        				errorMsg = "Delete table fail.";
        				return false;
     	            }catch(Exception backerr){
     	            	System.out.println("rollback faild!");
     	            }
        		}
     		}	
     		
     		conn1.commit();
       	  	conn1.setAutoCommit(true);
    		
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
    		   conn1.close();
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
