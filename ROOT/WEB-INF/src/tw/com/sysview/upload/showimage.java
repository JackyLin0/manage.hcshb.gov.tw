/*
 * 撰寫日期：2008/1/4
 * 程式名稱：BShowImageData.java
 * 功能：民眾端即時算出縮圖
 * 撰寫者：
 */
 
package tw.com.sysview.upload;

import javax.servlet.*;
import javax.servlet.http.*;

import tw.com.sysview.downdoc.svList;

import java.io.*;
import java.util.Properties;
import java.awt.*;
import java.awt.image.*;
import com.sun.image.codec.jpeg.*;
 
public class showimage extends HttpServlet {
	
	  private static final String CONTENT_TYPE = "image/jpeg;charset=UTF-8";  
	  
	  //Initialize global variables
	  public void init() throws ServletException {
	  }
	 
	  //Process the HTTP Get request
	  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    ServletContext application = getServletContext();
    	String uriString=request.getParameter("file");
    	
    	String flag=request.getParameter("flag");
    	
		String sysRoot=(String) application.getRealPath("");
		sysRoot = sysRoot.replace('\\','/');
		
		//判斷OS版本
		String PRO_PATH = "";
		if ( sysRoot.indexOf("/") == -1 )
			PRO_PATH = sysRoot+"\\WEB-INF\\uploadpath.properties";
		else
			PRO_PATH = sysRoot+"/WEB-INF/uploadpath.properties";

		Properties p = new Properties();
        p.load(new FileInputStream(PRO_PATH)) ;
        
        String filefolder = "";
        if ( flag.equals("doc") ) {
        	filefolder=p.getProperty("filepath");
        }else if ( flag.equals("pic") ) {
        	filefolder=p.getProperty("picpath");
        }else if ( flag.equals("media") ) {
        	filefolder=p.getProperty("mediapath");
        }else if ( flag.equals("epaper") ) {
        	filefolder=p.getProperty("epaperpath");
        }
        
	    double w = 0.00;
	    double h = 0.00;
	    String wStr = request.getParameter("w");
	    if (wStr == null) {
	      wStr = "0";
	    }
	    String hStr = request.getParameter("h");
	    if (hStr == null) {
	      hStr = "0";
	    }
	    w = Double.parseDouble(wStr);
	    h = Double.parseDouble(hStr);
	 
	    String file = svList.replace(filefolder,"\\","/")+uriString;
	    
	 
	    ServletOutputStream output=response.getOutputStream();
	 
	    response.setContentType(CONTENT_TYPE);
	 
	    String imageFile = ""+file;
	    InputStream imageIn = new FileInputStream(new File(imageFile));
	    JPEGImageDecoder decoder = JPEGCodec.createJPEGDecoder(imageIn);
	    BufferedImage image = decoder.decodeAsBufferedImage();
	    image = resizeAWTs(image, w, h);
	    JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(output);
	    encoder.encode(image);
	 
	    imageIn.close();
	    output.close();
	  }
	 
	  //Process the HTTP Post request
	  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    try {
	      doGet(request,response);
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	  }
	  //Clean up resources
	  public void destroy() {
	  }
	 
	  //Resize Image
	  public BufferedImage resizeAWTs(BufferedImage src, double width, double hight) {
	      double factorX = 1.00;
	      double factorY = 1.00;
	      int w = src.getWidth();
	      double wD = Double.parseDouble(""+w);
	      int h = src.getHeight();
	      double hD = Double.parseDouble(""+h);
	      factorX = width / wD;
	      if (factorX>1) factorX=1;
	      factorY = hight / hD;
	      if (factorY>1) factorY=1;
	      if (factorX<factorY) {
	        factorY = factorX;
	      } else {
	        factorX = factorY;
	      }
	      int newW = (int)(Math.floor(factorX * w));
	      int newH = (int)(Math.floor(factorY * h));
	      Image temp = src.getScaledInstance(newW, newH, Image.SCALE_AREA_AVERAGING);
	      BufferedImage tgt = createBlankImage(src, newW, newH);
	      Graphics2D g = tgt.createGraphics();
	      g.drawImage(temp, 0, 0, null);
	      g.dispose();
	      return tgt;
	  }
	 
	  //Uses image to create another image of the same "type", but of a factored size
	  public BufferedImage createBlankImage(BufferedImage src, int w, int h) {
	      int type = src.getType();
	      if (type != BufferedImage.TYPE_CUSTOM)
	          return new BufferedImage(w, h, type);
	      else {
	          ColorModel cm = src.getColorModel();
	          WritableRaster raster = src.getRaster().createCompatibleWritableRaster(w, h);
	          boolean isRasterPremultiplied = src.isAlphaPremultiplied();
	          return new BufferedImage(cm, raster, isRasterPremultiplied, null);
	      }
	  }
}
