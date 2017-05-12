/*
 * 撰寫日期：2009/2/1
 * 程式名稱：QuestionExamineData.java
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

import sysview.zhiren.function.SvString;

public class QuestionExamineData {
	private int allrecordCount = 0;

    private String errorMsg = null;

    //Questionnaire
    private String serno = null;
    private String pubunitdn = null;
    private String pubunitname = null;
    private String subject = null;
    private String content = null;
    private String posterdate = null;
    private String closedate = null;
    private String startusing = null;
    private String questiontype = null;
    private String isbasic = null;
    private String basicfield = null;
    private int prizenumber = 0;
    private String clientfile = null;
    private String serverfile = null;    
    private String expfile = null;
    private String imagemagick = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    private String examine = null;
    private String examinename = null;
    private String examinedate = null;
    
    //QuestionnaireDetail
    private String msubject = null;
    private int serialno = 0;
    private String choicetype = null;
    private String clientfile1 = null;
    private String serverfile1 = null;
    private String expfile1 = null;
    private String imagemagick1 = null;
    private String clientfile2 = null;
    private String serverfile2 = null;
    private String expfile2 = null;
    private String imagemagick2 = null;
    private String clientfile3 = null;
    private String serverfile3 = null;
    private String expfile3 = null;
    private String imagemagick3 = null;
    private String clientfile4 = null;
    private String serverfile4 = null;
    private String expfile4 = null;
    private String imagemagick4 = null;
    private String clientfile5 = null;
    private String serverfile5 = null;
    private String expfile5 = null;
    private String imagemagick5 = null;
    private String clientfile6 = null;
    private String serverfile6 = null;
    private String expfile6 = null;
    private String imagemagick6 = null;
    private String clientfile7 = null;
    private String serverfile7 = null;
    private String expfile7 = null;
    private String imagemagick7 = null;
    private String clientfile8 = null;
    private String serverfile8 = null;
    private String expfile8 = null;
    private String imagemagick8 = null;
    private String inputtext = null;
    private String rellection = null;
    private String answer = null;
    
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getBasicfield() {
		return basicfield;
	}
	public void setBasicfield(String basicfield) {
		this.basicfield = basicfield;
	}
	public String getChoicetype() {
		return choicetype;
	}
	public void setChoicetype(String choicetype) {
		this.choicetype = choicetype;
	}
	public String getClientfile() {
		return clientfile;
	}
	public void setClientfile(String clientfile) {
		this.clientfile = clientfile;
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
	public String getClientfile6() {
		return clientfile6;
	}
	public void setClientfile6(String clientfile6) {
		this.clientfile6 = clientfile6;
	}
	public String getClientfile7() {
		return clientfile7;
	}
	public void setClientfile7(String clientfile7) {
		this.clientfile7 = clientfile7;
	}
	public String getClientfile8() {
		return clientfile8;
	}
	public void setClientfile8(String clientfile8) {
		this.clientfile8 = clientfile8;
	}
	public String getClosedate() {
		return closedate;
	}
	public void setClosedate(String closedate) {
		this.closedate = closedate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getExamine() {
		return examine;
	}
	public void setExamine(String examine) {
		this.examine = examine;
	}
	public String getExaminedate() {
		return examinedate;
	}
	public void setExaminedate(String examinedate) {
		this.examinedate = examinedate;
	}
	public String getExaminename() {
		return examinename;
	}
	public void setExaminename(String examinename) {
		this.examinename = examinename;
	}
	public String getExpfile() {
		return expfile;
	}
	public void setExpfile(String expfile) {
		this.expfile = expfile;
	}
	public String getExpfile1() {
		return expfile1;
	}
	public void setExpfile1(String expfile1) {
		this.expfile1 = expfile1;
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
	public String getExpfile6() {
		return expfile6;
	}
	public void setExpfile6(String expfile6) {
		this.expfile6 = expfile6;
	}
	public String getExpfile7() {
		return expfile7;
	}
	public void setExpfile7(String expfile7) {
		this.expfile7 = expfile7;
	}
	public String getExpfile8() {
		return expfile8;
	}
	public void setExpfile8(String expfile8) {
		this.expfile8 = expfile8;
	}
	public String getImagemagick() {
		return imagemagick;
	}
	public void setImagemagick(String imagemagick) {
		this.imagemagick = imagemagick;
	}
	public String getImagemagick1() {
		return imagemagick1;
	}
	public void setImagemagick1(String imagemagick1) {
		this.imagemagick1 = imagemagick1;
	}
	public String getImagemagick2() {
		return imagemagick2;
	}
	public void setImagemagick2(String imagemagick2) {
		this.imagemagick2 = imagemagick2;
	}
	public String getImagemagick3() {
		return imagemagick3;
	}
	public void setImagemagick3(String imagemagick3) {
		this.imagemagick3 = imagemagick3;
	}
	public String getImagemagick4() {
		return imagemagick4;
	}
	public void setImagemagick4(String imagemagick4) {
		this.imagemagick4 = imagemagick4;
	}
	public String getImagemagick5() {
		return imagemagick5;
	}
	public void setImagemagick5(String imagemagick5) {
		this.imagemagick5 = imagemagick5;
	}
	public String getImagemagick6() {
		return imagemagick6;
	}
	public void setImagemagick6(String imagemagick6) {
		this.imagemagick6 = imagemagick6;
	}
	public String getImagemagick7() {
		return imagemagick7;
	}
	public void setImagemagick7(String imagemagick7) {
		this.imagemagick7 = imagemagick7;
	}
	public String getImagemagick8() {
		return imagemagick8;
	}
	public void setImagemagick8(String imagemagick8) {
		this.imagemagick8 = imagemagick8;
	}
	public String getInputtext() {
		return inputtext;
	}
	public void setInputtext(String inputtext) {
		this.inputtext = inputtext;
	}
	public String getIsbasic() {
		return isbasic;
	}
	public void setIsbasic(String isbasic) {
		this.isbasic = isbasic;
	}
	public String getMsubject() {
		return msubject;
	}
	public void setMsubject(String msubject) {
		this.msubject = msubject;
	}
	public String getPosterdate() {
		return posterdate;
	}
	public void setPosterdate(String posterdate) {
		this.posterdate = posterdate;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
	}
	public int getPrizenumber() {
		return prizenumber;
	}
	public void setPrizenumber(int prizenumber) {
		this.prizenumber = prizenumber;
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
	public String getQuestiontype() {
		return questiontype;
	}
	public void setQuestiontype(String questiontype) {
		this.questiontype = questiontype;
	}
	public String getRellection() {
		return rellection;
	}
	public void setRellection(String rellection) {
		this.rellection = rellection;
	}
	public int getSerialno() {
		return serialno;
	}
	public void setSerialno(int serialno) {
		this.serialno = serialno;
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
	public String getServerfile6() {
		return serverfile6;
	}
	public void setServerfile6(String serverfile6) {
		this.serverfile6 = serverfile6;
	}
	public String getServerfile7() {
		return serverfile7;
	}
	public void setServerfile7(String serverfile7) {
		this.serverfile7 = serverfile7;
	}
	public String getServerfile8() {
		return serverfile8;
	}
	public void setServerfile8(String serverfile8) {
		this.serverfile8 = serverfile8;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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
	
	//查詢多筆資料及筆數
    public ArrayList<Object> findByday( String tablename, String keyword, String punit, String examine )
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
    			sSql.append( " and Subject like '%" + keyword + "%'" );
    		}
    			
    		if ( punit != null && !punit.equals("") ) {
    			String[] mpunit = SvString.split(punit,"||");
    			sSql.append( " and PubUnitDN like '%" + mpunit[0] + "%'" );
    		}
    		
    		if ( examine != null && !examine.equals("null") && !examine.equals("") ) {
    			sSql.append( " and Examine = '" + examine + "'" );
    		}

    		sSql.append( " order by UpdateDate desc,Serno desc,PubUnitDN" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			QuestionExamineData tmpQuery = new QuestionExamineData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setSubject( rs.getString( "Subject" ) );
    			tmpQuery.setContent( rs.getString( "Content" ) );
    			tmpQuery.setPosterdate( rs.getString( "PosterDate" ) );
    			tmpQuery.setClosedate( rs.getString( "CloseDate" ) );
    			tmpQuery.setStartusing( rs.getString( "StartUsing" ) );
    			tmpQuery.setQuestiontype( rs.getString( "QuestionType" ) );
    			tmpQuery.setIsbasic( rs.getString( "IsBasic" ) );
    			tmpQuery.setBasicfield( rs.getString( "BasicField" ) );
    			tmpQuery.setClientfile( rs.getString( "ClientFile" ) );
    			tmpQuery.setServerfile( rs.getString( "ServerFile" ) );
    			tmpQuery.setExpfile( rs.getString( "ExpFile" ) );
    			tmpQuery.setImagemagick( rs.getString( "ImageMagick" ) );
    			tmpQuery.setPostname( rs.getString( "PostName" ) );
    			tmpQuery.setUpdatedate( rs.getString( "UpdateDate" ) );
    			tmpQuery.setExamine( rs.getString( "Examine" ) );
    			tmpQuery.setExaminename( rs.getString( "ExamineName" ) );
    			tmpQuery.setExaminedate( rs.getString( "ExamineDate" ) );
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
    		this.subject = rs.getString( "Subject" );
    		this.content = rs.getString( "Content" );
    		this.posterdate = rs.getString( "PosterDate" );
    		this.closedate = rs.getString( "CloseDate" );
    		this.startusing = rs.getString( "StartUsing" );
    		this.questiontype = rs.getString( "QuestionType" );
    		this.isbasic = rs.getString( "IsBasic" );
    		this.basicfield = rs.getString( "BasicField" );
    		this.prizenumber = rs.getInt( "PrizeNumber" );
    		this.clientfile = rs.getString( "ClientFile" );
    		this.serverfile = rs.getString( "ServerFile" );
    		this.expfile = rs.getString( "ExpFile" );
    		this.imagemagick = rs.getString( "ImageMagick" );
    		this.postname = rs.getString( "PostName" );
    		this.updatedate = rs.getString( "UpdateDate" );
    		this.examine = rs.getString( "Examine" );
    		this.examinename = rs.getString( "ExamineName" );
    		this.examinedate = rs.getString( "ExamineDate" );
    		
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
    public ArrayList<Object> findByday( String serno )
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
    		
    		sSql.append( "select * from QuestionnaireDetail where Serno = '" + serno + "' order by SerialNo" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			QuestionnaireData tmpQuery = new QuestionnaireData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setMsubject( rs.getString( "Subject" ) );
    			tmpQuery.setChoicetype( rs.getString( "ChoiceType" ) );
    			tmpQuery.setClientfile1( rs.getString( "ClientFile1" ) );
    			tmpQuery.setServerfile1( rs.getString( "ServerFile1" ) );
    			tmpQuery.setExpfile1( rs.getString( "ExpFile1" ) );
    			tmpQuery.setImagemagick1( rs.getString( "ImageMagick1" ) );
    			tmpQuery.setClientfile2( rs.getString( "ClientFile2" ) );
    			tmpQuery.setServerfile2( rs.getString( "ServerFile2" ) );
    			tmpQuery.setExpfile2( rs.getString( "ExpFile2" ) );
    			tmpQuery.setImagemagick2( rs.getString( "ImageMagick2" ) );
    			tmpQuery.setClientfile3( rs.getString( "ClientFile3" ) );
    			tmpQuery.setServerfile3( rs.getString( "ServerFile3" ) );
    			tmpQuery.setExpfile3( rs.getString( "ExpFile3" ) );
    			tmpQuery.setImagemagick3( rs.getString( "ImageMagick3" ) );
    			tmpQuery.setClientfile4( rs.getString( "ClientFile4" ) );
    			tmpQuery.setServerfile4( rs.getString( "ServerFile4" ) );
    			tmpQuery.setExpfile4( rs.getString( "ExpFile4" ) );
    			tmpQuery.setImagemagick4( rs.getString( "ImageMagick4" ) );
    			tmpQuery.setClientfile5( rs.getString( "ClientFile5" ) );
    			tmpQuery.setServerfile5( rs.getString( "ServerFile5" ) );
    			tmpQuery.setExpfile5( rs.getString( "ExpFile5" ) );
    			tmpQuery.setImagemagick5( rs.getString( "ImageMagick5" ) );
    			tmpQuery.setClientfile6( rs.getString( "ClientFile6" ) );
    			tmpQuery.setServerfile6( rs.getString( "ServerFile6" ) );
    			tmpQuery.setExpfile6( rs.getString( "ExpFile6" ) );
    			tmpQuery.setImagemagick6( rs.getString( "ImageMagick6" ) );
    			tmpQuery.setClientfile7( rs.getString( "ClientFile7" ) );
    			tmpQuery.setServerfile7( rs.getString( "ServerFile7" ) );
    			tmpQuery.setExpfile7( rs.getString( "ExpFile7" ) );
    			tmpQuery.setImagemagick7( rs.getString( "ImageMagick7" ) );
    			tmpQuery.setClientfile8( rs.getString( "ClientFile8" ) );
    			tmpQuery.setServerfile8( rs.getString( "ServerFile8" ) );
    			tmpQuery.setExpfile8( rs.getString( "ExpFile8" ) );
    			tmpQuery.setImagemagick8( rs.getString( "ImageMagick8" ) );
    			tmpQuery.setInputtext( rs.getString( "InputText" ) );
    			tmpQuery.setRellection( rs.getString( "Rellection" ) );
    			tmpQuery.setAnswer( rs.getString( "Answer" ) );
    			
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
    	
    	PreparedStatement stmts = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//update
     		stmts = conn.prepareStatement(
    			"update Questionnaire set Examine = ?, ExamineName = ?, ExamineDate = ? where Serno = ?");
    		
     		stmts.setString(1, examine );
     		stmts.setString(2, examinename );
     		stmts.setString(3, getNowYear() );
     		stmts.setString(4, serno );
    		
    		int updateRow = stmts.executeUpdate();
    		
    		if ( updateRow < 0 )
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
    		
    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "update data error: " + sqle.toString();
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
