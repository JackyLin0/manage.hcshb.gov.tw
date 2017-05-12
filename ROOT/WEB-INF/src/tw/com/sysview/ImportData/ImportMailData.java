/*
 * 撰寫日期：2008/4/29
 * 程式名稱：ImportMailData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.ImportData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import sysview.zhiren.function.SvNumber;

public class ImportMailData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    //電子報訂戶資料
    private String serno = null;
    private String name = null;
    private String email = null;
    
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
    	ResultSet rs1 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		stmts = conn.prepareStatement("select * from EpaperMailData where Email = '" + email + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			//找最大序號 start
        		stmts1 = conn.prepareStatement("select max(serno) as seqno from EpaperMailData where substring(serno,1,8) = ?" );
        		stmts1.clearParameters();
        		stmts1.setString(1,getNowYear());
        		rs1 = stmts1.executeQuery();
     
        		int tempno = 0;
        		String mserno1 = "";
        		while ( rs1.next() )
        		{
        			String mseq = rs1.getString("seqno");
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
        		String sql =  "insert into EpaperMailData";
        		       sql += "(Serno,Name,Email,CreateDate,Ip)";
        		       sql += " values(?,?,?,?,?)";
        		
        		stmts = conn.prepareStatement(sql);
        		
        		stmts.clearParameters();
        		stmts.setString(1, serno );
        		stmts.setString(2, name );
        		stmts.setString(3, email );
        		stmts.setString(4, getNowYear() );
        		stmts.setString(5, "轉入" );
        		
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

    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    
             
}
