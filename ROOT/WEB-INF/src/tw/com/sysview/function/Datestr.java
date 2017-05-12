package tw.com.sysview.function;

public class Datestr {

	/**
	 * @param args
	 */
	public static String date_chinese(String datestr,String formate){
		try{
            if( datestr == null ) 
            	return "";
            
            //如果datestr是空字串 則直接回傳空字串 不需再組 年/月/日  (garyyin)
            if( datestr.length() == 0 ){
                return "";
            }

            String str1="";
            //1:不加民國如93年1月1日,2:加民國如民國93年1月1日,3:加中華民國如中華民國93年1月1日

            String yy="";
            String mm="";
            String dd="";
            
            if( formate.equals("4") ){
                if( datestr.length() == 8 ){  //帶入為西元年
                	yy=datestr.substring(0,4);
                    mm=datestr.substring(4,6);
                    dd=datestr.substring(6,8);
                }
            }else{
                if( datestr.length() == 8 ){  //帶入為西元年
                    yy=String.valueOf(Integer.parseInt(datestr.substring(0,4))-1911);
                    mm=datestr.substring(4,6);
                    dd=datestr.substring(6,8);
                }else if( datestr.length() == 7 ){//如0930101
                    yy=datestr.substring(0,3);
                    mm=datestr.substring(3,5);
                    dd=datestr.substring(5,7);
                }else if( datestr.length() == 6 ){//如930101
                    yy=datestr.substring(0,2);
                    mm=datestr.substring(2,4);
                    dd=datestr.substring(4,6);
                }
            }
                
            str1=yy+"年"+mm+"月"+dd+"日";
            if ( formate.equals("2") ){
                    str1="民國"+str1;
            }else if( formate.equals("3") ){
                    str1="中華民國"+str1;
            }
            return str1;
        }catch(Exception e){
            e.printStackTrace();
            return "";//Exception code by garyyin 避免 Exception output
        }
    }
	
	public static String date_num(String datestr,String formate){
		if( datestr == null ) 
			return "";
		if( datestr.equals("") ) 
			return "";
	     
		String str1="";
		//1:093.01.01,2:093/01/01,3:2001/01/01
		String yy="";
		String mm="";
		String dd="";
	    if( datestr.length() == 8 && formate.equals("3") ){
	    	yy=datestr.substring(0,4);
	    	mm=datestr.substring(4,6);
	    	dd=datestr.substring(6,8);
		}else if( datestr.length() == 8 ){//帶入為西元年
			yy=String.valueOf(Integer.parseInt(datestr.substring(0,4))-1911);
			mm=datestr.substring(4,6);
			dd=datestr.substring(6,8);
		}else if( datestr.length() == 7 ){//如0930101
			yy=datestr.substring(0,3);
			mm=datestr.substring(3,5);
			dd=datestr.substring(5,7);
		}else if( datestr.length() == 6 ){//如930101
			yy=datestr.substring(0,2);
			mm=datestr.substring(2,4);
			dd=datestr.substring(4,6);
		}
		
		
		if ( formate.equals("1") ){
			str1=yy+"."+mm+"."+dd;
		}else if( formate.equals("2") ){
			str1=yy+"/"+mm+"/"+dd;
		}else if( formate.equals("3") ){
			str1=yy+"/"+mm+"/"+dd;
		}
		return str1;
	}
	
    public static String timeformat(String time,String formate){
    	if ( time == null ) 
    		return "";
		if ( time.equals("") ) 
			return "";
		
		String str1="";
		//1:12時00分,2:12點00分,3:12/00,4:12-00,5:12.00
		
		String hh="";
		String mm="";
		if(time.length()==4){ //帶入為1200	
			hh=time.substring(0,2);
			mm=time.substring(2,4);
		}
		
		if ( formate.equals("1") ){
			str1=hh+"時"+mm+"分";
		}else if( formate.equals("2") ){
			str1=hh+"點"+mm+"分";
		}else if( formate.equals("3") ){
			str1=hh+"/"+mm;
		}else if( formate.equals("4") ){
			str1=hh+"-"+mm;
		}else if(formate.equals("5")){
			str1=hh+"."+mm;
		}
		return str1;
	}
    
    public static String num_ch(String num){
    	if(num==null) return "";
    	if(num.equals("")) return "";
    	
    	String str1="";
    	String ch_str="十,一,二,三,四,五,六,七,八,九";
    	String cha[]=ch_str.split(",");
    	if ( num.length() == 1 ){
    		str1=cha[Integer.parseInt(num)];
    	}else if( num.length() == 2 ){
    		if( !num.substring(0,1).equals("0") ){
    			if( num.substring(0,1).equals("1") ){
    				str1="十";
    			}else{
    				str1=cha[Integer.parseInt(num.substring(0,1))]+"十";
    			}
    			if(!num.substring(1,2).equals("0")){
    				str1=str1+cha[Integer.parseInt(num.substring(1,2))];
    			}
    		}else{
    			str1=cha[Integer.parseInt(num.substring(1,2))];
    		}
    	}else if( num.length() == 3 ){
    		str1=cha[Integer.parseInt(num.substring(0,1))]+"百";
    		if( !num.substring(1,2).equals("0") ){
    			if( num.substring(1,2).equals("1") ){
    				str1=str1+"十";
    			}else{
    				str1=str1+cha[Integer.parseInt(num.substring(0,1))]+"十";
    			}
    		}else{
    			if( !num.substring(2,3).equals("0") ){
    				str1=str1+"零";
    			}
    		}
    		if( !num.substring(2,3).equals("0") ){
    			str1=str1+cha[Integer.parseInt(num.substring(2,3))];
    		}
    	}
    	return str1;
    }
}



