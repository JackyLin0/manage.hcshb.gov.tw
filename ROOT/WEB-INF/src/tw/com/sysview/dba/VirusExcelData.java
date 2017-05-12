/*
 * 撰寫日期：2008/3/11
 * 程式名稱：VirusExcelData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import sysview.zhiren.function.SvString;

public class VirusExcelData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String pubunitdn = null;
    private String pubunitname = null;
    private String subject = null;
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
    private int num = 0;
    
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
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
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
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
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getSubjectno() {
		return subjectno;
	}
	public void setSubjectno(String subjectno) {
		this.subjectno = subjectno;
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
	
	//查詢多筆資料及筆數(尋找園所名稱)
    public ArrayList<Object> findBysubjectno( String tablename, String punit, String sdate1, String sdate2 )
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
    		
    		sSql.append( "select distinct(SubjectNo) as subjectno,Subject from " + tablename + " where 1=1" );
    		
    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and PubUnitDN like '%" + mpunit[0] + "%'" );
    		}
    		
    		sSql.append( " and PosterDate >= '" + sdate1 + "' and PosterDate <= '" + sdate2 + "'" );
    		
    		sSql.append( " ORDER BY SubjectNo" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			VirusExcelData tmpQuery = new VirusExcelData();
    			tmpQuery.setSubjectno( rs.getString( "subjectno" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
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
    public ArrayList<Object> findByday( String tablename, String punit, String subjectno, String sdate1, String sdate2 )
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
    		
    		sSql.append( "select SubjectNo,Subject,IsCheck,sum(EquipmentQual) as equipmentqual,sum(EquipmentNoQual) as equipmentnoqual,sum(OpportunityQual) as opportunityqual,sum(OpportunityNoQual) as opportunitynoqual,sum(MovementQual) as movementqual,sum(MovementNoQual) as movementnoqual,sum(HealthsiftQual) as healthsiftqual,sum(HealthsiftNoQual) as healthsiftnoqual,sum(CourseQual) as coursequal,sum(CourseNoQual) as coursenoqual from " + tablename + " where SubjectNo = '" + subjectno + "'" );
    		
    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and PubUnitDN like '%" + mpunit[0] + "%'" );
    		}
    		
    		sSql.append( " and PosterDate >= '" + sdate1 + "' and PosterDate <= '" + sdate2 + "'" );
    		sSql.append( " group by SubjectNo,Subject,IsCheck" );
    		sSql.append( " ORDER BY SubjectNo,IsCheck" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			VirusExcelData tmpQuery = new VirusExcelData();
    			tmpQuery.setSubjectno( rs.getString( "SubjectNo" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setIscheck( rs.getString( "Ischeck" ) );
    			tmpQuery.setEquipmentqual( rs.getInt( "equipmentqual" ) );
    			tmpQuery.setEquipmentnoqual( rs.getInt( "equipmentnoqual" ) );
    			tmpQuery.setOpportunityqual( rs.getInt( "opportunityqual" ) );
    			tmpQuery.setOpportunitynoqual( rs.getInt( "opportunitynoqual" ) );
    			tmpQuery.setMovementqual( rs.getInt( "movementqual" ) );
    			tmpQuery.setMovementnoqual( rs.getInt( "movementnoqual" ) );
    			tmpQuery.setHealthsiftqual( rs.getInt( "healthsiftqual" ) );
    			tmpQuery.setHealthsiftnoqual( rs.getInt( "healthsiftnoqual" ) );
    			tmpQuery.setCoursequal( rs.getInt( "coursequal" ) );
    			tmpQuery.setCoursenoqual( rs.getInt( "coursenoqual" ) );
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
    public boolean load( String tablename, String punit, String subjectno, String ischeck )
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
    		stmts = conn.prepareStatement("select PubUnitDN,PubUnitName,PosterDate from " + tablename + " where PubUnitDN = '" + punit + "' and SubjectNo = '" + subjectno + "' and IsCheck = '" + ischeck + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.pubunitdn = rs.getString( "PubUnitDN" );
    		this.pubunitname = rs.getString( "PubUnitName" );
    		this.posterdate = rs.getString( "PosterDate" );
    		
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

    //查詢單筆資料(尋找學校數目)
    public boolean loadnum( String tablename, String pubunitdn, String sdate1, String sdate2 )
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
    		stmts = conn.prepareStatement("select count(distinct(SubjectNo)) as num from " + tablename + " where PubUnitDN = '"+ pubunitdn + "' and PosterDate >= '" + sdate1 + "' and PosterDate <= '" + sdate2 + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.num = rs.getInt( "num" );
    		
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
	
	//查詢多筆資料及筆數
    public ArrayList<Object> findBysum( String tablename, String punit, String sdate1, String sdate2 )
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
    		
    		sSql.append( "select IsCheck,sum(EquipmentQual) as equipmentqual,sum(EquipmentNoQual) as equipmentnoqual,sum(OpportunityQual) as opportunityqual,sum(MovementQual) as movementqual from " + tablename + " where 1=1" );
    		
    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and PubUnitDN like '%" + mpunit[0] + "%'" );
    		}
    		
    		sSql.append( " and PosterDate >= '" + sdate1 + "' and PosterDate <= '" + sdate2 + "'" );
    		sSql.append( " group by IsCheck" );
    		sSql.append( " ORDER BY IsCheck" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			VirusExcelData tmpQuery = new VirusExcelData();
    			tmpQuery.setIscheck( rs.getString( "Ischeck" ) );
    			tmpQuery.setEquipmentqual( rs.getInt( "equipmentqual" ) );
    			tmpQuery.setEquipmentnoqual( rs.getInt( "equipmentnoqual" ) );
    			tmpQuery.setOpportunityqual( rs.getInt( "opportunityqual" ) );
    			tmpQuery.setMovementqual( rs.getInt( "movementqual" ) );
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
