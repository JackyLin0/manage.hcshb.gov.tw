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

public class AnnouItemData {
	
	private String serno = "";
	private String mserno = "";
	private String stuName = "";
	private String famPhone = "";
	private String docdate = "";
	private String docName = "";
	private String remark = "";
	private String record = "";
	
	private int allrecordCount = 0;
    private String errorMsg = null;
    
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getMserno() {
		return mserno;
	}
	public void setMserno(String mserno) {
		this.mserno = mserno;
	}
	public String getStuName() {
		return stuName;
	}
	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
	public String getFamPhone() {
		return famPhone;
	}
	public void setFamPhone(String famPhone) {
		this.famPhone = famPhone;
	}
	public String getDocdate() {
		return docdate;
	}
	public void setDocdate(String docdate) {
		this.docdate = docdate;
	}
	public String getDocName() {
		return docName;
	}
	public void setDocName(String docName) {
		this.docName = docName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getRecord() {
		return record;
	}
	public void setRecord(String record) {
		this.record = record;
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
    		stmts = conn.prepareStatement("select max(serno) as seqno from AnnouItem where substring(serno,1,8) = ?" );
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
    		String sql =  "insert into AnnouItem";
    		       sql += "(serno,mserno,stuName,famPhone,docdate,docName,remark,record)";
    		       sql += " values(?,?,?,?,?,?,?,?)";
    		
    		stmts2 = conn.prepareStatement(sql);
    		
    		stmts2.clearParameters();
    		stmts2.setString(1, serno );
    		stmts2.setString(2, mserno );
    		stmts2.setString(3, stuName );
    		stmts2.setString(4, famPhone );
    		stmts2.setString(5, docdate );
    		stmts2.setString(6, docName );
    		stmts2.setString(7, remark );
    		stmts2.setString(8, record );

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
    public ArrayList findByday(String serno){
    	
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
    		
    		sSql.append( "select * from AnnouItem where mserno = '" + serno + "'" );

    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList result = new ArrayList();
    		
    		for(int i = 0; rs.next(); i++){
    			AnnouItemData tmpQuery = new AnnouItemData();
    			tmpQuery.setSerno( rs.getString( "serno" ) );
    			tmpQuery.setMserno( rs.getString( "mserno" ) );
    			tmpQuery.setStuName( rs.getString( "stuName" ) );
    			tmpQuery.setFamPhone( rs.getString( "famPhone" ) );
    			tmpQuery.setDocdate( rs.getString( "docdate" ) );
    			tmpQuery.setDocName( rs.getString( "docName" ) );
    			tmpQuery.setRemark( rs.getString( "remark" ) );
    			tmpQuery.setRecord( rs.getString( "record" ) );
    			
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
    public boolean remove(String serno){
    	
    	Connection conn = null;
    	
    	try{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	}catch(Exception e){
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    		return false;
    	}
    	
    	ResultSet rs = null;
    	PreparedStatement stmts1 = null;
    	
    	try{
    		
            //同意易動設定
     		conn.setAutoCommit(false);

        	//刪除資料
        	String dsql = "delete AnnouItem where mserno = '" + serno + "'";
        			
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
    		   if(stmts1 != null){
    			   stmts1.close();
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
