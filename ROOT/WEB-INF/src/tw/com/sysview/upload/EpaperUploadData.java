/*
 * 撰寫日期：2008/3/21
 * 程式名稱：EpaperUploadData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.upload;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import sysview.zhiren.function.SvNumber;
import sysview.zhiren.function.SvString;

public class EpaperUploadData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    private String serno = null;
    private String clientfile = null;
    private String serverfile = null;
    private String expfile = null;
    private String imagemagick = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    
	public String getClientfile() {
		return clientfile;
	}
	public void setClientfile(String clientfile) {
		this.clientfile = clientfile;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getExpfile() {
		return expfile;
	}
	public void setExpfile(String expfile) {
		this.expfile = expfile;
	}
	public String getImagemagick() {
		return imagemagick;
	}
	public void setImagemagick(String imagemagick) {
		this.imagemagick = imagemagick;
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
	public String getServerfile() {
		return serverfile;
	}
	public void setServerfile(String serverfile) {
		this.serverfile = serverfile;
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
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		String[] ary_server = SvString.split(serverfile,"||");
     		String[] ary_client = SvString.split(clientfile,"||");
     		String[] ary_exp = SvString.split(expfile,"||");
     		String[] ary_imagemagick = null;
     		
     		if ( imagemagick != null  && !imagemagick.equals("null") ) {
     			ary_imagemagick = SvString.split(imagemagick,"||");
     		}
     		for ( int i=0; i<ary_server.length; i++ ) {

        		//找最大序號 start
        		stmts = conn.prepareStatement("select max(Serno) as seqno from EpaperSendFile where substring(Serno,1,8) = ?" );
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
        		
        		//insert        		
        		String sql =  "insert into EpaperSendFile";
        		       sql += "(Serno,ClientFile,ServerFile,ExpFile,ImageMagick,PostName,CreateDate,UpdateDate)";
        		       sql += " values(?,?,?,?,?,?,?,?)";
        		       
        		stmts = conn.prepareStatement(sql);
        		
        		stmts.clearParameters();
        		stmts.setString(1, serno );
        		stmts.setString(2, ary_client[i] );
        		stmts.setString(3, ary_server[i] );
        		stmts.setString(4, ary_exp[i] );
        		if ( imagemagick != null  && !imagemagick.equals("null") ) {
        			stmts.setString(5, ary_imagemagick[i] );
        		}else{
        			stmts.setString(5, "" );
        		}       		
        		stmts.setString(6, postname );
        		stmts.setString(7, getNowYear() );
        		stmts.setString(8, getNowYear() );
        		
        		int updateRow = stmts.executeUpdate();
        		
        		if ( updateRow < 0 )
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
     		
    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
    			if ( stmts != null ) stmts.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
    			
	//查詢多筆資料及筆數
    public ArrayList<Object> findByday()
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
    		
    		sSql.append( "select * from EpaperSendFile order by UpdateDate desc" );

    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperUploadData tmpQuery = new EpaperUploadData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setClientfile( rs.getString( "ClientFile" ) );
    			tmpQuery.setServerfile( rs.getString( "ServerFile" ) );
    			tmpQuery.setExpfile( rs.getString( "ExpFile" ) );
    			tmpQuery.setImagemagick( rs.getString( "ImageMagick" ) );
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
    public boolean load( String serno )
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
    		stmts = conn.prepareStatement("select * from EpaperSendFile where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.clientfile = rs.getString( "ClientFile" );
    		this.serverfile = rs.getString( "ServerFile" );
    		this.expfile = rs.getString( "ExpFile" );
    		this.imagemagick = rs.getString( "ImageMagick" );
    		this.postname = rs.getString( "PostName" );
    		this.createdate = rs.getString( "CreateDate" );
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
    	
    	PreparedStatement stmts = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//update
    		stmts = conn.prepareStatement(
    				"update EpaperSendFile set ClientFile = ?, ServerFile = ?, ExpFile = ?, ImageMagick = ?, PostName = ?, Updatedate = ? where Serno = ?" ); 
    		stmts.clearParameters();    	 	
    		stmts.setString(1, clientfile );
    		stmts.setString(2, serverfile );
    		stmts.setString(3, expfile );
    		stmts.setString(4, imagemagick );
    		stmts.setString(5, postname );
    		stmts.setString(6, getNowYear() );
    		stmts.setString(7, serno );
    		
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

    //刪除資料
    public boolean remove( String path )
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
			
     		//刪除檔案路徑
	        String filepath = path;
     		String[] ary_mserno = SvString.split(serno,"&");
     		for ( int i=0; i<ary_mserno.length; i++ ) {
     			String[] ary_del = SvString.split(ary_mserno[i],"||");
     			String msql = "select * from EpaperSendFile where Serno = '" + ary_del[0] + "'";
     			stmts = conn.prepareStatement(msql);
        		stmts.clearParameters();
        		rs = stmts.executeQuery();
        		
        		if ( rs.next() ) {
        			//刪除檔案
        			File d0 = new File(filepath,rs.getString("ServerFile"));
    				if (d0.exists())
    					d0.delete();
    				//縮圖檔案
    				if ( rs.getString("ImageMagick") != null && !rs.getString("ImageMagick").equals("null") && !rs.getString("ImageMagick").equals("") ) {
    					File d1 = new File(filepath,rs.getString("ImageMagick"));
        				if (d1.exists())
        					d1.delete();
    				}
        			
        			//刪除資料
        			String dsql = "delete EpaperSendFile where Serno = '" + ary_del[0] + "'";
        			
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
    
    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }	
    
}
