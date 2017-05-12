/*
 * 撰寫日期：2007/3/23
 * 程式名稱：FLangFactory.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.lang;

public class FLangFactory {

	private static FLangFactory flangFactory = null;
	
	private FLanguage ch;
	private FLanguage en;
	private FLanguage jp;
	
	private FLangFactory(String path){
		//判斷OS版本
		String Lang_PATH = "";
		if ( path.indexOf("/") == -1 )
			Lang_PATH = path + "\\WEB-INF\\fchinese.properties";
		else
			Lang_PATH = path + "/WEB-INF/fchinese.properties";

		this.ch = new FLanguage(Lang_PATH);
		//this.en = new Language(path+ "\\WEB-INF\\fenglish.properties");
		//this.jp = new Language(path+ "\\WEB-INF\\fjapan.properties");
	}
	
	public static FLangFactory getInstance(String path){
		if(flangFactory == null){
			flangFactory = new FLangFactory(path);
		}
		
		return flangFactory;
	}
	
	public FLanguage getFLanguage(String language){
		if(language.equals("en")){
			return en;
		}else if(language.equals("jp")){
			return jp;
		}else{
			return ch;
		}
	}
	
}
