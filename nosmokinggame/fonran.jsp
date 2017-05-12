<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ include file="configure.jsp" %>
<%
	class fonran
	{
		HttpSession session ;
		HttpServletRequest request ;
		Connection conn ;
		configure configure ;
		Boolean is_create_calendar = false ;
		
		public fonran(HttpSession get_session, HttpServletRequest get_request,configure get_configure)
		{
			session = get_session ;
			request = get_request ;
			configure = get_configure ;
		}
		
		public void connect_mssql()
		{
			try
			{
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	 
				conn=DriverManager.getConnection("jdbc:sqlserver://"+configure.db_ip+":1433;user="+configure.db_uid+";password="+configure.db_pwd+";database="+configure.db_name);
			}
			catch(Exception e)
			{
			}
		}
		
		public ResultSet query(String sql)
		{
			try
			{
				Statement command = null;
				ResultSet rs = null;
				
				//command = conn.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
				command = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE , ResultSet.CONCUR_UPDATABLE);
	
				rs = command.executeQuery(sql);
				
				return rs ;
			}
			catch(Exception e)
			{
				return null ;
			}
		}
		
		public void execute_sql(String sql)
		{
			execute(sql) ;
		}
		
		public void execute(String sql)
		{
			try
			{
				Statement command = null;
				
				command = conn.createStatement();
	
				command.execute(sql);
			}
			catch(Exception e)
			{
			}
		}
		
		public String sql_string( String s )
		{
			if( s == null ) return "" ;
			
			return s.replace("'","''") ;
		}
	
		public String get_parameter(String id)
		{
			try
			{
				ResultSet rs = query("select val from parameter_sheet where id = '" + sql_string(id) + "'") ;
				
				if( rs.next() )
				{
					return rs.getString("val") ;
				}
				else
				{
					return "" ;
				}
			}
			catch(Exception e)
			{
				return "" ;
			}
		}
		
		public String urlencode(String s)
		{
			//return java.net.URLEncoder.encode(s,"utf-8") ;
			return java.net.URLEncoder.encode(s) ;
		}
		
		public String now()
		{
			java.util.Date d = new java.util.Date() ;
			
			return d.toLocaleString() ;
		}
		
		public Boolean limit_function( String function_sn , String limit_type )
		{
			try
			{
				ResultSet rs = query("select sn from limit_function where function_sn = "+function_sn+" and limit_type = '"+limit_type+"' and limit_group_sn = " + session.getAttribute("session_limit_group_sn") ) ;
			
				if( rs.next() )
				{
					return true ;
				}
				else
				{
					return false ;
				}
			}
			catch(Exception e)
			{
				return false ;
			}
		}
		
		public String get_function_name( String function_sn )
		{
			try
			{
				ResultSet rs = query("select caption from menu_function where sn = "+function_sn);
				
				if( rs.next() )
				{
					return rs.getString("caption") ;
				}
				else
				{
					return "" ;
				}
			}
			catch(Exception e)
			{
				return "" ;
			}
		}
		
		public int get_sn(String table_name)
		{
			try
			{
				ResultSet rs = query("select sn from sn_counter where table_name = '"+sql_string(table_name)+"'") ;
			
				if(rs.next())
				{
					execute("update sn_counter set sn = sn + 1 where table_name = '"+sql_string(table_name)+"'") ;
					return rs.getInt("sn") ;
				}
				else
				{
					execute("insert into sn_counter ( table_name , sn ) values ('"+sql_string(table_name)+"',2)") ;
					return 1 ;
				}
			}
			catch(Exception e)
			{
				return 0 ;
			}
			
		}
		
		public String get_code( String code_type_id , String code_id )
		{
			try
			{
				ResultSet rs = query("select code.caption from code_type left join code on code_type.sn = code.code_type_sn where code_type.id = '" + code_type_id + "' and code.id = '" + code_id + "'") ;
			
				if(rs.next())
				{
					return rs.getString("caption") ;
				}
				else
				{
					return "" ;
				}
			}
			catch(Exception e)
			{
				return "" ;
			}
		}
		
		public java.sql.Date sql_date()
		{
			java.util.Date ud = new java.util.Date();
			java.sql.Date d = new java.sql.Date(ud.getTime()) ;
			
			return d ;
		}
		
		// 紀錄 log
		public void employee_log_1( String caption , String remark )
		{
			try
			{
				ResultSet rs = query("select * from employee_log where sn < 0") ;
				
				java.util.Date ud = new java.util.Date();
				java.sql.Date d = new java.sql.Date(ud.getTime()) ;
			
				rs.moveToInsertRow() ;
			
				rs.updateInt("sn",get_sn("employee_log")) ;
				rs.updateInt("employee_sn",(Integer)session.getAttribute("session_employee_sn")) ;
				rs.updateString("full_name",(String)session.getAttribute("session_update_user")) ;
				rs.updateString("ip",request.getRemoteAddr()) ;
				rs.updateDate("log_time",sql_date()) ;
				rs.updateString("caption",caption) ;
				rs.updateString("remark",remark) ;
			
				rs.insertRow() ;
				//rs.moveToCurrentRow() ;
			}
			catch(Exception e)
			{
			}
		}
		
		// 紀錄 log
		public void employee_log_2( String function_sn, String remark )
		{
			employee_log_1( get_function_name( function_sn ) , remark) ;
		}
		
		public Integer cint( String s )
		{
			try
			{
				return Integer.valueOf(s) ;
			}
			catch(Exception e)
			{
				return 0 ;
			}
		}
		
		public String cstr( Object s )
		{
			try
			{
				if( s == null ) return "" ;
				
				return String.valueOf(s) ;
			}
			catch(Exception e)
			{
				return "" ;
			}
		}
		
		public String cdate( String d , String dateFormat )
		{
            try
            {
            	SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
            	Date date = null ;
            	date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(d) ;
            	return sdf.format(date);
            }
            catch(Exception e)
            {
            	return "" ; 
            }
            
		}
		
		public String field( ResultSet rs , String field_name )
		{
			try
			{
				if( rs == null ) return "" ;
				
				return rs.getString(field_name) ;
			}
			catch(Exception e)
			{
				//return cstr(request.getParameter(field_name)) ;
				return "" ;
			}
		}
		
		public String select_code( String input_name , String code_type_id , String code_id , Boolean allow_null , String null_caption  )
		{
			try
			{
				ResultSet rs = query("select code.* from code_type left join code on code_type.sn = code.code_type_sn where code_type.id = '"+code_type_id+"' order by code.id") ;
				String result = "" ;
				
				result += "<select name='"+input_name+"'>" ;
				
				if( allow_null ) result += "<option value=''>" + null_caption + "</option>" ;
				
				while( rs.next() )
				{
					if( rs.getBoolean("is_show") )
					{
						if( rs.getString("id").equals(code_id) )
						{
							result += "<option value='" + rs.getString("id") + "' selected>" + rs.getString("caption") + "</option>" ;
						}
						else
						{
							result += "<option value='" + rs.getString("id") + "'>" + rs.getString("caption") + "</option>" ;
						}
					}
				}
				
				result += "</select>" ;
				
				return result ;
			}
			catch(Exception e)
			{
				return "" ;
			}
		}

		public String select_sn( String input_name , String table_name , String show_field , Integer sn)
		{
			return select_sn( input_name , table_name , show_field , sn , "") ;
		}
		
		public String select_sn( String input_name , String table_name , String show_field , Integer sn , String condition)
		{
			try
			{
				String sql ;
				String result = "" ;
				
				sql = "select sn , "+show_field+" from "+table_name ;
				if( ! cstr(condition).equals("") ) sql += " where "+condition ;
				sql += " order by " + show_field ;
				
				ResultSet rs = query(sql) ;
				
				result += "<select name='"+input_name+"'>" ;
				
				while( rs.next() )
				{
					if( rs.getInt("sn") == sn )
					{
						result += "<option value='" + rs.getString("sn") + "' selected>" + rs.getString(show_field) + "</option>" ;
					}
					else
					{
						result += "<option value='" + rs.getString("sn") + "'>" + rs.getString(show_field) + "</option>" ;
					}
				}
				
				result += "</select>" ;
				
				return result ;
			}
			catch(Exception e)
			{
				return e.getMessage() ;
			}
		}

		public String create_calendar()
		{
			return create_calendar(1970,2030) ;
		}
		
		public String create_calendar( Integer start_year , Integer end_year )
		{
			is_create_calendar = true ;
			
			return "<iframe width=174 height=189 name=\"gToday:normal:agenda.js\" id=\"gToday:normal:agenda.js\" src=\""+configure.root_path+"/module/calendar/ipopeng.jsp?start_year="+cstr(start_year)+"&end_year="+cstr(end_year)+"\" scrolling=\"no\" frameborder=\"0\" style=\"visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;\"></iframe>" ;
		}
		
		public String date_picker( String name )
		{
			return date_picker( name , "" ) ;
		}
		
		public String date_picker( String name , String value )
		{
			String result = "" ;
			
			if( ! is_create_calendar ) result += create_calendar() ;
			
			result += "<input name=\""+name+"\" value=\""+value+"\" size=\"12\"><img src=\""+configure.root_path+"/module/calendar/calbtn.gif\" align=\"absmiddle\" onclick=\"gfPop.fPopCalendar("+name+")\">" ;
			
			return result ;
		}
		
		public boolean no_bad_string()
		{
			java.util.Enumeration enuParam = request.getParameterNames();
			String strName="", strOrigName="";
			String[] strAry; 
			int i;
			boolean is_ok = true ; 
			
			//request
			while (enuParam.hasMoreElements() ) {
    		strName=(String) enuParam.nextElement();
    		strOrigName=strName;
    		strAry=request.getParameterValues(strName);
    		
    		for (i=0;i< strAry.length;i++) {
    			if(strAry[i].indexOf("script")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("<iframe")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf(" and ")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("%\0")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("�H\0")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("onmouse")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("alert")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("'")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("\"")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf(".asa")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("cookie")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("\"\"")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("'\"\"")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("\''")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("\\\"\"")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("\'")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("\\'")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("%2527")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("�H2527")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("%25")!=-1) is_ok = false ; 
				if(strAry[i].indexOf("�H25")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("%27")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("�H27")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("%00")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("�H00")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("%00'")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("�H00'")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("%3d")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("�H3d")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("jyi=")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("0.01")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("j/*")!=-1) is_ok = false ; 
    			if(strAry[i].indexOf("*/")!=-1) is_ok = false ; 
    			}
			}
			
			//session
			strAry=session.getValueNames();
			for(i=0; i<strAry.length; i++)
			{
				if(session.getAttribute(strAry[i]).toString().indexOf("script")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("<iframe")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf(" and ")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("%\0")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("�H\0")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("onmouse")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("alert")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("'")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("\"")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf(".asa")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("cookie")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("\"\"")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("'\"\"")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("\''")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("\\\"\"")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("\'")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("\\'")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("%2527")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("�H2527")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("%25")!=-1) is_ok = false ; 
				if(session.getAttribute(strAry[i]).toString().indexOf("�H25")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("%27")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("�H27")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("%00")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("�H00")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("%00'")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("�H00'")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("%3d")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("�H3d")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("jyi=")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("0.01")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("j/*")!=-1) is_ok = false ; 
    			if(session.getAttribute(strAry[i]).toString().indexOf("*/")!=-1) is_ok = false ;
			}
			
			//cookie
			Cookie sck[] = request.getCookies();
			for(i=0;i<sck.length;i++) 
			{
				if(sck[i].getValue().indexOf("script")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("<iframe")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf(" and ")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("%\0")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("�H\0")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("onmouse")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("alert")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("'")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("\"")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf(".asa")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("cookie")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("\"\"")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("'\"\"")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("\''")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("\\\"\"")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("\'")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("\\'")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("%2527")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("�H2527")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("%25")!=-1) is_ok = false ; 
				if(sck[i].getValue().indexOf("�H25")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("%27")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("�H27")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("%00")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("�H00")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("%00'")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("�H00'")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("%3d")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("�H3d")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("jyi=")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("0.01")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("j/*")!=-1) is_ok = false ; 
    			if(sck[i].getValue().indexOf("*/")!=-1) is_ok = false ;
			}
			
			return is_ok ;
		}
	}
	request.setCharacterEncoding("utf-8");
	fonran f = new fonran(session,request,configure) ;
	f.connect_mssql() ;
	try
	{
		if(!f.no_bad_string()){out.close();}
	}catch(Exception e){}
	
	
%>