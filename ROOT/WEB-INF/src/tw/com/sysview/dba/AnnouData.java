/*
 * 撰寫日期：2009/7/29
 * 程式名稱：AnnouData.java
 * 功能：
 * 撰寫者：平軒
 */
package tw.com.sysview.dba;

import java.sql.*;
import java.util.*;
import java.text.SimpleDateFormat;
import sysview.zhiren.function.SvNumber;
import sysview.zhiren.function.SvString;

public class AnnouData extends WebSiteLog{
	
	private String schName = "";
	private String annouDate = "";
	private String className = "";
	private String stuNum = "";
	private String sickNum = "";
	private String updateName = "";
	private String postDate = "";
	private String updateDate = "";
	private String language = null;
	
	private int allrecordCount = 0;
    private String errorMsg = null;
    
	public String getSchName() {
		return schName;
	}
	public void setSchName(String schName) {
		this.schName = schName;
	}
	public String getAnnouDate() {
		return annouDate;
	}
	public void setAnnouDate(String annouDate) {
		this.annouDate = annouDate;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getStuNum() {
		return stuNum;
	}
	public void setStuNum(String stuNum) {
		this.stuNum = stuNum;
	}
	public String getSickNum() {
		return sickNum;
	}
	public void setSickNum(String sickNum) {
		this.sickNum = sickNum;
	}
	public String getUpdateName() {
		return updateName;
	}
	public void setUpdateName(String updateName) {
		this.updateName = updateName;
	}
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
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
	public void setAllrecordCount(int allrecordCount) {
		this.allrecordCount = allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	
	//新增資料
    public boolean create(){
    	
    	Connection conn = null;
    	try{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	}catch(Exception e){
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}    	
    	
    	//找最大序號 start
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	
    	try{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//找最大序號 start
    		stmts = conn.prepareStatement("select max(serno) as seqno from AnnouData where substring(serno,1,8) = ?" );
    		stmts.clearParameters();
    		stmts.setString(1,getNowYear());
    		rs = stmts.executeQuery();
 
    		int tempno = 0;
    		String mserno1 = "";
    		
    		while(rs.next()){
    			String mseq = rs.getString("seqno");
    			if(mseq == null){
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
    		String sql =  "insert into AnnouData";
    		       sql += "(serno,PubUnitDN,PubUnitName,schName,annouDate,className,stuNum,sickNum,postName,updateName,postDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?)";
    		
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, pubunitdn );
    		stmts2.setString(3, pubunitname );
    		stmts2.setString(4, schName );
    		stmts2.setString(5, annouDate );
    		stmts2.setString(6, className );
    		stmts2.setString(7, stuNum );
    		stmts2.setString(8, sickNum );
    		stmts2.setString(9, postname );
    		stmts2.setString(10, updateName );
    		stmts2.setString(11, getNowYear() );
    		stmts2.setString(12, getNowYear() );

    		int updateRow2 = stmts2.executeUpdate();
    		
    		if(updateRow2 < 0){
    			try{
    				conn.rollback();
    				errorMsg = "Insert into table fail.";
    				System.out.println(errorMsg);
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}else{
    			this.serno = serno;
    		}

    		//網站維運統計共用參數(WebSiteLog)
    		if(!createlog(conn,language)){
    			try{
    				conn.rollback();
    				errorMsg = "Insert into table fail2.";
    				System.out.println(errorMsg);
    				return false;
    			}catch(Exception backerr){
    				System.out.println("rollback faild!");
    			}
    		}
    		
    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	}catch(SQLException sqle){
    		errorMsg = "create data error: " + sqle.toString();
    	}finally{
    		try{
    			if(rs != null){
    				rs.close();
    			}
    			if(stmts != null){
    				stmts.close();
    			}
    			if(stmts1 != null){
    				stmts1.close();
    			}
    			if(stmts2 != null){
    				stmts2.close();
    			}
    			conn.close();
    		}catch(SQLException se){
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
    
	//查詢多筆資料及筆數
    public ArrayList findByday(String tablename, String keyword, String schName, String punit, String sdate1, String sdate2){
    	
    	Connection conn = null;
    	
    	try{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	}catch(Exception e){
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return null;
    	}
       
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	
    	try{
    		StringBuffer sSql = new StringBuffer();
    		
    		sSql.append( "select * from " + tablename + " where 1=1" );
    		
    		if(keyword != null && !keyword.equals("")){
    			sSql.append( " and  className like '%" + keyword + "%'" );
    		}
    		
    		if(schName != null && !schName.equals("")){
    			sSql.append( " and  schName like '%" + schName + "%'" );
    		}
    		
    		sSql.append( " and annouDate >= '" + sdate1 + "' and annouDate <= '" + sdate2 + "'" );
    		
    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and PubUnitDN like '%" + mpunit[0] + "%'" );
    		}
    		
    		sSql.append( " order by postDate desc,Serno desc,PubUnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList result = new ArrayList();
    		
    		for(int i = 0; rs.next(); i++){
    			AnnouData tmpQuery = new AnnouData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setSchName( rs.getString( "schName" ) );
    			tmpQuery.setAnnouDate( rs.getString( "annouDate" ) );
    			tmpQuery.setClassName( rs.getString( "className" ) );
    			tmpQuery.setStuNum( rs.getString( "stuNum" ) );
    			tmpQuery.setSickNum( rs.getString( "sickNum" ) );
    			tmpQuery.setPostname(rs.getString("postName"));
    			tmpQuery.setPostDate( rs.getString( "postDate" ) );
    			tmpQuery.setUpdateDate( rs.getString( "UpdateDate" ) );
    			
    			result.add( tmpQuery );
    		}
    		
    		if(result.size() > 0){
    			allrecordCount = result.size();
    			return result;
    		}
       
    		errorMsg = "No such as row.";
    	}catch(SQLException sqle){
    		errorMsg = "find from table error: " + sqle.toString();
    	}finally{
    		try{
    			if(rs != null){
    				rs.close();
    			}
    			if(stmts != null){
    				stmts.close();
    			}
    			conn.close();
    		}catch(SQLException se){
    			errorMsg = "close ResultSet or Statment or connection error: " + se.toString();
    		}
    	}
    	return null;
    }
    
    //刪除資料
    public boolean remove(){
    	
    	Connection conn = null;
    	
    	try{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	}catch(Exception e){
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}
    	
    	ResultSet rs = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	
    	try{
    		
            //同意易動設定
     		conn.setAutoCommit(false);

     		String[] ary_mserno = SvString.split(serno,"||");
     		
     		for(int i=0; i<ary_mserno.length; i++){
     			String msql = "select * from " + tablename + " where Serno = '" + ary_mserno[i] + "'";
     			stmts = conn.prepareStatement(msql);
        		stmts.clearParameters();
        		rs = stmts.executeQuery();
        		
        		if(rs.next()){
        			this.setSerno(rs.getString( "Serno" ));
        			this.setPubunitdn(rs.getString( "PubUnitDN" ));
        			this.setPubunitname(rs.getString( "PubUnitName" ));
        			this.setSubject(rs.getString( "ClassName" ));
        			//網站維運統計共用參數(WebSiteLog)        			
            		if(!createlog(conn,language)){
            			try{
            				conn.rollback();
            				errorMsg = "Insert into table(Log) fail.";
            				System.out.println(errorMsg);
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            	return false;
         	            }
            		}

        			//刪除資料
        			String dsql = "delete " + tablename + " where Serno = '" + ary_mserno[i] + "'";
        			
        			stmts1 = conn.prepareStatement(dsql);
        			int updateRow = stmts1.executeUpdate();
        			if(updateRow <= 0){
            			try{
            				conn.rollback();
            				errorMsg = "Delete table fail.";
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            }
            		}
        			
        			//刪除資料
        			dsql = "delete AnnouItem where mserno = '" + ary_mserno[i] + "'";
        			
        			stmts1 = conn.prepareStatement(dsql);
        			updateRow = stmts1.executeUpdate();
        			if(updateRow <= 0){
            			try{
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
  
       }catch(SQLException sqle){ 
           errorMsg = "delete data error: " + sqle.toString();
       }finally{
    	   try{
    		   if(rs != null){
    			   rs.close();
    		   }
    		   if(stmts != null){
    			   stmts.close();
    		   }
    		   if(stmts1 != null){
    			   stmts1.close();
    		   }
    		   if(stmts2 != null){
    			   stmts2.close();
    		   }
    		   conn.close();
    	   }catch(SQLException se){
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }
    
    //查詢單筆資料
    public boolean load( String serno, String tablename ){
    	
    	Connection conn = null;
    	
    	try{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	}catch(Exception e){
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}
    	
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	
    	try{
    		stmts = conn.prepareStatement("select * from " + tablename + " where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if(!rs.next()){
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.pubunitdn = rs.getString( "PubUnitDN" );
    		this.pubunitname = rs.getString( "PubUnitName" );
    		this.schName = rs.getString( "schName" );
    		this.annouDate = rs.getString( "annouDate" );
    		this.className = rs.getString( "className" );
    		this.stuNum = rs.getString( "stuNum" );
    		this.sickNum = rs.getString( "sickNum" );
    		this.postname = rs.getString( "PostName" );
    		this.updateDate = rs.getString( "UpdateDate" );
    		
    		return true;
    	}catch(SQLException sqle){
    		errorMsg = "Query into table error: " + sqle.toString();
    	}finally{
    		try{
    			if(rs != null){
    				rs.close();
    			}
    			if(stmts != null){
    				stmts.close();
    			}
    			conn.close();
    		}catch(SQLException se){
    			errorMsg = "close ResultSet or Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
    
    //修改資料
    public boolean store(){
    	
    	Connection conn = null;
    	
    	try{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	}catch(Exception e){
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}    	
    	
    	//找最大序號 start
    	ResultSet rs = null;
    	ResultSet rs3 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	
    	try{
            //同意易動設定
     		conn.setAutoCommit(false);

    		//update
    		stmts2 = conn.prepareStatement(
    			"update " + tablename + " set PubUnitDN = ?, PubUnitName = ?, schName = ?, annouDate = ?, className = ?, stuNum = ?, sickNum = ?, updateName = ?, UpdateDate = ? where Serno = ?");
    		   		
    		stmts2.setString(1, pubunitdn );
    		stmts2.setString(2, pubunitname );
    		stmts2.setString(3, schName );
    		stmts2.setString(4, annouDate );
    		stmts2.setString(5, className );
    		stmts2.setString(6, stuNum );
    		stmts2.setString(7, sickNum );
    		stmts2.setString(8, updateName );
    		stmts2.setString(9, getNowYear() );
    		stmts2.setString(10, serno );
    		
    		int updateRow2 = stmts2.executeUpdate();
    		
    		if(updateRow2 < 0){
    			try{
    				conn.rollback();
    				errorMsg = "Insert into table fail(Statistics).";
    				System.out.println(errorMsg);
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}
    		
    		//網站維運統計共用參數(WebSiteLog)
    		if(!createlog(conn,language)){
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
    		
    	}catch(SQLException sqle){
    		errorMsg = "update data error: " + sqle.toString();
    	}finally{
    		try{
    			if(rs != null){
    				rs.close();
    			}
    			if(stmts != null){
    				stmts.close();
    			}
    			if(stmts1 != null){
    				stmts1.close();
    			}
    			if(stmts2 != null){
    				stmts2.close();
    			}
    			conn.close();
    		}catch(SQLException se){
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
    
    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear(){		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }
}
