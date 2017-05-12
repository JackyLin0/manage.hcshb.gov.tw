<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="../fonran.jsp" %>
<%
	if( session.getAttribute("session_login") != "1" )
	{
		if( request.getParameter("uid") == null )
		{
			response.sendRedirect("login.jsp");
		}
		else
		{
			String uid = f.cstr(request.getParameter("uid")) ;
			Integer sn = 0 ;
			Integer limit_group_sn = 0 ;
			
			ResultSet rs = f.query("select * from employee where uid = '" + uid + "'") ;
			
			if( rs.next() )
			{
				sn = rs.getInt("sn") ;
				limit_group_sn = rs.getInt("limit_group_sn") ;
			}
			else
			{
				sn = f.get_sn("employee") ;
				limit_group_sn = 2 ;
				
				rs.moveToInsertRow() ;
				
				rs.updateInt("sn",sn) ;
				rs.updateString("uid",uid) ;
				rs.updateString("pwd",uid) ;
				rs.updateString("full_name",uid) ;
				rs.updateInt("limit_group_sn",limit_group_sn) ;
				rs.updateString("remark","") ;
				rs.updateString("update_user",uid) ;
				rs.updateDate("update_time",f.sql_date()) ;
				
				rs.insertRow() ;
			}
			
			session.setAttribute("session_login","1") ;
			session.setAttribute("session_limit_group_sn",limit_group_sn) ;
			session.setAttribute("session_update_user",uid) ;
			session.setAttribute("session_employee_sn",sn) ;
			
			f.employee_log_1("Login", "Login") ;
			
			response.sendRedirect("/nosmokinggame/manage/index.jsp?Time=" + f.urlencode(f.now()));
		}
	}

%>