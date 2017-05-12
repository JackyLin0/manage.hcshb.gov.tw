package tw.com.sysview.dba;

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

public class IndexBannerData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;

    private String posterdate = null;
    private String closedate = null;
    private String startusing = null;
    private String relateurl = null;
    private String relatename = null;
    private String clientfile = null;
    private String serverfile = null;
    private String expfile = null;
    private String imagemagick = null;
    private int fsort = 0;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    private String websitedn = null;
    private String websitename = null;
    private String language = null;
        	
	public String getPosterdate() {
		return posterdate;
	}
	public void setPosterdate(String posterdate) {
		this.posterdate = posterdate;
	}
	public String getClosedate() {
		return closedate;
	}
	public void setClosedate(String closedate) {
		this.closedate = closedate;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
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
	public String getClientfile() {
		return clientfile;
	}
	public void setClientfile(String clientfile) {
		this.clientfile = clientfile;
	}
	public String getServerfile() {
		return serverfile;
	}
	public void setServerfile(String serverfile) {
		this.serverfile = serverfile;
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
	public int getFsort() {
		return fsort;
	}
	public void setFsort(int fsort) {
		this.fsort = fsort;
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
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setAllrecordCount(int allrecordCount) {
		this.allrecordCount = allrecordCount;
	}

	//新增資料
    public boolean create() {
    	Connection conn = null;
    	try {
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
    	
    	try {
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
    		
    		//insert
    		String sql =  "insert into " + tablename;
    		       sql += "(Serno,PubUnitDN,PubUnitName,Subject,WebSiteDN,WebSiteName,PosterDate,CloseDate,StartUsing,RelateUrl,RelateName,ClientFile,ServerFile,ExpFile,ImageMagick,Fsort,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		       
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, pubunitdn );
    		stmts2.setString(3, pubunitname );
    		stmts2.setString(4, subject );
    		stmts2.setString(5, websitedn );
    		stmts2.setString(6, websitename );
    		stmts2.setString(7, posterdate );
    		stmts2.setString(8, closedate );
    		stmts2.setString(9, startusing );
    		stmts2.setString(10, relateurl );
    		stmts2.setString(11, relatename );
    		stmts2.setString(12, clientfile );
    		stmts2.setString(13, serverfile );
    		stmts2.setString(14, expfile );
    		stmts2.setString(15, imagemagick );
    		stmts2.setInt(16, fsort );
    		stmts2.setString(17, postname );
    		stmts2.setString(18, getNowYear() );
    		stmts2.setString(19, getNowYear() );
    		
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

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
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

	//查詢多筆資料及筆數
	public ArrayList<Object> findByday( String tablename, String keyword, String websitedn, String sdate1, String sdate2 ) {
		Connection conn = null;
		try {
			//連結資料庫
			conn = tw.com.sysview.dba.DbConnection.getConnection();
		} catch ( Exception e ) {
			errorMsg = "Get DataSource or Connection error: " + e.toString();
			return null;
		}
		
		PreparedStatement stmts = null;
		ResultSet rs = null;
		try {
			StringBuffer sSql = new StringBuffer();
			
			sSql.append( "select * from " + tablename + " where WebSiteDN = '" + websitedn + "'" );
			
			if ( keyword != null && !keyword.equals("") )  {
				sSql.append( " and Subject like '%" + keyword + "%'" );
			}
			
			sSql.append( " and PosterDate >= '" + sdate1 + "' and PosterDate <= '" + sdate2 + "'" );
			
			sSql.append( " order by UpdateDate desc,Serno desc,PubUnitDN" );
			
			stmts = conn.prepareStatement( sSql.toString() );
			stmts.clearParameters();
			
			rs = stmts.executeQuery();
			ArrayList<Object> result = new ArrayList<Object>();
			
			for ( int i = 0; rs.next(); i++ ) {
				BannerRightData tmpQuery = new BannerRightData();
				tmpQuery.setSerno( rs.getString( "Serno" ) );
				tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
				tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
				tmpQuery.setSubject( rs.getString( "Subject" ) );
				tmpQuery.setWebsitedn( rs.getString( "WebSiteDN" ) );
				tmpQuery.setWebsitename( rs.getString( "WebSiteName" ) );
				tmpQuery.setPosterdate( rs.getString( "PosterDate" ) );
				tmpQuery.setClosedate( rs.getString( "CloseDate" ) );
				tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
				tmpQuery.setRelateurl( rs.getString( "RelateUrl" ) );
				tmpQuery.setRelatename( rs.getString( "RelateName" ) );
				tmpQuery.setClientfile( rs.getString( "ClientFile" ) );
				tmpQuery.setServerfile( rs.getString( "ServerFile" ) );
				tmpQuery.setExpfile( rs.getString( "ExpFile" ) );
				tmpQuery.setImagemagick( rs.getString( "ImageMagick" ) );
				tmpQuery.setFsort( rs.getInt( "Fsort" ) );
				tmpQuery.setPostname( rs.getString( "PostName" ) );
				tmpQuery.setUpdatedate( rs.getString( "UpdateDate" ) );
				result.add( tmpQuery );
			}
			if ( result.size() > 0 ) {
				allrecordCount = result.size();
				return result;
			}
			errorMsg = "No such as row.";
		} catch ( SQLException sqle ) {
			errorMsg = "find from table error: " + sqle.toString();
		} finally {
			try {
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
    public boolean load( String serno, String tablename ) {
    	Connection conn = null;
    	try {
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}
    	
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	try {
    		stmts = conn.prepareStatement("select * from " + tablename + " where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() ) {
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.serno = rs.getString( "Serno" );
    		this.pubunitdn = rs.getString( "PubUnitDN" );
    		this.pubunitname = rs.getString( "PubUnitName" );
    		this.subject = rs.getString( "Subject" );
    		this.websitedn = rs.getString( "WebSiteDN" );
    		this.websitename = rs.getString( "WebSiteName" );
    		this.posterdate = rs.getString( "PosterDate" );
    		this.closedate = rs.getString( "CloseDate" );
    		this.startusing = rs.getString( "StartUsing" );
    		this.relateurl = rs.getString( "RelateUrl" );
    		this.relatename = rs.getString( "RelateName" );
    		this.clientfile = rs.getString( "ClientFile" );
    		this.serverfile = rs.getString( "ServerFile" );
    		this.expfile = rs.getString( "ExpFile" );
    		this.imagemagick = rs.getString( "ImageMagick" );
    		this.fsort = rs.getInt( "Fsort" );
    		this.postname = rs.getString( "PostName" );
    		this.updatedate = rs.getString( "UpdateDate" );
    		
    		return true;
    	} catch ( SQLException sqle ) {
    		errorMsg = "Query into table error: " + sqle.toString();
    	} finally {
    		try {
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
    public boolean store() {
    	Connection conn = null;
    	try {
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
    	
    	try {
            //同意易動設定
     		conn.setAutoCommit(false);

     		String dsql = "delete " + tablename + " where Serno = '" + serno + "'";
     		
			stmts = conn.prepareStatement(dsql);
			int deleteRow = stmts.executeUpdate();
			if ( deleteRow < 0 ) {
    			try {
    				conn.rollback();
    				errorMsg = "Delete table fail.";
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}
    		
    		//insert
    		String sql =  "insert into " + tablename;
    		       sql += "(Serno,PubUnitDN,PubUnitName,Subject,WebSiteDN,WebSiteName,PosterDate,CloseDate,StartUsing,RelateUrl,RelateName,ClientFile,ServerFile,ExpFile,ImageMagick,Fsort,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		       
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, pubunitdn );
    		stmts2.setString(3, pubunitname );
    		stmts2.setString(4, subject );
    		stmts2.setString(5, websitedn );
    		stmts2.setString(6, websitename );
    		stmts2.setString(7, posterdate );
    		stmts2.setString(8, closedate );
    		stmts2.setString(9, startusing );
    		stmts2.setString(10, relateurl );
    		stmts2.setString(11, relatename );
    		stmts2.setString(12, clientfile );
    		stmts2.setString(13, serverfile );
    		stmts2.setString(14, expfile );
    		stmts2.setString(15, imagemagick );
    		stmts2.setInt(16, fsort );
    		stmts2.setString(17, postname );
    		stmts2.setString(18, getNowYear() );
    		stmts2.setString(19, getNowYear() );
    		
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

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
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

    //刪除資料
    public boolean remove( String filepath ) {
    	Connection conn = null;
    	try {
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}
    	
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
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
        			this.setSubject(rs.getString( "Subject" ));
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
            		
            		//刪除檔案
            		if ( rs.getString("ServerFile") != null && !rs.getString("ServerFile").equals("null") ) {
        				File d1 = new File(filepath,rs.getString("ServerFile"));
        			      if (d1.exists()) {
        			    	  d1.delete();
        			      }
        			}
            		if ( rs.getString("ImageMagick") != null && !rs.getString("ImageMagick").equals("null") ) {
        				File d2 = new File(filepath,rs.getString("ImageMagick"));
        			      if (d2.exists()) {
        			    	  d2.delete();
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
    		   if ( stmts2 != null ) stmts2.close();
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
    private String getNowYear() {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    
              	
}
