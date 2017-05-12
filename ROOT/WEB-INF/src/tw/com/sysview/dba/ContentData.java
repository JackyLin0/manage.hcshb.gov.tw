/*
 * 撰寫日期：2008/2/19
 * 程式名稱：ContentData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ContentData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String serno = null;
    private String topserno = null;
    private String toplevelcontent = null;
    private String toplevellink = null;
    private Integer islevel = null;
    private String islevelcontent = null;
    private String islevellink = null;
    private String flag = null;
    private String startusing = null;
    private Integer fsort = null;
    private String postname = null;
    private String updatedate = null;
    
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public Integer getFsort() {
		return fsort;
	}
	public void setFsort(Integer fsort) {
		this.fsort = fsort;
	}
	public Integer getIslevel() {
		return islevel;
	}
	public void setIslevel(Integer islevel) {
		this.islevel = islevel;
	}
	public String getIslevelcontent() {
		return islevelcontent;
	}
	public void setIslevelcontent(String islevelcontent) {
		this.islevelcontent = islevelcontent;
	}
	public String getIslevellink() {
		return islevellink;
	}
	public void setIslevellink(String islevellink) {
		this.islevellink = islevellink;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
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
	public String getToplevelcontent() {
		return toplevelcontent;
	}
	public void setToplevelcontent(String toplevelcontent) {
		this.toplevelcontent = toplevelcontent;
	}
	public String getToplevellink() {
		return toplevellink;
	}
	public void setToplevellink(String toplevellink) {
		this.toplevellink = toplevellink;
	}
	public String getTopserno() {
		return topserno;
	}
	public void setTopserno(String topserno) {
		this.topserno = topserno;
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
	
	//查詢多筆資料及筆數
    public ArrayList<Object> findByday( String tablename )
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
    		
    		sSql.append( "select * from " + tablename + " where TopSerno <> '0' or ( TopSerno = '0' and Flag = '2' ) order by IsLevel,Fsort " );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			ContentData tmpQuery = new ContentData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setTopserno( rs.getString( "TopSerno" ) );
    			tmpQuery.setToplevelcontent( rs.getString( "TopLevelContent" ) );
    			tmpQuery.setToplevellink( rs.getString( "TopLevelLink" ) );
    			tmpQuery.setIslevel( rs.getInt( "IsLevel" ) );
    			tmpQuery.setIslevelcontent( rs.getString( "IsLevelContent" ) );
    			tmpQuery.setIslevellink( rs.getString( "IsLevelLink" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
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
	
}
