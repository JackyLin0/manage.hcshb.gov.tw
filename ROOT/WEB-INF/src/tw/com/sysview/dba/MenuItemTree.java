/*
 * 撰寫日期：2007/4/7
 * 程式名稱：MenuItemTree.java
 * 功能：sitemap
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;
import java.util.Properties;

import sysview.zhiren.function.SvString;

public class MenuItemTree {

	private static MenuItemTree instance;	
	private Map<String, String> sitemapHash = new HashMap<String, String>();
	
	
	//private constructor
	private MenuItemTree(String path) throws FileNotFoundException, IOException{

		//判斷OS版本
		String Sitemap_PATH = "";
		if ( path.indexOf("/") == -1 )
			Sitemap_PATH = path+ "\\WEB-INF\\menu.properties";
		else
			Sitemap_PATH= path+ "/WEB-INF/menu.properties";

		Properties sitemap = new Properties();  
		sitemap.load(new FileInputStream(Sitemap_PATH ) );
		String table = sitemap.getProperty("sitemap");
		String menuimgpath = sitemap.getProperty("menuimgpath");
		
		String[] tablenames = table.split(",");
		for(int i=0; i<tablenames.length; i++){
			String siteHtml = getSitemap(tablenames[i],menuimgpath);
			sitemapHash.put(tablenames[i], siteHtml);
		}
	}
	
	public static MenuItemTree getInstance(String path) throws FileNotFoundException, IOException{
		if(instance == null){
			instance = new MenuItemTree(path);
		}
		
		return instance;
	}
	
	public void update(String tablename,String menuimgpath){
		System.out.println("tablename="+tablename);
		String html = getSitemap(tablename,menuimgpath);
		this.sitemapHash.remove(tablename);
		this.sitemapHash.put(tablename, html);
		
	}
	
	/**
	 * @param args
	 */
		
	private String getSitemap(String tablename,String menuimgpath){
		Map<String, MenuItem> menuItemHash1 = new HashMap<String, MenuItem>();
		LinkedList<MenuItem> menuItems1 = new LinkedList<MenuItem>();
		
		String errorMsg = "";
		
		Connection conn = null;
    	try
    	{
    		//連結資料庫
    		conn = tw.com.sysview.dba.DbConnection.getConnection();
    	} catch ( Exception e ) {
    		errorMsg = "Get DataSource or Connection error: " + e.toString();
    	}
    	
    	PreparedStatement stmts = null;
    	PreparedStatement stmts1 = null;
    	ResultSet rs = null;
    	ResultSet rs1 = null;
    	try
    	{
    		//找最大層次
    		stmts1 = conn.prepareStatement("select max(IsLevel) as seqno from " + tablename  );
    		
    		stmts1.clearParameters();
    		
    		rs1 = stmts1.executeQuery();
    		int mseq = 0;
    		while ( rs1.next() )
    		{
    			mseq = rs1.getInt("seqno");
    		}
    		
    		StringBuffer sSql = new StringBuffer();
    		
    		sSql.append( "select * from " + tablename + " where 1=1" );
    		
    		sSql.append( " order by IsLevel,Fsort" );
    		
    		stmts = conn.prepareStatement( sSql.toString() );
    		stmts.clearParameters();
       
    		rs = stmts.executeQuery();
    		
    		for ( int i=0; rs.next(); i++ )
    		{
    			MenuItem menu = new MenuItem();
    			//menu.setChildren("");
    			menu.setSerno( rs.getString( "Serno" ) );
    			menu.setTopserno( rs.getString( "TopSerno" ) );
    			menu.setToplevelcontent( rs.getString( "TopLevelContent" ) );
    			menu.setToplevellink( rs.getString( "TopLevelLink" ) );
    			menu.setIslevel( rs.getInt( "IsLevel" ) );
    			menu.setIslevelcontent( rs.getString( "IsLevelContent" ) );
    			menu.setIslevellink( rs.getString( "IsLevelLink" ) );
    			menu.setFlag( rs.getString( "Flag" ) );
    			menu.setTarget( rs.getString( "Target" ) );
    			menu.setStartusing( rs.getString( "StartUsing" ) );
    			menu.setFsort( rs.getInt( "Fsort" ) );
    			menu.setClientfile1( rs.getString( "ClientFile1" ) );
    			menu.setServerfile1( rs.getString( "ServerFile1" ) );
    			menu.setPostname( rs.getString( "PostName" ) );
    			menu.setUpdatedate( rs.getString( "UpdateDate" ) );
    			
    			menuItemHash1.put(rs.getString( "Serno" ),menu);
    		}
    		
    		MenuItem root = new MenuItem();
    		root.setSerno("root");
    		root.setIslevelcontent("root");
    		root.setTopserno("root");
    		
			Iterator<MenuItem> iter = menuItemHash1.values().iterator();
			while ( iter.hasNext() ){
				MenuItem menuItem = iter.next();
				String parentSerno = menuItem.getTopserno();
				
				if( parentSerno.equals("") || parentSerno.equals("0") ){
					//root.getChildren().add(menuItem.getFsort(), menuItem);
					root.getChildren().add(menuItem);
				}else{
					MenuItem parent = menuItemHash1.get(parentSerno);
					if(parent == null){
						System.out.println("error can't find serno" + parentSerno + " content is " + menuItem.getIslevelcontent());
					}
					parent.getChildren().add(menuItem);	
				}
			}
			
			//preorder travel			
			preorder(root, menuItems1);
			
			//gen html table
			String html = "<table border='0' width='100%' align='center'>";
			
			java.util.Iterator<MenuItem> iter1 = menuItems1.iterator();			
			
			int num1 = 0;
			int num2 = 0;
			int num3 = 0;
			int num4 = 0;
			int num5 = 0;
			int num6 = 0;
			int num7 = 0;
			String level2 = "";
			String level3 = "";
			String level4 = "";
			String level5 = "";
			String level6 = "";
			String level7 = "";
			String ming = "";
			
			while ( iter1.hasNext() ){
				MenuItem m1 = iter1.next();
				if(!m1.getSerno().equals("root")){
					for ( int i=1; i<=mseq; i++ ) {
						//第一層可上傳圖片
						String ming1 = "";
						String href1 = "";
						if ( m1.getIslevel() == i ) {
							html += "<tr><td><span class='main_title80'>";
							//編號start
							String num = "";						
							if ( m1.getIslevel() == 1) {
								num1 = num1 + 1;
								num = String.valueOf(num1);
								ming = "<img src=" + menuimgpath + "/img/folder.gif alt='Folder' width='16' height='16' border='0'/>";
								ming1 = "<img src=" + menuimgpath + "/img/Cmd_Save.gif alt='第一層Menu圖片上傳' width='16' height='16' border='0'/>";
								href1 = "<a href='javascript:img(" + m1.getSerno() + ")'>";
							}else if ( m1.getIslevel() == 2 ) {
								if ( !level2.equals(m1.getTopserno()) && !level2.equals("") )
									num2 = 0;
								num2 = num2 + 1;
								num = String.valueOf(num1) + "-" + String.valueOf(num2);
								level2 = m1.getTopserno();
								ming = "<img src=" + menuimgpath + "/img/l.gif alt='-' width='19' height='20' border='0'/><img src=" + menuimgpath + "/img/file1.gif alt='Folder' width='16' height='16' border='0'/>";
							}else if ( m1.getIslevel() == 3) {
								if ( !level3.equals(m1.getTopserno()) && !level3.equals("") )
									num3 = 0;
								num3 = num3 + 1;
								num = String.valueOf(num1) + "-" + String.valueOf(num2) + "-" + String.valueOf(num3);
								level3 = m1.getTopserno();
								ming = "<img src=" + menuimgpath + "/img/l.gif alt='-' width='19' height='20' border='0'/><img src=" + menuimgpath + "/img/file1.gif alt='Folder' width='16' height='16' border='0'/>";
							}else if ( m1.getIslevel() == 4) {
								if ( !level4.equals(m1.getTopserno()) && !level4.equals("") )
									num4 = 0;
								num4 = num4 + 1;
								num = String.valueOf(num1) + "-" + String.valueOf(num2) + "-" + String.valueOf(num3) + "-" + String.valueOf(num4);
								level4 = m1.getTopserno();
								ming = "<img src=" + menuimgpath + "/img/l.gif alt='-' width='19' height='20' border='0'/><img src=" + menuimgpath + "/img/file1.gif alt='Folder' width='16' height='16' border='0'/>";
							}else if ( m1.getIslevel() == 5) {
								if ( !level5.equals(m1.getTopserno()) && !level5.equals("") )
									num5 = 0;
								num5 = num5 + 1;
								num = String.valueOf(num1) + "-" + String.valueOf(num2) + "-" + String.valueOf(num3) + "-" + String.valueOf(num4) + "-" + String.valueOf(num5);
								level5 = m1.getTopserno();
								ming = "<img src=" + menuimgpath + "/img/l.gif alt='-' width='19' height='20' border='0'/><img src=" + menuimgpath + "/img/file1.gif alt='Folder' width='16' height='16' border='0'/>";
							}else if ( m1.getIslevel() == 6) {
								if ( !level6.equals(m1.getTopserno()) && !level6.equals("") )
									num6 = 0;
								num6 = num6 + 1;
								num = String.valueOf(num1) + "-" + String.valueOf(num2) + "-" + String.valueOf(num3) + "-" + String.valueOf(num4) + "-" + String.valueOf(num5) + "-" + String.valueOf(num6);
								level6 = m1.getTopserno();
								ming = "<img src=" + menuimgpath + "/img/l.gif alt='-' width='19' height='20' border='0'/><img src=" + menuimgpath + "/img/file1.gif alt='Folder' width='16' height='16' border='0'/>";
							}else if ( m1.getIslevel() == 7) {
								if ( !level7.equals(m1.getTopserno()) && !level7.equals("") )
									num7 = 0;
								num7 = num7 + 1;
								num = String.valueOf(num1) + "-" + String.valueOf(num2) + "-" + String.valueOf(num3) + "-" + String.valueOf(num4) + "-" + String.valueOf(num5) + "-" + String.valueOf(num6) + "-" + String.valueOf(num7);
								level7 = m1.getTopserno();
								ming = "<img src=" + menuimgpath + "/img/l.gif alt='-' width='19' height='20' border='0'/><img src=" + menuimgpath + "/img/file1.gif alt='Folder' width='16' height='16' border='0'/>";
							}
							
							//編號end
							
							String href = "<a href='javascript:mdy(" + m1.getSerno() + ")'>";
												
							String[] ary_num = SvString.split(num,"-");
							String mspace = "";
							if ( ary_num.length > 2 ) {
								for ( int j=0; j<ary_num.length; j++ ) {
									if ( mspace.equals("") )
										mspace = "&nbsp;";
									else
										mspace = mspace + "&nbsp;";
								}
							}							
							html += mspace + ming + "  " + href + m1.getIslevelcontent() + "</a>" + "    " + href1 + ming1 + "</a></span></td></tr>";
						}
					}
				}
			}
			html += "</table>";
			
			return html;
			
			
			//return this.menuItems;
			
    	}catch(Exception e){
    		e.printStackTrace();
    	} finally {
    		try
    		{
    			if ( rs != null ) rs.close();
    			if ( rs1 != null ) rs1.close();
    			if ( stmts != null ) stmts.close();
    			if ( stmts1 != null ) stmts1.close();
    			conn.close();
    		} catch ( SQLException se ) {
    			errorMsg = "close ResultSet or Statment or connection error: " + se.toString();
    		}
    	}
    	
		return null;		
		
	}
	
	
	private void preorder(MenuItem menuItem, LinkedList<MenuItem> menuItems1){
		menuItems1.add(menuItem);
		
		Iterator<MenuItem> iter = menuItem.getChildren().iterator();
		while(iter.hasNext()){
			MenuItem child = iter.next();
			preorder(child, menuItems1);
		}
	}


	public Map<String, String> getSitemapHash() {
		return sitemapHash;
	}


	public void setSitemapHash(Map<String, String> sitemapHash) {
		this.sitemapHash = sitemapHash;
	}

}
