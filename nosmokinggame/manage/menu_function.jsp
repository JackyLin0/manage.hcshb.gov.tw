<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="library.jsp" %>
<%
	String id = request.getParameter("id") ;
	String sn = request.getParameter("sn") ;
	ResultSet rs ;
	
	if( sn == null )
	{
		rs = f.query("select sn , url from menu_function where id = '"+f.sql_string(id)+"'") ;
	}
	else
	{
		rs = f.query("select sn , url from menu_function where sn = "+f.sql_string(sn)) ;
	}
	
	if( ! rs.next() )
	{
		out.print("<html>\n") ;
		out.print("<script language=\"javascript\">\n") ;
		out.print("	window.alert(\"無此功能代碼，請確認輸入是否正確\") ;\n") ;
		out.print("	history.back() ;\n") ;
		out.print("</script>\n") ;
		out.print("</html>\n") ;
		return ;
	}
	
	ResultSet limit = f.query("select sn from limit_menu where menu_type = 'menu_function' and menu_sn = " + rs.getString("sn") + " and limit_group_sn = " + session.getAttribute("session_limit_group_sn") ) ;

	if( ! limit.next() )
	{
		out.print("<html>\n") ;
		out.print("<script language=\"javascript\">\n") ;
		out.print("	window.alert(\"您沒有進入此功能的權限\") ;\n") ;
		out.print("	history.back() ;\n") ;
		out.print("</script>\n") ;
		return ;
	}
	else
	{
		// 記錄使用次數
		
		ResultSet menu_function_frequently = f.query( "select * from menu_function_frequently where employee_sn = " + session.getAttribute("session_limit_group_sn") + " and menu_function_sn = " + rs.getString("sn") ) ;
	
		if( ! menu_function_frequently.next() )
		{
			
			menu_function_frequently.moveToInsertRow();
			
			menu_function_frequently.updateInt("sn",f.get_sn("menu_function_frequently")) ;
			menu_function_frequently.updateInt("employee_sn",(Integer)session.getAttribute("session_limit_group_sn")) ;
			menu_function_frequently.updateInt("counter",1) ;
			
			menu_function_frequently.updateInt("menu_function_sn", rs.getInt("sn")) ;
			
			menu_function_frequently.insertRow() ;
			
		}
		else
		{
			menu_function_frequently.updateInt("counter", menu_function_frequently.getInt("counter")+1 ) ;
			
			menu_function_frequently.updateRow();
		}
		
		// 進入功能
		
		if( rs.getString("url").indexOf("?") == -1 )
		{
			response.sendRedirect(rs.getString("url") + "?function_sn=" + rs.getString("sn") + "&time=" + f.urlencode(f.now()));
		}
		else
		{
			response.sendRedirect(rs.getString("url") + "&function_sn=" + rs.getString("sn") + "&time=" + f.urlencode(f.now()));
		}
	}
%>

