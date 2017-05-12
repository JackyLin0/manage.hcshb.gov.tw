/*
 * 撰寫日期：2010/6/27
 * 程式名稱：MetaTagData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.metatag;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import sysview.zhiren.function.SvNumber;
import tw.com.sysview.dba.WebSiteLog;

public class MetaTagData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    private String websitedn = null;
    private String websitename = null;
    private String menudata = null;
    private String title = null;
    private String subject = null;
    private String creator = null;
    private String publisher = null;
    private String contributor = null;
    private String mtype = null;
    private String mformat = null;
    private String identifier = null;
    private String relation = null;
    private String source = null;
    private String languagetype = null;
    private String rights = null;
    private String themeclass = null;
    private String cakeclass = null;
    private String serviceclass = null;
    private String postname = null;
    private String createdate = null;
    
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
	public String getMenudata() {
		return menudata;
	}
	public void setMenudata(String menudata) {
		this.menudata = menudata;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getContributor() {
		return contributor;
	}
	public void setContributor(String contributor) {
		this.contributor = contributor;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	public String getMformat() {
		return mformat;
	}
	public void setMformat(String mformat) {
		this.mformat = mformat;
	}
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	public String getRelation() {
		return relation;
	}
	public void setRelation(String relation) {
		this.relation = relation;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getLanguagetype() {
		return languagetype;
	}
	public void setLanguagetype(String languagetype) {
		this.languagetype = languagetype;
	}
	public String getRights() {
		return rights;
	}
	public void setRights(String rights) {
		this.rights = rights;
	}
	public String getThemeclass() {
		return themeclass;
	}
	public void setThemeclass(String themeclass) {
		this.themeclass = themeclass;
	}
	public String getCakeclass() {
		return cakeclass;
	}
	public void setCakeclass(String cakeclass) {
		this.cakeclass = cakeclass;
	}
	public String getServiceclass() {
		return serviceclass;
	}
	public void setServiceclass(String serviceclass) {
		this.serviceclass = serviceclass;
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
    	ResultSet rs1 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		stmts = conn.prepareStatement("select * from " + tablename + " where WebSiteDN = '" + websitedn + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{

        		//找最大序號 start
        		stmts1 = conn.prepareStatement("select max(serno) as seqno from " + tablename + " where substring(serno,1,8) = ?" );
        		stmts1.clearParameters();
        		stmts1.setString(1,getNowYear());
        		rs1 = stmts1.executeQuery();
     
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
        		
        		//insert
        		String sql =  "insert into " + tablename;
        		       sql += "(Serno,WebSiteDN,WebSiteName,MenuData,Title,Subject,Creator,Publisher,Contributor,MType,MFormat,Identifier,Relation,Source,LanguageType,Rights,ThemeClass,CakeClass,ServiceClass,PostName,CreateDate,UpdateDate)";
        		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        		       
        		stmts2 = conn.prepareStatement(sql);
        		
        		stmts2.clearParameters();
        		stmts2.setString(1, serno );
        		stmts2.setString(2, websitedn );
        		stmts2.setString(3, websitename );
        		stmts2.setString(4, menudata );
        		stmts2.setString(5, title );
        		stmts2.setString(6, subject );
        		stmts2.setString(7, creator );
        		stmts2.setString(8, publisher );
        		stmts2.setString(9, contributor );
        		stmts2.setString(10, mtype );
        		stmts2.setString(11, mformat );
        		stmts2.setString(12, identifier );
        		stmts2.setString(13, relation );
        		stmts2.setString(14, source );
        		stmts2.setString(15, languagetype );
        		stmts2.setString(16, rights );
        		stmts2.setString(17, themeclass );
        		stmts2.setString(18, cakeclass );
        		stmts2.setString(19, serviceclass );
        		stmts2.setString(20, postname );
        		stmts2.setString(21, getNowYear() );
        		stmts2.setString(22, getNowYear() );
        		
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
        		
    		}else{
         		stmts3 = conn.prepareStatement(
    	    			"update " + tablename + " set Title = ?, Subject = ?, Creator = ?, Publisher = ?, Contributor = ?, MType = ?, MFormat = ?, Identifier = ?, Relation = ?, Source = ?, LanguageType = ?, Rights = ?, ThemeClass = ?, CakeClass = ?, ServiceClass = ?, PostName = ?, UpdateDate = ? where WebSiteDN = ?");
    	    	
         		stmts3.setString(1, title);
         		stmts3.setString(2, subject);
         		stmts3.setString(3, creator );
         		stmts3.setString(4, publisher );
         		stmts3.setString(5, contributor );
         		stmts3.setString(6, mtype);
         		stmts3.setString(7, mformat );
         		stmts3.setString(8, identifier );
         		stmts3.setString(9, relation );
         		stmts3.setString(10, source );
         		stmts3.setString(11, languagetype );
         		stmts3.setString(12, rights );
         		stmts3.setString(13, themeclass );
         		stmts3.setString(14, cakeclass );
         		stmts3.setString(15, serviceclass );
         		stmts3.setString(16, postname );
         		stmts3.setString(17, getNowYear() );
         		stmts3.setString(18, websitedn );
    		    
    		    int updateRow3 = stmts3.executeUpdate();
    		    
    		    if ( updateRow3 < 0 ) {
    		    	try {
    		    		conn.rollback();
    		    		errorMsg = "Insert into table fail.";
    		    		System.out.println("aa="+errorMsg);
    		    		return false;
    		    	}catch(Exception backerr){
    		    		System.out.println("rollback faild!");
    		    	}
    		    }
    		
    		}
    		
    		//網站維運統計共用參數(WebSiteLog)
    		this.setLanguagetype("chinese");
    		if ( !createlog(conn,languagetype) )  {
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
    
    //查詢單筆資料
    public boolean load( String tablename, String websitedn )
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
    		stmts = conn.prepareStatement("select * from " + tablename + " where WebSiteDN = '" + websitedn + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.serno = rs.getString( "Serno" );
    		this.websitedn = rs.getString( "WebSiteDN" );
    		this.websitename = rs.getString( "WebSiteName" ); 
    		this.menudata =  rs.getString( "MenuData" );
    		this.title =  rs.getString( "Title" );
    		this.subject = rs.getString( "Subject" );
    		this.creator = rs.getString( "Creator" );
    		this.publisher = rs.getString( "Publisher" );
    		this.contributor = rs.getString( "Contributor" );
    		this.mtype = rs.getString( "MType" );
    		this.mformat = rs.getString( "MFormat" );
    		this.identifier = rs.getString( "Identifier" );
    		this.relation = rs.getString( "Relation" );
    		this.source = rs.getString( "Source" );
    		this.languagetype = rs.getString( "LanguageType" );
    		this.rights = rs.getString( "Rights" );
    		this.themeclass = rs.getString( "ThemeClass" );
    		this.cakeclass = rs.getString( "CakeClass" );
    		this.serviceclass = rs.getString( "ServiceClass" );
    		
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
    
    //查詢單筆資料(查詢各table)
    public boolean loaddata( String tablename, String dataserno )
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
    		stmts = conn.prepareStatement("select * from " + tablename + " where Serno = '" + dataserno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.serno = rs.getString( "Serno" );
    		this.themeclass = rs.getString( "ThemeClass" );
    		this.cakeclass = rs.getString( "CakeClass" ); 
    		this.serviceclass =  rs.getString( "ServiceClass" );
    		
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
