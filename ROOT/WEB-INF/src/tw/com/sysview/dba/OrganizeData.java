/*
 * 撰寫日期：2008/2/22
 * 程式名稱：OrganizeData.java
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

public class OrganizeData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String updatedate = null;
    
    //OrganLiaise
    private String mserno = null;
    private String unitdn = null;
    private String unitname1 = null;
    private String tel = null;
    private String extension = null;
    private String fax = null;
    private String email = null;
    private int fsort = 0;
    private String mfsort = null;
    
    //OrganizeFrame
    private String content = null;
    private String clientfile1 = null;
    private String serverfile1 = null;
    private String expfile1 = null;
    
    public String getClientfile1() {
		return clientfile1;
	}
	public void setClientfile1(String clientfile1) {
		this.clientfile1 = clientfile1;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getExpfile1() {
		return expfile1;
	}
	public void setExpfile1(String expfile1) {
		this.expfile1 = expfile1;
	}
	public String getExtension() {
		return extension;
	}
	public void setExtension(String extension) {
		this.extension = extension;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public int getFsort() {
		return fsort;
	}
	public void setFsort(int fsort) {
		this.fsort = fsort;
	}
	public String getMfsort() {
		return mfsort;
	}
	public void setMfsort(String mfsort) {
		this.mfsort = mfsort;
	}
	public String getMserno() {
		return mserno;
	}
	public void setMserno(String mserno) {
		this.mserno = mserno;
	}
	public String getServerfile1() {
		return serverfile1;
	}
	public void setServerfile1(String serverfile1) {
		this.serverfile1 = serverfile1;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getUnitdn() {
		return unitdn;
	}
	public void setUnitdn(String unitdn) {
		this.unitdn = unitdn;
	}
	public String getUnitname1() {
		return unitname1;
	}
	public void setUnitname1(String unitname1) {
		this.unitname1 = unitname1;
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

	//查詢單筆資料(聯絡資訊)
    public boolean loadinfor( String pubunitdn, String unitdn )
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
    		stmts = conn.prepareStatement("select * from OrganLiaise where PubUnitDN = '" + pubunitdn + "' and UnitDN = '" + unitdn + "'");
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
    		this.unitdn = rs.getString( "UnitDN" );
    		this.unitname1 = rs.getString( "UnitName" );
    		this.tel = rs.getString( "Tel" );
    		this.extension = rs.getString( "Extension" );
    		this.fax = rs.getString( "Fax" );
    		this.email = rs.getString( "Email" );
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
    
    //修改資料(聯絡資訊)
    public boolean storeinfor()
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
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		String msql = "select * from OrganLiaise where PubUnitDN = '" + pubunitdn + "'";
 			
			stmts3 = conn.prepareStatement(msql);
    		stmts3.clearParameters();
    		rs1 = stmts3.executeQuery();
    		
    		if ( rs1.next() ) {
    			String dsql = "delete OrganLiaise where PubUnitDN = '" + pubunitdn + "'";
    			
    			stmts3 = conn.prepareStatement(dsql);
    			int updateRow = stmts3.executeUpdate();
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
    		
     		String[] ary_mserno = SvString.split(mserno,"||");
     		String[] ary_unitdn = SvString.split(unitdn,"||");
     		String[] ary_unitname = SvString.split(unitname1,"||");
     		String[] ary_tel = SvString.split(tel,"||");
     		String[] ary_extension = SvString.split(extension,"||");
     		String[] ary_fax = SvString.split(fax,"||");
     		String[] ary_email = SvString.split(email,"||");
     		String[] ary_fsort = SvString.split(mfsort,"||");
     		
     		for ( int i=0; i<ary_unitdn.length; i++ ) {
        		if ( ary_mserno[i].equals("a") ){
        			//找最大序號 start
            		stmts = conn.prepareStatement("select max(Serno) as seqno from OrganLiaise where substring(serno,1,8) = ?" );
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
            		
            		this.setStatus("A");
            		
            		//找最大序號 end
        		}else{
        			this.serno = ary_mserno[i];        			
        			this.setStatus("U");        			
        		}
        		
        		//insert
        		String sql =  "insert into OrganLiaise";
        		       sql += "(Serno,PubUnitDN,PubUnitName,UnitDN,UnitName,Tel,Extension,Fax,Email,Fsort,PostName,CreateDate,UpdateDate)";
        		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        		      
        		stmts2 = conn.prepareStatement(sql);
        		
        		stmts2.clearParameters();
        		stmts2.setString(1, this.serno );
        		stmts2.setString(2, pubunitdn );
        		stmts2.setString(3, pubunitname );
        		stmts2.setString(4, ary_unitdn[i] );
        		stmts2.setString(5, ary_unitname[i] );
        		if ( ary_tel[i].equals("a") )
        			ary_tel[i] = "";
        		stmts2.setString(6, ary_tel[i] );
        		if ( ary_extension[i].equals("a") )
        			ary_extension[i] = "";
        		stmts2.setString(7, ary_extension[i] );
        		if ( ary_fax[i].equals("a") )
        			ary_fax[i] = "";
        		stmts2.setString(8, ary_fax[i] );
        		if ( ary_email[i].equals("a") )
        			ary_email[i] = "";
        		stmts2.setString(9, ary_email[i] );
        		stmts2.setInt(10, Integer.parseInt(ary_fsort[i]) );
        		stmts2.setString(11, postname );
        		stmts2.setString(12, getNowYear() );
        		stmts2.setString(13, getNowYear() );
        		
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
        		this.setSerno(serno);
        		this.setSubject(ary_unitname[i]);
        		if ( !createlog(conn,"chinese") )  {
        			try {
        				conn.rollback();
        				errorMsg = "Insert into table fail2.";
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
      		errorMsg = "update data error: " + sqle.toString();
      	} finally {
      		try
      		{
      			if ( stmts != null ) stmts.close();
      			if ( stmts1 != null ) stmts1.close();
      			if ( stmts2 != null ) stmts2.close();
      			if ( stmts3 != null ) stmts3.close();
      			if ( rs != null ) rs.close();
      			if ( rs1 != null ) rs1.close();
      			conn.close();
      		} catch ( SQLException se ) {
      			errorMsg = "close Statment or connection error: " + se.toString();
      		}
      	}
      	return false;
    }
	
	//查詢多筆資料及筆數(聯絡資訊)
    public ArrayList<Object> findByday( String pubunitdn )
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
    		
    		sSql.append( "select * from OrganLiaise where PubUnitDN = UnitDN and PubUnitDN = '" + pubunitdn + "'" );

    		sSql.append( " order by Fsort" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			OrganizeData tmpQuery = new OrganizeData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setUnitdn( rs.getString( "UnitDN" ) );
    			tmpQuery.setUnitname( rs.getString( "UnitName" ) );
    			tmpQuery.setTel( rs.getString( "Tel" ) );
    			tmpQuery.setExtension( rs.getString( "Extension" ) );
    			tmpQuery.setFax( rs.getString( "Fax" ) );
    			tmpQuery.setEmail( rs.getString( "Email" ) );
    			tmpQuery.setFsort( rs.getInt( "Fsort" ) );
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
	
    /**
     * 取得現在的日期(格式:yyyymmdd)
     */
    private String getNowYear()
    {		
    	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    	return fmt.format(Calendar.getInstance().getTime());
    }    
                       
}
