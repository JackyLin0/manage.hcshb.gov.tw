/*
 * 撰寫日期：2008/3/2
 * 程式名稱：EpaperStyleData.java
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

public class EpaperStyleData {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String alldata = null;
    
    private String serno = null;
    private String mserno = null;
    private String mclassname = null;
    private String flag = null;
    private int fsort = 0;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    
	public String getAlldata() {
		return alldata;
	}
	public void setAlldata(String alldata) {
		this.alldata = alldata;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public int getFsort() {
		return fsort;
	}
	public void setFsort(int fsort) {
		this.fsort = fsort;
	}
	public String getMclassname() {
		return mclassname;
	}
	public void setMclassname(String mclassname) {
		this.mclassname = mclassname;
	}
	public String getMserno() {
		return mserno;
	}
	public void setMserno(String mserno) {
		this.mserno = mserno;
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
    	ResultSet rs1 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		stmts1 = conn.prepareStatement("select * from EpaperStyle");
    		stmts1.clearParameters();
    		
    		rs1 = stmts1.executeQuery();
    		if ( rs1.next() )
    		{
    			//刪除資料(EpaperStyle)
    			String dsql = "delete EpaperStyle";
    			
    			stmts3 = conn.prepareStatement(dsql);
    			int updateRow3 = stmts3.executeUpdate();
    			if ( updateRow3 <= 0 ) 
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
    		
    		String[] ary_alldata = SvString.split(alldata,"&");
    		for ( int i=0; i<ary_alldata.length; i++ ) {
    			//找最大序號 start
        		stmts = conn.prepareStatement("select max(serno) as seqno from EpaperStyle where substring(serno,1,8) = ?" );
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
        		
        		String[] ary_data = SvString.split(ary_alldata[i],"||");
        		String flag = ary_data[2].substring(0,ary_data[2].length()-1);
        		int fsort = Integer.parseInt(ary_data[2].substring(ary_data[2].length()-1));
        		
    			//insert EpaperStyle
        		String msql =  "insert into EpaperStyle";
        		       msql += "(Serno,Mserno,Mclassname,Flag,Fsort,PostName,CreateDate,UpdateDate)";
        		       msql += " values(?,?,?,?,?,?,?,?)";
        		       
        		stmts2 = conn.prepareStatement(msql);
        		
        		stmts2.clearParameters();
        		stmts2.setString(1, serno );
        		stmts2.setString(2, ary_data[0] );
        		stmts2.setString(3, ary_data[1] );
        		stmts2.setString(4, flag );
        		stmts2.setInt(5, fsort );
        		stmts2.setString(6, postname );
        		stmts2.setString(7, getNowYear() );
        		stmts2.setString(8, getNowYear() );
        		
        		int updateRow2 = stmts2.executeUpdate();
        		
        		if ( updateRow2 < 0 ) {
        			try {
        				conn.rollback();
        				errorMsg = "Insert into table fail(EpaperStyle).";
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
    			if ( stmts2 != null ) stmts2.close();
    			if ( stmts3 != null ) stmts3.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close Statment or connection error: " + se.toString();
    		}
    	}
    	return false;
    }
	
	//查詢多筆資料及筆數
    public ArrayList<Object> findByday()
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
    		
    		sSql.append( "select distinct Mserno,Mclassname from EpaperData_view" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			EpaperStyleData tmpQuery = new EpaperStyleData();
    			tmpQuery.setMserno( rs.getString( "Mserno" ) );
    			tmpQuery.setMclassname( rs.getString( "Mclassname" ) );
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
    public boolean load( String flag, int fsort )
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
    		stmts = conn.prepareStatement("select * from EpaperStyle where Flag = '" + flag + "' and Fsort = " + fsort);
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		this.serno = rs.getString( "Serno" );
    		this.mserno = rs.getString( "Mserno" );
    		this.mclassname = rs.getString( "Mclassname" );
    		this.fsort = rs.getInt( "Fsort" );
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
	
    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    
          
}
