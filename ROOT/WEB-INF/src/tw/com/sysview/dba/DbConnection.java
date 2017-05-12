/*
 * 撰寫日期：2007/10/11
 * 程式名稱：DbConnection.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.NamingException;

public class DbConnection {
	
	static public Connection getConnection()
		throws NamingException, SQLException {
   	    Connection conn = DriverManager.getConnection("proxool.hcshb");
   	    return conn;
	}
	
	static public Connection getwebConnection()
		throws NamingException, SQLException {
   	    Connection conn = DriverManager.getConnection("proxool.hsinchu");
   	    return conn;
	}

}
