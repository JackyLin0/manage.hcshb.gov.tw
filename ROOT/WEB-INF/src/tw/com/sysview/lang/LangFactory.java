/*
 * 撰寫日期：2007/2/12
 * 程式名稱：LangFactory.java
 * 功能：語系
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.lang;

public class LangFactory {

	private static LangFactory langFactory = null;
	
	private Language ch;
	private Language en;
	private Language jp;
	
	private LangFactory(String path){
		//判斷OS版本
		String Lang_PATH = "";
		if ( path.indexOf("/") == -1 )
			Lang_PATH = path + "\\WEB-INF\\fchinese.properties";
		else
			Lang_PATH = path + "/WEB-INF/fchinese.properties";

		this.ch = new Language(Lang_PATH);
		//this.en = new Language(path+ "\\WEB-INF\\english.properties");
		this.en = new Language(Lang_PATH);
		//this.jp = new Language(path+ "\\WEB-INF\\japan.properties");
		this.jp = new Language(Lang_PATH);
	}
	
	public static LangFactory getInstance(String path){
		if(langFactory == null){
			langFactory = new LangFactory(path);
		}
		
		return langFactory;
	}
	
	public Language getLanguage(String language){
		if(language.equals("en")){
			return en;
		}else if(language.equals("jp")){
			return jp;
		}else{
			return ch;
		}
	}
	
}
