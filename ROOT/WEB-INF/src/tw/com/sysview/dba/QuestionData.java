/*
 * 撰寫日期：2008/12/14
 * 程式名稱：QuestionData.java
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

public class QuestionData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private int num = 0;
    private int flag = 0;
    private String prizedata = null;
    
    private String subject = null;
    private String pubunitdn = null;
    private String pubunitname = null;
    private String content = null;
    private String posterdate = null;
    private String closedate = null;
    private String startusing = null;
    private String questiontype = null;
    private String isbasic = null;
    private String basicfield = null;
    private String updatedate = null;

    private int prizenumber = 0;
    private String clientfile = null;
    private String serverfile = null;
    private String imagemagick = null;
    private String expfile = null;
    
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
    
    //QuestionnaireBasic
    private String serno = null;
    private int detailno = 0;
    private String respond = null;
    private String name = null;
    private String pid = null;
    private String sex = null;
    private String email = null;
    private String area = null;
    private String cityno = null;
    private String cityname = null;
    private String townsno = null;
    private String townsname = null;
    private String address = null;
    private String tel = null;
    private String degree = null;
    private String age = null;
    private String job = null;
    private String createdate = null;
    private String webip = null;
    
    //QuestionnaireAnswer
    private String answer1 = null;
    private String answer2 = null;
    private String answer3 = null;
    private String answer4 = null;
    private String answer5 = null;
    private String answer6 = null;
    private String answer7 = null;
    private String answer8 = null;
    private String createname = null;
    
	public String getPrizedata() {
		return prizedata;
	}
	public void setPrizedata(String prizedata) {
		this.prizedata = prizedata;
	}
	public String getCreatename() {
		return createname;
	}
	public void setCreatename(String createname) {
		this.createname = createname;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
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
	public String getBasicfield() {
		return basicfield;
	}
	public void setBasicfield(String basicfield) {
		this.basicfield = basicfield;
	}
	public String getClientfile() {
		return clientfile;
	}
	public void setClientfile(String clientfile) {
		this.clientfile = clientfile;
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
	public String getIsbasic() {
		return isbasic;
	}
	public void setIsbasic(String isbasic) {
		this.isbasic = isbasic;
	}
	public String getPosterdate() {
		return posterdate;
	}
	public void setPosterdate(String posterdate) {
		this.posterdate = posterdate;
	}
	public int getPrizenumber() {
		return prizenumber;
	}
	public void setPrizenumber(int prizenumber) {
		this.prizenumber = prizenumber;
	}
	public String getQuestiontype() {
		return questiontype;
	}
	public void setQuestiontype(String questiontype) {
		this.questiontype = questiontype;
	}
	public String getServerfile() {
		return serverfile;
	}
	public void setServerfile(String serverfile) {
		this.serverfile = serverfile;
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
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getChoicetype() {
		return choicetype;
	}
	public void setChoicetype(String choicetype) {
		this.choicetype = choicetype;
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
	public String getMsubject() {
		return msubject;
	}
	public void setMsubject(String msubject) {
		this.msubject = msubject;
	}
	public String getRellection() {
		return rellection;
	}
	public void setRellection(String rellection) {
		this.rellection = rellection;
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
	public String getInputtext() {
		return inputtext;
	}
	public void setInputtext(String inputtext) {
		this.inputtext = inputtext;
	}
	public int getSerialno() {
		return serialno;
	}
	public void setSerialno(int serialno) {
		this.serialno = serialno;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getAnswer1() {
		return answer1;
	}
	public void setAnswer1(String answer1) {
		this.answer1 = answer1;
	}
	public String getAnswer2() {
		return answer2;
	}
	public void setAnswer2(String answer2) {
		this.answer2 = answer2;
	}
	public String getAnswer3() {
		return answer3;
	}
	public void setAnswer3(String answer3) {
		this.answer3 = answer3;
	}
	public String getAnswer4() {
		return answer4;
	}
	public void setAnswer4(String answer4) {
		this.answer4 = answer4;
	}
	public String getAnswer5() {
		return answer5;
	}
	public void setAnswer5(String answer5) {
		this.answer5 = answer5;
	}
	public String getAnswer6() {
		return answer6;
	}
	public void setAnswer6(String answer6) {
		this.answer6 = answer6;
	}
	public String getAnswer7() {
		return answer7;
	}
	public void setAnswer7(String answer7) {
		this.answer7 = answer7;
	}
	public String getAnswer8() {
		return answer8;
	}
	public void setAnswer8(String answer8) {
		this.answer8 = answer8;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getCityname() {
		return cityname;
	}
	public void setCityname(String cityname) {
		this.cityname = cityname;
	}
	public String getCityno() {
		return cityno;
	}
	public void setCityno(String cityno) {
		this.cityno = cityno;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getDegree() {
		return degree;
	}
	public void setDegree(String degree) {
		this.degree = degree;
	}
	public int getDetailno() {
		return detailno;
	}
	public void setDetailno(int detailno) {
		this.detailno = detailno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getRespond() {
		return respond;
	}
	public void setRespond(String respond) {
		this.respond = respond;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getTownsname() {
		return townsname;
	}
	public void setTownsname(String townsname) {
		this.townsname = townsname;
	}
	public String getTownsno() {
		return townsno;
	}
	public void setTownsno(String townsno) {
		this.townsno = townsno;
	}
	public String getWebip() {
		return webip;
	}
	public void setWebip(String webip) {
		this.webip = webip;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	
	//查詢多筆資料及筆數
    public ArrayList<Object> findBydata( String serno )
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
    		
    		sSql.append( "select * from QuestionnaireAnswer where Serno = '" + serno + "'" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			QuestionData tmpQuery = new QuestionData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setSerialno( rs.getInt( "SerialNo" ) );
    			tmpQuery.setDetailno( rs.getInt( "DetailNo" ) );
    			tmpQuery.setAnswer1( rs.getString( "Answer1" ) );
    			tmpQuery.setAnswer2( rs.getString( "Answer2" ) );
    			tmpQuery.setAnswer3( rs.getString( "Answer3" ) );
    			tmpQuery.setAnswer4( rs.getString( "Answer4" ) );
    			tmpQuery.setAnswer5( rs.getString( "Answer5" ) );
    			tmpQuery.setAnswer6( rs.getString( "Answer6" ) );
    			tmpQuery.setAnswer7( rs.getString( "Answer7" ) );
    			tmpQuery.setAnswer8( rs.getString( "Answer8" ) );
    			tmpQuery.setInputtext( rs.getString( "InputText" ) );
    			tmpQuery.setCreatedate( rs.getString( "CreateDate" ) );
    			tmpQuery.setWebip( rs.getString( "WebIP" ) );
    			
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
	
	//查詢多筆資料及筆數(查詢答卷總人數)
    public ArrayList<Object> findBynum( String serno )
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
    		
    		sSql.append( "select distinct DetailNo,CreateDate from QuestionnaireAnswer where Serno = '" + serno + "'" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			QuestionData tmpQuery = new QuestionData();
    			tmpQuery.setDetailno( rs.getInt( "DetailNo" ) );
    			tmpQuery.setCreatedate( rs.getString( "CreateDate" ) );
    			
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
    public boolean load( String serno, int detailno )
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
    		stmts = conn.prepareStatement("select * from QuestionnaireBasic where Serno = '" + serno + "' and DetailNo = " + detailno);
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.detailno = rs.getInt( "DetailNo" );
    		this.respond = rs.getString( "Respond" );
    		this.name = rs.getString( "Name" );
    		this.pid = rs.getString( "Pid" );
    		this.sex = rs.getString( "Sex" );
    		this.email = rs.getString( "Email" );
    		this.area = rs.getString( "Area" );
    		this.cityno = rs.getString( "CityNo" );
    		this.cityname = rs.getString( "CityName" );
    		this.townsno = rs.getString( "TownsNo" );
    		this.townsname = rs.getString( "TownsName" );
    		this.address = rs.getString( "Address" );
    		this.tel = rs.getString( "Tel" );
    		this.degree = rs.getString( "Degree" );
    		this.age = rs.getString( "Age" );
    		this.job = rs.getString( "Job" );
    		this.createdate = rs.getString( "CreateDate" );
    		
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
	
	//查詢多筆資料及筆數(尋找該問卷題目)
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
    			QuestionData tmpQuery = new QuestionData();
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

    //查詢單筆資料(查詢該填卷者此題之答案)
    public boolean load( String serno, int serialno, int detailno )
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
    		stmts = conn.prepareStatement("select * from QuestionnaireAnswer where Serno = '" + serno + "' and SerialNo = " + serialno + " and DetailNo = " + detailno);
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.serialno = rs.getInt( "SerialNo" );
    		this.detailno = rs.getInt( "DetailNo" );
    		this.answer1 = rs.getString( "Answer1" );
    		this.answer2 = rs.getString( "Answer2" );
    		this.answer3 = rs.getString( "Answer3" );
    		this.answer4 = rs.getString( "Answer4" );
    		this.answer5 = rs.getString( "Answer5" );
    		this.answer6 = rs.getString( "Answer6" );
    		this.answer7 = rs.getString( "Answer7" );
    		this.answer8 = rs.getString( "Answer8" );
    		this.inputtext = rs.getString( "InputText" );
    		this.createdate = rs.getString( "CreateDate" );
    		
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
	
	//查詢多筆資料及筆數(查詢可產生中獎名單的問卷)
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
    		
    		sSql.append( "select * from " + tablename + " where IsBasic = 'Y'" );
    		
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
    			QuestionData tmpQuery = new QuestionData();
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
	
	//查詢多筆資料及筆數(查詢中獎名單)
    public ArrayList<Object> findByprize( String serno )
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
    		
    		sSql.append( "select * from QuestionnairePrize where Serno = '" + serno + "'" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			QuestionData tmpQuery = new QuestionData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setDetailno( rs.getInt( "DetailNo" ) );
    			tmpQuery.setName( rs.getString( "Name" ) );
    			tmpQuery.setPid( rs.getString( "Pid" ) );
    			tmpQuery.setCreatedate( rs.getString( "CreateDate" ) );
    			
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
	
	//查詢多筆資料及筆數(產生中獎名單)
    public ArrayList<Object> findByRprize( String serno )
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
    		
    		sSql.append( "select Top " + num + " Serno,DetailNo,Pid,Name from QuestionnaireBasic where Serno = '" + serno + "'" );
    		
    		if ( flag != 0 ) {
    			sSql.append( " and Respond >= " + flag );
    		}
    		
    		sSql.append( " order by newid()" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i=0; rs.next(); i++ )
    		{
    			QuestionData tmpQuery = new QuestionData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setDetailno( rs.getInt( "DetailNo" ) );
    			tmpQuery.setName( rs.getString( "Name" ) );
    			tmpQuery.setPid( rs.getString( "Pid" ) );
    			
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
     		
     		String msql = "select * from QuestionnairePrize where Serno = '" + serno + "'";
 			stmts = conn.prepareStatement(msql);
    		stmts.clearParameters();
    		rs = stmts.executeQuery();
    		
    		if ( rs.next() ) {
    			String dsql = "delete QuestionnairePrize where Serno = '" + serno + "'";
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
    		
    		//insert QuestionnairePrize
    		String[] ary_prizedata = SvString.split(prizedata,"&");
    		for ( int i=0; i<ary_prizedata.length; i++ ) {
    			String[] ary_prize = SvString.split(ary_prizedata[i],"||");
    			String sql =  "insert into QuestionnairePrize";
    			       sql += "(Serno,DetailNo,Name,Pid,CreateName,CreateDate)";
    			       sql += " values(?,?,?,?,?,?)";
    			
    			stmts2 = conn.prepareStatement(sql);
    			
    			stmts2.clearParameters();
    			stmts2.setString(1, ary_prize[0] );
    			stmts2.setInt(2, Integer.parseInt(ary_prize[1]) );
    			stmts2.setString(3, ary_prize[2] );
    			stmts2.setString(4, ary_prize[3] );
    			stmts2.setString(5, createname );
    			stmts2.setString(6, getNowYear() );
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

    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    
       
}
