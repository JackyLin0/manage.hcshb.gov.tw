/*
 * 撰寫日期：2008/2/21
 * 程式名稱：ManagerData.java
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

public class ManagerData extends WebSiteLog {
	private int allrecordCount = 0;

    private String errorMsg = null;
    
    private String name = null;
    private String proftitle = null;
    private String item1 = null;
    private String content1 = null;
    private String item2 = null;
    private String content2 = null;
    private String item3 = null;
    private String content3 = null;
    private String item4 = null;
    private String content4 = null;
    private String item5 = null;
    private String content5 = null;
    private String item6 = null;
    private String content6 = null;
    private String item7 = null;
    private String content7 = null;
    private String item8 = null;
    private String content8 = null;
    private String item9 = null;
    private String content9 = null;
    private String item10 = null;
    private String content10 = null;
    private String iscurrent = null;
    private String clientfile1 = null;
    private String serverfile1 = null;
    private int fsort = 0;
    private String expfile1 = null;
    private String updatedate = null;
    
	public String getClientfile1() {
		return clientfile1;
	}
	public void setClientfile1(String clientfile1) {
		this.clientfile1 = clientfile1;
	}
	public String getContent1() {
		return content1;
	}
	public void setContent1(String content1) {
		this.content1 = content1;
	}
	public String getContent10() {
		return content10;
	}
	public void setContent10(String content10) {
		this.content10 = content10;
	}
	public String getContent2() {
		return content2;
	}
	public void setContent2(String content2) {
		this.content2 = content2;
	}
	public String getContent3() {
		return content3;
	}
	public void setContent3(String content3) {
		this.content3 = content3;
	}
	public String getContent4() {
		return content4;
	}
	public void setContent4(String content4) {
		this.content4 = content4;
	}
	public String getContent5() {
		return content5;
	}
	public void setContent5(String content5) {
		this.content5 = content5;
	}
	public String getContent6() {
		return content6;
	}
	public void setContent6(String content6) {
		this.content6 = content6;
	}
	public String getContent7() {
		return content7;
	}
	public void setContent7(String content7) {
		this.content7 = content7;
	}
	public String getContent8() {
		return content8;
	}
	public void setContent8(String content8) {
		this.content8 = content8;
	}
	public String getContent9() {
		return content9;
	}
	public void setContent9(String content9) {
		this.content9 = content9;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public String getExpfile1() {
		return expfile1;
	}
	public void setExpfile1(String expfile1) {
		this.expfile1 = expfile1;
	}
	public int getFsort() {
		return fsort;
	}
	public void setFsort(int fsort) {
		this.fsort = fsort;
	}
	public String getIscurrent() {
		return iscurrent;
	}
	public void setIscurrent(String iscurrent) {
		this.iscurrent = iscurrent;
	}
	public String getItem1() {
		return item1;
	}
	public void setItem1(String item1) {
		this.item1 = item1;
	}
	public String getItem10() {
		return item10;
	}
	public void setItem10(String item10) {
		this.item10 = item10;
	}
	public String getItem2() {
		return item2;
	}
	public void setItem2(String item2) {
		this.item2 = item2;
	}
	public String getItem3() {
		return item3;
	}
	public void setItem3(String item3) {
		this.item3 = item3;
	}
	public String getItem4() {
		return item4;
	}
	public void setItem4(String item4) {
		this.item4 = item4;
	}
	public String getItem5() {
		return item5;
	}
	public void setItem5(String item5) {
		this.item5 = item5;
	}
	public String getItem6() {
		return item6;
	}
	public void setItem6(String item6) {
		this.item6 = item6;
	}
	public String getItem7() {
		return item7;
	}
	public void setItem7(String item7) {
		this.item7 = item7;
	}
	public String getItem8() {
		return item8;
	}
	public void setItem8(String item8) {
		this.item8 = item8;
	}
	public String getItem9() {
		return item9;
	}
	public void setItem9(String item9) {
		this.item9 = item9;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProftitle() {
		return proftitle;
	}
	public void setProftitle(String proftitle) {
		this.proftitle = proftitle;
	}
	public String getServerfile1() {
		return serverfile1;
	}
	public void setServerfile1(String serverfile1) {
		this.serverfile1 = serverfile1;
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
    	ResultSet rs2 = null;
    	ResultSet rs3 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
    		//找最大序號 start
    		stmts = conn.prepareStatement("select max(serno) as seqno from OrganizeChief where substring(serno,1,8) = ?" );
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
    		
    		//排序start
    		int mcount1 = 0;
    		if ( fsort != 0 )
    		{
    			stmts1 = conn.prepareStatement("select count(*) as mcount from OrganizeChief where PubUnitDN = '" + pubunitdn + "' and Fsort = " + fsort);
    			stmts1.clearParameters();
        		
        		rs1 = stmts1.executeQuery();        		
        		while ( rs1.next() )
        		{
        			mcount1 = Integer.parseInt(rs1.getString("mcount"));
        		}
    		}else if ( fsort == 0 ) {
    			stmts2 = conn.prepareStatement("select max(Fsort) as fsort from OrganizeChief where PubUnitDN = '" + pubunitdn + "'");
    			stmts2.clearParameters();
        		
        		rs2 = stmts2.executeQuery();
        		while ( rs2.next() )
        		{
        			int mfsort = rs2.getInt("fsort");
        			this.fsort = mfsort + 1;
        		}
    		}
    		if ( mcount1 > 0 )
    		{
    			StringBuffer sSql = new StringBuffer();
        		
        		sSql.append( "select * from OrganizeChief where Serno <> '" + serno + "' and fsort >= " + fsort + " and PubUnitDN = '" + pubunitdn + "'" );

        		stmts3 = conn.prepareStatement( sSql.toString() );
        		stmts3.clearParameters();
           
        		rs3 = stmts3.executeQuery();
        		
        		for ( int i=0; rs3.next(); i++ )
        		{
        			int mfsort = rs3.getInt( "Fsort") + 1;
                    //update
            		stmts4 = conn.prepareStatement(
            			"update OrganizeChief set Fsort = ? where Serno = ?" ); 
            		stmts4.clearParameters();    	 	
            		stmts4.setInt(1, mfsort );
            		stmts4.setString(2, rs3.getString( "Serno" ) );
            		int updateRow1 = stmts4.executeUpdate();
            		if ( updateRow1 <= 0 )
            		{
            			try {
            				conn.rollback();
            				errorMsg = "Update table fail.";
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            }
            		}
        		}
    		}
    		
    		//insert
    		String sql =  "insert into OrganizeChief";
    		       sql += "(Serno,PubUnitDN,PubUnitName,Name,ProfTitle,Item1,Content1,Item2,Content2,Item3,Content3,Item4,Content4,Item5,Content5,Item6,Content6,";
    		       sql += "Item7,Content7,Item8,Content8,Item9,Content9,Item10,Content10,Iscurrent,ClientFile1,ServerFile1,ExpFile1,Fsort,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		       
    		stmts = conn.prepareStatement(sql);
    		
    		stmts.clearParameters();
    		stmts.setString(1, serno );
    		stmts.setString(2, pubunitdn );
    		stmts.setString(3, pubunitname );
    		stmts.setString(4, name );
    		stmts.setString(5, proftitle );
    		stmts.setString(6, item1 );
    		stmts.setString(7, content1 );
    		stmts.setString(8, item2 );
    		stmts.setString(9, content2 );
    		stmts.setString(10, item3 );
    		stmts.setString(11, content3 );
    		stmts.setString(12, item4 );
    		stmts.setString(13, content4 );
    		stmts.setString(14, item5 );
    		stmts.setString(15, content5 );
    		stmts.setString(16, item6 );
    		stmts.setString(17, content6 );
    		stmts.setString(18, item7 );
    		stmts.setString(19, content7 );
    		stmts.setString(20, item8 );
    		stmts.setString(21, content8 );
    		stmts.setString(22, item9 );
    		stmts.setString(23, content9 );
    		stmts.setString(24, item10 );
    		stmts.setString(25, content10 );
    		stmts.setString(26, iscurrent );
    		stmts.setString(27, clientfile1 );
    		stmts.setString(28, serverfile1 );
    		stmts.setString(29, expfile1 );
    		stmts.setInt(30, fsort );
    		stmts.setString(31, postname );
    		stmts.setString(32, getNowYear() );
    		stmts.setString(33, getNowYear() );
    		
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

    		conn.commit();
       	  	conn.setAutoCommit(true);

    		return true;
    		
    	} catch ( SQLException sqle ) {
    		errorMsg = "create data error: " + sqle.toString();
    	} finally {
    		try {
    			if ( rs != null ) rs.close();
    			if ( rs1 != null ) rs1.close();
    			if ( rs2 != null ) rs2.close();
    			if ( rs3 != null ) rs3.close();
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
    public ArrayList<Object> findByday( String name, String punit )
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
    		
    		sSql.append( "select * from OrganizeChief where 1=1" );
    		
    		if ( name != null && !name.equals("") )  {
    			sSql.append( " and Name like '%" + name + "%'" );
    		}
    			
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
    			ManagerData tmpQuery = new ManagerData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setName( rs.getString( "Name" ) );
    			tmpQuery.setProftitle( rs.getString( "ProfTitle" ) );
    			tmpQuery.setItem1( rs.getString( "Item1" ) );
    			tmpQuery.setContent1( rs.getString( "Content1" ) );
    			tmpQuery.setItem2( rs.getString( "Item2" ) );
    			tmpQuery.setContent2( rs.getString( "Content2" ) );
    			tmpQuery.setItem3( rs.getString( "Item3" ) );
    			tmpQuery.setContent3( rs.getString( "Content3" ) );
    			tmpQuery.setItem4( rs.getString( "Item4" ) );
    			tmpQuery.setContent4( rs.getString( "Content4" ) );
    			tmpQuery.setItem5( rs.getString( "Item5" ) );
    			tmpQuery.setContent5( rs.getString( "Content5" ) );
    			tmpQuery.setItem6( rs.getString( "Item6" ) );
    			tmpQuery.setContent6( rs.getString( "Content6" ) );
    			tmpQuery.setItem7( rs.getString( "Item7" ) );
    			tmpQuery.setContent7( rs.getString( "Content7" ) );
    			tmpQuery.setItem8( rs.getString( "Item8" ) );
    			tmpQuery.setContent8( rs.getString( "Content8" ) );
    			tmpQuery.setItem9( rs.getString( "Item9" ) );
    			tmpQuery.setContent9( rs.getString( "Content9" ) );
    			tmpQuery.setItem10( rs.getString( "Item10" ) );
    			tmpQuery.setContent10( rs.getString( "Content10" ) );
    			tmpQuery.setIscurrent( rs.getString( "IsCurrent" ) );
    			tmpQuery.setClientfile1( rs.getString( "ClientFile1" ) );
    			tmpQuery.setServerfile1( rs.getString( "ServerFile1" ) );
    			tmpQuery.setExpfile1( rs.getString( "ExpFile1" ) );
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
    
    //查詢單筆資料
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
    		stmts = conn.prepareStatement("select * from OrganizeChief where Serno = '" + serno + "'");
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
    		this.name = rs.getString( "Name" );
    		this.proftitle = rs.getString( "ProfTitle" );
    		this.item1 = rs.getString( "Item1" );
    		this.content1 = rs.getString( "Content1" );
    		this.item2 = rs.getString( "Item2" );
    		this.content2 = rs.getString( "Content2" );
    		this.item3 = rs.getString( "Item3" );
    		this.content3 = rs.getString( "Content3" );
    		this.item4 = rs.getString( "Item4" );
    		this.content4 = rs.getString( "Content4" );
    		this.item5 = rs.getString( "Item5" );
    		this.content5 = rs.getString( "Content5" );
    		this.item6 = rs.getString( "Item6" );
    		this.content6 = rs.getString( "Content6" );
    		this.item7 = rs.getString( "Item7" );
    		this.content7 = rs.getString( "Content7" );
    		this.item8 = rs.getString( "Item8" );
    		this.content8 = rs.getString( "Content8" );
    		this.item9 = rs.getString( "Item9" );
    		this.content9 = rs.getString( "Content9" );
    		this.item10 = rs.getString( "Item10" );
    		this.content10 = rs.getString( "Content10" );
    		this.iscurrent = rs.getString( "Iscurrent" );
    		this.clientfile1 = rs.getString( "ClientFile1" );
    		this.serverfile1 = rs.getString( "ServerFile1" );
    		this.expfile1 = rs.getString( "ExpFile1" );
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
    	ResultSet rs1 = null;
    	ResultSet rs2 = null;
    	ResultSet rs3 = null;
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	PreparedStatement stmts2 = null;
    	PreparedStatement stmts3 = null;
    	PreparedStatement stmts4 = null;
    	try
    	{
            //同意易動設定
     		conn.setAutoCommit(false);
     		
     		this.serno = serno;
     		
     		String dsql = "delete OrganizeChief where Serno = '" + serno + "'";
     		
			stmts = conn.prepareStatement(dsql);
			int deleteRow = stmts.executeUpdate();
			if ( deleteRow <= 0 ) 
			{
    			try {
    				conn.rollback();
    				errorMsg = "Delete table fail.";
    				return false;
 	            }catch(Exception backerr){
 	            	System.out.println("rollback faild!");
 	            }
    		}

    		//排序start
    		int mcount1 = 0;
    		if ( fsort != 0 )
    		{
    			stmts1 = conn.prepareStatement("select count(*) as mcount from OrganizeChief where PubUnitDN = '" + pubunitdn + "' and Fsort = " + fsort);
    			stmts1.clearParameters();
        		
        		rs1 = stmts1.executeQuery();        		
        		while ( rs1.next() )
        		{
        			mcount1 = Integer.parseInt(rs1.getString("mcount"));
        		}
    		}else if ( fsort == 0 ) {
    			stmts2 = conn.prepareStatement("select max(Fsort) as fsort from OrganizeChief where PubUnitDN = '" + pubunitdn + "'");
    			stmts2.clearParameters();
        		
        		rs2 = stmts2.executeQuery();
        		while ( rs2.next() )
        		{
        			int mfsort = rs2.getInt("fsort");
        			this.fsort = mfsort + 1;
        		}
    		}
    		if ( mcount1 > 0 )
    		{
    			StringBuffer sSql = new StringBuffer();
        		
        		sSql.append( "select * from OrganizeChief where Serno <> '" + serno + "' and fsort >= " + fsort + " and PubUnitDN = '" + pubunitdn + "'" );

        		stmts3 = conn.prepareStatement( sSql.toString() );
        		stmts3.clearParameters();
           
        		rs3 = stmts3.executeQuery();
        		
        		for ( int i=0; rs3.next(); i++ )
        		{
        			int mfsort = rs3.getInt( "Fsort") + 1;
                    //update
            		stmts4 = conn.prepareStatement(
            			"update " + tablename + " set Fsort = ? where Serno = ?" ); 
            		stmts4.clearParameters();    	 	
            		stmts4.setInt(1, mfsort );
            		stmts4.setString(2, rs3.getString( "Serno" ) );
            		int updateRow1 = stmts4.executeUpdate();
            		if ( updateRow1 <= 0 )
            		{
            			try {
            				conn.rollback();
            				errorMsg = "Update table fail.";
            				return false;
         	            }catch(Exception backerr){
         	            	System.out.println("rollback faild!");
         	            }
            		}
        		}
    		}
     		
    		//insert
    		String sql =  "insert into OrganizeChief";
    		       sql += "(Serno,PubUnitDN,PubUnitName,Name,ProfTitle,Item1,Content1,Item2,Content2,Item3,Content3,Item4,Content4,Item5,Content5,Item6,Content6,";
    		       sql += "Item7,Content7,Item8,Content8,Item9,Content9,Item10,Content10,Iscurrent,ClientFile1,ServerFile1,ExpFile1,Fsort,PostName,CreateDate,UpdateDate)";
    		       sql += " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    		       
    		stmts = conn.prepareStatement(sql);
    		
    		stmts.clearParameters();
    		stmts.setString(1, serno );
    		stmts.setString(2, pubunitdn );
    		stmts.setString(3, pubunitname );
    		stmts.setString(4, name );
    		stmts.setString(5, proftitle );
    		stmts.setString(6, item1 );
    		stmts.setString(7, content1 );
    		stmts.setString(8, item2 );
    		stmts.setString(9, content2 );
    		stmts.setString(10, item3 );
    		stmts.setString(11, content3 );
    		stmts.setString(12, item4 );
    		stmts.setString(13, content4 );
    		stmts.setString(14, item5 );
    		stmts.setString(15, content5 );
    		stmts.setString(16, item6 );
    		stmts.setString(17, content6 );
    		stmts.setString(18, item7 );
    		stmts.setString(19, content7 );
    		stmts.setString(20, item8 );
    		stmts.setString(21, content8 );
    		stmts.setString(22, item9 );
    		stmts.setString(23, content9 );
    		stmts.setString(24, item10 );
    		stmts.setString(25, content10 );
    		stmts.setString(26, iscurrent );
    		stmts.setString(27, clientfile1 );
    		stmts.setString(28, serverfile1 );
    		stmts.setString(29, expfile1 );
    		stmts.setInt(30, fsort );
    		stmts.setString(31, postname );
    		stmts.setString(32, getNowYear() );
    		stmts.setString(33, getNowYear() );
    		
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
    	PreparedStatement stmts2 = null;
    	try {
    		
            //同意易動設定
     		conn.setAutoCommit(false);

     		String[] ary_mserno = SvString.split(serno,"||");
     		for ( int i=0; i<ary_mserno.length; i++ ) {
     			String msql = "select * from OrganizeChief where Serno = '" + ary_mserno[i] + "'";
     			stmts = conn.prepareStatement(msql);
        		stmts.clearParameters();
        		rs = stmts.executeQuery();
        		
        		if ( rs.next() ) {
        			this.setSerno(rs.getString( "Serno" ));
        			this.setPubunitdn(rs.getString( "PubUnitDN" ));
        			this.setPubunitname(rs.getString( "PubUnitName" ));
        			this.setSubject(rs.getString( "Name" ));
        			//網站維運統計共用參數(WebSiteLog)
            		if ( !createlog(conn,"chinese") )
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
        			String dsql = "delete OrganizeChief where Serno = '" + ary_mserno[i] + "'";
        			
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
	
    //查詢單筆資料(刪除檔案)
    public boolean loadfile( String serno )
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
    		stmts = conn.prepareStatement("select * from OrganizeChief where Serno = '" + serno + "'");
    		stmts.clearParameters();
    		
    		rs = stmts.executeQuery();
    		if ( !rs.next() )
    		{
    			errorMsg = "No the data";
    			return false;
    		}
    		
    		this.clientfile1 = rs.getString( "ClientFile1" );
    		this.serverfile1 = rs.getString( "ServerFile1" );
    		this.expfile1 = rs.getString( "ExpFile1" );
    		
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
	
	//查詢多筆資料及筆數(排序)
    public ArrayList<Object> findBysort( String pubunitdn )
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
    		
    		sSql.append( "select * from OrganizeChief where PubUnitDN = '" + pubunitdn + "' order by Fsort desc" );

    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		ArrayList<Object> result = new ArrayList<Object>();
    		
    		for ( int i = 0; rs.next(); i++ )
    		{
    			ManagerData tmpQuery = new ManagerData();
    			tmpQuery.setSerno( rs.getString( "Serno" ) );
    			tmpQuery.setPubunitdn( rs.getString( "PubUnitDN" ) );
    			tmpQuery.setPubunitname( rs.getString( "PubUnitName" ) );
    			tmpQuery.setName( rs.getString( "Name" ) );
    			tmpQuery.setProftitle( rs.getString( "ProfTitle" ) );
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
