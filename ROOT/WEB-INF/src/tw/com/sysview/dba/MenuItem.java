/*
 * 撰寫日期：2007/4/7
 * 程式名稱：MenuItem.java
 * 功能：sitemap
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.dba;

import java.util.LinkedList;

public class MenuItem {
	private String serno = null;
    private String topserno = null;
    private String toplevelcontent = null;
    private String toplevellink = null;
    private Integer islevel = null;
    private String islevelcontent = null;
    private String islevellink = null;
    private String flag = null;
    private String target = null;
    private String startusing = null;
    private Integer fsort = null;
    private String clientfile1 = null;
    private String serverfile1 = null;
    private String postname = null;
    private String updatedate = null;
    private LinkedList<MenuItem> children = new LinkedList<MenuItem>();
    

	public LinkedList<MenuItem> getChildren() {
		return children;
	}
	public void setChildren(LinkedList<MenuItem> children) {
		this.children = children;
	}
	public String getClientfile1() {
		return clientfile1;
	}
	public void setClientfile1(String clientfile1) {
		this.clientfile1 = clientfile1;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public Integer getFsort() {
		return fsort;
	}
	public void setFsort(Integer fsort) {
		this.fsort = fsort;
	}
	public Integer getIslevel() {
		return islevel;
	}
	public void setIslevel(Integer islevel) {
		this.islevel = islevel;
	}
	public String getIslevelcontent() {
		return islevelcontent;
	}
	public void setIslevelcontent(String islevelcontent) {
		this.islevelcontent = islevelcontent;
	}
	public String getIslevellink() {
		return islevellink;
	}
	public void setIslevellink(String islevellink) {
		this.islevellink = islevellink;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getServerfile1() {
		return serverfile1;
	}
	public void setServerfile1(String serverfile1) {
		this.serverfile1 = serverfile1;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getToplevelcontent() {
		return toplevelcontent;
	}
	public void setToplevelcontent(String toplevelcontent) {
		this.toplevelcontent = toplevelcontent;
	}
	public String getToplevellink() {
		return toplevellink;
	}
	public void setToplevellink(String toplevellink) {
		this.toplevellink = toplevellink;
	}
	public String getTopserno() {
		return topserno;
	}
	public void setTopserno(String topserno) {
		this.topserno = topserno;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
}
