/*
 * 撰寫日期：2008/2/23
 * 程式名稱：InformationData.java
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

public class InformationData970425 extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //衛生資訊
    private String mserno = null;
    private String mclassname = null;
    private String posterdate = null;
    private String closedate = null;
    private String startusing = null;
    private String relateurl = null;
    private String relatename = null;
    private String updatedate = null;
    private int fsort = 0;
    private int detailno = 0;
    private String item = null;
    private String content = null;
    private String language = null;

    private String serverfile = null;
    private String imagemagick = null;
    private String smediafile = null;
    
	public String getImagemagick() {
		return imagemagick;
	}
	public void setImagemagick(String imagemagick) {
		this.imagemagick = imagemagick;
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
	public int getDetailno() {
		return detailno;
	}
	public void setDetailno(int detailno) {
		this.detailno = detailno;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getClosedate() {
		return closedate;
	}
	public void setClosedate(String closedate) {
		this.closedate = closedate;
	}
	public int getFsort() {
		return fsort;
	}
	public void setFsort(int fsort) {
		this.fsort = fsort;
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
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	
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
    		String mserno1 = "";
    		while ( rs.next() )
    		{
    			String mseq = rs.getString("seqno");
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
    		
    		//insert InformationData
    		String sql =  "insert into " + tablename;
    		       sql += "(Serno,PubUnitDN,PubUnitName,Mserno,Mclassname,PosterDate,CloseDate,StartUsing,RelateUrl,RelateName,Fsort,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, pubunitdn );
    		stmts2.setString(3, pubunitname );
    		stmts2.setString(4, mserno );
    		stmts2.setString(5, mclassname );
    		stmts2.setString(6, posterdate );
    		stmts2.setString(7, closedate );
    		stmts2.setString(8, startusing );
    		stmts2.setString(9, relateurl );
    		stmts2.setString(10, relatename );
    		stmts2.setInt(11, fsort );
    		stmts2.setString(12, postname );
    		stmts2.setString(13, getNowYear() );
    		stmts2.setString(14, getNowYear() );
    		
    		int updateRow2 = stmts2.executeUpdate();
    		
    		if ( updateRow2 < 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Insert into table fail(InformationData).";
    				System.out.println(errorMsg);
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}
    		
    		String[] ary_item = SvString.split(item,"||");
    		String[] ary_content = SvString.split(content,"||");
    		for ( int i=0; i<ary_item.length; i++ ) {
    			//找最大編號 start
        		stmts = conn.prepareStatement("select max(detailno) as seqno from InformationItem where Serno = ?" );
        		stmts.clearParameters();
        		stmts.setString(1,serno);
        		
        		rs = stmts.executeQuery();
     
        		int tempno1 = 0;
        		while ( rs.next() )
        		{
        			String mseq = rs.getString("seqno");
        			if ( mseq == null)
        			{
        				tempno1 = 1;
        			}else{
        				tempno1 = Integer.parseInt(mseq)+1;
        			}
        			this.detailno = tempno1;
        		}
        		//找最大編號 end
        		
    			String mcontent = ary_content[i];
    			if ( mcontent.equals("a") )
    				mcontent = "";
    			//insert InformationData
        		String msql =  "insert into InformationItem";
        		       msql += "(Serno,DetailNo,Item,Content)";
        		       msql += " values(?,?,?,?)";
        		
        		stmts3 = conn.prepareStatement(msql);
        		
        		stmts3.clearParameters();
        		stmts3.setString(1, serno );
        		stmts3.setInt(2, detailno );
        		stmts3.setString(3, ary_item[i] );
        		stmts3.setString(4, mcontent );
        		
        		int updateRow3 = stmts3.executeUpdate();
        		
        		if ( updateRow3 < 0 )
        		{
        			try {
        				conn.rollback();
        				errorMsg = "Insert into table fail(InformationItem).";
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
    				errorMsg = "Insert into table fail(WebSiteLog).";
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
    			if ( stmts3 != null ) stmts3.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
	
	//查詢多筆資料及筆數(InformationData)
    public ArrayList findByday( String tablename, String punit, String qclass )
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

    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and PubUnitDN like '%" + mpunit[0] + "%'" );
    		}
    		
    		if ( qclass != null && !qclass.equals("") ) {
    			String[] ary_class = SvString.split(qclass,"-");
    			sSql.append( " and Mserno = '" + ary_class[0] + "'" );
    		}
    		sSql.append( " order by UpdateDate desc,Serno desc,PubUnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList result = new ArrayList();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			InformationData970425 tmpQuery = new InformationData970425();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setMserno( rs.getString( "Mserno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
    			tmpQuery.setPosterdate( rs.getString( "PosterDate" ) );
    			tmpQuery.setClosedate( rs.getString( "CloseDate" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setRelateurl( rs.getString( "RelateUrl" ) );
    			tmpQuery.setRelatename( rs.getString( "RelateName" ) );
    			tmpQuery.setFsort( rs.getInt( "Fsort" ) );
    			tmpQuery.setUpdatedate( rs.getString( "Updatedate" ) );
    			
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
    public boolean load( String serno, String tablename )
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
    		this.mserno = rs.getString( "Mserno" );
    		this.mclassname = rs.getString( "Mclassname" );
    		this.posterdate = rs.getString( "PosterDate" );
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
	
	//查詢多筆資料及筆數(InformationItem)
    public ArrayList findByday( String serno )
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
    		
    		sSql.append( "select * from InformationItem where Serno = '" + serno + "'" );

    		sSql.append( " order by DetailNo" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList result = new ArrayList();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			InformationData970425 tmpQuery = new InformationData970425();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setDetailno( rs.getInt( "DetailNo" ) );
    			tmpQuery.setItem( rs.getString( "Item" ) );
    			tmpQuery.setContent( rs.getString( "Content" ) );
    			
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
    	
    	//找最大序號 start
    	ResultSet rs = null;
    	ResultSet rs3 = null;
    	ResultSet rs5 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	PreparedStatement stmts5 = null;
    	PreparedStatement stmts6 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//update
    		stmts2 = conn.prepareStatement(
    			"update " + tablename + " set Mserno = ?, Mclassname = ?, PosterDate = ?, CloseDate = ?, StartUsing = ?, RelateUrl = ?, RelateName = ?, Fsort = ?, PostName = ?, UpdateDate = ? where Serno = ? and PubUnitDN = ?");
    		   		
    		stmts2.setString(1, mserno );
    		stmts2.setString(2, mclassname );
    		stmts2.setString(3, posterdate );
    		stmts2.setString(4, closedate );
    		stmts2.setString(5, startusing );
    		stmts2.setString(6, relateurl );
    		stmts2.setString(7, relatename );
    		stmts2.setInt(8, fsort );
    		stmts2.setString(9, postname );
    		stmts2.setString(10, getNowYear() );
    		stmts2.setString(11, serno );
    		stmts2.setString(12, pubunitdn );
    		
    		int updateRow2 = stmts2.executeUpdate();
    		
    		if ( updateRow2 < 0 )
    		{
    			try {
    				conn.rollback();
    				errorMsg = "Insert into table fail(Statistics).";
    				System.out.println(errorMsg);
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}
    		
    		String msql = "select * from InformationItem where Serno = '" + serno + "'";
 			stmts3 = conn.prepareStatement(msql);
    		stmts3.clearParameters();
    		rs3 = stmts3.executeQuery();
    		
    		if ( rs3.next() ) {
    			String dsql = "delete InformationItem where Serno = '" + serno + "'";
    			stmts4 = conn.prepareStatement(dsql);
    			int updateRow4 = stmts4.executeUpdate();
    			if ( updateRow4 < 0 ) 
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

    		String[] ary_item = SvString.split(item,"||");
    		String[] ary_content = SvString.split(content,"||");
    		for ( int i=0; i<ary_item.length; i++ ) {
    			//找最大編號 start
        		stmts5 = conn.prepareStatement("select max(detailno) as seqno from InformationItem where Serno = ?" );
        		stmts5.clearParameters();
        		stmts5.setString(1,serno);
        		
        		rs5 = stmts5.executeQuery();
     
        		int tempno1 = 0;
        		while ( rs5.next() )
        		{
        			String mseq = rs5.getString("seqno");
        			if ( mseq == null)
        			{
        				tempno1 = 1;
        			}else{
        				tempno1 = Integer.parseInt(mseq)+1;
        			}
        			this.detailno = tempno1;
        		}
        		//找最大編號 end
        		
    			String mcontent = ary_content[i];
    			if ( mcontent.equals("a") )
    				mcontent = "";
    			//insert InformationData
        		String msql6 =  "insert into InformationItem";
        		       msql6 += "(Serno,DetailNo,Item,Content)";
        		       msql6 += " values(?,?,?,?)";
        		
        		stmts6 = conn.prepareStatement(msql6);
        		
        		stmts6.clearParameters();
        		stmts6.setString(1, serno );
        		stmts6.setInt(2, detailno );
        		stmts6.setString(3, ary_item[i] );
        		stmts6.setString(4, mcontent );
        		
        		int updateRow6 = stmts6.executeUpdate();
        		
        		if ( updateRow6 < 0 )
        		{
        			try {
        				conn.rollback();
        				errorMsg = "Insert into table fail(InformationItem).";
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
    				errorMsg = "Insert into table fail(WebSiteLog).";
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
    		try {
    			if ( rs != null ) rs.close();
    			if ( rs3 != null ) rs3.close();
    			if ( rs5 != null ) rs5.close();
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
    	
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	PreparedStatement stmts5 = null;
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);

     		String[] ary_mserno = SvString.split(serno,"||");
     		
     		for ( int i=0; i<ary_mserno.length; i++ ) {
     			String msql = "select * from " + tablename + " where Serno = '" + ary_mserno[i] + "'";
     			stmts = conn.prepareStatement(msql);
        		stmts.clearParameters();
        		rs = stmts.executeQuery();
        		
        		if ( rs.next() ) {
        			this.setSerno(rs.getString( "Serno" ));
        			this.setPubunitdn(rs.getString( "PubUnitDN" ));
        			this.setPubunitname(rs.getString( "PubUnitName" ));
        			this.setSubject(rs.getString( "Mclassname" ));
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

        			//刪除資料(InformationData)
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

        			//刪除資料(Informationitem)
        			String dsqlitem = "delete InformationItem where Serno = '" + ary_mserno[i] + "'";
        			
        			stmts5 = conn.prepareStatement(dsqlitem);
        			int updateRow5 = stmts5.executeUpdate();
        			if ( updateRow5 <= 0 ) 
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
    		   if ( rs != null ) rs.close();
    		   if ( rs1 != null ) rs1.close();
    		   if ( stmts != null ) stmts.close();
    		   if ( stmts1 != null ) stmts1.close();
    		   if ( stmts2 != null ) stmts2.close();
    		   if ( stmts3 != null ) stmts3.close();
    		   if ( stmts4 != null ) stmts4.close();
    		   if ( stmts5 != null ) stmts5.close();
    		   conn.close();
    	   }catch( SQLException se ) {
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }          		
	
	//查詢多筆資料及筆數(刪除檔案)
    public ArrayList findBydel( String tablename, String serno )
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
    		ArrayList result = new ArrayList();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			InformationData970425 tmpQuery = new InformationData970425();
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
