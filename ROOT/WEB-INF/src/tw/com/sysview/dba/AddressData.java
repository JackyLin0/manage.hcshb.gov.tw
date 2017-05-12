/*
 * 撰寫日期：2008/2/14
 * 程式名稱：AddressData.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AddressData {
	
	public static ArrayList<Object> getAddressData(){
    	Connection conn = null;    	
    	
		PreparedStatement stmt = null;
		ResultSet rs = null;
		StringBuffer citys = new StringBuffer();
		StringBuffer areas = new StringBuffer();
		try{
			//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
			
			String sql = "select * from City order by CityNo,TownsNo";
			
			stmt = conn.prepareStatement(sql);			
			stmt.clearParameters();
			rs = stmt.executeQuery();
			
			String cityno = "01";
			String citycname = "";
			String[] city = new String[2];
			String townsno = "";
			String townscname = "";
			String area = "";
			String tmp_cityno = "";
			
			while ( rs.next() ){
				tmp_cityno = rs.getString( "CityNo" );
				citycname = rs.getString( "CityCName" );
				townsno = rs.getString( "TownsNo" );
				townscname = rs.getString( "TownsCName" );
				area = rs.getString( "Area" );
				if( cityno.equals(tmp_cityno) ){
					areas.append(area).append("||").append(townsno).append("||").append(townscname).append(",");
					city[0] = tmp_cityno;
					city[1] = citycname;
				}else{
					areas.setCharAt(areas.length() - 1, ';');
					areas.append(area).append("||").append(townsno).append("||").append(townscname).append(",");
					citys.append(city[0]).append("||").append(city[1]).append(",");
					
					city[0] = tmp_cityno;
					city[1] = citycname;
					cityno = tmp_cityno;
				}
			}
			areas.setLength(areas.length() - 1);
			city[0] = cityno;
			city[1] = citycname;
			citys.append(city[0]).append("||").append(city[1]);
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try
			{
				if ( rs != null ) rs.close();
				if ( stmt != null ) stmt.close();
				conn.close();
			} catch ( SQLException se ) {
				se.printStackTrace();
			}
		}
		
		ArrayList<Object> result = new ArrayList<Object>();
		result.add(citys.toString());
		result.add(areas.toString());
		return result;
	}

}
