package tw.com.sysview.downdoc;
import java.util.StringTokenizer;
import java.lang.Integer;
import java.io.*;
import javax.mail.internet.*;
import sun.misc.*;
import java.net.URLEncoder;


public class svList {
	static private String data="";
	static private int num=0;
	static private String delim=",";
   static String rfc822EscapeChars=" <>@,;:./?=\\\"*~～|+%&\r\n\t";
	
	static public int getLen(String data,String delim){
		StringTokenizer tokens=new StringTokenizer(data,delim);
		return(tokens.countTokens());
	}
	static public int getLen(String data){
		delim=",";
		StringTokenizer tokens=new StringTokenizer(data,delim);
		return(tokens.countTokens());
	}
	static public String rest(String data,String delim){
		int ptr=data.indexOf(delim);
		if(data.indexOf(delim)!=-1)
			return(data.substring(ptr+1));
		else
			return("");
	}
	static public String rest(String data){
		delim=",";
		int ptr=data.indexOf(delim);
		if(data.indexOf(delim)!=-1)
			return(data.substring(ptr+1));
		else
			return("");
	}
	static public String getAt(String data1,String num1,String delim1){
		data=data1;
		num=Integer.parseInt(num1);
		delim=delim1;
		return(process());
	}
	static public String getAt(String data1,int num1,String delim1){
		data=data1;
		num=num1;
		delim=delim1;
		return(process());
	}
	static public String getAt(String data1,int num1){
		delim=",";
		data=data1;
		num=num1;
		return(process());
	}
	static public String deleteAt(String data1,String num1,String delim1){
		data=data1;
		num=Integer.parseInt(num1);
		delim=delim1;
		return(delprocess());
	}
	static public String deleteAt(String data1,int num1,String delim1){
		data=data1;
		num=num1;
		delim=delim1;
		return(delprocess());
	}
	static public String deleteAt(String data1,int num1){
		delim=",";
		data=data1;
		num=num1;
		return(delprocess());
	}
	static public String getAt(String data1,String num1){
		delim=",";
		data=data1;
		num=Integer.parseInt(num1);
		return(process());
	}
	static public String getFirst(String data,String delim){
		int ptr=data.indexOf(delim);
		if(data.indexOf(delim)!=-1)
			return(data.substring(0,ptr));
		else
			return("");
	}
	static public String getFirst(String data){
		delim=",";
		int ptr=data.indexOf(delim);
		if(data.indexOf(delim)!=-1)
			return(data.substring(0,ptr));
		else
			return("");
	}
	static private String process(){
		StringTokenizer tokens=new StringTokenizer(data,delim);
		int count=tokens.countTokens();
		if(num>=count)
			return("");
		else{
			int ptr=0;
			String value="";
			for(int i=0;i<count;i++){
				value=tokens.nextToken();
				if(i==num)
					break;
			}
			return(value);
		}
	}
	static private String delprocess(){
		StringTokenizer tokens=new StringTokenizer(data,delim);
		int count=tokens.countTokens();
		if(num>=count)
			return("");
		else{
			int ptr=0;
			String recombine="";
			String value="";
			for(int i=0;i<count;i++){
				value=tokens.nextToken();
				if(i!=num)
					recombine+=value+delim;
			}
			if(recombine.length()!=0)
				recombine=recombine.substring(0,recombine.length()-1);
			return(recombine);
		}
	}
	static public String replace(String s,String old,String replacement){
		if(s.length()>100000) return s;
	 	int i=s.indexOf(old);
	 	StringBuffer r=new StringBuffer();
	 	if(i==-1) return s;
	 	r.append(s.substring(0,i)+replacement);
	 	if(i+old.length()<s.length())
	 		r.append(replace(s.substring(i+old.length(),s.length()),old,replacement));
	 	return r.toString();
	} 
	static public String getWord(String data,int num){
		if(data.getBytes().length>num){
           StringBuffer sb=new StringBuffer();
           boolean keepGoing=true;
           int wordCount=0;
           int ptr=0;
           int len=data.length();
           while(keepGoing){
           		if(wordCount<num && ptr<len){
           			char c=data.charAt(ptr++);
           			if(((int)c)>1000)
           				wordCount+=2;
           			else
           				wordCount++;
           			sb.append(c);
           		}else
           			keepGoing=false;
           }
           
           data=sb.toString();
       }
       return(data);
	}
	static public String getWord(String data,int num,String append){
		if(data.getBytes().length>num){
           StringBuffer sb=new StringBuffer();
           boolean keepGoing=true;
           int wordCount=0;
           int ptr=0;
           int len=data.length();
           while(keepGoing){
           		if(wordCount<num && ptr<len){
           			char c=data.charAt(ptr++);
           			if(((int)c)>1000)
           				wordCount+=2;
           			else
           				wordCount++;
           			sb.append(c);
           		}else
           			keepGoing=false;
           }
           data=sb.toString()+append;
       }
       return(data);
	}
	static public boolean isCharsetBig5(String big5Data) throws UnsupportedEncodingException{
		byte[] bin=big5Data.getBytes("Big5");
		boolean isBig5=false;
		for(int i=0;i<bin.length;i++)
			if(bin[i]<0){
				isBig5=true;
				break;
			}
      return(isBig5);
	}
    static public String escapeFileName(String unescapeStr){
    	 String filename="";
		 String ext="";
		 StringBuffer sbuffer=new StringBuffer();
		 StringBuffer ebuffer=new StringBuffer();
		 int ptr=unescapeStr.lastIndexOf('.');
		 if(ptr!=-1){
		 	  filename=unescapeStr.substring(0,ptr);
		 	  ext=unescapeStr.substring(ptr+1);
		 }else{
		 	 filename=unescapeStr;
		 }
    	 int filenameLen=filename.length();
    	 int escapeLen=rfc822EscapeChars.length();
		 for(int s=0;s<filenameLen;s++){
		 		char letter=filename.charAt(s);
		 		for(int skipnum=0;skipnum<escapeLen;skipnum++){
		 			if(letter==rfc822EscapeChars.charAt(skipnum))
		 				letter='_';
		 		}
				sbuffer.append(letter);
		 }
		 int extLen=ext.length();
		 for(int e=0;e<extLen;e++){
		 		char letter=ext.charAt(e);
		 		for(int skipnum=0;skipnum<escapeLen;skipnum++){
		 			if(letter==rfc822EscapeChars.charAt(skipnum))
		 				letter='_';
		 		}
				ebuffer.append(letter);
		 }
		 if(ptr!=-1)
		 	  return(sbuffer.toString().trim()+"."+ebuffer.toString());
		 else 
		 	  return(sbuffer.toString().trim());
	 }
    static public String escapeString(String unescapeStr){
		 StringBuffer sbuffer=new StringBuffer();
    	 int unescapeStrLen=unescapeStr.length();
    	 int escapeLen=rfc822EscapeChars.length();
		 for(int s=0;s<unescapeStrLen;s++){
		 		char letter=unescapeStr.charAt(s);
		 		for(int skipnum=0;skipnum<escapeLen;skipnum++){
		 			if(letter==rfc822EscapeChars.charAt(skipnum))
		 				letter='_';
		 		}
				sbuffer.append(letter);
		 }
 	    return(sbuffer.toString().trim());
	 }
    static public String escapeXml(String text){
		   StringBuffer xmlBuffer=new StringBuffer();
         for (int i = 0; i < text.length(); i++) {
             char c = text.charAt(i);
             if (c == '&')
                 xmlBuffer.append("&amp;");
             else if (c == '<')
                 xmlBuffer.append("&lt;");
             else if (c == '>')
                 xmlBuffer.append("&gt;");
             else if (c == '"')
                 xmlBuffer.append("&#034;");
             else if (c == '\'')
                 xmlBuffer.append("&#039;");
             else
                 xmlBuffer.append(c);
         }
         return(xmlBuffer.toString());
	 }	
    static public String removeSpace(String unSpace){
    	 int len=unSpace.length();
		 StringBuffer sbuffer=new StringBuffer();
		 for(int s=0;s<len;s++){
		 		char letter=unSpace.charAt(s);
		 		if(letter!=' ')
					sbuffer.append(letter);
		 }
		 return(sbuffer.toString().trim());
	 }
    static public String decodeHeader(String encodeHeader){
      String result="";
    	try{
	      if(encodeHeader!=null){
		    	int question1=encodeHeader.indexOf("=?");
		    	int question2=encodeHeader.indexOf("?=");
		    	if(question1==-1 && question2==-1)
		  			encodeHeader=new String(encodeHeader.getBytes("ISO8859_1"),"Big5");
		            String address=svList.replace(encodeHeader,"\"","");
		            address=svList.replace(address,"\r\n","");
		            int cptr1=address.indexOf("?==?");
		            if(cptr1!=-1){
		            	address=svList.replace(address," ","");
		            	int cptr2=address.indexOf("?=",cptr1+4);
		            	if(cptr2!=-1){
		            		address=address.substring(0,cptr1)+address.substring(cptr2+1);
		            	}
		         	}
		            try{
						  String etext=address;
				        int len=etext.length();
				     	  StringBuffer reorg=new StringBuffer();		
				        boolean keepgoing=true;
				        while(keepgoing){
				        	  int ptr1=etext.indexOf("=?");
					        if(ptr1!=-1){
					        	  reorg.append(etext.substring(0,ptr1));
					        	  etext.substring(ptr1,etext.length());
					        	  ptr1=etext.indexOf("=?");
					        }
				       	  int ptr2=etext.indexOf("?",ptr1+2);
				        	  int ptr3=etext.indexOf("?=",ptr2+4);
				        	  if(ptr2!=-1 && ptr3!=-1){
					     	  	  String pestr=etext.substring(ptr1,ptr3+2);
					     	  	  
					        	  try{
					               if((pestr.indexOf("=?")!=-1)&&(pestr.indexOf("?=")!=-1)){
					           			int pe1=pestr.indexOf("=?");
					                  int pe2=pestr.indexOf("?",pe1+2);
					                  String charset=pestr.substring(pe1+2,pe2);
			                  		reorg.append(pestr.startsWith("=??B?")?pestr:MimeUtility.decodeWord(pestr));
					               }else{
						        			reorg.append(pestr.startsWith("=??B?")?pestr:MimeUtility.decodeWord(pestr));
						        		}
					        	  
					        		}catch(javax.mail.internet.ParseException pe){
					               if((pestr.indexOf("=?")!=-1)&&(pestr.indexOf("?=")!=-1)){
					           			int pe1=pestr.indexOf("=?");
					                  int pe2=pestr.indexOf("?",pe1+2);
					               }else
						        			reorg.append(pestr);
					        		}
					        		int ptr4=etext.indexOf("=?",ptr3+2);
					        		if(ptr4!=-1){
					        			etext=etext.substring(ptr3+2,etext.length());
					        		}else{
					        			if(len>ptr3+2){
					        				String appendix=etext.substring(ptr3+2,etext.length());
					        				reorg.append(etext.substring(ptr3+2,etext.length()));
					        			}
					        			keepgoing=false;
					        		}
					        	}else{
				               String chineseChar=svList.isCharsetBig5(etext)?etext:MimeUtility.decodeText(new String(etext.getBytes("ISO8859_1"),"Big5")); 
				               if(chineseChar.startsWith("=?"))
				               	chineseChar=MimeUtility.decodeText(new String(svList.removeSpace(chineseChar).getBytes("ISO8859_1"),"Big5")); 
					        		reorg.append(chineseChar);
					        		keepgoing=false;
					        	}
				        	}
		               result=reorg.toString();
			            String result1=result.replace('\\',' ').trim();
			            result1=svList.replace(result1,"\"","");
			            result1=svList.replace(result1,"'","");
			            
		   	         if(result1.indexOf('<')==0){
		         	      String result2=result1.replace('<',' ');
		            	   result=result2.replace('>',' ');
		            	}else
		               	result=result1;
		            }catch(UnsupportedEncodingException e){
		            	if(encodeHeader.indexOf("utf-7")!=-1){
			            	result=decodeUTF7(encodeHeader);
		            	}else{
				            int ptr1=encodeHeader.indexOf("=?");
				            int ptr2=encodeHeader.indexOf("?",ptr1+2);
			            	if(ptr1!=-1 && ptr2!=-1)
			           	 	    result=MimeUtility.decodeText(svList.replace(encodeHeader,encodeHeader.substring(ptr1+2,ptr2),"Big5"));
			           	}
		            }
		   }
		}catch(Exception e){}
		finally{
			
		
		}
		return(result);
   }
   static private String decodeUTF7(String encodeHeader){
   	String result="";
   	try{
	   	if(encodeHeader.indexOf("utf-7")!=-1){
	      	for(int count=0;count<svList.getLen(encodeHeader,"\r\n");count++){
	      		String headerStr=svList.getAt(encodeHeader,count,"\r\n");
	      		int ptr=headerStr.indexOf("?B?");
	      		String utf7string=headerStr.substring(ptr+3,headerStr.indexOf("?=",ptr+3));
		         ByteToCharUTF7 btc = new ByteToCharUTF7();
		         byte[] bytes = new BASE64Decoder().decodeBuffer(utf7string);
		         char[] chars = new char[bytes.length / 2 + 1];
				   try{
		        	  btc.convert(bytes, 0, bytes.length,chars, 0, chars.length);
				   }catch(Exception ee){}
		         result+=new String(chars);
	         }
	   	}else{
	         int ptr1=encodeHeader.indexOf("=?");
	         int ptr2=encodeHeader.indexOf("?",ptr1+2);
	      	if(ptr1!=-1 && ptr2!=-1)
	     	 	    result=MimeUtility.decodeText(svList.replace(encodeHeader,encodeHeader.substring(ptr1+2,ptr2),"Big5"));
	     	}
	   }catch(Exception e){
	   	System.out.println(e);
	   }
	   return(result);
   }
   static public String decodeFileName(String fileName){
            String result="";
            try{
		        int len=fileName.length();
		     	  StringBuffer reorg=new StringBuffer();		
		        boolean keepgoing=true;
		        while(keepgoing){
		        	  int ptr1=fileName.indexOf("=?");
			        if(ptr1!=-1){
			        	  reorg.append(fileName.substring(0,ptr1));
			        	  fileName.substring(ptr1,fileName.length());
			        	  ptr1=fileName.indexOf("=?");
			        }
		       	  int ptr2=fileName.indexOf("?",ptr1+2);
		        	  int ptr3=fileName.indexOf("?=",ptr2+4);
		        	  if(ptr2!=-1 && ptr3!=-1){
			     	  	  String pestr=fileName.substring(ptr1,ptr3+2);
			        	  try{
			               if((pestr.indexOf("=?")!=-1)&&(pestr.indexOf("?=")!=-1)){
			           			int pe1=pestr.indexOf("=?");
			                  int pe2=pestr.indexOf("?",pe1+2);
			                  String charset=pestr.substring(pe1+2,pe2);
		                  	reorg.append(pestr.startsWith("=??B?")?pestr:MimeUtility.decodeWord(pestr));
			               }else{
				        			reorg.append(pestr.startsWith("=??B?")?pestr:MimeUtility.decodeWord(pestr));
				        		}
			        		}catch(javax.mail.internet.ParseException pe){
			               if((pestr.indexOf("=?")!=-1)&&(pestr.indexOf("?=")!=-1)){
			           			int pe1=pestr.indexOf("=?");
			                  int pe2=pestr.indexOf("?",pe1+2);
			               }else
				        			reorg.append(pestr);
			        		}
			        		int ptr4=fileName.indexOf("=?",ptr3+2);
			        		if(ptr4!=-1){
			        			fileName=fileName.substring(ptr3+2,fileName.length());
			        		}else{
			        			if(len>ptr3+2){
			        				String appendix=fileName.substring(ptr3+2,fileName.length());
			        				reorg.append(fileName.substring(ptr3+2,fileName.length()));
			        			}
			        			keepgoing=false;
			        		}
			        	}else{
		               String chineseChar=svList.isCharsetBig5(fileName)?fileName:MimeUtility.decodeText(new String(fileName.getBytes("ISO8859_1"),"Big5")); 
		               if(chineseChar.startsWith("=?"))
		               	chineseChar=MimeUtility.decodeText(new String(svList.removeSpace(chineseChar).getBytes("ISO8859_1"),"Big5")); 
			        		reorg.append(chineseChar);
			        		keepgoing=false;
			        	}
		        	}
               result=escapeFileName(reorg.toString());
            }catch(UnsupportedEncodingException uee){
            	if(fileName.indexOf("utf-7")!=-1){
	            	result=decodeUTF7(fileName);
            	}else{
		            int ptr1=fileName.indexOf("=?");
		            int ptr2=fileName.indexOf("?",ptr1+2);
	            	if(ptr1!=-1 && ptr2!=-1){
	            		try{
	           	 	    result=MimeUtility.decodeText(svList.replace(fileName,fileName.substring(ptr1+2,ptr2),"Big5"));
	           	 	   }catch(Exception e){}
	           	 	}
	           	}
            }
               
            return(result);
   }   	 
   
   static public String encodeURL(String url,String charset) throws UnsupportedEncodingException{
      StringBuffer sb=new StringBuffer();
      int len=url.length();
      for(int i=0;i<len;i++){
     		String str=String.valueOf(url.charAt(i));
     		if(url.charAt(i)<1000){
     			sb.append(str);
     		}else{
  				sb.append(URLEncoder.encode(str,charset));
     		}
       }
       return(sb.toString());
   }
}