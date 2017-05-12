/*
 * 撰寫日期：2007/3/24
 * 程式名稱：UploadData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.upload;

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

import sysview.zhiren.function.SvString;

public class UploadData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    private String serno = null;
    private int detailno = 0;
    private String flag = null;
    private String clientfile = null;
    private String serverfile = null;
    private String expfile = null;
    private String imagemagick = null;
    private String mainimage = null;
    private String cmediafile = null;
    private String smediafile = null;
    private String expmediafile = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
	
	public String getCmediafile() {
		return cmediafile;
	}
	public void setCmediafile(String cmediafile) {
		this.cmediafile = cmediafile;
	}
	public String getExpmediafile() {
		return expmediafile;
	}
	public void setExpmediafile(String expmediafile) {
		this.expmediafile = expmediafile;
	}
	public String getMainimage() {
		return mainimage;
	}
	public void setMainimage(String mainimage) {
		this.mainimage = mainimage;
	}
	public String getSmediafile() {
		return smediafile;
	}
	public void setSmediafile(String smediafile) {
		this.smediafile = smediafile;
	}
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
	public int getDetailno() {
		return detailno;
	}
	public void setDetailno(int detailno) {
		this.detailno = detailno;
	}
	public String getExpfile() {
		return expfile;
	}
	public void setExpfile(String expfile) {
		this.expfile = expfile;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
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
    public boolean create( String tablename )
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
     		String[] ary_smedia = null;
     		String[] ary_cmedia = null;
     		String[] ary_expmedia = null;
     		
     		if ( imagemagick != null  && !imagemagick.equals("null") ) {
     			ary_imagemagick = SvString.split(imagemagick,"||");
     		}
     		if ( smediafile != null && !smediafile.equals("null") ) {
     			ary_smedia = SvString.split(smediafile,"||");
         		ary_cmedia = SvString.split(cmediafile,"||");
         		ary_expmedia = SvString.split(expmediafile,"||");
     		}     		
     		
     		for ( int i=0; i<ary_server.length; i++ ) {
     			//找最大編號 start
        		stmts = conn.prepareStatement("select max(detailno) as seqno from " + tablename + " where Serno = ? and Flag = ?" );
        		stmts.clearParameters();
        		stmts.setString(1,serno);
        		stmts.setString(2,flag);
        		rs = stmts.executeQuery();
     
        		int tempno = 0;
        		while ( rs.next() )
        		{
        			String mseq = rs.getString("seqno");
        			if ( mseq == null)
        			{
        				tempno = 1;
        			}else{
        				tempno = Integer.parseInt(mseq)+1;
        			}
        			this.detailno = tempno;
        		}
        		//找最大編號 end
        		
        		//insert        		
        		String sql =  "insert into " + tablename;
        		       sql += "(Serno,DetailNo,Flag,ClientFile,ServerFile,ExpFile,ImageMagick,MainImage,CMediaFile,SMediaFile,ExpMediaFile,PostName,CreateDate,UpdateDate)";
        		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        		       
        		stmts = conn.prepareStatement(sql);
        		
        		stmts.clearParameters();
        		stmts.setString(1, serno );
        		stmts.setInt(2, detailno );
        		stmts.setString(3, flag );
        		stmts.setString(4, ary_client[i] );
        		stmts.setString(5, ary_server[i] );
        		stmts.setString(6, ary_exp[i] );
        		if ( imagemagick != null  && !imagemagick.equals("null") ) {
        			stmts.setString(7, ary_imagemagick[i] );
        		}else{
        			stmts.setString(7, "" );
        		}
        		stmts.setString(8, "N" );        		
        		if ( smediafile != null && !smediafile.equals("null") ) {
        			stmts.setString(9, ary_cmedia[i] );
            		stmts.setString(10, ary_smedia[i] );
            		stmts.setString(11, ary_expmedia[i] );
        		}else{        			
            		stmts.setString(9, "" );
            		stmts.setString(10, "" );
            		stmts.setString(11, "" );
        		}        		
        		stmts.setString(12, postname );
        		stmts.setString(13, getNowYear() );
        		stmts.setString(14, getNowYear() );
        		
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
  //新增資料
    public boolean createtest( String tablename )
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
     		System.out.println("serverfile="+serverfile);
     		System.out.println("serverfile length:"+ary_server.length);
     		System.out.println("serno:"+serno);
     		System.out.println("flag:"+flag);
     		String[] ary_client = SvString.split(clientfile,"||");
     		String[] ary_exp = SvString.split(expfile,"||");
     		String[] ary_imagemagick = null;
     		String[] ary_smedia = null;
     		String[] ary_cmedia = null;
     		String[] ary_expmedia = null;
     		
     		if ( imagemagick != null  && !imagemagick.equals("null") ) {
     			ary_imagemagick = SvString.split(imagemagick,"||");
     		}
     		if ( smediafile != null && !smediafile.equals("null") ) {
     			ary_smedia = SvString.split(smediafile,"||");
         		ary_cmedia = SvString.split(cmediafile,"||");
         		ary_expmedia = SvString.split(expmediafile,"||");
     		}     		
     		
     		for ( int i=0; i<ary_server.length; i++ ) {
     			System.out.println(i);
     			//找最大編號 start
        		stmts = conn.prepareStatement("select max(detailno) as seqno from " + tablename + " where Serno = ? and Flag = ?" );
        		System.out.println("select max(detailno) as seqno from " + tablename + " where Serno = ? and Flag = ?");
        		stmts.clearParameters();
        		stmts.setString(1,serno);
        		stmts.setString(2,flag);
        		rs = stmts.executeQuery();
        		System.out.println("query");
        		int tempno = 0;
        		while ( rs.next() )
        		{
        			String mseq = rs.getString("seqno");
        			if ( mseq == null)
        			{
        				tempno = 1;
        			}else{
        				tempno = Integer.parseInt(mseq)+1;
        			}
        			this.detailno = tempno;
        		}
        		//找最大編號 end
        		System.out.println("this.detailno="+this.detailno);
        		//insert        		
        		String sql =  "insert into " + tablename;
        		       sql += "(Serno,DetailNo,Flag,ClientFile,ServerFile,ExpFile,ImageMagick,MainImage,CMediaFile,SMediaFile,ExpMediaFile,PostName,CreateDate,UpdateDate)";
        		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        		       System.out.println("insert sql="+sql);       
        		stmts = conn.prepareStatement(sql);
        		
        		stmts.clearParameters();
        		stmts.setString(1, serno );
        		stmts.setInt(2, detailno );
        		stmts.setString(3, flag );
        		stmts.setString(4, ary_client[i] );
        		stmts.setString(5, ary_server[i] );
        		stmts.setString(6, ary_exp[i] );
        		if ( imagemagick != null  && !imagemagick.equals("null") ) {
        			stmts.setString(7, ary_imagemagick[i] );
        		}else{
        			stmts.setString(7, "" );
        		}
        		stmts.setString(8, "N" );        		
        		if ( smediafile != null && !smediafile.equals("null") ) {
        			stmts.setString(9, ary_cmedia[i] );
            		stmts.setString(10, ary_smedia[i] );
            		stmts.setString(11, ary_expmedia[i] );
        		}else{        			
            		stmts.setString(9, "" );
            		stmts.setString(10, "" );
            		stmts.setString(11, "" );
        		}        		
        		stmts.setString(12, postname );
        		stmts.setString(13, getNowYear() );
        		stmts.setString(14, getNowYear() );
        		System.out.println("insert sql par=");       
        		int updateRow = stmts.executeUpdate();
        		System.out.println("insert sql updatte="+updateRow);
        		
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
    		System.out.println("Commit=");
       	  	conn.setAutoCommit(true);
       	 System.out.println("setAutoCommit=");
    		return true;
    		
    	} catch ( Exception sqle ) {
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
    public ArrayList<Object> findByday( String tablename, String serno, String flag )
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
    		//Piclibrary="Y"是表示引用圖庫
    		sSql.append( "select * from " + tablename + " where Serno = '" + serno + "' and flag = '" + flag + "' and Piclibrary is null" );

    		sSql.append( " order by UpdateDate desc,detailno" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			UploadData tmpQuery = new UploadData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setDetailno( rs.getInt( "DetailNo" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
    			tmpQuery.setClientfile( rs.getString( "ClientFile" ) );
    			tmpQuery.setServerfile( rs.getString( "ServerFile" ) );
    			tmpQuery.setExpfile( rs.getString( "ExpFile" ) );
    			tmpQuery.setImagemagick( rs.getString( "ImageMagick" ) );
    			tmpQuery.setMainimage( rs.getString( "MainImage" ) );
    			tmpQuery.setCmediafile( rs.getString( "CMediaFile" ) );
    			tmpQuery.setSmediafile( rs.getString( "SMediaFile" ) );
    			tmpQuery.setExpmediafile( rs.getString( "ExpMediaFile" ) );
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
    public boolean load( String tablename, String serno, int detailno, String flag )
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
    		stmts = conn.prepareStatement("select * from " + tablename + " where Serno = '" + serno + "' and Detailno = '"+ detailno + "' and Flag = '" + flag + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.detailno = rs.getInt( "DetailNo" );
    		this.flag = rs.getString( "Flag" );
    		this.clientfile = rs.getString( "ClientFile" );
    		this.serverfile = rs.getString( "ServerFile" );
    		this.expfile = rs.getString( "ExpFile" );
    		this.imagemagick = rs.getString( "ImageMagick" );
    		this.mainimage = rs.getString( "MainImage" );
    		this.cmediafile = rs.getString( "CMediaFile" );
    		this.smediafile = rs.getString( "SMediaFile" );
    		this.expmediafile = rs.getString( "ExpMediaFile" );
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
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//update
    		stmts = conn.prepareStatement(
    				"update " + tablename + " set ClientFile = ?, ServerFile = ?, ExpFile = ?, ImageMagick = ?, CMediaFile = ?, SMediaFile = ?, ExpMediaFile = ?, PostName = ?, Updatedate = ? where Serno = ? and DetailNo = ? and Flag = ?" ); 
    		stmts.clearParameters();    	 	
    		stmts.setString(1, clientfile );
    		stmts.setString(2, serverfile );
    		stmts.setString(3, expfile );
    		stmts.setString(4, imagemagick );
    		stmts.setString(5, cmediafile );
    		stmts.setString(6, smediafile );
    		stmts.setString(7, expmediafile );
    		stmts.setString(8, postname );
    		stmts.setString(9, getNowYear() );
    		stmts.setString(10, serno );
    		stmts.setInt(11, detailno );
    		stmts.setString(12, flag );
    		
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
    public boolean remove( String tablename, String sysRoot, String path ) throws FileNotFoundException, IOException
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
			//判斷OS版本
			String Upload_PATH = "";
			if ( sysRoot.indexOf("/") == -1 )
				Upload_PATH = sysRoot+"\\WEB-INF\\uploadpath.properties";
			else
				Upload_PATH = sysRoot+"/WEB-INF/uploadpath.properties";

			Properties upload = new Properties();
			upload.load(new FileInputStream(Upload_PATH));
			String uploadpath = "";
			if ( flag.equals("doc") ) {
				uploadpath = upload.getProperty("filepath");
			}else if ( flag.equals("pic")) {
				uploadpath = upload.getProperty("picpath");
			}else if ( flag.equals("media")) {
				uploadpath = upload.getProperty("mediapath");
			}
	        String filepath = uploadpath + path;
     		String[] ary_mserno = SvString.split(serno,"&");
     		for ( int i=0; i<ary_mserno.length; i++ ) {
     			String[] ary_del = SvString.split(ary_mserno[i],"||");
     			String msql = "select * from " + tablename + " where Serno = '" + ary_del[0] + "' and DetailNo = '" + ary_del[1] + "' and Flag = '" + flag + "'";
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
    				if ( flag.equals("media") ) {
    					File d2 = new File(filepath,rs.getString("SMediaFile"));
        				if (d2.exists())
        					d2.delete();
    				}
        			
        			//刪除資料
        			String dsql = "delete " + tablename + " where Serno = '" + ary_del[0] + "' and DetailNo = '" + ary_del[1] + "' and Flag = '" + flag + "'";
        			System.out.println("dsql="+dsql);
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
    
    //修改資料(主圖設定儲存)
    public boolean storemain( String tablename )
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
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//update
     		stmts1 = conn.prepareStatement(
    				"update " + tablename + " set MainImage = ? where Serno = ? and Flag = ?" ); 
     		
    		stmts1.clearParameters();    	 	
    		stmts1.setString(1, "N" );
    		stmts1.setString(2, serno );
    		stmts1.setString(3, "pic" );

    		int updateRow1 = stmts1.executeUpdate();
    		
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
    		
    		stmts = conn.prepareStatement(
    				"update " + tablename + " set MainImage = ? where Serno = ? and DetailNo = ? and Flag = ?" ); 
    		stmts.clearParameters();    	 	
    		stmts.setString(1, "Y" );
    		stmts.setString(2, serno );
    		stmts.setInt(3, detailno );
    		stmts.setString(4, "pic" );
    		
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
      			if ( stmts1 != null ) stmts1.close();
      			conn.close();
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
