package tw.com.sysview.function;

import java.io.*;
import java.util.*;
import java.text.SimpleDateFormat;
import sysview.zhiren.servlet.mime.SvMultipartRequest;
import javax.servlet.http.*;
import javax.servlet.*;
import sysview.zhiren.function.*;

public class UplFiles {
	
	private String[] filename = null;
	private String[] originfile = null;
	private String[] expfile = null;
	
	public String[] getFilenames(){
		return this.filename;
	}
	
	public String[] getOriginFiles(){
		return this.originfile;
	}
	
	public String[] getExpFile(){
		return this.expfile;
	}
	
	public SvMultipartRequest process(HttpServletRequest request,ServletConfig config) throws Exception{
		String sysRoot = (String) config.getServletContext().getRealPath("");
		sysRoot = sysRoot.replace('\\','/');
		String fullname = sysRoot + request.getRequestURI();
		String fullpath = fullname.substring(0,fullname.lastIndexOf("/"));
		//取得程式所在的資料夾(EX：message)
		String fileforder = fullpath.substring(fullpath.lastIndexOf("/")+1,fullpath.length());
		
		//取得程式所在的上一層資料夾(EX：pubkinmen)
		String fullpath1 = fullpath.substring(0,fullpath.lastIndexOf("/"));
		String fileforder1 = fullpath1.substring(fullpath1.lastIndexOf("/")+1,fullpath1.length());
		
		//取得根路徑
		//String rootfolder = (String)application.getInitParameter("rootfolder");
		String rootfolder = config.getServletContext().getInitParameter("rootfolder");
		
		
		String filepath = rootfolder + "/" + fileforder1 + "/" + fileforder; 

		//目錄不存在時，建立目錄
		File f = new File(filepath);  
		if (!f.exists()) 
		   f.mkdirs();
	
		//接受上一頁Form內的所有欄位值
		SvMultipartRequest req = new SvMultipartRequest(request);  
		
		if ( !req.process(filepath) )   
		{ 
			throw new Exception("檔案無法上傳！");
		}
		
		//取系統日期
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
		String ndate = fmt.format(Calendar.getInstance().getTime());
		
		File[] reqfile = req.getFiles();  
		  //取得上傳檔案的個數 
		  int num = reqfile.length;    
System.out.println("num:" + num);		  
		  //宣告陣列
		  filename = new String[num];  
		  originfile = new String[num];
		  
		    
		  for (int i=0; i<num; i++)
		  {
		    filename[i] = reqfile[i].getName();      
		    originfile[i] = req.getOriginFile(filename[i]);
	    	//如果是圖檔，rename 年月日時分秒
	    	String subfile = SvString.right(filename[i],'.');    	
	    	if ( subfile.toUpperCase().equals("JPG") || subfile.toUpperCase().equals("GIF") ) {
	    		String filename2 = ndate + i + "." + subfile;
	    		File oldfile = new File(filepath + "/" + filename[i]);
	    		File newfile = new File(filepath + "/" + filename2);
	    		//imess.setServerfile1(filename[i]);
	    		if ( oldfile.renameTo(newfile) )
	    			//imess.setServerfile1(filename2);
	    			filename[i] = filename2;
	    	}else{
	    		//imess.setServerfile1(filename[i]);
	    	}
	    	//imess.setClientfile1(originfile[i]);
		  }
		  
		  return req;
	}
	
	public SvMultipartRequest processAdd(HttpServletRequest request,ServletConfig config,int count) throws Exception{
		String uplPath = this.getFilePath(request,config);
		return processAdd(request,config,uplPath,count);
	}
	
	public SvMultipartRequest processAdd(HttpServletRequest request,ServletConfig config,int count,int size) throws Exception{
		String uplPath = this.getFilePath(request,config);
		return processAdd(request,config,uplPath,count,size);
	}
	
	public SvMultipartRequest processAdd(HttpServletRequest request,ServletConfig config,String uplPath,int count) throws Exception{
		int size = 1024000 * 10;
		return processAdd(request,config,uplPath,count,size);
	}
	
	public SvMultipartRequest processAdd(HttpServletRequest request,ServletConfig config,String uplPath,int count,int size) throws Exception{
		
		//取得根路徑
		String rootfolder = config.getServletContext().getInitParameter("rootfolder");
		
		String filepath = rootfolder + "/" + uplPath; 
		
		//目錄不存在時，建立目錄
		File f = new File(filepath);  
		if (!f.exists()) 
		   f.mkdirs();
		
		//接受上一頁Form內的所有欄位值
		SvMultipartRequest req = new SvMultipartRequest(request);
		if ( !req.process(filepath,size) )   
		{ 
			throw new Exception("檔案無法上傳！");
		}
		
		//取得檔名參數
		//String[] osfile = getParameters(req,"osfile",count);
		//String[] orfile = getParameters(req,"orfile",count);
		String[] nsfile = getParameters(req,"nsfile",count);
		
		//取系統日期
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
		String ndate = fmt.format(Calendar.getInstance().getTime());
		
		File[] reqfile = req.getFiles();  
		  //取得上傳檔案的個數 
		  int num = reqfile.length;    
System.out.println("num:" + num);		  
		  //宣告陣列
		  filename = genStringArray(count);  
		  originfile = genStringArray(count);
		  
		  String[] fieldIndex = getUplFieldIndex(nsfile);
		    
		  for (int i=0; i<num; i++)
		  {
			int index = Integer.parseInt(fieldIndex[i]);
			
		    filename[index] = reqfile[i].getName();      
		    originfile[index] = req.getOriginFile(filename[index]);
	    	//如果是圖檔，rename 年月日時分秒
	    	String subfile = SvString.right(filename[index],'.');    	
	    	if ( subfile.toUpperCase().equals("JPG") || subfile.toUpperCase().equals("GIF") ) {
	    		String filename2 = ndate + i + "." + subfile;
	    		File oldfile = new File(filepath + "/" + filename[index]);
	    		File newfile = new File(filepath + "/" + filename2);
	    		//imess.setServerfile1(filename[i]);
	    		if ( oldfile.renameTo(newfile) )
	    			//imess.setServerfile1(filename2);
	    			filename[index] = filename2;
	    	}else{
	    		//imess.setServerfile1(filename[i]);
	    	}
	    	//imess.setClientfile1(originfile[i]);
	    	
		  }
		  
		  expfile = getParameters(req,"expfile",count);
		  
		  return req;
	}
	
	public SvMultipartRequest processMdy(HttpServletRequest request,ServletConfig config,int count) throws Exception{
		String uplPath = this.getFilePath(request,config);
		return processMdy(request,config,uplPath,count);
	}
	
	public SvMultipartRequest processMdy(HttpServletRequest request,ServletConfig config,int count,int size) throws Exception{
		String uplPath = this.getFilePath(request,config);
		return processMdy(request,config,uplPath,count,size);
	}
	
	public SvMultipartRequest processMdy(HttpServletRequest request,ServletConfig config,String uplPath,int count) throws Exception{
		int size = 1024000 * 10;
		return processMdy(request,config,uplPath,count,size);
	}
	public SvMultipartRequest processMdy(HttpServletRequest request,ServletConfig config,String uplPath,int count,int size) throws Exception{
		 
		//取得根路徑
		String rootfolder = config.getServletContext().getInitParameter("rootfolder");
		
		String filepath = rootfolder + "/" + uplPath;
	
		//目錄不存在時，建立目錄
		File f = new File(filepath);  
		if (!f.exists()) 
		   f.mkdirs();
		
		//接受上一頁Form內的所有欄位值
		SvMultipartRequest req = new SvMultipartRequest(request);
		
		if ( !req.process(filepath,size) )   
		{ 
			throw new Exception("檔案無法上傳！");
		}
		
		//取得檔名參數
		String[] osfile = getParameters(req,"osfile",count);
		String[] orfile = getParameters(req,"orfile",count);
		String[] nsfile = getParameters(req,"nsfile",count);
		
		//取系統日期
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddHHmmss");
		String ndate = fmt.format(Calendar.getInstance().getTime());
		
		File[] reqfile = req.getFiles();  
		  //取得上傳檔案的個數 
		  int num = reqfile.length;    
System.out.println("num:" + num);		  
		  //宣告陣列
		  filename = osfile.clone();  
		  originfile = orfile.clone();
		  
		  String[] fieldIndex = getUplFieldIndex(nsfile);
		    
		  for (int i=0; i<num; i++)
		  {
			int index = Integer.parseInt(fieldIndex[i]);
			
		    filename[index] = reqfile[i].getName();      
		    originfile[index] = req.getOriginFile(filename[index]);
	    	//如果是圖檔，rename 年月日時分秒
	    	String subfile = SvString.right(filename[index],'.');    	
	    	if ( subfile.toUpperCase().equals("JPG") || subfile.toUpperCase().equals("GIF") ) {
	    		String filename2 = ndate + i + "." + subfile;
	    		File oldfile = new File(filepath + "/" + filename[index]);
	    		File newfile = new File(filepath + "/" + filename2);
	    		//imess.setServerfile1(filename[i]);
	    		if ( oldfile.renameTo(newfile) )
	    			//imess.setServerfile1(filename2);
	    			filename[index] = filename2;
	    	}else{
	    		//imess.setServerfile1(filename[i]);
	    	}
	    	//imess.setClientfile1(originfile[i]);
	    	
	    	
	    	if (!osfile[index].equals(""))  {
  			  File d1 = new File(filepath,osfile[index]);               
  			  if (d1.exists()){
  				  d1.delete();
  			  }
  		  	}
		  }
		  
		  //判斷若無檔案重新上傳時，是否要將原檔案刪除
		  String[] dfile = getParameters(req,"dfile",count);
		  expfile = getParameters(req,"expfile",count);
		  for(int i = 0; i < dfile.length; i++){
			  if ( (nsfile[i].equals("")) && (!dfile[i].equals("")) ) {
				  filename[i] = "";
				  originfile[i] = "";
				  expfile[i] = "";
			      if (!osfile[i].equals("")) {
			    	  File d1 = new File(filepath,osfile[i]);
			          if (d1.exists()) {
			        	  d1.delete();
			          } 
			      }  
			  }
		  }
		  
		  return req;
	}
	
	//取得以[name]1,[name]2,[name]3...命名的參數值;其中count為個數
	private String[] getParameters(SvMultipartRequest req,String name,int count){
		String[] result = new String[count];
		for(int i = 0; i < count; i++){
			result[i] = ( String )req.getParameter( name + (i+1),"" );
		}
		return result;
	}
	
	//取得多個上傳檔案欄位中,實際有上傳檔案的索引位置
	//例如:有5個上傳檔案欄位,現在只有第2和第5個欄位有上傳檔案,則回傳值為:result[] = {"1","4"};
	private String[] getUplFieldIndex(String[] nsfile){
		String result = "";
		for(int i = 0; i < nsfile.length; i++){
			if(!nsfile[i].equals("")){
				if(result.equals("")){
					result += i;
				}else{
					result += "," + i;
				}
			}
		}
		return SvString.split(result, ",");
	}
	
	public String getFilePath(HttpServletRequest request,ServletConfig config){
		String sysRoot = (String) config.getServletContext().getRealPath("");
		sysRoot = sysRoot.replace('\\','/');
		String fullname = sysRoot + request.getRequestURI();
		String fullpath = fullname.substring(0,fullname.lastIndexOf("/"));
		//取得程式所在的資料夾(EX：message)
		String fileforder = fullpath.substring(fullpath.lastIndexOf("/")+1,fullpath.length());
		
		//取得程式所在的上一層資料夾(EX：pubkinmen)
		String fullpath1 = fullpath.substring(0,fullpath.lastIndexOf("/"));
		String fileforder1 = fullpath1.substring(fullpath1.lastIndexOf("/")+1,fullpath1.length());
		
		
		String filepath = fileforder1 + "/" + fileforder;
		
		return filepath;
	}
	
	private String[] genStringArray(int n){
		String[] result = new String[n];
		for(int i = 0; i < n; i++){
			result[i] = "";
		}
		return result;
	}

}
