/*
 * 撰寫日期：2010/6/26
 * 程式名稱：ThemeXml.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.metatag;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Properties;

public class ThemeXml {
	private int allrecordCount = 0;
	
    private String errorMsg = null;
    private int serno = 0;
    private String category = null;
    private String classno1 = null;
    private String classcname = null;
    private String classename = null;
    private String startusing = null;
    private String postname = null;
    private String createdate = null;
    private String updatedate = null;
    private String classno2 = null;
    private String classno3 = null;
	public int getSerno() {
		return serno;
	}
	public void setSerno(int serno) {
		this.serno = serno;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getClassno1() {
		return classno1;
	}
	public void setClassno1(String classno1) {
		this.classno1 = classno1;
	}
	public String getClasscname() {
		return classcname;
	}
	public void setClasscname(String classcname) {
		this.classcname = classcname;
	}
	public String getClassename() {
		return classename;
	}
	public void setClassename(String classename) {
		this.classename = classename;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getClassno2() {
		return classno2;
	}
	public void setClassno2(String classno2) {
		this.classno2 = classno2;
	}
	public String getClassno3() {
		return classno3;
	}
	public void setClassno3(String classno3) {
		this.classno3 = classno3;
	}
	public int getAllrecordCount() {
		return allrecordCount;
	}
	public String getErrorMsg() {
		return errorMsg;
	}

	//新增資料(主題分類)
    public boolean createfile( String path )
    {
    	try
    	{
    		//判斷OS版本
    		String FILE_PATH = "";
    		if ( path.indexOf("/") == -1 )
    			FILE_PATH = path + "\\WEB-INF\\uploadpath.properties";
    		else
    			FILE_PATH = path + "/WEB-INF/uploadpath.properties";

    		Properties sitemap = new Properties();  
    		sitemap.load(new FileInputStream(FILE_PATH) );
    		
    		String metapath = sitemap.getProperty("metapath");
    		String targetmetapath = sitemap.getProperty("targetmetapath");
    		
    		String filename = "theme.xml";

    		File d1 = new File(metapath,filename);
    		if ( d1.exists() )
    			d1.delete();

    		File d2 = new File(targetmetapath,filename);
    		if ( d2.exists() )
    			d2.delete();
    		
    		MetaClassData query1 = new MetaClassData();    		
    		ArrayList<Object> qlists1 = query1.findByone("MetaTagClass1", "1", "Y");    		
    		int rcount1  = query1.getAllrecordCount();
    		
    		String xmlpath = metapath + "/" + filename;
    		
    		OutputStream fileOut = new FileOutputStream(xmlpath,true);
    		Writer mw = new OutputStreamWriter(fileOut,"utf-8");
    		
    		mw.write("<?xml version='1.0' encoding='utf-8'?>");
    		mw.write("<tree id='0'>");
    		mw.write("<item text='主題分類' id='主題分類' open='1' im0='folderClosed.gif' im1='folderOpen.gif' im2='folderClosed.gif' call='1' select='1'>");
    		//第一層
    		if ( qlists1 != null ) {
    			for ( int i=0; i<rcount1; i++ ) {
    				MetaClassData qlist1 = ( MetaClassData )qlists1.get( i );
    				String datavalue1 = qlist1.getClassno1() + "||" + qlist1.getClasscname();    				
    				mw.write("<item text='" + qlist1.getClasscname() + "' id='" + datavalue1 + "' open='1' im0='folderClosed.gif' im1='folderOpen.gif' im2='folderClosed.gif'>");
    				//第二層
    				MetaClassData query2 = new MetaClassData();
    	    		ArrayList<Object> qlists2 = query2.findBytwo("MetaTagClass2", "1", qlist1.getClassno1(), "Y");
    	    		int rcount2  = query2.getAllrecordCount();
    	    		if ( qlists2 != null ) {
    	    			for ( int j=0; j<rcount2; j++ ) {
    	    				MetaClassData qlist2 = ( MetaClassData )qlists2.get( j );
    	    				String datavalue2 = datavalue1 + "-" + qlist2.getClassno2() + "||" + qlist2.getClasscname();
    	    				//第三層
    	    				MetaClassData query3 = new MetaClassData();
    	    	    		ArrayList<Object> qlists3 = query3.findBythree("MetaTagClass3", "1", qlist1.getClassno1(), qlist2.getClassno2(), "Y");
    	    	    		int rcount3  = query3.getAllrecordCount();
    	    	    		if ( qlists3 != null ) {
    	    	    			mw.write("<item text='" + qlist2.getClasscname() + "' id='" + datavalue2 + "' im0='folderClosed.gif' im1='folderOpen.gif' im2='folderClosed.gif'>");
    	    	    			for ( int k=0; k<rcount3; k++ ) {
    	    	    				MetaClassData qlist3 = ( MetaClassData )qlists3.get( k );
    	    	    				String datavalue3 = datavalue2 + "-" + qlist3.getClassno3() + "||" + qlist3.getClasscname();
    	    	    				mw.write("<item text='" + qlist3.getClasscname() + "' id='" + datavalue3 + "' im0='iconText.gif' im1='iconText.gif' im2='iconText.gif'/>");
    	    	    			}
    	    	    			mw.write("</item>");
    	    	    		}else{
    	    	    			mw.write("<item text='" + qlist2.getClasscname() + "' id='" + datavalue2 + "' im0='iconText.gif' im1='folderOpen.gif' im2='iconText.gif'/>");
    	    	    		}
    	    			}
    	    		}
    	    		mw.write("</item>");
    			}
    		}
    		mw.write("</item>");
    		mw.write("</tree>");
    		
    		mw.close();
    		String sourcefile = metapath + "//" + filename;
    		String targetfile =  targetmetapath + "//" + filename;
    		
    		try{
    			FileInputStream fis  = new FileInputStream(sourcefile);
    			FileOutputStream fos = new FileOutputStream(targetfile);
    			byte[] buf = new byte[1024];
    			int i = 0;
    			while((i=fis.read(buf))!=-1) {
    				fos.write(buf, 0, i);
    			}
    			fis.close();
    			fos.close();
    			
    		}catch(Exception e){
    			System.out.println("false");
    		}
    		return true;
    	}catch(IOException e){
    		return false;
    	}
    }
    
}
