/*
 * 撰寫日期：2007/3/23
 * 程式名稱：FLanguage.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.lang;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class FLanguage {
	private String upload1 = null;             //檔案上傳(1)
	private String expfile1 = null;            //檔案說明(1)
	private String upload2 = null;             //檔案上傳(2)
	private String expfile2 = null;            //檔案上傳(2)
	private String upload3 = null;             //檔案上傳(3)
	private String expfile3 = null;            //檔案上傳(4)
	private String filename = null;            //檔案名稱
	private String fileexp = null;             //檔案說明
	private String upload = null;              //上傳
	private String del = null;                 //刪除
	private String save = null;                //儲存
	private String back = null;                //回上頁
	private String cancel = null;              //取消
	private String top = null;                 //回頁首
	private String uploadpic1 = null;          //圖片上傳(1)
	private String exppic1 = null;             //圖片說明(1)
	private String uploadpic2 = null;          //圖片上傳(2)
	private String exppic2 = null;             //圖片說明(2)
	private String uploadpic3 = null;          //圖片上傳(3)
	private String exppic3 = null;             //圖片說明(3)
	private String uploadpic4 = null;          //圖片上傳(4)
	private String exppic4 = null;             //圖片說明(4)
	private String picname = null;             //圖片
	private String picexp = null;              //圖片說明
	private String mainimage = null;           //主圖設定
	private String close = null;               //關閉視窗
	private String preview = null;             //預覽圖
	private String exppreview = null;          //預覽圖說明
	private String mediafile = null;           //media檔案
	private String expmedia = null;            //media檔案說明
	private String filemanage = null;          //檔案管理
	private String picmanage = null;           //圖片管理
	private String mediamanage = null;         //影音管理
	private String piclibrary = null;          //圖庫管理
	private String fileupload = null;          //檔案上傳
	private String picupload = null;           //圖片上傳
	private String mediaupload = null;         //影音上傳
	private String cancelpiclibrary = null;    //取消引用
	
	public String getCancelpiclibrary() {
		return cancelpiclibrary;
	}
	public void setCancelpiclibrary(String cancelpiclibrary) {
		this.cancelpiclibrary = cancelpiclibrary;
	}
	public String getPiclibrary() {
		return piclibrary;
	}
	public void setPiclibrary(String piclibrary) {
		this.piclibrary = piclibrary;
	}
	public String getExppic4() {
		return exppic4;
	}
	public void setExppic4(String exppic4) {
		this.exppic4 = exppic4;
	}
	public String getUploadpic4() {
		return uploadpic4;
	}
	public void setUploadpic4(String uploadpic4) {
		this.uploadpic4 = uploadpic4;
	}
	public String getMainimage() {
		return mainimage;
	}
	public void setMainimage(String mainimage) {
		this.mainimage = mainimage;
	}
	public String getPicexp() {
		return picexp;
	}
	public void setPicexp(String picexp) {
		this.picexp = picexp;
	}
	public String getPicname() {
		return picname;
	}
	public void setPicname(String picname) {
		this.picname = picname;
	}
	public String getExpmedia() {
		return expmedia;
	}
	public void setExpmedia(String expmedia) {
		this.expmedia = expmedia;
	}
	public String getExppreview() {
		return exppreview;
	}
	public void setExppreview(String exppreview) {
		this.exppreview = exppreview;
	}
	public String getFileupload() {
		return fileupload;
	}
	public void setFileupload(String fileupload) {
		this.fileupload = fileupload;
	}
	public String getMediaupload() {
		return mediaupload;
	}
	public void setMediaupload(String mediaupload) {
		this.mediaupload = mediaupload;
	}
	public String getPicupload() {
		return picupload;
	}
	public void setPicupload(String picupload) {
		this.picupload = picupload;
	}
	public String getFilemanage() {
		return filemanage;
	}
	public void setFilemanage(String filemanage) {
		this.filemanage = filemanage;
	}
	public String getMediamanage() {
		return mediamanage;
	}
	public void setMediamanage(String mediamanage) {
		this.mediamanage = mediamanage;
	}
	public String getPicmanage() {
		return picmanage;
	}
	public void setPicmanage(String picmanage) {
		this.picmanage = picmanage;
	}
	public String getFileexp() {
		return fileexp;
	}
	public void setFileexp(String fileexp) {
		this.fileexp = fileexp;
	}
	public String getBack() {
		return back;
	}
	public void setBack(String back) {
		this.back = back;
	}
	public String getCancel() {
		return cancel;
	}
	public void setCancel(String cancel) {
		this.cancel = cancel;
	}
	public String getClose() {
		return close;
	}
	public void setClose(String close) {
		this.close = close;
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
	public String getExpfile2() {
		return expfile2;
	}
	public void setExpfile2(String expfile2) {
		this.expfile2 = expfile2;
	}
	public String getExpfile3() {
		return expfile3;
	}
	public void setExpfile3(String expfile3) {
		this.expfile3 = expfile3;
	}
	public String getExppic1() {
		return exppic1;
	}
	public void setExppic1(String exppic1) {
		this.exppic1 = exppic1;
	}
	public String getExppic2() {
		return exppic2;
	}
	public void setExppic2(String exppic2) {
		this.exppic2 = exppic2;
	}
	public String getExppic3() {
		return exppic3;
	}
	public void setExppic3(String exppic3) {
		this.exppic3 = exppic3;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getMediafile() {
		return mediafile;
	}
	public void setMediafile(String mediafile) {
		this.mediafile = mediafile;
	}
	public String getPreview() {
		return preview;
	}
	public void setPreview(String preview) {
		this.preview = preview;
	}
	public String getSave() {
		return save;
	}
	public void setSave(String save) {
		this.save = save;
	}
	public String getTop() {
		return top;
	}
	public void setTop(String top) {
		this.top = top;
	}
	public String getUpload1() {
		return upload1;
	}
	public void setUpload1(String upload1) {
		this.upload1 = upload1;
	}
	public String getUpload() {
		return upload;
	}
	public void setUpload(String upload) {
		this.upload = upload;
	}
	public String getUpload2() {
		return upload2;
	}
	public void setUpload2(String upload2) {
		this.upload2 = upload2;
	}
	public String getUpload3() {
		return upload3;
	}
	public void setUpload3(String upload3) {
		this.upload3 = upload3;
	}
	public String getUploadpic1() {
		return uploadpic1;
	}
	public void setUploadpic1(String uploadpic1) {
		this.uploadpic1 = uploadpic1;
	}
	public String getUploadpic2() {
		return uploadpic2;
	}
	public void setUploadpic2(String uploadpic2) {
		this.uploadpic2 = uploadpic2;
	}
	public String getUploadpic3() {
		return uploadpic3;
	}
	public void setUploadpic3(String uploadpic3) {
		this.uploadpic3 = uploadpic3;
	}

	public FLanguage(String filename){
		Properties mess = new Properties();
		try {
			mess.load(new FileInputStream(filename) );
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
		} catch (IOException e) {
			// TODO Auto-generated catch block
		}
	
		this.upload1 = mess.getProperty("upload1");
		this.expfile1 = mess.getProperty("expfile1");
		this.upload2 = mess.getProperty("upload2");
		this.expfile2 = mess.getProperty("expfile2");
		this.upload3 = mess.getProperty("upload3");
		this.expfile3 = mess.getProperty("expfile3");
		this.filename = mess.getProperty("filename");
		this.fileexp = mess.getProperty("fileexp");
		this.upload = mess.getProperty("upload");
		this.del = mess.getProperty("del");
		this.save = mess.getProperty("save");
		this.back = mess.getProperty("back");
		this.cancel = mess.getProperty("cancel");
		this.top = mess.getProperty("top");
		this.uploadpic1 = mess.getProperty("uploadpic1");
		this.exppic1 = mess.getProperty("exppic1");
		this.uploadpic2 = mess.getProperty("uploadpic2");
		this.exppic2 = mess.getProperty("exppic2");
		this.uploadpic3 = mess.getProperty("uploadpic3");
		this.exppic3 = mess.getProperty("exppic3");
		this.uploadpic4 = mess.getProperty("uploadpic4");
		this.exppic4 = mess.getProperty("exppic4");
		this.picname = mess.getProperty("picname");
		this.picexp = mess.getProperty("picexp");
		this.mainimage = mess.getProperty("mainimage");
		this.close = mess.getProperty("close");
		this.preview = mess.getProperty("preview");
		this.exppreview = mess.getProperty("exppreview");
		this.mediafile = mess.getProperty("mediafile");
		this.expmedia = mess.getProperty("expmedia");
		this.filemanage = mess.getProperty("filemanage");
		this.picmanage = mess.getProperty("picmanage");
		this.mediamanage = mess.getProperty("mediamanage");
		this.piclibrary = mess.getProperty("piclibrary");
		this.fileupload = mess.getProperty("fileupload");
		this.picupload = mess.getProperty("picupload");
		this.mediaupload = mess.getProperty("mediaupload");
		this.cancelpiclibrary = mess.getProperty("cancelpiclibrary");
	}	

}
