/*
 * 撰寫日期：2008/2/14
 * 程式名稱：WebSiteLog.java
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

public class WebSiteLog {
	private int allrecordCount = 0;
	
    private String errorMsg = null;
    	
	public String serno = null;
	public String pubunitdn = null;
	public String pubunitname = null;
	public String tablename = null;
	public String unitname = null;
	public String subject = null;
	public String postname = null;
	public String webip = null;
	public String status = null;
	public String flag = null;
	
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getTablename() {
		return tablename;
	}
	public void setTablename(String tablename) {
		this.tablename = tablename;
	}
	public String getUnitname() {
		return unitname;
	}
	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}
	public String getWebip() {
		return webip;
	}
	public void setWebip(String webip) {
		this.webip = webip;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}

	//新增中文版log資料(WebSiteLog)
    public boolean createlog(Connection conn, String language)
    {
    	PreparedStatement stmtslog = null;
    	ResultSet rslog = null;
    	PreparedStatement stmtslog1 = null;
    	
    	try {
    		if ( language.equals("ch") )
    			this.flag = "chinese";
    		else if ( language.equals("en") )
    			this.flag = "english";
    		else if ( language.equals("en") )
    			this.flag = "japan";
    		else
    			this.flag = language;

    		stmtslog = conn.prepareStatement("select * from WebSiteLog where Serno = '" + serno + "' and PubUnitDN = '" + pubunitdn + "' and TableName = '" + tablename + "'");
    		stmtslog.clearParameters();
    		rslog = stmtslog.executeQuery();
    		if ( !rslog.next() ) {
                //inser into WebSiteLog
        		String sql =  "insert into WebSiteLog";
        		       sql += "(Serno,PubUnitDN,PubUnitName,TableName,UnitName,Subject,PostName,UpdateDate,WebIP,Status,Flag)";
        		       sql += " values(?,?,?,?,?,?,?,?,?,?,?)";
        		
        		stmtslog = conn.prepareStatement(sql);
        		stmtslog.clearParameters();
        		stmtslog.setString(1, serno );
        		stmtslog.setString(2, pubunitdn );
        		stmtslog.setString(3, pubunitname );
        		stmtslog.setString(4, tablename );
        		stmtslog.setString(5, unitname );
        		stmtslog.setString(6, subject );
        		stmtslog.setString(7, postname );
        		stmtslog.setString(8, getNowYear() );
        		stmtslog.setString(9, webip );
        		stmtslog.setString(10, status );
        		stmtslog.setString(11, this.flag );
        		
        		int updateRow = stmtslog.executeUpdate();
        		
        		if ( updateRow <= 0 )
        		{
        			errorMsg = "Insert into table(WebSiteLog) fail.";
        			return false;
        		}	
        		
        		return true;
    		}else{
    			stmtslog1 = conn.prepareStatement(
        			"update WebSiteLog set UnitName = ?, Subject = ?, PostName = ?, UpdateDate = ?, WebIP = ?, Status = ?, Flag = ? where Serno = ? and PubUnitDN = ? and TableName = ?" ); 
    			stmtslog1.clearParameters();    	 	
    			stmtslog1.setString(1, unitname );
    			stmtslog1.setString(2, subject );
    			stmtslog1.setString(3, postname );
    			stmtslog1.setString(4, getNowYear() );
    			stmtslog1.setString(5, webip );
    			stmtslog1.setString(6, status );
    			stmtslog1.setString(7, this.flag );
    			stmtslog1.setString(8, serno );
    			stmtslog1.setString(9, pubunitdn );
    			stmtslog1.setString(10, tablename );
    			
        		int updateRow = stmtslog1.executeUpdate();
        		
        		if ( updateRow <= 0 )
        		{
        			errorMsg = "Update table(WebSiteLog) fail.";
        			return false;
        		}
        		return true;
    		}    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error(WebSiteLog): " + sqle.toString();
    	} finally {
    		try {    			
    			if ( stmtslog != null ) stmtslog.close();
    			if ( rslog != null ) rslog.close();
    			if ( stmtslog1 != null ) stmtslog1.close();
    		} catch ( SQLException se ) {
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
