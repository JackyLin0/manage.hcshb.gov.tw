/*
 * 撰寫日期：2008/2/18
 * 程式名稱：MenuData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
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

public class MenuData {
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
    private String target = null;
    private String startusing = null;
    private Integer fsort = null;
    private String showlink = null;
    private String clientfile1 = null;
    private String serverfile1 = null;
    private String clientfile2 = null;
    private String serverfile2 = null;
    private String expfile2 = null;
    private String clientfile3 = null;
    private String serverfile3 = null;
    private String expfile3 = null;
    private String clientfile4 = null;
    private String serverfile4 = null;
    private String expfile4 = null;
    private String clientfile5 = null;
    private String serverfile5 = null;
    private String expfile5 = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    private String themeclass = null;
    private String cakeclass = null;
    private String serviceclass = null;
    
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getClientfile4() {
		return clientfile4;
	}
	public void setClientfile4(String clientfile4) {
		this.clientfile4 = clientfile4;
	}
	public String getClientfile5() {
		return clientfile5;
	}
	public void setClientfile5(String clientfile5) {
		this.clientfile5 = clientfile5;
	}
	public String getExpfile4() {
		return expfile4;
	}
	public void setExpfile4(String expfile4) {
		this.expfile4 = expfile4;
	}
	public String getExpfile5() {
		return expfile5;
	}
	public void setExpfile5(String expfile5) {
		this.expfile5 = expfile5;
	}
	public String getServerfile4() {
		return serverfile4;
	}
	public void setServerfile4(String serverfile4) {
		this.serverfile4 = serverfile4;
	}
	public String getServerfile5() {
		return serverfile5;
	}
	public void setServerfile5(String serverfile5) {
		this.serverfile5 = serverfile5;
	}
	public String getClientfile1() {
		return clientfile1;
	}
	public void setClientfile1(String clientfile1) {
		this.clientfile1 = clientfile1;
	}
	public String getClientfile2() {
		return clientfile2;
	}
	public void setClientfile2(String clientfile2) {
		this.clientfile2 = clientfile2;
	}
	public String getClientfile3() {
		return clientfile3;
	}
	public void setClientfile3(String clientfile3) {
		this.clientfile3 = clientfile3;
	}
	public String getExpfile2() {
		return expfile2;
	}
	public void setExpfile2(String expfile2) {
		this.expfile2 = expfile2;
	}
	public String getExpfile3() {
		return expfile3;
	}
	public void setExpfile3(String expfile3) {
		this.expfile3 = expfile3;
	}
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
	public String getServerfile1() {
		return serverfile1;
	}
	public void setServerfile1(String serverfile1) {
		this.serverfile1 = serverfile1;
	}
	public String getServerfile2() {
		return serverfile2;
	}
	public void setServerfile2(String serverfile2) {
		this.serverfile2 = serverfile2;
	}
	public String getServerfile3() {
		return serverfile3;
	}
	public void setServerfile3(String serverfile3) {
		this.serverfile3 = serverfile3;
	}
	public String getShowlink() {
		return showlink;
	}
	public void setShowlink(String showlink) {
		this.showlink = showlink;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
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
	//新增資料
    public boolean create(String tablename)
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
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	PreparedStatement stmts5 = null;
    	PreparedStatement stmts6 = null;
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	ResultSet rs2 = null;
    	ResultSet rs3 = null;
    	ResultSet rs6 = null;
    	
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
    		
    		//排序start
    		int mcount1 = 0;
    		if ( fsort != 0 )
    		{
    			stmts1 = conn.prepareStatement("select count(*) as mcount from " + tablename + " where IsLevel = " + islevel + " and Fsort = " + fsort);
    			stmts1.clearParameters();
        		
        		rs1 = stmts1.executeQuery();        		
        		while ( rs1.next() )
        		{
        			mcount1 = Integer.parseInt(rs1.getString("mcount"));
        		}
    		}else if ( fsort == 0 ) {
    			stmts2 = conn.prepareStatement("select max(Fsort) as fsort from " + tablename + " where IsLevel = " + islevel);
    			stmts2.clearParameters();
        		
        		rs2 = stmts2.executeQuery();
        		while ( rs2.next() )
        		{
        			int mfsort = rs2.getInt("fsort");
        			this.fsort = mfsort + 1;
        		}
    		}
    		if ( mcount1 > 0 )
    		{
    			StringBuffer sSql = new StringBuffer();
        		
        		sSql.append( "select * from " + tablename + " where Serno <> '" + serno + "' and fsort >= " + fsort + " and IsLevel = " + islevel );

        		stmts3 = conn.prepareStatement( sSql.toString() );
        		stmts3.clearParameters();
           
        		rs3 = stmts3.executeQuery();
        		
        		for ( int i=0; rs3.next(); i++ )
        		{
        			int mfsort = rs3.getInt( "Fsort") + 1;
                    //update
            		stmts4 = conn.prepareStatement(
            			"update " + tablename + " set Fsort = ? where Serno = ?" ); 
            		stmts4.clearParameters();    	 	
            		stmts4.setInt(1, mfsort );
            		stmts4.setString(2, rs3.getString( "Serno" ) );
            		int updateRow1 = stmts4.executeUpdate();
            		if ( updateRow1 <= 0 )
            		{
            			try {
            				conn.rollback();
            				errorMsg = "Update table fail.";
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            }
            		}
        		}
    		}
    		
    		//上一層資料
    		if ( islevel == 1 )
    		{
    			this.topserno = "";
    			this.toplevelcontent ="";
    			this.toplevellink = "";
    		}else{
    			stmts6 = conn.prepareStatement("select * from " +tablename + " where Serno = '" + topserno + "'");
    			stmts6.clearParameters();
    			
    			rs6 = stmts6.executeQuery();
    			if ( !rs6.next() )
    			{
    				errorMsg = "No the data";
    				return false;
    			}
    			this.topserno = rs6.getString( "Serno" );
    			this.toplevelcontent = rs6.getString( "IsLevelContent" );
    			this.toplevellink = rs6.getString( "IsLevelLink" );
    		}
    		
    		//inser into
    		String sql =  "insert into " + tablename;
    		       sql += "(Serno,TopSerno,TopLevelContent,TopLevelLink,IsLevel,IsLevelContent,IsLevelLink,Flag,Target,StartUsing,Fsort,ClientFile1,ServerFile1,ShowLink,PostName,CreateDate,UpdateDate,ThemeClass,CakeClass,ServiceClass)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		       
    		stmts5 = conn.prepareStatement(sql);
    		stmts5.setString(1, serno );
    		stmts5.setString(2, topserno );
    		stmts5.setString(3, toplevelcontent );
    		stmts5.setString(4, toplevellink );
    		stmts5.setInt(5, islevel );
    		stmts5.setString(6, islevelcontent );
    		stmts5.setString(7, islevellink );
    		stmts5.setString(8, flag );
    		stmts5.setString(9, target );
    		stmts5.setString(10, startusing );
    		stmts5.setInt(11, fsort );
    		stmts5.setString(12, clientfile1 );
    		stmts5.setString(13, serverfile1 );
    		stmts5.setString(14, showlink );
    		stmts5.setString(15, postname );
    		stmts5.setString(16, getNowYear() );
    		stmts5.setString(17, getNowYear() );
    		stmts5.setString(18, themeclass);
    		stmts5.setString(19, cakeclass);
    		stmts5.setString(20, serviceclass);
    		int updateRow = stmts5.executeUpdate();
    		
    		if ( updateRow <= 0 )
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
    
    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
    			if ( rs1 != null ) rs1.close();
    			if ( rs2 != null ) rs2.close();
    			if ( rs3 != null ) rs3.close();
    			if ( rs6 != null ) rs6.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			if ( stmts4 != null ) stmts4.close();
    			if ( stmts5 != null ) stmts5.close();
    			if ( stmts6 != null ) stmts6.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
    				
	//查詢多筆資料及筆數
    public ArrayList<Object> findByday( String tablename, String islevelcontent )
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
    		
    		sSql.append( "select * from " + tablename );

    		if ( !islevelcontent.equals("") )
    			sSql.append( " where  IsLevelContent like '%" + islevelcontent + "%'" );
    		
    		sSql.append( " order by Serno desc" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			MenuData tmpQuery = new MenuData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setTopserno( rs.getString( "TopSerno" ) );
    			tmpQuery.setToplevelcontent( rs.getString( "TopLevelContent" ) );
    			tmpQuery.setToplevellink( rs.getString( "TopLevelLink" ) );
    			tmpQuery.setIslevel( rs.getInt( "IsLevel" ) );
    			tmpQuery.setIslevelcontent( rs.getString( "IsLevelContent" ) );
    			tmpQuery.setIslevellink( rs.getString( "IsLevelLink" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
    			tmpQuery.setTarget( rs.getString( "Target" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setFsort( rs.getInt( "Fsort" ) );
    			tmpQuery.setClientfile1( rs.getString( "ClientFile1" ) );
    			tmpQuery.setServerfile1( rs.getString( "ServerFile1" ) );
    			tmpQuery.setClientfile2( rs.getString( "ClientFile2" ) );
    			tmpQuery.setServerfile2( rs.getString( "ServerFile2" ) );
    			tmpQuery.setExpfile2( rs.getString( "ExpFile2" ) );
    			tmpQuery.setClientfile3( rs.getString( "ClientFile3" ) );
    			tmpQuery.setServerfile3( rs.getString( "ServerFile3" ) );
    			tmpQuery.setExpfile3( rs.getString( "ExpFile3" ) );
    			tmpQuery.setClientfile4( rs.getString( "ClientFile4" ) );
    			tmpQuery.setServerfile4( rs.getString( "ServerFile4" ) );
    			tmpQuery.setExpfile4( rs.getString( "ExpFile4" ) );
    			tmpQuery.setClientfile5( rs.getString( "ClientFile5" ) );
    			tmpQuery.setServerfile5( rs.getString( "ServerFile5" ) );
    			tmpQuery.setExpfile5( rs.getString( "ExpFile5" ) );
    			tmpQuery.setShowlink( rs.getString( "ShowLink" ) );
    			tmpQuery.setPostname( rs.getString( "PostName" ) );
    			tmpQuery.setCreatedate( rs.getString( "CreateDate" ) );
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
    		System.out.println(errorMsg);
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
	
	//查詢多筆資料及筆數(查詢第二層)
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
    		
    		sSql.append( "select * from " + tablename + " where StartUsing = '1' order by IsLevel" );

    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			MenuData tmpQuery = new MenuData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setTopserno( rs.getString( "TopSerno" ) );
    			tmpQuery.setToplevelcontent( rs.getString( "TopLevelContent" ) );
    			tmpQuery.setToplevellink( rs.getString( "TopLevelLink" ) );
    			tmpQuery.setIslevel( rs.getInt( "IsLevel" ) );
    			tmpQuery.setIslevelcontent( rs.getString( "IsLevelContent" ) );
    			tmpQuery.setIslevellink( rs.getString( "IsLevelLink" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
    			tmpQuery.setTarget( rs.getString( "Target" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setFsort( rs.getInt( "Fsort" ) );
    			tmpQuery.setClientfile1( rs.getString( "ClientFile1" ) );
    			tmpQuery.setServerfile1( rs.getString( "ServerFile1" ) );
    			tmpQuery.setClientfile2( rs.getString( "ClientFile2" ) );
    			tmpQuery.setServerfile2( rs.getString( "ServerFile2" ) );
    			tmpQuery.setExpfile2( rs.getString( "ExpFile2" ) );
    			tmpQuery.setClientfile3( rs.getString( "ClientFile3" ) );
    			tmpQuery.setServerfile3( rs.getString( "ServerFile3" ) );
    			tmpQuery.setExpfile3( rs.getString( "ExpFile3" ) );
    			tmpQuery.setClientfile4( rs.getString( "ClientFile4" ) );
    			tmpQuery.setServerfile4( rs.getString( "ServerFile4" ) );
    			tmpQuery.setExpfile4( rs.getString( "ExpFile4" ) );
    			tmpQuery.setClientfile5( rs.getString( "ClientFile5" ) );
    			tmpQuery.setServerfile5( rs.getString( "ServerFile5" ) );
    			tmpQuery.setExpfile5( rs.getString( "ExpFile5" ) );
    			tmpQuery.setShowlink( rs.getString( "ShowLink" ) );
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
	
	//查詢多筆資料及筆數
    public ArrayList<Object> findBysort( String tablename, int islevel )
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
    		
    		sSql.append( "select * from " + tablename + " where StartUsing = '1' and IsLevel = " + islevel + " order by Fsort desc" );

    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			MenuData tmpQuery = new MenuData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setTopserno( rs.getString( "TopSerno" ) );
    			tmpQuery.setToplevelcontent( rs.getString( "TopLevelContent" ) );
    			tmpQuery.setToplevellink( rs.getString( "TopLevelLink" ) );
    			tmpQuery.setIslevel( rs.getInt( "IsLevel" ) );
    			tmpQuery.setIslevelcontent( rs.getString( "IsLevelContent" ) );
    			tmpQuery.setIslevellink( rs.getString( "IsLevelLink" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
    			tmpQuery.setTarget( rs.getString( "Target" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setFsort( rs.getInt( "Fsort" ) );
    			tmpQuery.setClientfile1( rs.getString( "ClientFile1" ) );
    			tmpQuery.setServerfile1( rs.getString( "ServerFile1" ) );
    			tmpQuery.setPostname( rs.getString( "PostName" ) );
    			tmpQuery.setCreatedate( rs.getString( "CreateDate" ) );
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
    		this.topserno = rs.getString( "TopSerno" );
    		this.toplevelcontent = rs.getString( "TopLevelContent" );
    		this.toplevellink = rs.getString( "TopLevelLink" );
    		this.islevel = rs.getInt( "IsLevel" );
    		this.islevelcontent = rs.getString( "IsLevelContent" );
    		this.islevellink = rs.getString( "IsLevelLink" );
    		this.flag = rs.getString( "Flag" );
    		this.target = rs.getString( "Target" );
    		this.startusing = rs.getString( "StartUsing" );
    		this.fsort = rs.getInt( "Fsort" );
    		this.clientfile1 = rs.getString( "ClientFile1" );
    		this.serverfile1 = rs.getString( "ServerFile1" );
    		this.clientfile2 = rs.getString( "ClientFile2" );
    		this.serverfile2 = rs.getString( "ServerFile2" );
    		this.expfile2 = rs.getString( "ExpFile2" );
    		this.clientfile3 = rs.getString( "ClientFile3" );
    		this.serverfile3 = rs.getString( "ServerFile3" );
    		this.expfile3 = rs.getString( "ExpFile3" );
    		this.clientfile4 = rs.getString( "ClientFile4" );
    		this.serverfile4 = rs.getString( "ServerFile4" );
    		this.expfile4 = rs.getString( "ExpFile4" );
    		this.clientfile5 = rs.getString( "ClientFile5" );
    		this.serverfile5 = rs.getString( "ServerFile5" );
    		this.expfile5 = rs.getString( "ExpFile5" );
    		this.showlink = rs.getString( "ShowLink" );
    		this.postname = rs.getString( "PostName" );
    		this.themeclass = rs.getString( "ThemeClass" );
    		this.cakeclass = rs.getString( "CakeClass" );
    		this.serviceclass = rs.getString( "ServiceClass" );
    		
    		return true;
    	} catch ( SQLException sqle ) {
    		errorMsg = "Query into table error(Message): " + sqle.toString();
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
    public boolean store( String tablename )
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
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	PreparedStatement stmts5 = null;
    	PreparedStatement stmts6 = null;
    	ResultSet rs1 = null;
    	ResultSet rs2 = null;
    	ResultSet rs3 = null;
    	ResultSet rs6 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//排序start
    		int mcount1 = 0;
    		if ( fsort != 0 )
    		{
    			stmts1 = conn.prepareStatement("select count(*) as mcount from " + tablename + " where IsLevel = " + islevel + " and Fsort = " + fsort);
    			stmts1.clearParameters();
        		
        		rs1 = stmts1.executeQuery();        		
        		while ( rs1.next() )
        		{
        			mcount1 = Integer.parseInt(rs1.getString("mcount"));
        		}
    		}else if ( fsort == 0 ) {
    			stmts2 = conn.prepareStatement("select max(Fsort) as fsort from " + tablename + " where IsLevel = " + islevel);
    			stmts2.clearParameters();
        		
        		rs2 = stmts2.executeQuery();
        		while ( rs2.next() )
        		{
        			int mfsort = rs2.getInt("fsort");
        			this.fsort = mfsort + 1;
        		}
    		}
    		if ( mcount1 > 0 )
    		{
    			StringBuffer sSql = new StringBuffer();
        		
        		sSql.append( "select * from " + tablename + " where Serno <> '" + serno + "' and fsort >= " + fsort + " and IsLevel = " + islevel );

        		stmts3 = conn.prepareStatement( sSql.toString() );
        		stmts3.clearParameters();
           
        		rs3 = stmts3.executeQuery();
        		
        		for ( int i=0; rs3.next(); i++ )
        		{
        			int mfsort = rs3.getInt( "Fsort") + 1;
                    //update
            		stmts4 = conn.prepareStatement(
            			"update " + tablename + " set Fsort = ? where Serno = ?" ); 
            		stmts4.clearParameters();    	 	
            		stmts4.setInt(1, mfsort );
            		stmts4.setString(2, rs3.getString( "Serno" ) );
            		int updateRow1 = stmts4.executeUpdate();
            		if ( updateRow1 <= 0 )
            		{
            			try {
            				conn.rollback();
            				errorMsg = "Update table fail.";
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            }
            		}
        		}
    		}
    		
    		//上一層資料
    		if ( islevel == 1 )
    		{
    			this.topserno = "0";
    			this.toplevelcontent ="";
    			this.toplevellink = "";
    		}else{
    			stmts6 = conn.prepareStatement("select * from " + tablename + " where Serno = '" + topserno + "'");
    			stmts6.clearParameters();
    			
    			rs6 = stmts6.executeQuery();
    			if ( !rs6.next() )
    			{
    				errorMsg = "No the data";
    				return false;
    			}
    			this.topserno = rs6.getString( "Serno" );
    			this.toplevelcontent = rs6.getString( "IsLevelContent" );
    			this.toplevellink = rs6.getString( "IsLevelLink" );
    		}

    		String sql =  "update " + tablename;
    		       sql += " set TopSerno = ?, TopLevelContent = ?, TopLevelLink = ?, IsLevel = ?, IsLevelContent = ?, IsLevelLink = ?, " +
    		              "Flag = ?, Target = ?, StartUsing = ?, Fsort = ?, ClientFile1 = ?, ServerFile1 = ?, PostName = ?, UpdateDate = ?, ThemeClass = ?, CakeClass = ?, ServiceClass = ? where Serno = ?";
		       
		    stmts5 = conn.prepareStatement(sql);
		    
		    stmts5.setString(1, topserno );
		    stmts5.setString(2, toplevelcontent );
		    stmts5.setString(3, toplevellink );
		    stmts5.setInt(4, islevel );
		    stmts5.setString(5, islevelcontent );
		    stmts5.setString(6, islevellink );
		    stmts5.setString(7, flag );
		    stmts5.setString(8, target );
		    stmts5.setString(9, startusing );
		    stmts5.setInt(10, fsort );
		    stmts5.setString(11, clientfile1 );
		    stmts5.setString(12, serverfile1 );
		    stmts5.setString(13, postname );
		    stmts5.setString(14, getNowYear() );
		    stmts5.setString(15, themeclass);
		    stmts5.setString(16, cakeclass);
		    stmts5.setString(17, serviceclass);
		    stmts5.setString(18, serno );
		    
    		int updateRow = stmts5.executeUpdate();
    		
    		if ( updateRow <= 0 )
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
    		
    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( rs1 != null ) rs1.close();
    			if ( rs2 != null ) rs2.close();
    			if ( rs3 != null ) rs3.close();
    			if ( rs6 != null ) rs6.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			if ( stmts4 != null ) stmts4.close();
    			if ( stmts5 != null ) stmts5.close();
    			if ( stmts6 != null ) stmts6.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }

    //刪除資料
    public boolean remove( String tablename, String sysRoot ) throws FileNotFoundException, IOException
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
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		String Menu_PATH = "";
     		if ( sysRoot.indexOf("/") == -1 )
     			Menu_PATH = sysRoot + "\\WEB-INF\\menu.properties";
     		else
     			Menu_PATH = sysRoot + "/WEB-INF/menu.properties";
			
			Properties menu = new Properties();
			menu.load(new FileInputStream(Menu_PATH)) ;
	        String menupath = menu.getProperty("menupath");
     		
     		String[] ary_mserno = SvString.split(serno,"||");
     		for ( int i=0; i<ary_mserno.length; i++ ) {
     			String msql = "select * from " + tablename + " where Serno = '" + ary_mserno[i] + "'";
     			stmts = conn.prepareStatement(msql);
        		stmts.clearParameters();
        		rs = stmts.executeQuery();
        		
        		if ( rs.next() ) {
        			//刪除檔案
        			String mflag = rs.getString("Flag");        			
        			String mislevellink = rs.getString("IsLevelLink");
        			
        			if ( mflag.equals("0") ) {    
        				String[] ary_link = SvString.split(mislevellink,"/");
            			String delpath = menupath + "/" + ary_link[0] + "/" + ary_link[1];
        				File d0 = new File(delpath,ary_link[2]);
        				if (d0.exists())
        					d0.delete();
        			}else if ( mflag.equals("1") ) {
        				String[] ary_link = SvString.split(mislevellink,"/");
            			String delpath = menupath + "/" + ary_link[0] + "/" + ary_link[1];
            			String sfile1 = rs.getString("ServerFile1");
            			if ( sfile1 != null && !sfile1.equals("null") ) {            				
            				File d1 = new File(delpath,sfile1);
            				if (d1.exists())
            					d1.delete();
            			}        				
        			}else if ( mflag.equals("3") ) {
        				String[] ary_link = SvString.split(mislevellink,"/");
            			String delpath = menupath + "/" + ary_link[0] + "/" + ary_link[1];
        				String sfile1 = rs.getString("ServerFile1");
        				
        				if ( sfile1 != null && !sfile1.equals("null") ) {
        					File d3 = new File(delpath,sfile1);
            				if (d3.exists())
            					d3.delete();
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
    		   if ( stmts != null ) stmts.close();
    		   if ( rs != null ) rs.close();
    		   if ( stmts1 != null ) stmts1.close();
    		   conn.close();
    	   }catch( SQLException se ) {
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }          		
    
    //修改資料(Menu圖片上傳)
    public boolean storeimg( String tablename )
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
     		
    		//update
    		stmts = conn.prepareStatement(
    				"update " + tablename + " set ClientFile2 = ?, ServerFile2 = ?, ExpFile2 = ?, ClientFile3 = ?, ServerFile3 = ?, ExpFile3 = ?, ClientFile4 = ?, ServerFile4 = ?, ExpFile4 = ?, ClientFile5 = ?, ServerFile5 = ?, ExpFile5 = ?, PostName = ?, Updatedate = ? where Serno = ?" ); 
    		stmts.clearParameters();    	 	
    		stmts.setString(1, clientfile2 );
    		stmts.setString(2, serverfile2 );
    		stmts.setString(3, expfile2 );
    		stmts.setString(4, clientfile3 );
    		stmts.setString(5, serverfile3 );
    		stmts.setString(6, expfile3 );
    		stmts.setString(7, clientfile4 );
    		stmts.setString(8, serverfile4 );
    		stmts.setString(9, expfile4 );
    		stmts.setString(10, clientfile5 );
    		stmts.setString(11, serverfile5 );
    		stmts.setString(12, expfile5 );
    		stmts.setString(13, postname );
    		stmts.setString(14, getNowYear() );
    		stmts.setString(15, serno );
    		
    		int updateRow = stmts.executeUpdate();
    		
    		if ( updateRow <= 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Update table fail.";
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
      			if ( stmts != null ) stmts.close();
      			conn.close();
      		} catch ( SQLException se ) {
      			errorMsg = "close Statment or connection error: " + se.toString();
      		}
      	}
      	return false;
    }
	
	//查詢多筆資料及筆數(查詢是否還有子系統)
    public ArrayList<Object> findBydata( String tablename, String topserno )
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
    		
    		sSql.append( "select * from " + tablename + " where StartUsing = '1' and TopSerno = '" + topserno + "' order by IsLevel" );

    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			MenuData tmpQuery = new MenuData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
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
