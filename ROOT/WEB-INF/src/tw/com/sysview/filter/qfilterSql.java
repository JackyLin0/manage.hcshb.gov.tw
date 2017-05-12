/*
 * 撰寫日期：2007/7/15
 * 程式名稱：qfilterSql.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.filter;

public class qfilterSql {
	
	private String mcontent = null;
	
	public String getMcontent() {
		return mcontent;
	}

	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}

	//(&)轉成&amp，('')轉成&qout，(')轉成&#39，(<)轉成&lt，(>)轉成&gt
	public boolean filterSql( String mcintent1 ) {
		try {
			String chk[] = {"'","''",";",")","(","\""," or "," and ","%","<script>","</script>","</","<",">","*","&","update ","delete ","insert ","select ","&amp","&#37","&#39","&#40","&#41","&qout","&lt","&gt"};
			for ( int i=0; i<chk.length; i++ ) {
				while (mcintent1.indexOf(chk[i]) != -1)  {
					mcintent1 = mcintent1.replace(chk[i], "");
			    }
			}
			this.mcontent = mcintent1;
			return true;
			
		}finally{
			
		}
		
	}

}
