/*
 * 撰寫日期：2007/6/2
 * 程式名稱：ImageMagick.java
 * 功能：
 * 撰寫者：張資梅
 */
 
package tw.com.sysview.upload;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import magick.ImageInfo;
import magick.MagickImage;


public class ImageMagick {	

    public void converImage( String imagesize, String sSourceFilename, String sDestFilename ) throws IOException {
    	
    	System.setProperty("jmagick.systemclassloader","no"); 
    	
    	try {
    		/*
    		ImageInfo info = new ImageInfo(sSourceFilename);
    		MagickImage image = new MagickImage(info);
    		if ( image.getColorspace() == 12 ) {
    			image.profileImage("ICM",loadProfile("C:\\Program Files\\ImageMagick-6.3.1-Q16\\config\\sRGB.icm"));
    		}
    		System.out.println(image.getColorspace());
    		*/

    		ImageMagickResize imagecli = new ImageMagickResize();
    		imagecli.resizeImage(sSourceFilename,sDestFilename,imagesize,"");
    		
    	}catch (Exception ex) {
        	System.out.println("error="+ex);
        }

    }
    
    public boolean check( String imageresize, String bigimage ) throws IOException {

    	System.setProperty("jmagick.systemclassloader","no"); 
    	
    	try {
    		
    		ImageInfo imageInfo = new ImageInfo();
        	imageInfo.setFileName(bigimage);
        	MagickImage miImage = new MagickImage(imageInfo);
        	if ( miImage.getDimension().width > Integer.parseInt(imageresize) ) {
        		return true;
        	}
        	
    	}catch (Exception ex) {
        	System.out.println("error="+ex);
        }
    	return false;
    }
    

    private static byte[] loadProfile(String s)throws IOException {

        FileInputStream fis = null;

        try {

            File f = new File(s);

            int len = (int)f.length();

            byte[] b = new byte[len];

            fis = new FileInputStream(s);

            int read = fis.read(b);

            if (read != len)

                throw new IOException("Unexcepted end of file");

            return b;

        } finally {

            if (fis != null)

                fis.close();

        }

    }
}
