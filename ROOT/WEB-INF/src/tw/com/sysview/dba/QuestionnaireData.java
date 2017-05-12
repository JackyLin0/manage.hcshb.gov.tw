/*
 * 撰寫日期：2008/12/9
 * 程式名稱：QuestionnaireData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
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

public class QuestionnaireData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    private String questdata = null;
    private String textdata = null;
    private String filedata = null;
    private String ofiledata = null;
    
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
    private String language = null;
    
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
    
	public String getOfiledata() {
		return ofiledata;
	}
	public void setOfiledata(String ofiledata) {
		this.ofiledata = ofiledata;
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
	public String getInputtext() {
		return inputtext;
	}
	public void setInputtext(String inputtext) {
		this.inputtext = inputtext;
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
	public int getSerialno() {
		return serialno;
	}
	public void setSerialno(int serialno) {
		this.serialno = serialno;
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
	public String getTextdata() {
		return textdata;
	}
	public void setTextdata(String textdata) {
		this.textdata = textdata;
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
	public String getFiledata() {
		return filedata;
	}
	public void setFiledata(String filedata) {
		this.filedata = filedata;
	}
	public String getQuestdata() {
		return questdata;
	}
	public void setQuestdata(String questdata) {
		this.questdata = questdata;
	}
	public String getExpfile() {
		return expfile;
	}
	public void setExpfile(String expfile) {
		this.expfile = expfile;
	}
	public String getClientfile() {
		return clientfile;
	}
	public void setClientfile(String clientfile) {
		this.clientfile = clientfile;
	}
	public String getBasicfield() {
		return basicfield;
	}
	public void setBasicfield(String basicfield) {
		this.basicfield = basicfield;
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
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getPosterdate() {
		return posterdate;
	}
	public void setPosterdate(String posterdate) {
		this.posterdate = posterdate;
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
    	ResultSet rs3 = null;
    	ResultSet rs6 = null;
    	ResultSet rs9 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	PreparedStatement stmts5 = null;
    	PreparedStatement stmts6 = null;
    	PreparedStatement stmts7 = null;
    	PreparedStatement stmts8 = null;
    	PreparedStatement stmts9 = null;
    	PreparedStatement stmts10 = null;
    	PreparedStatement stmts11 = null;
    	
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
    		
    		//insert Questionnaire
    		String sql =  "insert into " + tablename;
    		       sql += "(Serno,PubUnitDN,PubUnitName,Subject,Content,PosterDate,CloseDate,StartUsing,QuestionType,IsBasic,BasicField,PrizeNumber,ClientFile,ServerFile,ExpFile,ImageMagick,PostName,CreateDate,UpdateDate,Examine,ExamineName,ExamineDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, pubunitdn );
    		stmts2.setString(3, pubunitname );
    		stmts2.setString(4, subject );
    		stmts2.setString(5, content );
    		stmts2.setString(6, posterdate );
    		stmts2.setString(7, closedate );
    		stmts2.setString(8, startusing );
    		stmts2.setString(9, questiontype );
    		stmts2.setString(10, isbasic );
    		stmts2.setString(11, basicfield );
    		stmts2.setInt(12, prizenumber );
    		stmts2.setString(13, clientfile );
    		stmts2.setString(14, serverfile );
    		stmts2.setString(15, expfile );
    		stmts2.setString(16, imagemagick );
    		stmts2.setString(17, postname );
    		stmts2.setString(18, getNowYear() );
    		stmts2.setString(19, getNowYear() );
    		stmts2.setString(20, "0" );
    		stmts2.setString(21, "" );
    		stmts2.setString(22, "" );
    		
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
    		
    		//insert QuestionnaireDetail
    		/**
    		 * textdata：題目的選項
    		 * questdata：題目、複選、文字輸入、解答
    		 */
    		String[] ary_questdata = SvString.split(questdata,"&");
    		if ( !textdata.equals("") ) {
    			String[] ary_textdata = SvString.split(textdata,"&");
        		for ( int t=0; t<ary_textdata.length; t++ ) {
        			String[] ary_choice = SvString.split(ary_textdata[t],"||");
        			String msql = "select * from QuestionnaireDetail where Serno = '" + serno + "' and SerialNo = " + ary_choice[0];
        			
        			stmts3 = conn.prepareStatement(msql);
            		stmts3.clearParameters();
        			rs3 = stmts3.executeQuery();
        			
            		if ( !rs3.next() ) {
            			String isql =  "insert into QuestionnaireDetail";
            			       isql += "(Serno,SerialNo,ChoiceType,ClientFile1,ServerFile1,ExpFile1,ImageMagick1,ClientFile2,ServerFile2,ExpFile2,ImageMagick2,ClientFile3,ServerFile3,ExpFile3,ImageMagick3,";
            			       isql += "ClientFile4,ServerFile4,ExpFile4,ImageMagick4,ClientFile5,ServerFile5,ExpFile5,ImageMagick5,ClientFile6,ServerFile6,ExpFile6,ImageMagick6,";
            			       isql += "ClientFile7,ServerFile7,ExpFile7,ImageMagick7,ClientFile8,ServerFile8,ExpFile8,ImageMagick8)";
         		               isql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
         		        stmts4 = conn.prepareStatement(isql);
         		       
         		        stmts4.clearParameters();
         		        stmts4.setString(1, serno );
         		        stmts4.setString(2, ary_choice[0] );
         		        stmts4.setString(3, "1" );
         		        stmts4.setString(4, "" );
         		        stmts4.setString(5, ary_choice[1].equals("a") ? "" : ary_choice[1] );
         		        stmts4.setString(6, "" );
         		        stmts4.setString(7, "" );
         		        stmts4.setString(8, "" );
        		        stmts4.setString(9, ary_choice[2].equals("a") ? "" : ary_choice[2] );
        		        stmts4.setString(10, "" );
        		        stmts4.setString(11, "" );
        		        stmts4.setString(12, "" );
         		        stmts4.setString(13, ary_choice[3].equals("a") ? "" : ary_choice[3] );
         		        stmts4.setString(14, "" );
         		        stmts4.setString(15, "" );
         		        stmts4.setString(16, "" );
        		        stmts4.setString(17, ary_choice[4].equals("a") ? "" : ary_choice[4] );
        		        stmts4.setString(18, "" );
        		        stmts4.setString(19, "" );
        		        stmts4.setString(20, "" );
         		        stmts4.setString(21, ary_choice[5].equals("a") ? "" : ary_choice[5] );
         		        stmts4.setString(22, "" );
         		        stmts4.setString(23, "" );
         		        stmts4.setString(24, "" );
        		        stmts4.setString(25, ary_choice[6].equals("a") ? "" : ary_choice[6] );
        		        stmts4.setString(26, "" );
        		        stmts4.setString(27, "" );
        		        stmts4.setString(28, "" );
         		        stmts4.setString(29, ary_choice[7].equals("a") ? "" : ary_choice[7] );
         		        stmts4.setString(30, "" );
         		        stmts4.setString(31, "" );
         		        stmts4.setString(32, "" );
        		        stmts4.setString(33, ary_choice[8].equals("a") ? "" : ary_choice[8] );
        		        stmts4.setString(34, "" );
        		        stmts4.setString(35, "" );
        		        
        	    		int updateRow4 = stmts4.executeUpdate();    	    		
        	    		if ( updateRow4 < 0 )
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
            		}else{
            			stmts5 = conn.prepareStatement(
            	    			"update QuestionnaireDetail set ChoiceType = ?, ServerFile1 = ?, ServerFile2 = ?, ServerFile3 = ?, ServerFile4 = ?, ServerFile5 = ?, ServerFile6 = ?, ServerFile7 = ?, ServerFile8 = ? where Serno = ? and SerialNo = ?");
            	    		   		
            			stmts5.setString(1, "1" );
            			stmts5.setString(2, ary_choice[1].equals("a") ? "" : ary_choice[1] );
            			stmts5.setString(3, ary_choice[2].equals("a") ? "" : ary_choice[2] );
            			stmts5.setString(4, ary_choice[3].equals("a") ? "" : ary_choice[3] );
            			stmts5.setString(5, ary_choice[4].equals("a") ? "" : ary_choice[4] );
            			stmts5.setString(6, ary_choice[5].equals("a") ? "" : ary_choice[5] );
            			stmts5.setString(7, ary_choice[6].equals("a") ? "" : ary_choice[6] );
            			stmts5.setString(8, ary_choice[7].equals("a") ? "" : ary_choice[7] );
            			stmts5.setString(9, ary_choice[8].equals("a") ? "" : ary_choice[8] );
            			stmts5.setString(10, serno );
            			stmts5.setString(11, ary_choice[0] );
            	    		
            	    	int updateRow5 = stmts5.executeUpdate();
            	    	if ( updateRow5 < 0 ) {
            	    		try {
            	    			conn.rollback();
            	    			errorMsg = "Insert into table fail(Statistics).";
            	    			System.out.println(errorMsg);
            	    			return false;
            	    		}catch(Exception backerr){
            	    			System.out.println("rollback faild!");
            	    		}
            	    	}
            		}
        		}
    		}
    		
    		for ( int q=0; q<ary_questdata.length; q++ ) {
    			String[] ary_choice = SvString.split(ary_questdata[q],"||");
    			String msql = "select * from QuestionnaireDetail where Serno = '" + serno + "' and SerialNo = " + ary_choice[0];
    			
    			stmts6 = conn.prepareStatement(msql);
        		stmts6.clearParameters();
    			rs6 = stmts6.executeQuery();
        		if ( !rs6.next() ) {
        			String isql =  "insert into QuestionnaireDetail";
        			       isql += "(Serno,SerialNo,Subject,InputText,Rellection,Answer)";
     		               isql += " values(?,?,?,?,?,?)";
     		        stmts7 = conn.prepareStatement(isql);
     		        
     		        stmts7.clearParameters();
     		        stmts7.setString(1, serno );
     		        stmts7.setString(2, ary_choice[0] );
     		        stmts7.setString(3, ary_choice[1] );
     		        stmts7.setString(4, ary_choice[2] );
     		        stmts7.setString(5, ary_choice[3] );
     		        stmts7.setString(6, ary_choice[4] );
    	    		int updateRow7 = stmts7.executeUpdate();
    	    		
    	    		if ( updateRow7 < 0 )
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
        		}else{
        			stmts8 = conn.prepareStatement(
        	    			"update QuestionnaireDetail set Subject = ?, InputText = ?, Rellection = ?, Answer = ? where Serno = ? and SerialNo = ?");
        	    		   		
        			stmts8.setString(1, ary_choice[1] );
        			stmts8.setString(2, ary_choice[2] );
        			stmts8.setString(3, ary_choice[3] );
        			stmts8.setString(4, ary_choice[4] );
        			stmts8.setString(5, serno );
        			stmts8.setString(6, ary_choice[0] );
        	    	int updateRow8 = stmts8.executeUpdate();
        	    		
        	    	if ( updateRow8 < 0 ) {
        	    		try {
        	    			conn.rollback();
        	    			errorMsg = "Insert into table fail(Statistics).";
        	    			System.out.println(errorMsg);
        	    			return false;
        	    		}catch(Exception backerr){
        	    			System.out.println("rollback faild!");
        	    		}
        	    	}
        		}
    		}
    		
    		if ( !filedata.equals("") ) {
    			String[] ary_filedata = SvString.split(filedata,"&");
        		for ( int f=0; f<ary_filedata.length; f++ ) {
        			String[] ary_choice = SvString.split(ary_filedata[f],"||");
        			String msql = "select * from QuestionnaireDetail where Serno = '" + serno + "' and SerialNo = " + ary_choice[0];
         			stmts9 = conn.prepareStatement(msql);
         			
            		stmts9.clearParameters();
            		
            		rs9 = stmts9.executeQuery();
            		
            		String mcfile1 = "";
            		String msfile1 = "";
            		String mexpfile1 = "";
            		String mimage1 = "";
            		String mcfile2 = "";
            		String msfile2 = "";
            		String mexpfile2 = "";
            		String mimage2 = "";
            		String mcfile3 = "";
            		String msfile3 = "";
            		String mexpfile3 = "";
            		String mimage3 = "";
            		String mcfile4 = "";
            		String msfile4 = "";
            		String mexpfile4 = "";
            		String mimage4 = "";
            		String mcfile5 = "";
            		String msfile5 = "";
            		String mexpfile5 = "";
            		String mimage5 = "";
            		String mcfile6 = "";
            		String msfile6 = "";
            		String mexpfile6 = "";
            		String mimage6 = "";
            		String mcfile7 = "";
            		String msfile7 = "";
            		String mexpfile7 = "";
            		String mimage7 = "";
            		String mcfile8 = "";
            		String msfile8 = "";
            		String mexpfile8 = "";
            		String mimage8 = "";
            		
            		if ( !ary_choice[1].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[1],",");
            			mcfile1 = ary_choicedata[0];
                		msfile1 = ary_choicedata[1];
                		mexpfile1 = ary_choicedata[2];
                		mimage1 = ary_choicedata[3];
            		}
            		if ( !ary_choice[2].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[2],",");
            			mcfile2 = ary_choicedata[0];
                		msfile2 = ary_choicedata[1];
                		mexpfile2 = ary_choicedata[2];
                		mimage2 = ary_choicedata[3];
            		}
            		if ( !ary_choice[3].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[3],",");
            			mcfile3 = ary_choicedata[0];
                		msfile3 = ary_choicedata[1];
                		mexpfile3 = ary_choicedata[2];
                		mimage3 = ary_choicedata[3];
            		}
            		if ( !ary_choice[4].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[4],",");
            			mcfile4 = ary_choicedata[0];
                		msfile4 = ary_choicedata[1];
                		mexpfile4 = ary_choicedata[2];
                		mimage4 = ary_choicedata[3];
            		}
            		if ( !ary_choice[5].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[5],",");
            			mcfile5 = ary_choicedata[0];
                		msfile5 = ary_choicedata[1];
                		mexpfile5 = ary_choicedata[2];
                		mimage5 = ary_choicedata[3];
            		}
            		if ( !ary_choice[6].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[6],",");
            			mcfile6 = ary_choicedata[0];
                		msfile6 = ary_choicedata[1];
                		mexpfile6 = ary_choicedata[2];
                		mimage6 = ary_choicedata[3];
            		}
            		if ( !ary_choice[7].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[7],",");
            			mcfile7 = ary_choicedata[0];
                		msfile7 = ary_choicedata[1];
                		mexpfile7 = ary_choicedata[2];
                		mimage7 = ary_choicedata[3];
            		}
            		if ( !ary_choice[8].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[8],",");
            			mcfile8 = ary_choicedata[0];
                		msfile8 = ary_choicedata[1];
                		mexpfile8 = ary_choicedata[2];
                		mimage8 = ary_choicedata[3];
            		}
            		
            		if ( !rs9.next() ) {
            			String isql =  "insert into QuestionnaireDetail";
     			               isql += "(Serno,SerialNo,ChoiceType,ClientFile1,ServerFile1,ExpFile1,ImageMagick1,ClientFile2,ServerFile2,ExpFile2,ImageMagick2,ClientFile3,ServerFile3,ExpFile3,ImageMagick3,";
     			               isql += "ClientFile4,ServerFile4,ExpFile4,ImageMagick4,ClientFile5,ServerFile5,ExpFile5,ImageMagick5,ClientFile6,ServerFile6,ExpFile6,ImageMagick6,";
     			               isql += "ClientFile7,ServerFile7,ExpFile7,ImageMagick7,ClientFile8,ServerFile8,ExpFile8,ImageMagick8)";
    		                   isql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		            stmts10 = conn.prepareStatement(isql);
    		            
    		            stmts10.clearParameters();
    		            stmts10.setString(1, serno );
    		            stmts10.setString(2, ary_choice[0] );
    		            stmts10.setString(3, "2" );
    		            stmts10.setString(4, mcfile1 );
    		            stmts10.setString(5, msfile1 );
    		            stmts10.setString(6, mexpfile1 );
    		            stmts10.setString(7, mimage1 );
    		            stmts10.setString(8, mcfile2 );
    		            stmts10.setString(9, msfile2 );
    		            stmts10.setString(10, mexpfile2 );
    		            stmts10.setString(11, mimage2 );
    		            stmts10.setString(12, mcfile3 );
    		            stmts10.setString(13, msfile3 );
    		            stmts10.setString(14, mexpfile3 );
    		            stmts10.setString(15, mimage3 );
    		            stmts10.setString(16, mcfile4 );
    		            stmts10.setString(17, msfile4 );
    		            stmts10.setString(18, mexpfile4 );
    		            stmts10.setString(19, mimage4 );
    		            stmts10.setString(20, mcfile5 );
    		            stmts10.setString(21, msfile5 );
    		            stmts10.setString(22, mexpfile5 );
    		            stmts10.setString(23, mimage5 );
    		            stmts10.setString(24, mcfile6 );
    		            stmts10.setString(25, msfile6 );
    		            stmts10.setString(26, mexpfile6 );
    		            stmts10.setString(27, mimage6 );
    		            stmts10.setString(28, mcfile7 );
    		            stmts10.setString(29, msfile7 );
    		            stmts10.setString(30, mexpfile7 );
    		            stmts10.setString(31, mimage7 );
    		            stmts10.setString(32, mcfile8 );
    		            stmts10.setString(33, msfile8 );
    		            stmts10.setString(34, mexpfile8 );
    		            stmts10.setString(35, mimage8 );
        	    		int updateRow10 = stmts10.executeUpdate();
        	    		
        	    		if ( updateRow10 < 0 )
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
            		}else{
            			stmts11 = conn.prepareStatement(
    	    			   "update QuestionnaireDetail set ChoiceType = ?, ClientFile1 = ?, ServerFile1 = ?, ExpFile1 = ?, ImageMagick1 = ?, ClientFile2 = ?, ServerFile2 = ?, ExpFile2 = ?, ImageMagick2 = ?, ClientFile3 = ?, ServerFile3 = ?, ExpFile3 = ?, ImageMagick3 = ?, ClientFile4 = ?, ServerFile4 = ?, ExpFile4 = ?, ImageMagick4 = ?, " +
            		               "ClientFile5 = ?, ServerFile5 = ?, ExpFile5 = ?, ImageMagick5 = ?, ClientFile6 = ?, ServerFile6 = ?, ExpFile6 = ?, ImageMagick6 = ?, ClientFile7 = ?, ServerFile7 = ?, ExpFile7 = ?, ImageMagick7 = ?, " +
            	                   "ClientFile8 = ?, ServerFile8 = ?, ExpFile8 = ?, ImageMagick8 = ? where Serno = ? and SerialNo = ?");
            			
    		            stmts11.setString(1, "2" );
    		            stmts11.setString(2, mcfile1 );
    		            stmts11.setString(3, msfile1 );
    		            stmts11.setString(4, mexpfile1 );
    		            stmts11.setString(5, mimage1 );
    		            stmts11.setString(6, mcfile2 );
    		            stmts11.setString(7, msfile2 );
    		            stmts11.setString(8, mexpfile2 );
    		            stmts11.setString(9, mimage2 );
    		            stmts11.setString(10, mcfile3 );
    		            stmts11.setString(11, msfile3 );
    		            stmts11.setString(12, mexpfile3 );
    		            stmts11.setString(13, mimage3 );
    		            stmts11.setString(14, mcfile4 );
    		            stmts11.setString(15, msfile4 );
    		            stmts11.setString(16, mexpfile4 );
    		            stmts11.setString(17, mimage4 );
    		            stmts11.setString(18, mcfile5 );
    		            stmts11.setString(19, msfile5 );
    		            stmts11.setString(20, mexpfile5 );
    		            stmts11.setString(21, mimage5 );
    		            stmts11.setString(22, mcfile6 );
    		            stmts11.setString(23, msfile6 );
    		            stmts11.setString(24, mexpfile6 );
    		            stmts11.setString(25, mimage6 );
    		            stmts11.setString(26, mcfile7 );
    		            stmts11.setString(27, msfile7 );
    		            stmts11.setString(28, mexpfile7 );
    		            stmts11.setString(29, mimage7 );
    		            stmts11.setString(30, mcfile8 );
    		            stmts11.setString(31, msfile8 );
    		            stmts11.setString(32, mexpfile8 );
    		            stmts11.setString(33, mimage8 );
    		            stmts11.setString(34, serno );
    		            stmts11.setString(35, ary_choice[0] );
    		            
        	    		int updateRow11 = stmts11.executeUpdate();
        	    		
        	    		if ( updateRow11 < 0 )
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
    			if ( rs3 != null ) rs3.close();
    			if ( rs6 != null ) rs6.close();
    			if ( rs9 != null ) rs9.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			if ( stmts4 != null ) stmts4.close();
    			if ( stmts5 != null ) stmts5.close();
    			if ( stmts6 != null ) stmts6.close();
    			if ( stmts7 != null ) stmts7.close();
    			if ( stmts8 != null ) stmts8.close();
    			if ( stmts9 != null ) stmts9.close();
    			if ( stmts10 != null ) stmts10.close();
    			if ( stmts11 != null ) stmts11.close();
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
    			QuestionnaireData tmpQuery = new QuestionnaireData();
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
    	
    	ResultSet rs1 = null;
    	ResultSet rs3 = null;
    	ResultSet rs6 = null;
    	ResultSet rs9 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	PreparedStatement stmts5 = null;
    	PreparedStatement stmts6 = null;
    	PreparedStatement stmts7 = null;
    	PreparedStatement stmts8 = null;
    	PreparedStatement stmts9 = null;
    	PreparedStatement stmts10 = null;
    	PreparedStatement stmts11 = null;
    	PreparedStatement stmts12 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//update
     		stmts = conn.prepareStatement(
    			"update " + tablename + " set Subject = ?, Content = ?, PosterDate = ?, CloseDate = ?, StartUsing = ?, QuestionType = ?, IsBasic = ?, BasicField = ?, PrizeNumber = ?, ClientFile = ?, ServerFile = ?, ExpFile = ?, ImageMagick = ?, PostName = ?, UpdateDate = ?, Examine = ?, ExamineName = ?, ExamineDate = ? where Serno = ? and PubUnitDN = ?");
    		
     		stmts.setString(1, subject );
     		stmts.setString(2, content );
     		stmts.setString(3, posterdate );
     		stmts.setString(4, closedate );
     		stmts.setString(5, startusing );
     		stmts.setString(6, questiontype );
     		stmts.setString(7, isbasic );
     		stmts.setString(8, basicfield );
     		stmts.setInt(9, prizenumber );
     		stmts.setString(10, clientfile );
     		stmts.setString(11, serverfile );
     		stmts.setString(12, expfile );
     		stmts.setString(13, imagemagick );
     		stmts.setString(14, postname );
    		stmts.setString(15, getNowYear() );
    		stmts.setString(16, "0" );
    		stmts.setString(17, "" );
    		stmts.setString(18, "" );
    		stmts.setString(19, serno );
    		stmts.setString(20, pubunitdn );
    		
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
    		
    		//先刪除原Dtail的資料
    		String msql = "select * from QuestionnaireDetail where Serno = '" + serno + "'";
 			stmts1 = conn.prepareStatement(msql);
    		stmts1.clearParameters();
    		rs1 = stmts1.executeQuery();
    		
    		if ( rs1.next() ) {
    			String dsql = "delete QuestionnaireDetail where Serno = '" + serno + "'";
    			stmts2 = conn.prepareStatement(dsql);
    			int updateRow2 = stmts2.executeUpdate();
    			if ( updateRow2 < 0 ) 
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
    		
    		//insert QuestionnaireDetail    		
    		String[] ary_textdata = SvString.split(textdata,"&");
    		String[] ary_questdata = SvString.split(questdata,"&");
    		
    		if ( !textdata.equals("") ) {
    			for ( int t=0; t<ary_textdata.length; t++ ) {
        			String[] ary_choice = SvString.split(ary_textdata[t],"||");
        			String msql3 = "select * from QuestionnaireDetail where Serno = '" + serno + "' and SerialNo = " + ary_choice[0];
        			
        			stmts3 = conn.prepareStatement(msql3);
            		stmts3.clearParameters();
        			rs3 = stmts3.executeQuery();
        			
            		if ( !rs3.next() ) {
            			String isql =  "insert into QuestionnaireDetail";
            			       isql += "(Serno,SerialNo,ChoiceType,ClientFile1,ServerFile1,ExpFile1,ImageMagick1,ClientFile2,ServerFile2,ExpFile2,ImageMagick2,ClientFile3,ServerFile3,ExpFile3,ImageMagick3,";
            			       isql += "ClientFile4,ServerFile4,ExpFile4,ImageMagick4,ClientFile5,ServerFile5,ExpFile5,ImageMagick5,ClientFile6,ServerFile6,ExpFile6,ImageMagick6,";
            			       isql += "ClientFile7,ServerFile7,ExpFile7,ImageMagick7,ClientFile8,ServerFile8,ExpFile8,ImageMagick8)";
         		               isql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
         		        stmts4 = conn.prepareStatement(isql);
         		       
         		        stmts4.clearParameters();
         		        stmts4.setString(1, serno );
         		        stmts4.setString(2, ary_choice[0] );
         		        stmts4.setString(3, "1" );
         		        stmts4.setString(4, "" );
         		        stmts4.setString(5, ary_choice[1].equals("a") ? "" : ary_choice[1] );
         		        stmts4.setString(6, "" );
         		        stmts4.setString(7, "" );
         		        stmts4.setString(8, "" );
        		        stmts4.setString(9, ary_choice[2].equals("a") ? "" : ary_choice[2] );
        		        stmts4.setString(10, "" );
        		        stmts4.setString(11, "" );
        		        stmts4.setString(12, "" );
         		        stmts4.setString(13, ary_choice[3].equals("a") ? "" : ary_choice[3] );
         		        stmts4.setString(14, "" );
         		        stmts4.setString(15, "" );
         		        stmts4.setString(16, "" );
        		        stmts4.setString(17, ary_choice[4].equals("a") ? "" : ary_choice[4] );
        		        stmts4.setString(18, "" );
        		        stmts4.setString(19, "" );
        		        stmts4.setString(20, "" );
         		        stmts4.setString(21, ary_choice[5].equals("a") ? "" : ary_choice[5] );
         		        stmts4.setString(22, "" );
         		        stmts4.setString(23, "" );
         		        stmts4.setString(24, "" );
        		        stmts4.setString(25, ary_choice[6].equals("a") ? "" : ary_choice[6] );
        		        stmts4.setString(26, "" );
        		        stmts4.setString(27, "" );
        		        stmts4.setString(28, "" );
         		        stmts4.setString(29, ary_choice[7].equals("a") ? "" : ary_choice[7] );
         		        stmts4.setString(30, "" );
         		        stmts4.setString(31, "" );
         		        stmts4.setString(32, "" );
        		        stmts4.setString(33, ary_choice[8].equals("a") ? "" : ary_choice[8] );
        		        stmts4.setString(34, "" );
        		        stmts4.setString(35, "" );
        		        
        	    		int updateRow4 = stmts4.executeUpdate();    	    		
        	    		if ( updateRow4 < 0 )
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
            		}else{
            			stmts5 = conn.prepareStatement(
            	    			"update QuestionnaireDetail set ChoiceType = ?, ServerFile1 = ?, ServerFile2 = ?, ServerFile3 = ?, ServerFile4 = ?, ServerFile5 = ?, ServerFile6 = ?, ServerFile7 = ?, ServerFile8 = ? where Serno = ? and SerialNo = ?");
            	    		   		
            			stmts5.setString(1, "1" );
            			stmts5.setString(2, ary_choice[1].equals("a") ? "" : ary_choice[1] );
            			stmts5.setString(3, ary_choice[2].equals("a") ? "" : ary_choice[2] );
            			stmts5.setString(4, ary_choice[3].equals("a") ? "" : ary_choice[3] );
            			stmts5.setString(5, ary_choice[4].equals("a") ? "" : ary_choice[4] );
            			stmts5.setString(6, ary_choice[5].equals("a") ? "" : ary_choice[5] );
            			stmts5.setString(7, ary_choice[6].equals("a") ? "" : ary_choice[6] );
            			stmts5.setString(8, ary_choice[7].equals("a") ? "" : ary_choice[7] );
            			stmts5.setString(9, ary_choice[8].equals("a") ? "" : ary_choice[8] );
            			stmts5.setString(10, serno );
            			stmts5.setString(11, ary_choice[0] );
            	    		
            	    	int updateRow5 = stmts5.executeUpdate();
            	    	if ( updateRow5 < 0 ) {
            	    		try {
            	    			conn.rollback();
            	    			errorMsg = "Insert into table fail(Statistics).";
            	    			System.out.println(errorMsg);
            	    			return false;
            	    		}catch(Exception backerr){
            	    			System.out.println("rollback faild!");
            	    		}
            	    	}
            		}
        		}
    		}
    		
    		for ( int q=0; q<ary_questdata.length; q++ ) {
    			String[] ary_choice = SvString.split(ary_questdata[q],"||");
    			String msql1 = "select * from QuestionnaireDetail where Serno = '" + serno + "' and SerialNo = " + ary_choice[0];
    			
    			stmts6 = conn.prepareStatement(msql1);
        		stmts6.clearParameters();
    			rs6 = stmts6.executeQuery();
        		if ( !rs6.next() ) {
        			String isql =  "insert into QuestionnaireDetail";
        			       isql += "(Serno,SerialNo,Subject,InputText,Rellection,Answer)";
     		               isql += " values(?,?,?,?,?,?)";
     		        stmts7 = conn.prepareStatement(isql);
     		        
     		        stmts7.clearParameters();
     		        stmts7.setString(1, serno );
     		        stmts7.setString(2, ary_choice[0] );
     		        stmts7.setString(3, ary_choice[1] );
     		        stmts7.setString(4, ary_choice[2] );
     		        stmts7.setString(5, ary_choice[3] );
     		        stmts7.setString(6, ary_choice[4] );
    	    		int updateRow7 = stmts7.executeUpdate();
    	    		
    	    		if ( updateRow7 < 0 )
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
        		}else{
        			stmts8 = conn.prepareStatement(
        	    			"update QuestionnaireDetail set Subject = ?, InputText = ?, Rellection = ?, Answer = ? where Serno = ? and SerialNo = ?");
        	    		   		
        			stmts8.setString(1, ary_choice[1] );
        			stmts8.setString(2, ary_choice[2] );
        			stmts8.setString(3, ary_choice[3] );
        			stmts8.setString(4, ary_choice[4] );
        			stmts8.setString(5, serno );
        			stmts8.setString(6, ary_choice[0] );
        	    	int updateRow8 = stmts8.executeUpdate();
        	    		
        	    	if ( updateRow8 < 0 ) {
        	    		try {
        	    			conn.rollback();
        	    			errorMsg = "Insert into table fail(Statistics).";
        	    			System.out.println(errorMsg);
        	    			return false;
        	    		}catch(Exception backerr){
        	    			System.out.println("rollback faild!");
        	    		}
        	    	}
        		}
    		}
    		
    		if ( !filedata.equals("") ) {
    			String[] ary_filedata = SvString.split(filedata,"&");
        		for ( int f=0; f<ary_filedata.length; f++ ) {
        			String[] ary_choice = SvString.split(ary_filedata[f],"||");
        			String msql2 = "select * from QuestionnaireDetail where Serno = '" + serno + "' and SerialNo = " + ary_choice[0];
         			stmts9 = conn.prepareStatement(msql2);
         			
            		stmts9.clearParameters();
            		
            		rs9 = stmts9.executeQuery();
            		
            		String mcfile1 = "";
            		String msfile1 = "";
            		String mexpfile1 = "";
            		String mimage1 = "";
            		String mcfile2 = "";
            		String msfile2 = "";
            		String mexpfile2 = "";
            		String mimage2 = "";
            		String mcfile3 = "";
            		String msfile3 = "";
            		String mexpfile3 = "";
            		String mimage3 = "";
            		String mcfile4 = "";
            		String msfile4 = "";
            		String mexpfile4 = "";
            		String mimage4 = "";
            		String mcfile5 = "";
            		String msfile5 = "";
            		String mexpfile5 = "";
            		String mimage5 = "";
            		String mcfile6 = "";
            		String msfile6 = "";
            		String mexpfile6 = "";
            		String mimage6 = "";
            		String mcfile7 = "";
            		String msfile7 = "";
            		String mexpfile7 = "";
            		String mimage7 = "";
            		String mcfile8 = "";
            		String msfile8 = "";
            		String mexpfile8 = "";
            		String mimage8 = "";
            		
            		if ( !ary_choice[1].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[1],",");
            			mcfile1 = ary_choicedata[0];
                		msfile1 = ary_choicedata[1];
                		mexpfile1 = ary_choicedata[2];
                		mimage1 = ary_choicedata[3];
            		}
            		if ( !ary_choice[2].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[2],",");
            			mcfile2 = ary_choicedata[0];
                		msfile2 = ary_choicedata[1];
                		mexpfile2 = ary_choicedata[2];
                		mimage2 = ary_choicedata[3];
            		}
            		if ( !ary_choice[3].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[3],",");
            			mcfile3 = ary_choicedata[0];
                		msfile3 = ary_choicedata[1];
                		mexpfile3 = ary_choicedata[2];
                		mimage3 = ary_choicedata[3];
            		}
            		if ( !ary_choice[4].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[4],",");
            			mcfile4 = ary_choicedata[0];
                		msfile4 = ary_choicedata[1];
                		mexpfile4 = ary_choicedata[2];
                		mimage4 = ary_choicedata[3];
            		}
            		if ( !ary_choice[5].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[5],",");
            			mcfile5 = ary_choicedata[0];
                		msfile5 = ary_choicedata[1];
                		mexpfile5 = ary_choicedata[2];
                		mimage5 = ary_choicedata[3];
            		}
            		if ( !ary_choice[6].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[6],",");
            			mcfile6 = ary_choicedata[0];
                		msfile6 = ary_choicedata[1];
                		mexpfile6 = ary_choicedata[2];
                		mimage6 = ary_choicedata[3];
            		}
            		if ( !ary_choice[7].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[7],",");
            			mcfile7 = ary_choicedata[0];
                		msfile7 = ary_choicedata[1];
                		mexpfile7 = ary_choicedata[2];
                		mimage7 = ary_choicedata[3];
            		}
            		if ( !ary_choice[8].equals("a")) {
            			String[] ary_choicedata = SvString.split(ary_choice[8],",");
            			mcfile8 = ary_choicedata[0];
                		msfile8 = ary_choicedata[1];
                		mexpfile8 = ary_choicedata[2];
                		mimage8 = ary_choicedata[3];
            		}
            		
            		if ( !rs9.next() ) {
            			String isql =  "insert into QuestionnaireDetail";
     			               isql += "(Serno,SerialNo,ChoiceType,ClientFile1,ServerFile1,ExpFile1,ImageMagick1,ClientFile2,ServerFile2,ExpFile2,ImageMagick2,ClientFile3,ServerFile3,ExpFile3,ImageMagick3,";
     			               isql += "ClientFile4,ServerFile4,ExpFile4,ImageMagick4,ClientFile5,ServerFile5,ExpFile5,ImageMagick5,ClientFile6,ServerFile6,ExpFile6,ImageMagick6,";
     			               isql += "ClientFile7,ServerFile7,ExpFile7,ImageMagick7,ClientFile8,ServerFile8,ExpFile8,ImageMagick8)";
    		                   isql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		            stmts10 = conn.prepareStatement(isql);
    		            
    		            stmts10.clearParameters();
    		            stmts10.setString(1, serno );
    		            stmts10.setString(2, ary_choice[0] );
    		            stmts10.setString(3, "2" );
    		            stmts10.setString(4, mcfile1 );
    		            stmts10.setString(5, msfile1 );
    		            stmts10.setString(6, mexpfile1 );
    		            stmts10.setString(7, mimage1 );
    		            stmts10.setString(8, mcfile2 );
    		            stmts10.setString(9, msfile2 );
    		            stmts10.setString(10, mexpfile2 );
    		            stmts10.setString(11, mimage2 );
    		            stmts10.setString(12, mcfile3 );
    		            stmts10.setString(13, msfile3 );
    		            stmts10.setString(14, mexpfile3 );
    		            stmts10.setString(15, mimage3 );
    		            stmts10.setString(16, mcfile4 );
    		            stmts10.setString(17, msfile4 );
    		            stmts10.setString(18, mexpfile4 );
    		            stmts10.setString(19, mimage4 );
    		            stmts10.setString(20, mcfile5 );
    		            stmts10.setString(21, msfile5 );
    		            stmts10.setString(22, mexpfile5 );
    		            stmts10.setString(23, mimage5 );
    		            stmts10.setString(24, mcfile6 );
    		            stmts10.setString(25, msfile6 );
    		            stmts10.setString(26, mexpfile6 );
    		            stmts10.setString(27, mimage6 );
    		            stmts10.setString(28, mcfile7 );
    		            stmts10.setString(29, msfile7 );
    		            stmts10.setString(30, mexpfile7 );
    		            stmts10.setString(31, mimage7 );
    		            stmts10.setString(32, mcfile8 );
    		            stmts10.setString(33, msfile8 );
    		            stmts10.setString(34, mexpfile8 );
    		            stmts10.setString(35, mimage8 );
        	    		int updateRow10 = stmts10.executeUpdate();
        	    		
        	    		if ( updateRow10 < 0 )
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
            		}else{
            			stmts11 = conn.prepareStatement(
    	    			   "update QuestionnaireDetail set ChoiceType = ?, ClientFile1 = ?, ServerFile1 = ?, ExpFile1 = ?, ImageMagick1 = ?, ClientFile2 = ?, ServerFile2 = ?, ExpFile2 = ?, ImageMagick2 = ?, ClientFile3 = ?, ServerFile3 = ?, ExpFile3 = ?, ImageMagick3 = ?, ClientFile4 = ?, ServerFile4 = ?, ExpFile4 = ?, ImageMagick4 = ?, " +
            		               "ClientFile5 = ?, ServerFile5 = ?, ExpFile5 = ?, ImageMagick5 = ?, ClientFile6 = ?, ServerFile6 = ?, ExpFile6 = ?, ImageMagick6 = ?, ClientFile7 = ?, ServerFile7 = ?, ExpFile7 = ?, ImageMagick7 = ?, " +
            	                   "ClientFile8 = ?, ServerFile8 = ?, ExpFile8 = ?, ImageMagick8 = ? where Serno = ? and SerialNo = ?");
            			
    		            stmts11.setString(1, "2" );
    		            stmts11.setString(2, mcfile1 );
    		            stmts11.setString(3, msfile1 );
    		            stmts11.setString(4, mexpfile1 );
    		            stmts11.setString(5, mimage1 );
    		            stmts11.setString(6, mcfile2 );
    		            stmts11.setString(7, msfile2 );
    		            stmts11.setString(8, mexpfile2 );
    		            stmts11.setString(9, mimage2 );
    		            stmts11.setString(10, mcfile3 );
    		            stmts11.setString(11, msfile3 );
    		            stmts11.setString(12, mexpfile3 );
    		            stmts11.setString(13, mimage3 );
    		            stmts11.setString(14, mcfile4 );
    		            stmts11.setString(15, msfile4 );
    		            stmts11.setString(16, mexpfile4 );
    		            stmts11.setString(17, mimage4 );
    		            stmts11.setString(18, mcfile5 );
    		            stmts11.setString(19, msfile5 );
    		            stmts11.setString(20, mexpfile5 );
    		            stmts11.setString(21, mimage5 );
    		            stmts11.setString(22, mcfile6 );
    		            stmts11.setString(23, msfile6 );
    		            stmts11.setString(24, mexpfile6 );
    		            stmts11.setString(25, mimage6 );
    		            stmts11.setString(26, mcfile7 );
    		            stmts11.setString(27, msfile7 );
    		            stmts11.setString(28, mexpfile7 );
    		            stmts11.setString(29, mimage7 );
    		            stmts11.setString(30, mcfile8 );
    		            stmts11.setString(31, msfile8 );
    		            stmts11.setString(32, mexpfile8 );
    		            stmts11.setString(33, mimage8 );
    		            stmts11.setString(34, serno );
    		            stmts11.setString(35, ary_choice[0] );
    		            
        	    		int updateRow11 = stmts11.executeUpdate();
        	    		
        	    		if ( updateRow11 < 0 )
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
        		}
    		}
    		//選項圖片不變
    		if ( !ofiledata.equals("") ) {
    			String[] ary_ofiledata = SvString.split(ofiledata,"&");
    			for ( int i=0; i<ary_ofiledata.length; i++ ) {
    				String[] ary_choice = SvString.split(ary_ofiledata[i],"||");
    				if ( !ary_choice[1].equals("a") ) {
    					String[] ary_data = SvString.split(ary_choice[1],",");
    					stmts12 = conn.prepareStatement(
    							"update QuestionnaireDetail set ChoiceType = ?, ClientFile1 = ?, ServerFile1 = ?, ExpFile1 = ?, ImageMagick1 = ? where Serno = ? and SerialNo = ?");
    					
    					stmts12.setString(1, "2" );
    					stmts12.setString(2, ary_data[0] );
    					stmts12.setString(3, ary_data[1] );
    					stmts12.setString(4, ary_data[2] );
    					stmts12.setString(5, ary_data[3] );
    					stmts12.setString(6, serno );
    					stmts12.setString(7, ary_choice[0] );

        	    		int updateRow12 = stmts12.executeUpdate();        	    		
        	    		if ( updateRow12 < 0 )
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
    				if ( !ary_choice[2].equals("a") ) {
    					String[] ary_data = SvString.split(ary_choice[2],",");
    					stmts12 = conn.prepareStatement(
    							"update QuestionnaireDetail set ChoiceType = ?, ClientFile2 = ?, ServerFile2 = ?, ExpFile2 = ?, ImageMagick2 = ? where Serno = ? and SerialNo = ?");
    					
    					stmts12.setString(1, "2" );
    					stmts12.setString(2, ary_data[0] );
    					stmts12.setString(3, ary_data[1] );
    					stmts12.setString(4, ary_data[2] );
    					stmts12.setString(5, ary_data[3] );
    					stmts12.setString(6, serno );
    					stmts12.setString(7, ary_choice[0] );

        	    		int updateRow12 = stmts12.executeUpdate();        	    		
        	    		if ( updateRow12 < 0 )
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
    				if ( !ary_choice[3].equals("a") ) {
    					String[] ary_data = SvString.split(ary_choice[3],",");
    					stmts12 = conn.prepareStatement(
    							"update QuestionnaireDetail set ChoiceType = ?, ClientFile3 = ?, ServerFile3 = ?, ExpFile3 = ?, ImageMagick3 = ? where Serno = ? and SerialNo = ?");
    					
    					stmts12.setString(1, "2" );
    					stmts12.setString(2, ary_data[0] );
    					stmts12.setString(3, ary_data[1] );
    					stmts12.setString(4, ary_data[2] );
    					stmts12.setString(5, ary_data[3] );
    					stmts12.setString(6, serno );
    					stmts12.setString(7, ary_choice[0] );

        	    		int updateRow12 = stmts12.executeUpdate();        	    		
        	    		if ( updateRow12 < 0 )
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
    				if ( !ary_choice[4].equals("a") ) {
    					String[] ary_data = SvString.split(ary_choice[4],",");
    					stmts12 = conn.prepareStatement(
    							"update QuestionnaireDetail set ChoiceType = ?, ClientFile4 = ?, ServerFile4 = ?, ExpFile4 = ?, ImageMagick4 = ? where Serno = ? and SerialNo = ?");
    					
    					stmts12.setString(1, "2" );
    					stmts12.setString(2, ary_data[0] );
    					stmts12.setString(3, ary_data[1] );
    					stmts12.setString(4, ary_data[2] );
    					stmts12.setString(5, ary_data[3] );
    					stmts12.setString(6, serno );
    					stmts12.setString(7, ary_choice[0] );

        	    		int updateRow12 = stmts12.executeUpdate();        	    		
        	    		if ( updateRow12 < 0 )
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
    				if ( !ary_choice[5].equals("a") ) {
    					String[] ary_data = SvString.split(ary_choice[5],",");
    					stmts12 = conn.prepareStatement(
    							"update QuestionnaireDetail set ChoiceType = ?, ClientFile5 = ?, ServerFile5 = ?, ExpFile5 = ?, ImageMagick5 = ? where Serno = ? and SerialNo = ?");
    					
    					stmts12.setString(1, "2" );
    					stmts12.setString(2, ary_data[0] );
    					stmts12.setString(3, ary_data[1] );
    					stmts12.setString(4, ary_data[2] );
    					stmts12.setString(5, ary_data[3] );
    					stmts12.setString(6, serno );
    					stmts12.setString(7, ary_choice[0] );

        	    		int updateRow12 = stmts12.executeUpdate();        	    		
        	    		if ( updateRow12 < 0 )
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
    				if ( !ary_choice[6].equals("a") ) {
    					String[] ary_data = SvString.split(ary_choice[6],",");
    					stmts12 = conn.prepareStatement(
    							"update QuestionnaireDetail set ChoiceType = ?, ClientFile6 = ?, ServerFile6 = ?, ExpFile6 = ?, ImageMagick6 = ? where Serno = ? and SerialNo = ?");
    					
    					stmts12.setString(1, "2" );
    					stmts12.setString(2, ary_data[0] );
    					stmts12.setString(3, ary_data[1] );
    					stmts12.setString(4, ary_data[2] );
    					stmts12.setString(5, ary_data[3] );
    					stmts12.setString(6, serno );
    					stmts12.setString(7, ary_choice[0] );

        	    		int updateRow12 = stmts12.executeUpdate();        	    		
        	    		if ( updateRow12 < 0 )
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
    				if ( !ary_choice[7].equals("a") ) {
    					String[] ary_data = SvString.split(ary_choice[7],",");
    					stmts12 = conn.prepareStatement(
    							"update QuestionnaireDetail set ChoiceType = ?, ClientFile7 = ?, ServerFile7 = ?, ExpFile7 = ?, ImageMagick7 = ? where Serno = ? and SerialNo = ?");
    					
    					stmts12.setString(1, "2" );
    					stmts12.setString(2, ary_data[0] );
    					stmts12.setString(3, ary_data[1] );
    					stmts12.setString(4, ary_data[2] );
    					stmts12.setString(5, ary_data[3] );
    					stmts12.setString(6, serno );
    					stmts12.setString(7, ary_choice[0] );

        	    		int updateRow12 = stmts12.executeUpdate();        	    		
        	    		if ( updateRow12 < 0 )
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
    				if ( !ary_choice[8].equals("a") ) {
    					String[] ary_data = SvString.split(ary_choice[8],",");
    					stmts12 = conn.prepareStatement(
    							"update QuestionnaireDetail set ChoiceType = ?, ClientFile8 = ?, ServerFile8 = ?, ExpFile8 = ?, ImageMagick8 = ? where Serno = ? and SerialNo = ?");
    					
    					stmts12.setString(1, "2" );
    					stmts12.setString(2, ary_data[0] );
    					stmts12.setString(3, ary_data[1] );
    					stmts12.setString(4, ary_data[2] );
    					stmts12.setString(5, ary_data[3] );
    					stmts12.setString(6, serno );
    					stmts12.setString(7, ary_choice[0] );

        	    		int updateRow12 = stmts12.executeUpdate();        	    		
        	    		if ( updateRow12 < 0 )
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
    			if ( rs3 != null ) rs3.close();
    			if ( rs6 != null ) rs6.close();
    			if ( rs9 != null ) rs9.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			if ( stmts4 != null ) stmts4.close();
    			if ( stmts5 != null ) stmts5.close();
    			if ( stmts6 != null ) stmts6.close();
    			if ( stmts7 != null ) stmts7.close();
    			if ( stmts8 != null ) stmts8.close();
    			if ( stmts9 != null ) stmts9.close();
    			if ( stmts10 != null ) stmts10.close();
    			if ( stmts11 != null ) stmts11.close();
    			if ( stmts12 != null ) stmts12.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }

    //刪除資料
    public boolean remove( String filepath )
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
    	ResultSet rs1 = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
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

            		String msql1 = "select * from QuestionnaireDetail where Serno = '" + ary_mserno[i] + "'";
            		
         			stmts3 = conn.prepareStatement(msql1);
            		stmts3.clearParameters();
            		rs1 = stmts3.executeQuery();
            		if ( rs1.next() ) {
            			for ( int d=0; rs1.next(); d++ ) {
            				if ( rs1.getString( "ChoiceType" ).equals("2") ) {
            					if ( rs1.getString( "ServerFile1" ) != null && !rs1.getString( "ServerFile1" ).equals("null") && !rs1.getString( "ServerFile1" ).equals("") ) {
            						File df = new File(filepath,rs1.getString( "ServerFile1" ));
            						if (df.exists())
            							df.delete();
            						File dm = new File(filepath,rs1.getString( "ImageMagick1" ));
            						if (dm.exists())
            							dm.delete();
            					}
            					if ( rs1.getString( "ServerFile2" ) != null && !rs1.getString( "ServerFile2" ).equals("null") && !rs1.getString( "ServerFile2" ).equals("") ) {
            						File df = new File(filepath,rs1.getString( "ServerFile2" ));
            						if (df.exists())
            							df.delete();
            						File dm = new File(filepath,rs1.getString( "ImageMagick2" ));
            						if (dm.exists())
            							dm.delete();
            					}
            					if ( rs1.getString( "ServerFile3" ) != null && !rs1.getString( "ServerFile3" ).equals("null") && !rs1.getString( "ServerFile3" ).equals("") ) {
            						File df = new File(filepath,rs1.getString( "ServerFile3" ));
            						if (df.exists())
            							df.delete();
            						File dm = new File(filepath,rs1.getString( "ImageMagick3" ));
            						if (dm.exists())
            							dm.delete();
            					}
            					if ( rs1.getString( "ServerFile4" ) != null && !rs1.getString( "ServerFile4" ).equals("null") && !rs1.getString( "ServerFile4" ).equals("") ) {
            						File df = new File(filepath,rs1.getString( "ServerFile4" ));
            						if (df.exists())
            							df.delete();
            						File dm = new File(filepath,rs1.getString( "ImageMagick4" ));
            						if (dm.exists())
            							dm.delete();
            					}
            					if ( rs1.getString( "ServerFile5" ) != null && !rs1.getString( "ServerFile5" ).equals("null") && !rs1.getString( "ServerFile5" ).equals("") ) {
            						File df = new File(filepath,rs1.getString( "ServerFile5" ));
            						if (df.exists())
            							df.delete();
            						File dm = new File(filepath,rs1.getString( "ImageMagick5" ));
            						if (dm.exists())
            							dm.delete();
            					}
            					if ( rs1.getString( "ServerFile6" ) != null && !rs1.getString( "ServerFile6" ).equals("null") && !rs1.getString( "ServerFile6" ).equals("") ) {
            						File df = new File(filepath,rs1.getString( "ServerFile6" ));
            						if (df.exists())
            							df.delete();
            						File dm = new File(filepath,rs1.getString( "ImageMagick6" ));
            						if (dm.exists())
            							dm.delete();
            					}
            					if ( rs1.getString( "ServerFile7" ) != null && !rs1.getString( "ServerFile7" ).equals("null") && !rs1.getString( "ServerFile7" ).equals("") ) {
            						File df = new File(filepath,rs1.getString( "ServerFile7" ));
            						if (df.exists())
            							df.delete();
            						File dm = new File(filepath,rs1.getString( "ImageMagick7" ));
            						if (dm.exists())
            							dm.delete();
            					}
            					if ( rs1.getString( "ServerFile8" ) != null && !rs1.getString( "ServerFile8" ).equals("null") && !rs1.getString( "ServerFile8" ).equals("") ) {
            						File df = new File(filepath,rs1.getString( "ServerFile8" ));
            						if (df.exists())
            							df.delete();
            						File dm = new File(filepath,rs1.getString( "ImageMagick8" ));
            						if (dm.exists())
            							dm.delete();
            					}
            				}
            			}
            			String dsql = "delete QuestionnaireDetail where Serno = '" + ary_mserno[i] + "'";
            			stmts4 = conn.prepareStatement(dsql);
            			int updateRow = stmts4.executeUpdate();
            			if ( updateRow < 0 ) 
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
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    
             
}
