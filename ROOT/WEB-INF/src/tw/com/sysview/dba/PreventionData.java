/*
 * 撰寫日期：2008/3/8
 * 程式名稱：PreventionData.java
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

public class PreventionData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;

    private String subjectno = null;
    private String ischeck = null;
    private String posterdate = null;
    private int equipmentqual = 0;
    private int equipmentnoqual = 0;
    private int opportunityqual = 0;
    private int opportunitynoqual = 0;
    private int movementqual = 0;
    private int movementnoqual = 0;
    private int healthsiftqual = 0;
    private int healthsiftnoqual = 0;
    private int coursequal = 0;
    private int coursenoqual = 0;
    private String updatedate = null;
    private String language = null;
    
	public String getSubjectno() {
		return subjectno;
	}
	public void setSubjectno(String subjectno) {
		this.subjectno = subjectno;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public int getCoursenoqual() {
		return coursenoqual;
	}
	public void setCoursenoqual(int coursenoqual) {
		this.coursenoqual = coursenoqual;
	}
	public int getCoursequal() {
		return coursequal;
	}
	public void setCoursequal(int coursequal) {
		this.coursequal = coursequal;
	}
	public int getEquipmentnoqual() {
		return equipmentnoqual;
	}
	public void setEquipmentnoqual(int equipmentnoqual) {
		this.equipmentnoqual = equipmentnoqual;
	}
	public int getEquipmentqual() {
		return equipmentqual;
	}
	public void setEquipmentqual(int equipmentqual) {
		this.equipmentqual = equipmentqual;
	}
	public int getHealthsiftnoqual() {
		return healthsiftnoqual;
	}
	public void setHealthsiftnoqual(int healthsiftnoqual) {
		this.healthsiftnoqual = healthsiftnoqual;
	}
	public int getHealthsiftqual() {
		return healthsiftqual;
	}
	public void setHealthsiftqual(int healthsiftqual) {
		this.healthsiftqual = healthsiftqual;
	}
	public String getIscheck() {
		return ischeck;
	}
	public void setIscheck(String ischeck) {
		this.ischeck = ischeck;
	}
	public int getMovementnoqual() {
		return movementnoqual;
	}
	public void setMovementnoqual(int movementnoqual) {
		this.movementnoqual = movementnoqual;
	}
	public int getMovementqual() {
		return movementqual;
	}
	public void setMovementqual(int movementqual) {
		this.movementqual = movementqual;
	}
	public int getOpportunitynoqual() {
		return opportunitynoqual;
	}
	public void setOpportunitynoqual(int opportunitynoqual) {
		this.opportunitynoqual = opportunitynoqual;
	}
	public int getOpportunityqual() {
		return opportunityqual;
	}
	public void setOpportunityqual(int opportunityqual) {
		this.opportunityqual = opportunityqual;
	}
	public String getPosterdate() {
		return posterdate;
	}
	public void setPosterdate(String posterdate) {
		this.posterdate = posterdate;
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
    		
    		//insert
    		String sql =  "insert into " + tablename;
    		       sql += "(Serno,PubUnitDN,PubUnitName,SubjectNo,Subject,IsCheck,PosterDate,EquipmentQual,EquipmentNoQual,OpportunityQual,OpportunityNoQual,MovementQual,MovementNoQual,HealthsiftQual,HealthsiftNoQual,CourseQual,CourseNoQual,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, pubunitdn );
    		stmts2.setString(3, pubunitname );
    		stmts2.setString(4, subjectno );
    		stmts2.setString(5, subject );
    		stmts2.setString(6, ischeck );
    		stmts2.setString(7, posterdate );
    		stmts2.setInt(8, equipmentqual );
    		stmts2.setInt(9, equipmentnoqual );
    		stmts2.setInt(10, opportunityqual );
    		stmts2.setInt(11, opportunitynoqual );
    		stmts2.setInt(12, movementqual );
    		stmts2.setInt(13, movementnoqual );
    		stmts2.setInt(14, healthsiftqual );
    		stmts2.setInt(15, healthsiftnoqual );
    		stmts2.setInt(16, coursequal );
    		stmts2.setInt(17, coursenoqual );
    		stmts2.setString(18, postname );
    		stmts2.setString(19, getNowYear() );
    		stmts2.setString(20, getNowYear() );
    		
    		int updateRow2 = stmts2.executeUpdate();
    		
    		if ( updateRow2 < 0 )
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
    public ArrayList<Object> findByday( String tablename, String keyword, String punit, String sdate1, String sdate2 )
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
    		
    		if ( keyword != null && !keyword.equals("") )  {
    			sSql.append( " and (Subject like '%" + keyword + "%' or Content like '%" + keyword + "%')" );
    		}
    			
    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and PubUnitDN like '%" + mpunit[0] + "%'" );
    		}
    		
    		sSql.append( " and PosterDate >= '" + sdate1 + "' and PosterDate <= '" + sdate2 + "'" );
    		sSql.append( " order by UpdateDate desc,Serno desc,PubUnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PreventionData tmpQuery = new PreventionData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setSubjectno( rs.getString( "SubjectNo" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setIscheck( rs.getString( "Ischeck" ) );
    			tmpQuery.setPosterdate( rs.getString( "PosterDate" ) );
    			tmpQuery.setEquipmentqual( rs.getInt( "EquipmentQual" ) );
    			tmpQuery.setEquipmentnoqual( rs.getInt( "EquipmentNoQual" ) );
    			tmpQuery.setOpportunityqual( rs.getInt( "OpportunityQual" ) );
    			tmpQuery.setOpportunitynoqual( rs.getInt( "OpportunityNoQual" ) );
    			tmpQuery.setMovementqual( rs.getInt( "MovementQual" ) );
    			tmpQuery.setMovementnoqual( rs.getInt( "MovementNoQual" ) );
    			tmpQuery.setHealthsiftqual( rs.getInt( "HealthsiftQual" ) );
    			tmpQuery.setHealthsiftnoqual( rs.getInt( "HealthsiftNoQual" ) );
    			tmpQuery.setCoursequal( rs.getInt( "CourseQual" ) );
    			tmpQuery.setCoursenoqual( rs.getInt( "CourseNoQual" ) );
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
	
	//查詢多筆資料及筆數(查詢園所名稱)
    public ArrayList<Object> findByday( String organization )
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
    		
    		sSql.append( "select * from VirusName where Organization = '" + organization + "' and ( StartUsing = '1' or ( StartUsing = '0' and CloseDate >= '" + getNowYear() + "' ) )" );
    		
    		sSql.append( " order by UpdateDate desc,Serno desc,PubUnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			PreventionData tmpQuery = new PreventionData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
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
    		this.subjectno = rs.getString( "SubjectNo" );
    		this.subject = rs.getString( "Subject" );
    		this.ischeck = rs.getString( "IsCheck" );
    		this.posterdate = rs.getString( "PosterDate" );
    		this.equipmentqual = rs.getInt( "EquipmentQual" );
    		this.equipmentnoqual = rs.getInt( "EquipmentNoQual" );
    		this.opportunityqual = rs.getInt( "OpportunityQual" );
    		this.opportunitynoqual = rs.getInt( "OpportunityNoQual" );
    		this.movementqual = rs.getInt( "MovementQual" );
    		this.movementnoqual = rs.getInt( "MovementNoQual" );
    		this.healthsiftqual = rs.getInt( "HealthsiftQual" );
    		this.healthsiftnoqual = rs.getInt( "HealthsiftNoQual" );
    		this.coursequal = rs.getInt( "CourseQual" );
    		this.coursenoqual = rs.getInt( "CourseNoQual" );    		
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
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//update
    		stmts2 = conn.prepareStatement(
    			"update " + tablename + " set SubjectNo = ?, Subject = ?, IsCheck = ?, PosterDate = ?, EquipmentQual = ?, EquipmentNoQual = ?, OpportunityQual = ?, OpportunityNoQual = ?, MovementQual = ?, MovementNoQual = ?, HealthsiftQual = ?, HealthsiftNoQual = ?, CourseQual = ?, CourseNoQual = ?, PostName = ?, UpdateDate = ? where Serno = ? and PubUnitDN = ?");
    		   		
    		stmts2.setString(1, subjectno );
    		stmts2.setString(2, subject );
    		stmts2.setString(3, ischeck );
    		stmts2.setString(4, posterdate );
    		stmts2.setInt(5, equipmentqual );
    		stmts2.setInt(6, equipmentnoqual );
    		stmts2.setInt(7, opportunityqual );
    		stmts2.setInt(8, opportunitynoqual );
    		stmts2.setInt(9, movementqual );
    		stmts2.setInt(10, movementnoqual );
    		stmts2.setInt(11, healthsiftqual );
    		stmts2.setInt(12, healthsiftnoqual );
    		stmts2.setInt(13, coursequal );
    		stmts2.setInt(14, coursenoqual );
    		stmts2.setString(15, postname );
    		stmts2.setString(16, getNowYear() );
    		stmts2.setString(17, serno );
    		stmts2.setString(18, pubunitdn );
    		
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
    public boolean remove()
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
	
    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }	
            
}
