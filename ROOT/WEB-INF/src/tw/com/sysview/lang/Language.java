/*
 * 撰寫日期：2007/2/12
 * 程式名稱：Language.java
 * 功能：語系
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.lang;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class Language {	
	
	private String add;                   //新增
	private String mdy;                   //修改
	private String qry;                   //查詢
	private String del;                   //刪除
	private String save;                  //儲存
	private String dataadd;               //資料新增
	private String datamdy;               //資料修改
	private String upload;                //上傳
	private String back;                  //回上頁
	private String top;                   //回頁首
	private String islevel;               //目錄層次
	private String toplevelcontent;       //上一層級目錄名稱
	private String islevelcontent;        //目錄名稱
	private String flag;                  //網頁屬性
	private String ownplate;              //自行編輯網頁上傳
	private String commonplate;           //使用網頁版型
	private String ownplatepage;          //自行編輯網頁(靜態網頁)
	private String commonplatepage;       //使用網頁版型(靜態網頁)
	private String develprogram;          //動態程式
	private String hyperlink;             //超連結
	private String isnothing;             //無
	private String fsort;                 //排序
	private String startusing;            //啟用
	private String islevellink;           //連結	
	private String upload1;               //檔案上傳(1)
	private String expfile1;              //檔案說明(1)
	private String reset;                 //重設
	private String yes;                   //是
	private String no;                    //否
	private String serno;                 //序號
	private String pubunitdn;             //發布單位DN
	private String pubunitname;           //發布單位名稱
	private String websitedn;             //使用站台DN
	private String websitename;           //使用站台名稱
	private String classname;             //分類名稱
	private String fclassname;            //主分類名稱
	private String sclassname;            //次分類名稱
	private String postname;              //最後更新者姓名
	private String createdate;            //建檔日期
	private String updatedate;            //更新日期
	private String publishapname;         //多向發布應用系統名稱
	private String subject;               //標題
	private String secsubject;            //副標題
	private String content;               //詳細內容
	private String posterdate;            //發布日期
	private String closedate;             //截止日期
	private String perpetual;             //永久有效
	private String resetfsort;            //排序重整
	private String relateurl;             //相關資訊連結
	private String relatename;            //相關資訊連結名稱
	private String docfile;               //文件檔案
	private String imgfile;               //圖片檔案
	private String mediafile;             //影音檔案
	private String piclibrary;            //引用圖庫
	private String cancel;                //取消
	private String show;                  //顯示
	private String webname;               //請輸入網站名稱
	private String websitedata;           //發布站台設定
	private String examine;               //審核狀態
	private String aplistname;            //應用系統名稱
	private String dataexamine;           //資料審核
	private String agree;                 //同意
	private String noagree;               //不同意
	private String bulletinno;            //公告字號
	private String bulletinbasis;         //公文字號
	private String sponsorunit;           //主辦單位
	private String assistunit;            //協辦單位
	private String actsdate;              //活動日期(起)
	private String actstime;              //活動時間(起)
	private String actedate;              //活動日期(迄)
	private String actetime;              //活動時間(迄)
	private String actplace;              //活動地點
	private String name;                  //聯絡人
	private String tel;                   //聯絡電話
	private String fax;                   //傳真號碼
	private String email;                 //電子信箱
	private String onlinesign;            //是否提供線上報名
	private String islimitnum;            //是否有名額限制
	private String limitnum;              //名額限制
	private String signupnum;             //報名人數
	private String showtop;               //置頂
	private String question;              //問題
	private String answer;                //解答
	private String url;                   //網址

	public String getPiclibrary() {
		return piclibrary;
	}
	public void setPiclibrary(String piclibrary) {
		this.piclibrary = piclibrary;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getResetfsort() {
		return resetfsort;
	}
	public void setResetfsort(String resetfsort) {
		this.resetfsort = resetfsort;
	}
	public String getPerpetual() {
		return perpetual;
	}
	public void setPerpetual(String perpetual) {
		this.perpetual = perpetual;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getIsnothing() {
		return isnothing;
	}
	public void setIsnothing(String isnothing) {
		this.isnothing = isnothing;
	}
	public String getShowtop() {
		return showtop;
	}
	public void setShowtop(String showtop) {
		this.showtop = showtop;
	}
	public String getFclassname() {
		return fclassname;
	}
	public void setFclassname(String fclassname) {
		this.fclassname = fclassname;
	}
	public String getSclassname() {
		return sclassname;
	}
	public void setSclassname(String sclassname) {
		this.sclassname = sclassname;
	}
	public String getShow() {
		return show;
	}
	public void setShow(String show) {
		this.show = show;
	}
	public String getActedate() {
		return actedate;
	}
	public void setActedate(String actedate) {
		this.actedate = actedate;
	}
	public String getActetime() {
		return actetime;
	}
	public void setActetime(String actetime) {
		this.actetime = actetime;
	}
	public String getActplace() {
		return actplace;
	}
	public void setActplace(String actplace) {
		this.actplace = actplace;
	}
	public String getActsdate() {
		return actsdate;
	}
	public void setActsdate(String actsdate) {
		this.actsdate = actsdate;
	}
	public String getActstime() {
		return actstime;
	}
	public void setActstime(String actstime) {
		this.actstime = actstime;
	}
	public String getAssistunit() {
		return assistunit;
	}
	public void setAssistunit(String assistunit) {
		this.assistunit = assistunit;
	}
	public String getBulletinbasis() {
		return bulletinbasis;
	}
	public void setBulletinbasis(String bulletinbasis) {
		this.bulletinbasis = bulletinbasis;
	}
	public String getBulletinno() {
		return bulletinno;
	}
	public void setBulletinno(String bulletinno) {
		this.bulletinno = bulletinno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getIslimitnum() {
		return islimitnum;
	}
	public void setIslimitnum(String islimitnum) {
		this.islimitnum = islimitnum;
	}
	public String getLimitnum() {
		return limitnum;
	}
	public void setLimitnum(String limitnum) {
		this.limitnum = limitnum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOnlinesign() {
		return onlinesign;
	}
	public void setOnlinesign(String onlinesign) {
		this.onlinesign = onlinesign;
	}
	public String getSignupnum() {
		return signupnum;
	}
	public void setSignupnum(String signupnum) {
		this.signupnum = signupnum;
	}
	public String getSponsorunit() {
		return sponsorunit;
	}
	public void setSponsorunit(String sponsorunit) {
		this.sponsorunit = sponsorunit;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAgree() {
		return agree;
	}
	public void setAgree(String agree) {
		this.agree = agree;
	}
	public String getNoagree() {
		return noagree;
	}
	public void setNoagree(String noagree) {
		this.noagree = noagree;
	}
	public String getDataexamine() {
		return dataexamine;
	}
	public void setDataexamine(String dataexamine) {
		this.dataexamine = dataexamine;
	}
	public String getAplistname() {
		return aplistname;
	}
	public void setAplistname(String aplistname) {
		this.aplistname = aplistname;
	}
	public String getExamine() {
		return examine;
	}
	public void setExamine(String examine) {
		this.examine = examine;
	}
	public String getWebsitedata() {
		return websitedata;
	}
	public void setWebsitedata(String websitedata) {
		this.websitedata = websitedata;
	}
	public String getWebname() {
		return webname;
	}
	public void setWebname(String webname) {
		this.webname = webname;
	}
	public String getCancel() {
		return cancel;
	}
	public void setCancel(String cancel) {
		this.cancel = cancel;
	}
	public String getDocfile() {
		return docfile;
	}
	public void setDocfile(String docfile) {
		this.docfile = docfile;
	}
	public String getImgfile() {
		return imgfile;
	}
	public void setImgfile(String imgfile) {
		this.imgfile = imgfile;
	}
	public String getMediafile() {
		return mediafile;
	}
	public void setMediafile(String mediafile) {
		this.mediafile = mediafile;
	}
	public String getRelatename() {
		return relatename;
	}
	public void setRelatename(String relatename) {
		this.relatename = relatename;
	}
	public String getPublishapname() {
		return publishapname;
	}
	public void setPublishapname(String publishapname) {
		this.publishapname = publishapname;
	}
	public String getCommonplatepage() {
		return commonplatepage;
	}
	public void setCommonplatepage(String commonplatepage) {
		this.commonplatepage = commonplatepage;
	}
	public String getDevelprogram() {
		return develprogram;
	}
	public void setDevelprogram(String develprogram) {
		this.develprogram = develprogram;
	}
	public String getOwnplatepage() {
		return ownplatepage;
	}
	public void setOwnplatepage(String ownplatepage) {
		this.ownplatepage = ownplatepage;
	}
	public String getCommonplate() {
		return commonplate;
	}
	public void setCommonplate(String commonplate) {
		this.commonplate = commonplate;
	}
	public String getHyperlink() {
		return hyperlink;
	}
	public void setHyperlink(String hyperlink) {
		this.hyperlink = hyperlink;
	}
	public String getOwnplate() {
		return ownplate;
	}
	public void setOwnplate(String ownplate) {
		this.ownplate = ownplate;
	}
	public String getClassname() {
		return classname;
	}
	public void setClassname(String classname) {
		this.classname = classname;
	}
	public String getClosedate() {
		return closedate;
	}
	public void setClosedate(String closedate) {
		this.closedate = closedate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	public String getPosterdate() {
		return posterdate;
	}
	public void setPosterdate(String posterdate) {
		this.posterdate = posterdate;
	}
	public String getPostname() {
		return postname;
	}
	public void setPostname(String postname) {
		this.postname = postname;
	}
	public String getPubunitdn() {
		return pubunitdn;
	}
	public void setPubunitdn(String pubunitdn) {
		this.pubunitdn = pubunitdn;
	}
	public String getPubunitname() {
		return pubunitname;
	}
	public void setPubunitname(String pubunitname) {
		this.pubunitname = pubunitname;
	}
	public String getRelateurl() {
		return relateurl;
	}
	public void setRelateurl(String relateurl) {
		this.relateurl = relateurl;
	}
	public String getSecsubject() {
		return secsubject;
	}
	public void setSecsubject(String secsubject) {
		this.secsubject = secsubject;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getWebsitedn() {
		return websitedn;
	}
	public void setWebsitedn(String websitedn) {
		this.websitedn = websitedn;
	}
	public String getWebsitename() {
		return websitename;
	}
	public void setWebsitename(String websitename) {
		this.websitename = websitename;
	}
	public String getDataadd() {
		return dataadd;
	}
	public void setDataadd(String dataadd) {
		this.dataadd = dataadd;
	}
	public String getDatamdy() {
		return datamdy;
	}
	public void setDatamdy(String datamdy) {
		this.datamdy = datamdy;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getYes() {
		return yes;
	}
	public void setYes(String yes) {
		this.yes = yes;
	}
	public String getBack() {
		return back;
	}
	public void setBack(String back) {
		this.back = back;
	}
	public String getReset() {
		return reset;
	}
	public void setReset(String reset) {
		this.reset = reset;
	}
	public String getUpload1() {
		return upload1;
	}
	public void setUpload1(String upload1) {
		this.upload1 = upload1;
	}
	public String getAdd() {
		return add;
	}
	public void setAdd(String add) {
		this.add = add;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getExpfile1() {
		return expfile1;
	}
	public void setExpfile1(String expfile1) {
		this.expfile1 = expfile1;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getFsort() {
		return fsort;
	}
	public void setFsort(String fsort) {
		this.fsort = fsort;
	}
	public String getIslevel() {
		return islevel;
	}
	public void setIslevel(String islevel) {
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
	public String getMdy() {
		return mdy;
	}
	public void setMdy(String mdy) {
		this.mdy = mdy;
	}
	public String getQry() {
		return qry;
	}
	public void setQry(String qry) {
		this.qry = qry;
	}
	public String getSave() {
		return save;
	}
	public void setSave(String save) {
		this.save = save;
	}
	public String getStartusing() {
		return startusing;
	}
	public void setStartusing(String startusing) {
		this.startusing = startusing;
	}
	public String getTop() {
		return top;
	}
	public void setTop(String top) {
		this.top = top;
	}
	public String getToplevelcontent() {
		return toplevelcontent;
	}
	public void setToplevelcontent(String toplevelcontent) {
		this.toplevelcontent = toplevelcontent;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getUpload() {
		return upload;
	}
	public void setUpload(String upload) {
		this.upload = upload;
	}

	public Language(String filename){
		Properties mess = new Properties();
		try {
			mess.load(new FileInputStream(filename) );
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
		} catch (IOException e) {
			// TODO Auto-generated catch block
		}
		
		this.add = mess.getProperty("add");		
		this.mdy = mess.getProperty("mdy"); 
		this.qry = mess.getProperty("qry"); 
		this.del = mess.getProperty("del");
		this.save = mess.getProperty("save"); 
		this.dataadd = mess.getProperty("dataadd"); 
		this.datamdy = mess.getProperty("datamdy"); 
		this.upload = mess.getProperty("upload");
		this.back = mess.getProperty("back");
		this.top = mess.getProperty("top");
		this.islevel = mess.getProperty("islevel");
		this.toplevelcontent = mess.getProperty("toplevelcontent");
		this.islevelcontent = mess.getProperty("islevelcontent");
		this.flag = mess.getProperty("flag");
		this.ownplate = mess.getProperty("ownplate");
		this.commonplate = mess.getProperty("commonplate");
		this.ownplatepage = mess.getProperty("ownplatepage");
		this.commonplatepage = mess.getProperty("commonplatepage");
		this.develprogram = mess.getProperty("develprogram");
		this.hyperlink = mess.getProperty("hyperlink");
		this.isnothing = mess.getProperty("isnothing");
		this.fsort = mess.getProperty("fsort");
		this.startusing = mess.getProperty("startusing");
		this.islevellink = mess.getProperty("islevellink");
		this.updatedate = mess.getProperty("updatedate");
		this.upload1 = mess.getProperty("upload1");
		this.expfile1 = mess.getProperty("expfile1");
		this.reset = mess.getProperty("reset");
		this.yes = mess.getProperty("yes");
		this.no = mess.getProperty("no");		
		this.serno = mess.getProperty("serno");
		this.pubunitdn = mess.getProperty("pubunitdn");
		this.pubunitname = mess.getProperty("pubunitname");
		this.websitedn = mess.getProperty("websitedn");
		this.websitename = mess.getProperty("websitename");
		this.classname = mess.getProperty("classname");
		this.fclassname = mess.getProperty("fclassname");
		this.sclassname = mess.getProperty("sclassname");
		this.postname = mess.getProperty("postname");
		this.createdate = mess.getProperty("createdate");
		this.updatedate = mess.getProperty("updatedate");
		this.publishapname = mess.getProperty("publishapname");
		this.subject = mess.getProperty("subject");
		this.secsubject = mess.getProperty("secsubject");
		this.content = mess.getProperty("content");
		this.posterdate = mess.getProperty("posterdate");
		this.closedate = mess.getProperty("closedate");
		this.perpetual = mess.getProperty("perpetual");
		this.resetfsort = mess.getProperty("resetfsort");
		this.relateurl = mess.getProperty("relateurl");
		this.relatename = mess.getProperty("relatename");
		this.docfile = mess.getProperty("docfile");
		this.imgfile = mess.getProperty("imgfile");
		this.mediafile = mess.getProperty("mediafile");
		this.piclibrary = mess.getProperty("piclibrary");
		this.cancel = mess.getProperty("cancel");
		this.show = mess.getProperty("show");
		this.webname = mess.getProperty("webname");
		this.websitedata = mess.getProperty("websitedata");
		this.examine = mess.getProperty("examine");
		this.aplistname = mess.getProperty("aplistname");
		this.dataexamine = mess.getProperty("dataexamine");
		this.agree = mess.getProperty("agree");
		this.noagree = mess.getProperty("noagree");
		this.bulletinno = mess.getProperty("bulletinno");
		this.bulletinbasis = mess.getProperty("bulletinbasis");
		this.sponsorunit = mess.getProperty("sponsorunit");
		this.assistunit = mess.getProperty("assistunit");
		this.actsdate = mess.getProperty("actsdate");
		this.actstime = mess.getProperty("actstime");
		this.actedate = mess.getProperty("actedate");
		this.actetime = mess.getProperty("actetime");
		this.actplace = mess.getProperty("actplace");
		this.name = mess.getProperty("name");
		this.tel = mess.getProperty("tel");
		this.fax = mess.getProperty("fax");
		this.email = mess.getProperty("email");
		this.onlinesign = mess.getProperty("onlinesign");
		this.islimitnum = mess.getProperty("islimitnum");
		this.limitnum = mess.getProperty("limitnum");
		this.signupnum = mess.getProperty("signupnum");
		this.showtop = mess.getProperty("showtop");
		this.question = mess.getProperty("question");
		this.answer = mess.getProperty("answer");
		this.url = mess.getProperty("url");
	}
	
}
