/*
 * 撰寫日期：2008/6/7
 * 程式名稱：PicLibraryFileData.java
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

import sysview.zhiren.function.SvNumber;
import sysview.zhiren.function.SvString;

public class PicLibraryFileData {
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
    
	public String getClientfile() {
		return clientfile;
	}
	public void setClientfile(String clientfile) {
		this.clientfile = clientfile;
	}
	public String getCmediafile() {
		return cmediafile;
	}
	public void setCmediafile(String cmediafile) {
		this.cmediafile = cmediafile;
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
	public String getExpmediafile() {
		return expmediafile;
	}
	public void setExpmediafile(String expmediafile) {
		this.expmediafile = expmediafile;
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
	public String getMainimage() {
		return mainimage;
	}
	public void setMainimage(String mainimage) {
		this.mainimage = mainimage;
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
	public String getSmediafile() {
		return smediafile;
	}
	public void setSmediafile(String smediafile) {
		this.smediafile = smediafile;
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
    	ResultSet rs1 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
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
     			stmts = conn.prepareStatement("select max(Serno) as seqno from " + tablename + " where substring(Serno,1,8) = ?" );
        		stmts.clearParameters();
        		stmts.setString(1,getNowYear());
        		rs = stmts.executeQuery();
     
        		int tempno = 0;
        		int tempdetailno = 0;
        		String mserno = "";
        		while ( rs.next() )
        		{
        			String mseq = rs.getString("seqno");
        			if ( mseq == null)
        			{
        				mserno = SvNumber.format( 1, "0000" );
        				mserno = getNowYear() + mserno;
        				tempdetailno = 1;
        			}else{
        				tempno = new Integer(mseq.substring(8,12)).intValue()+1;
        				mserno = SvNumber.format( tempno, "0000" );
        				mserno = getNowYear()  + mserno;
        				
        				stmts1 = conn.prepareStatement("select max(detailno) as seqno from " + tablename + " where Serno = ?" );
                		stmts1.clearParameters();
                		stmts1.setString(1,mseq);
                		rs1 = stmts1.executeQuery();
             
                		while ( rs1.next() )
                		{
                			String mdetail = rs1.getString("seqno");
                			if ( mdetail == null)
                			{
                				tempdetailno = 1;
                			}else{
                				tempdetailno = Integer.parseInt(mdetail)+1;
                			}
                		}
        			}
        			this.serno = mserno;
        			this.detailno = tempdetailno;
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
    			if ( rs1 != null ) rs1.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
    			
	//查詢多筆資料及筆數
    public ArrayList findByday( String tablename )
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

    		sSql.append( " order by UpdateDate desc,detailno" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList result = new ArrayList();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PicLibraryFileData tmpQuery = new PicLibraryFileData();
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
			String Upload_PATH = sysRoot+"\\WEB-INF\\uploadpath.properties";
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

	//新增資料(圖庫引用)
    public boolean create( String tablename, String dataserno )
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
    	
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		stmts = conn.prepareStatement("select * from PicLibraryFile where Serno = '" + serno + "' and Detailno = '"+ detailno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		//找最大編號 start
    		stmts1 = conn.prepareStatement("select max(detailno) as seqno from " + tablename + " where Serno = ? and Flag = ?" );
    		stmts1.clearParameters();
    		stmts1.setString(1,dataserno);
    		stmts1.setString(2,"pic");
    		rs1 = stmts1.executeQuery();
    		
    		int tempno = 0;
    		while ( rs1.next() )
    		{
    			String mseq = rs1.getString("seqno");
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
    		       sql += "(Serno,DetailNo,Flag,ClientFile,ServerFile,ExpFile,ImageMagick,MainImage,CMediaFile,SMediaFile,ExpMediaFile,PostName,CreateDate,UpdateDate,PicLibrary)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		       
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, dataserno );
    		stmts2.setInt(2, detailno );
    		stmts2.setString(3, rs.getString( "Flag" ) );
    		stmts2.setString(4, rs.getString( "ClientFile" ) );
    		stmts2.setString(5, rs.getString( "ServerFile" ) );
    		stmts2.setString(6, rs.getString( "ExpFile" ) );
    		stmts2.setString(7, rs.getString( "ImageMagick" ) );
    		stmts2.setString(8, "N" );   
    		stmts2.setString(9, rs.getString( "CMediaFile" ) );
    		stmts2.setString(10, rs.getString( "SMediaFile" ) );
    		stmts2.setString(11, rs.getString( "ExpMediaFile" ) );
    		stmts2.setString(12, postname );
    		stmts2.setString(13, getNowYear() );
    		stmts2.setString(14, getNowYear() );
    		stmts2.setString(15, "Y" );
    		
    		int updateRow2 = stmts2.executeUpdate();
    		
    		if ( updateRow2 < 0 ) {
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
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
    
    //查詢單筆資料(尋找是否引用圖庫)
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
    		stmts = conn.prepareStatement("select * from " + tablename + " where Serno = '" + serno + "' and Piclibrary = 'Y'");
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

	//新增資料(取消圖庫引用)
    public boolean cancel( String tablename, String dataserno )
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
     		
     		String dsql = "delete " + tablename + " where Serno = '" + dataserno + "' and Piclibrary = 'Y'";
			
			stmts = conn.prepareStatement(dsql);
			int updateRow = stmts.executeUpdate();
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
			
    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( stmts != null ) stmts.close();
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
