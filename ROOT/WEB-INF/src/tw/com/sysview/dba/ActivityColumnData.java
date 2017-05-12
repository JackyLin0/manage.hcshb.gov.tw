/*
 * 撰寫日期：2008/12/3
 * 程式名稱：ActivityColumnData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import sysview.zhiren.function.SvNumber;
import sysview.zhiren.function.SvString;

public class ActivityColumnData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    private String sorcefield = null;
    private int fieldnum = 0;
    private String sorceserial = null;
    private String sorceisneed = null;
    private String misneed = null;
    private String mfieldname = null;
    private String mattribute = null;
    private String mfieldvalue = null;
    private String mlength = null;
    private String mserial = null;
    private String msubject = null;
    
    //Activities
    private String pubunitdn = null;
    private String pubunitname = null;
    private String subject = null;
    private String posterdate = null;
    private String onlinesign = null;
    private String islimitnum = null;
    private int limitnum = 0;
    private int signupnum = 0;
    private String signsdate = null;
    private String signedate = null;
    private String signplace = null;
    
    //ActivityColumn
    private String serno = null;
    private String fieldname = null;
    private String attribute = null;
    private String fieldvalue = null;
    private String fieldlength = null;    
    private String flag = null;
    private String createdate = null;
    private String postname = null;
    private String updatedate = null;
    private String fieldflag = null;
    
    //ActivityRecord
    private String activityserno = null;
    private int serialnum = 0;
    private String fieldserno = null;
    private String isneed = null;
    
	public String getFieldflag() {
		return fieldflag;
	}
	public void setFieldflag(String fieldflag) {
		this.fieldflag = fieldflag;
	}
	public String getSorceisneed() {
		return sorceisneed;
	}
	public void setSorceisneed(String sorceisneed) {
		this.sorceisneed = sorceisneed;
	}
	public String getMsubject() {
		return msubject;
	}
	public void setMsubject(String msubject) {
		this.msubject = msubject;
	}
	public String getMfieldvalue() {
		return mfieldvalue;
	}
	public void setMfieldvalue(String mfieldvalue) {
		this.mfieldvalue = mfieldvalue;
	}
	public int getFieldnum() {
		return fieldnum;
	}
	public void setFieldnum(int fieldnum) {
		this.fieldnum = fieldnum;
	}
	public String getMattribute() {
		return mattribute;
	}
	public void setMattribute(String mattribute) {
		this.mattribute = mattribute;
	}
	public String getMfieldname() {
		return mfieldname;
	}
	public void setMfieldname(String mfieldname) {
		this.mfieldname = mfieldname;
	}
	public String getMisneed() {
		return misneed;
	}
	public void setMisneed(String misneed) {
		this.misneed = misneed;
	}
	public String getMlength() {
		return mlength;
	}
	public void setMlength(String mlength) {
		this.mlength = mlength;
	}
	public String getMserial() {
		return mserial;
	}
	public void setMserial(String mserial) {
		this.mserial = mserial;
	}
	public String getSorcefield() {
		return sorcefield;
	}
	public void setSorcefield(String sorcefield) {
		this.sorcefield = sorcefield;
	}
	public String getSorceserial() {
		return sorceserial;
	}
	public void setSorceserial(String sorceserial) {
		this.sorceserial = sorceserial;
	}
	public String getFieldlength() {
		return fieldlength;
	}
	public void setFieldlength(String fieldlength) {
		this.fieldlength = fieldlength;
	}
	public String getIslimitnum() {
		return islimitnum;
	}
	public void setIslimitnum(String islimitnum) {
		this.islimitnum = islimitnum;
	}
	public int getLimitnum() {
		return limitnum;
	}
	public void setLimitnum(int limitnum) {
		this.limitnum = limitnum;
	}
	public String getOnlinesign() {
		return onlinesign;
	}
	public void setOnlinesign(String onlinesign) {
		this.onlinesign = onlinesign;
	}
	public String getPosterdate() {
		return posterdate;
	}
	public void setPosterdate(String posterdate) {
		this.posterdate = posterdate;
	}
	public String getSignedate() {
		return signedate;
	}
	public void setSignedate(String signedate) {
		this.signedate = signedate;
	}
	public String getSignplace() {
		return signplace;
	}
	public void setSignplace(String signplace) {
		this.signplace = signplace;
	}
	public String getSignsdate() {
		return signsdate;
	}
	public void setSignsdate(String signsdate) {
		this.signsdate = signsdate;
	}
	public int getSignupnum() {
		return signupnum;
	}
	public void setSignupnum(int signupnum) {
		this.signupnum = signupnum;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public void setActivityserno(String activityserno) {
		this.activityserno = activityserno;
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
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getAttribute() {
		return attribute;
	}
	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getFieldname() {
		return fieldname;
	}
	public void setFieldname(String fieldname) {
		this.fieldname = fieldname;
	}
	public String getFieldserno() {
		return fieldserno;
	}
	public void setFieldserno(String fieldserno) {
		this.fieldserno = fieldserno;
	}
	public String getFieldvalue() {
		return fieldvalue;
	}
	public void setFieldvalue(String fieldvalue) {
		this.fieldvalue = fieldvalue;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getIsneed() {
		return isneed;
	}
	public void setIsneed(String isneed) {
		this.isneed = isneed;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
	}
	public int getSerialnum() {
		return serialnum;
	}
	public void setSerialnum(int serialnum) {
		this.serialnum = serialnum;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getActivityserno() {
		return activityserno;
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
    	
    	ResultSet rs = null;
    	ResultSet rs2 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	Statement stmts3 = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		//inser ActivityColumn
     		if ( fieldnum > 0 ) {
     			String[] ary_misneed = SvString.split(misneed,"||");
     			String[] ary_mfieldname = SvString.split(mfieldname,"||");
     			String[] ary_mattribute = SvString.split(mattribute,"||");
     			String[] ary_mfieldvalue = SvString.split(mfieldvalue,"||");
     			String[] ary_mlength = SvString.split(mlength,"||");
     			String[] ary_mserial = SvString.split(mserial,"||");
     			
     			for ( int num=0; num<fieldnum; num++ ) {
     				//找最大序號 start
     	    		stmts = conn.prepareStatement("select max(Serno) as seqno from ActivityColumn where substring(Serno,1,8) = ?" );
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
     	    		
     	    		sorcefield = sorcefield + "||" + mserno;
     	    		sorceserial = sorceserial + "||" + ary_mserial[num];
     	    		sorceisneed = sorceisneed + "||" + ary_misneed[num];
         			
     	    		String sql =  "insert into ActivityColumn";
     	    		       sql += "(Serno,FieldName,Attribute,FieldValue,FieldLength,CreateDate,PostName,UpdateDate)";
     	    		       sql += " values(?,?,?,?,?,?,?,?)";
     	    		       
     	    		stmts = conn.prepareStatement(sql);
     	    		
     	    		stmts.clearParameters();
     	    		String mfieldvalue = ary_mfieldvalue[num];
     	    		if ( mfieldvalue.equals("a") )
     	    			mfieldvalue = "";
     	    		stmts.setString(1, this.serno );
     	    		stmts.setString(2, ary_mfieldname[num] );
     	    		stmts.setString(3, ary_mattribute[num] );
     	    		stmts.setString(4, mfieldvalue );
     	    		stmts.setString(5, ary_mlength[num] );
     	    		stmts.setString(6, getNowYear() );
     	    		stmts.setString(7, postname );
     	    		stmts.setString(8, getNowYear() );
     	    		
     	    		int updateRow = stmts.executeUpdate();
     	    		
     	    		if ( updateRow <= 0 ) {
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
     		}
     		
     		String[] ary_sorcefield = SvString.split(sorcefield,"||");
     		String[] ary_sorceserial = SvString.split(sorceserial,"||");
     		String[] ary_sorceisneed = SvString.split(sorceisneed,"||");
     		//insert ActivityRecord
     		for ( int s=0; s<ary_sorcefield.length; s++ ) {
     			String sql1 =  "insert into ActivityRecord";
     			       sql1 += "(ActivitySerno,SerialNum,FieldSerno,IsNeed,CreateDate,PostName,UpdateDate)";
     			       sql1 += " values(?,?,?,?,?,?,?)";
     			       
     			stmts1 = conn.prepareStatement(sql1);
     			
     			stmts1.clearParameters();
     			stmts1.setString(1, activityserno );
     			stmts1.setString(2, ary_sorceserial[s] );
     			stmts1.setString(3, ary_sorcefield[s] );
     			stmts1.setString(4, ary_sorceisneed[s] );
     			stmts1.setString(5, getNowYear() );
     			stmts1.setString(6, postname );
     			stmts1.setString(7, getNowYear() );
     			
     			int updateRow1 = stmts1.executeUpdate();
     			
     			if ( updateRow1 <= 0 ) {
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
     		
     		//createtable
     		StringBuffer sSql = new StringBuffer();
    		
    		sSql.append( "select * from ActivityRecord where ActivitySerno = '" + activityserno + "' order by SerialNum" );

    		stmts2 = conn.prepareStatement( sSql.toString() );
    		stmts2.clearParameters();
       
    		rs2 = stmts2.executeQuery();
    		
    		String createsql = "create table hcshb.dbo.A_" + activityserno + "( Serno nvarchar(12) PRIMARY KEY,";
    		String colname = "";
    		for ( int i=0; rs2.next(); i++ ) {
    			//取長度
    			int collength = Integer.parseInt(getLength(conn,rs2.getString( "FieldSerno" )));
    			
    			if ( colname.equals("") ) {
    				colname = "A"+rs2.getString( "FieldSerno" ) + " nvarchar(" + collength + "),";
    			}else{
    				colname = colname + " A"+rs2.getString( "FieldSerno" ) + " nvarchar(" + collength + "),";
    			}
    		}
    		createsql = createsql + colname + ")";
    		
    		stmts3 = conn.createStatement();
    		stmts3.executeUpdate( createsql );
    		
    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
    			if ( rs2 != null ) rs2.close();
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
    
    //取欄位長度
    private String getLength( Connection conn, String serno ) {
    	
    	PreparedStatement stmts = null;
    	ResultSet rs = null;
    	String mcollength = "0";
    	
    	try
    	{
    		stmts = conn.prepareStatement("select * from ActivityColumn where Serno = '" + serno + "'");
    		stmts.clearParameters();    		
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return null;
    		}
    		mcollength = rs.getString( "FieldLength" );
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "Query into table error: " + sqle.toString();
    	} finally {
    		try
    		{
    			if ( rs != null ) rs.close();
    			if ( stmts != null ) stmts.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close ResultSet or Statment or connection error: " + se.toString();
    		}
    	}	
    	return mcollength;
    }
    
	//查詢多筆資料及筆數
    public ArrayList<Object> findByday( String keyword, String punit, String sdate1, String sdate2 )
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
    		
    		sSql.append( "select Serno,PubUnitDN,PubUnitName,Subject,OnLineSign,IsLimitNum,LimitNum,SignUpNum,SignSDate,SignEDate,SignPlace,PosterDate,UpdateDate from Activities where OnlineSign = 'Y'" );
    		
    		sSql.append( " and Serno in(select ActivitySerno from ActivityRecord)" );
    		
    		if ( keyword != null && !keyword.equals("") )  {
    			sSql.append( " and Subject like '%" + keyword + "%'" );
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
    			ActivityColumnData tmpQuery = new ActivityColumnData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setOnlinesign( rs.getString( "OnLineSign" ) );
    			tmpQuery.setIslimitnum( rs.getString( "IsLimitNum" ) );
    			tmpQuery.setLimitnum( rs.getInt( "LimitNum" ) );
    			tmpQuery.setSignupnum( rs.getInt( "SignUpNum" ) );
    			tmpQuery.setSignsdate( rs.getString( "SignSDate" ) );
    			tmpQuery.setSignedate( rs.getString( "SignEDate" ) );
    			tmpQuery.setSignplace( rs.getString( "SignPlace" ) );
    			tmpQuery.setPosterdate( rs.getString( "PosterDate" ) );
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
    public ArrayList<Object> findByday( String punit )
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
    		
    		sSql.append( "select Serno,Subject,PubUnitDN,PubUnitName from Activities where OnlineSign = 'Y'" );
    		
    		sSql.append( " and Serno not in(select ActivitySerno from ActivityRecord)" );
    		
    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and PubUnitDN like '%" + mpunit[0] + "%'" );
    		}
    		
    		sSql.append( " order by UpdateDate desc,Serno desc,PubUnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			ActivityColumnData tmpQuery = new ActivityColumnData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
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
	
	//查詢多筆資料及筆數(尋找已建立的報名表欄位)
    public ArrayList<Object> findByField( String flag )
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
    		
    		sSql.append( "select * from ActivityColumn where 1=1" );
    		if ( !flag.equals("") ) {
    			sSql.append( " and FieldFlag = '" + flag + "'" );
    		}
    		
    		sSql.append( " order by Serno" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			ActivityColumnData tmpQuery = new ActivityColumnData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setFieldname( rs.getString( "FieldName" ) );
    			tmpQuery.setAttribute( rs.getString( "Attribute" ) );
    			tmpQuery.setFieldvalue( rs.getString( "FieldValue" ) );
    			tmpQuery.setFieldlength( rs.getString( "FieldLength" ) );
    			tmpQuery.setFlag( rs.getString( "Flag" ) );
    			tmpQuery.setCreatedate( rs.getString( "CreateDate" ) );
    			tmpQuery.setPostname( rs.getString( "PostName" ) );
    			tmpQuery.setUpdatedate( rs.getString( "UpdateDate" ) );
    			tmpQuery.setFieldflag( rs.getString( "FieldFlag" ) );
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

    //查詢單筆資料(尋找活動訊息標題)
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
    		stmts = conn.prepareStatement("select Serno,Subject from Activities where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.serno = rs.getString( "Serno" );
    		this.subject = rs.getString( "Subject" );
    		    		
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
	
	//查詢多筆資料及筆數(尋找該活動的報名表欄位)
    public ArrayList<Object> findByrecord( String activityserno )
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
    		
    		sSql.append( "select FieldSerno,IsNeed from ActivityRecord where ActivitySerno = '" + activityserno + "' order by SerialNum" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			ActivityColumnData tmpQuery = new ActivityColumnData();
    			tmpQuery.setFieldserno( rs.getString( "FieldSerno" ) );
    			tmpQuery.setIsneed( rs.getString( "IsNeed" ) );
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

    //查詢單筆資料(尋找活動訊息標題)
    public boolean loadrecord( String activityserno, String fieldserno )
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
    		stmts = conn.prepareStatement( "select FieldSerno,IsNeed from ActivityRecord where ActivitySerno = '" + activityserno + "' and FieldSerno = '" + fieldserno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.fieldserno = rs.getString( "FieldSerno" );
    		this.isneed = rs.getString( "IsNeed" );
    		    		
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
    	
    	ResultSet rs = null;
    	ResultSet rs2 = null;
    	ResultSet rs5 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	Statement stmts3 = null;
    	Statement stmts4 = null;
    	PreparedStatement stmts5 = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		String dropsql = "drop table hcshb.dbo.A_" + activityserno;

    		stmts4 = conn.createStatement();
    		stmts4.executeUpdate( dropsql );
    		
    		//刪除ActivityRecord資料
    		String msql = "select * from ActivityRecord where ActivitySerno = '" + activityserno + "'";
 			stmts5 = conn.prepareStatement(msql);
    		stmts5.clearParameters();
    		rs5 = stmts5.executeQuery();
    		if ( rs5.next() ) {
    			String dsql = "delete ActivityRecord where ActivitySerno = '" + activityserno + "'";
    			stmts5 = conn.prepareStatement(dsql);
    			int updateRow5 = stmts5.executeUpdate();
    			if ( updateRow5 < 0 ) 
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
    		
     		//inser ActivityColumn
     		if ( fieldnum > 0 ) {
     			String[] ary_misneed = SvString.split(misneed,"||");
     			String[] ary_mfieldname = SvString.split(mfieldname,"||");
     			String[] ary_mattribute = SvString.split(mattribute,"||");
     			String[] ary_mfieldvalue = SvString.split(mfieldvalue,"||");
     			String[] ary_mlength = SvString.split(mlength,"||");
     			String[] ary_mserial = SvString.split(mserial,"||");
     			
     			for ( int num=0; num<fieldnum; num++ ) {
     				//找最大序號 start
     	    		stmts = conn.prepareStatement("select max(Serno) as seqno from ActivityColumn where substring(Serno,1,8) = ?" );
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
     	    		
     	    		sorcefield = sorcefield + "||" + mserno;
     	    		sorceserial = sorceserial + "||" + ary_mserial[num];
     	    		sorceisneed = sorceisneed + "||" + ary_misneed[num];
         			
     	    		String sql =  "insert into ActivityColumn";
     	    		       sql += "(Serno,FieldName,Attribute,FieldValue,FieldLength,CreateDate,PostName,UpdateDate)";
     	    		       sql += " values(?,?,?,?,?,?,?,?)";
     	    		       
     	    		stmts = conn.prepareStatement(sql);
     	    		
     	    		stmts.clearParameters();
     	    		String mfieldvalue = ary_mfieldvalue[num];
     	    		if ( mfieldvalue.equals("a") )
     	    			mfieldvalue = "";
     	    		stmts.setString(1, this.serno );
     	    		stmts.setString(2, ary_mfieldname[num] );
     	    		stmts.setString(3, ary_mattribute[num] );
     	    		stmts.setString(4, mfieldvalue );
     	    		stmts.setString(5, ary_mlength[num] );
     	    		stmts.setString(6, getNowYear() );
     	    		stmts.setString(7, postname );
     	    		stmts.setString(8, getNowYear() );
     	    		
     	    		int updateRow = stmts.executeUpdate();
     	    		
     	    		if ( updateRow <= 0 ) {
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
     		}
     		
     		String[] ary_sorcefield = SvString.split(sorcefield,"||");
     		String[] ary_sorceserial = SvString.split(sorceserial,"||");
     		String[] ary_sorceisneed = SvString.split(sorceisneed,"||");
     		//insert ActivityRecord
     		for ( int s=0; s<ary_sorcefield.length; s++ ) {
     			String sql1 =  "insert into ActivityRecord";
     			       sql1 += "(ActivitySerno,SerialNum,FieldSerno,IsNeed,CreateDate,PostName,UpdateDate)";
     			       sql1 += " values(?,?,?,?,?,?,?)";
     			       
     			stmts1 = conn.prepareStatement(sql1);
     			
     			stmts1.clearParameters();
     			stmts1.setString(1, activityserno );
     			stmts1.setString(2, ary_sorceserial[s] );
     			stmts1.setString(3, ary_sorcefield[s] );
     			stmts1.setString(4, ary_sorceisneed[s] );
     			stmts1.setString(5, getNowYear() );
     			stmts1.setString(6, postname );
     			stmts1.setString(7, getNowYear() );
     			
     			int updateRow1 = stmts1.executeUpdate();
     			
     			if ( updateRow1 <= 0 ) {
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
     		
     		//createtable
     		StringBuffer sSql = new StringBuffer();
    		
    		sSql.append( "select * from ActivityRecord where ActivitySerno = '" + activityserno + "' order by SerialNum" );

    		stmts2 = conn.prepareStatement( sSql.toString() );
    		stmts2.clearParameters();
       
    		rs2 = stmts2.executeQuery();
    		
    		String createsql = "create table hcshb.dbo.A_" + activityserno + "( Serno nvarchar(12) PRIMARY KEY,";
    		String colname = "";
    		for ( int i=0; rs2.next(); i++ ) {
    			//取長度
    			int collength = Integer.parseInt(getLength(conn,rs2.getString( "FieldSerno" )));
    			
    			if ( colname.equals("") ) {
    				colname = "A"+rs2.getString( "FieldSerno" ) + " nvarchar(" + collength + "),";
    			}else{
    				colname = colname + " A"+rs2.getString( "FieldSerno" ) + " nvarchar(" + collength + "),";
    			}
    		}
    		createsql = createsql + colname + ")";
    		
    		stmts3 = conn.createStatement();
    		stmts3.executeUpdate( createsql );
    		
    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
    			if ( rs2 != null ) rs2.close();
    			if ( rs5 != null ) rs5.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			if ( stmts4 != null ) stmts4.close();
    			if ( stmts5 != null ) stmts5.close();
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
    	
    	Statement stmts = null;
    	ResultSet rs1 = null;
    	PreparedStatement stmts1 = null;
    	
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);

     		String[] ary_mserno = SvString.split(serno,"||");
     		
     		for ( int i=0; i<ary_mserno.length; i++ ) {     			

         		String dropsql = "drop table hcshb.dbo.A_" + ary_mserno[i];

        		stmts = conn.createStatement();
        		stmts.executeUpdate( dropsql );
        		
        		//刪除ActivityRecord資料
        		String msql = "select * from ActivityRecord where ActivitySerno = '" + ary_mserno[i] + "'";
     			stmts1 = conn.prepareStatement(msql);
        		stmts1.clearParameters();
        		rs1 = stmts1.executeQuery();
        		if ( rs1.next() ) {
        			String dsql = "delete ActivityRecord where ActivitySerno = '" + ary_mserno[i] + "'";
        			stmts1 = conn.prepareStatement(dsql);
        			int updateRow1 = stmts1.executeUpdate();
        			if ( updateRow1 < 0 ) 
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
    		   if ( rs1 != null ) rs1.close();
    		   if ( stmts != null ) stmts.close();
    		   if ( stmts1 != null ) stmts1.close();
    		   conn.close();
    	   }catch( SQLException se ) {
    		   errorMsg = "close Statment or connection error: " + se.toString();
           }
       }
       return false;
    }          		

    //查詢單筆資料(尋找欄位資料)
    public boolean loadfield( String serno )
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
    		stmts = conn.prepareStatement("select * from ActivityColumn where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.serno = rs.getString( "Serno" );
    		this.fieldname = rs.getString( "FieldName" );
    		this.attribute = rs.getString( "Attribute" );
    		this.fieldvalue = rs.getString( "FieldValue" );
    		this.fieldflag = rs.getString( "FieldFlag" );
    		    		
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
    public boolean storefield()
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
    				"update ActivityColumn set PostName = ?, UpdateDate = ?, FieldFlag = ? where Serno = ?" ); 
    		stmts.clearParameters();    	 	
    		stmts.setString(1, postname );
    		stmts.setString(2, getNowYear() );
    		stmts.setString(3, fieldflag );
    		stmts.setString(4, serno );
    		
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

    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }	
            
}
