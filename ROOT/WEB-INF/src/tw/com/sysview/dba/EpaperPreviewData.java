/*
 * 撰寫日期：2008/3/23
 * 程式名稱：EpaperPreviewData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class EpaperPreviewData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //EpaperSendMaste(電子報主檔)
    private String serno = null;
    private String pubunitdn = null;
    private String pubunitname = null;
    private String periodical = null;
    private String senddate = null;
    private String createdate = null;
    private String updatedate = null;
    private String flag = null;
    private String imgserno = null;
    
    private String mserno = null;
    private String mclassname = null;
    
    //EpaperSendDetail(電子報明細檔)
    private String ESerno = null;
    private String subject = null;
    private String tablename = null;
    private String startdate = null;
    private String enddate = null;
    
    //EpaperSendFile(電子報Logo圖片檔)
    private String serverfile = "";
    private String clientfile = "";
    private String expfile = "";
    
    private String imagemagick = null;
    
    //Activities(活動訊息)
    private String actsdate = null;
    private String actedate = null;
    private String posterdate = null;
    
    private String author = null;
    private String publisher = null;
    private String examiner = null;
    private String content = null;
    
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getExaminer() {
		return examiner;
	}
	public void setExaminer(String examiner) {
		this.examiner = examiner;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getImagemagick() {
		return imagemagick;
	}
	public void setImagemagick(String imagemagick) {
		this.imagemagick = imagemagick;
	}
	public String getActedate() {
		return actedate;
	}
	public void setActedate(String actedate) {
		this.actedate = actedate;
	}
	public String getActsdate() {
		return actsdate;
	}
	public void setActsdate(String actsdate) {
		this.actsdate = actsdate;
	}
	public String getPosterdate() {
		return posterdate;
	}
	public void setPosterdate(String posterdate) {
		this.posterdate = posterdate;
	}
	public String getTablename() {
		return tablename;
	}
	public void setTablename(String tablename) {
		this.tablename = tablename;
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
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getESerno() {
		return ESerno;
	}
	public void setESerno(String serno) {
		ESerno = serno;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getImgserno() {
		return imgserno;
	}
	public void setImgserno(String imgserno) {
		this.imgserno = imgserno;
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
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
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
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}

    //查詢單筆資料(查詢預覽之期刊-EpaperSendMaster)
    public boolean load( String periodical )
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
    		stmts = conn.prepareStatement("select * from EpaperSendMaster where Periodical = '" + periodical + "'");
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

    //查詢單筆資料(查詢此期刊之Logo圖)
    public boolean loadlogo( String imgserno )
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
    		stmts = conn.prepareStatement("select * from EpaperSendFile where Serno = '" + imgserno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.serverfile = rs.getString( "ServerFile" );
    		this.clientfile = rs.getString( "ClientFile" );
    		this.expfile = rs.getString( "ExpFile" );
    		
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
		
	//查詢多筆資料及筆數(查詢此期刊選用之類別)
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
    			EpaperPreviewData tmpQuery = new EpaperPreviewData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
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
	
	//查詢多筆資料及筆數(查詢此類別之明細)
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
    			EpaperPreviewData tmpQuery = new EpaperPreviewData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setESerno( rs.getString( "ESerno" ) );
    			tmpQuery.setMserno( rs.getString( "MSerno" ) );
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
	
	//查詢多筆資料及筆數(查詢活動訊息資料-Activities)
    public ArrayList<Object> findByact( String startdate, String enddate )
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
    		
    		sSql.append( "select Serno,Subject,ActSDate,ActEDate,PosterDate from Activities where PosterDate >= '" + startdate + "' and PosterDate <= '" + enddate + "'" );
    		
    		sSql.append( " order by Serno desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );    		
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperPreviewData tmpQuery = new EpaperPreviewData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setActsdate( rs.getString( "ActSDate" ) );
    			tmpQuery.setActedate( rs.getString( "ActEDate" ) );
    			tmpQuery.setPosterdate( rs.getString( "PosterDate" ) );
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

    //查詢單筆資料(查詢圖檔)
    public boolean loadfile( String tablename, String serno )
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
    		stmts = conn.prepareStatement("select Top 1 Serno,ServerFile,ClientFile,ExpFile,ImageMagick from " + tablename + " where Serno = '" + serno + "' and Flag = 'pic' order by MainImage desc,DetailNo");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.serverfile = rs.getString( "ServerFile" );
    		this.clientfile = rs.getString( "ClientFile" );
    		this.expfile = rs.getString( "ExpFile" );
    		this.imagemagick = rs.getString( "ImageMagick" );
    		
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

    //查詢單筆資料(查詢資料)
    public boolean loaddata( String tablename, String serno )
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
    		if ( tablename.equals( "EpaperData" ) ) {
    			stmts = conn.prepareStatement("select d.Serno,d.Subject,i.Content,d.Author,d.Publisher,d.Examiner from " + tablename + " as d,EpaperItem as i where d.Serno = i.Serno and DetailNo = 1 and d.Serno = '" + serno + "'");    			
    			stmts.clearParameters();    		
        		rs = stmts.executeQuery();
        		
        		if ( !rs.next() )
        		{
        			errorMsg = "No the data";
        			return false;
        		}
        		
        		this.serno = rs.getString( "Serno" );
        		this.subject = rs.getString( "Subject" );
        		this.content = rs.getString( "Content" );
        		this.author = rs.getString( "Author" );
        		this.publisher = rs.getString( "Publisher" );
        		this.examiner = rs.getString( "Examiner" ); 

        		return true;
    		}else{
    			stmts = conn.prepareStatement("select Serno,Subject,Content,Author,Publisher,Examiner from " + tablename + " where Serno = '" + serno + "'");
    			stmts.clearParameters();    		
        		rs = stmts.executeQuery();
        		
        		if ( !rs.next() )
        		{
        			errorMsg = "No the data";
        			return false;
        		}
        		
        		this.serno = rs.getString( "Serno" );
        		this.subject = rs.getString( "Subject" );
        		this.content = rs.getString( "Content" );
        		this.author = rs.getString( "Author" );
        		this.publisher = rs.getString( "Publisher" );
        		this.examiner = rs.getString( "Examiner" ); 

        		return true;
    		}	
    		
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

}
