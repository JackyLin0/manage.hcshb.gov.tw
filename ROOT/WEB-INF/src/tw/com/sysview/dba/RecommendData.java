/*
 * 撰寫日期：2010/5/27
 * 程式名稱：RecommendData.java
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

public class RecommendData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String websitedn = null;
    private String websitename = null;
    private String relateurl = null;
    private String relatename = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;

    private String language = null;
    //Menu
    private String menuserno = null;
    private String topserno = null;
    private String contlink = null;
    private int islevel = 0;
    private String islevelcontent = null;

	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public int getIslevel() {
		return islevel;
	}
	public void setIslevel(int islevel) {
		this.islevel = islevel;
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
	public String getIslevelcontent() {
		return islevelcontent;
	}
	public void setIslevelcontent(String islevelcontent) {
		this.islevelcontent = islevelcontent;
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
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}

	//新增資料
    public boolean create( String table )
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
    	ResultSet rs2 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		//先刪除資料再新增
     		String msql = "select * from " + tablename + " where WebSiteDN = '" + websitedn + "'";
     		stmts = conn.prepareStatement(msql);
    		stmts.clearParameters();
    		rs = stmts.executeQuery();
    		
    		if ( rs.next() ) {
    			//刪除資料
    			String dsql = "delete " + tablename + " where WebSiteDN = '" + websitedn + "'";
    			
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
    		
    		if ( menuserno != null && !menuserno.equals("null") && !menuserno.equals("") ) {
    			String[] ary_menuserno = SvString.split(menuserno, "-");
    			for ( int i=0; i<ary_menuserno.length; i++ ) {
    	    		//找最大序號 start
    	    		stmts2 = conn.prepareStatement("select max(serno) as seqno from " + tablename + " where substring(serno,1,8) = ?" );
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
    	    		
    				MenuData qmenu = new MenuData();
    				qmenu.load(table, ary_menuserno[i]);
    				String mrelateurl = "home.jsp?mserno=" + qmenu.getTopserno() + "&serno=" + qmenu.getSerno() + "&menudata=" + table + "&contlink=" + SvString.right(qmenu.getIslevellink(),"/");
    				String mrelatename = qmenu.getIslevelcontent();
    				
    				//insert
    	    		String sql =  "insert into " + tablename;
    	    		       sql += "(Serno,MenuSerno,PubUnitDN,PubUnitName,WebSiteDN,WebSiteName,RelateUrl,RelateName,PostName,CreateDate,UpdateDate)";
    	    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?)";
    	    		       
    	    		stmts3 = conn.prepareStatement(sql);
    	    		
    	    		stmts3.clearParameters();
    	    		stmts3.setString(1, serno );
    	    		stmts3.setString(2, ary_menuserno[i] );
    	    		stmts3.setString(3, pubunitdn );
    	    		stmts3.setString(4, pubunitname );
    	    		stmts3.setString(5, websitedn );
    	    		stmts3.setString(6, websitename );
    	    		stmts3.setString(7, mrelateurl );
    	    		stmts3.setString(8, mrelatename );
    	    		stmts3.setString(9, postname );
    	    		stmts3.setString(10, getNowYear() );
    	    		stmts3.setString(11, getNowYear() );
    	    	    		
    	    	    int updateRow3 = stmts3.executeUpdate();
    	    	    		
    	    	    if ( updateRow3 < 0 ) {
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

    		}
    		
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
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }

	//查詢多筆資料及筆數
    public ArrayList<Object> findBysort( String table, int islevel, String topserno )
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
    		
    		sSql.append( "select * from " + table + " where StartUsing = '1' and IsLevel =" + islevel );
    		
    		if ( topserno != null && !topserno.equals("null") && !topserno.equals("") ) {
    			sSql.append( " and TopSerno = '" + topserno + "'" );
    		}
    		sSql.append( " order by Fsort desc" );

    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			RecommendData tmpQuery = new RecommendData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setTopserno( rs.getString( "TopSerno" ) );
    			tmpQuery.setIslevel( rs.getInt( "IsLevel" ) );
    			tmpQuery.setIslevelcontent( rs.getString( "IsLevelContent" ) );
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
    public boolean load( String serno, String tablename, String websitedn )
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
    		stmts = conn.prepareStatement("select * from " + tablename + " where MenuSerno = '" + serno + "' and WebSiteDN = '" + websitedn + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.serno = rs.getString( "Serno" );
    		this.menuserno = rs.getString( "MenuSerno" );
    		this.pubunitdn = rs.getString( "PubUnitDN" );
    		this.pubunitname = rs.getString( "PubUnitName" );
    		this.websitedn = rs.getString( "WebSiteDN" );
    		this.websitename = rs.getString( "WebSiteName" ); 
    		this.relateurl = rs.getString( "RelateUrl" );
    		this.relatename = rs.getString( "RelateName" );
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

    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    

}
