package tw.com.sysview.upload;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

public class ImageMagickCli {

	public static void main(String[] args) {
		ImageMagickCli imagecli=new ImageMagickCli();
		String src="D:\\hsinchu\\downfile\\pic\\pubhsinchu\\activityphoto\\200706071427530.JPG";
		
		String dst="D:\\hsinchu\\downfile\\pic\\pubhsinchu\\activityphoto\\200706071427530s1.JPG";
		String percent="10%";
		imagecli.resizeImageByPercent(src, dst, percent);
		
		String dst2="D:\\hsinchu\\downfile\\pic\\pubhsinchu\\activityphoto\\200706071427530s2.JPG";
		String x="200";
		String y="100";
		imagecli.resizeImage(src, dst2, x, y);
	}

	public int resizeImageByPercent(String src, String dst, String percent) {

		try {
			String[] cmd = new String[5];
			cmd[0] = "C:\\Program Files\\ImageMagick-6.3.1-Q16\\convert.exe";
			cmd[1] = "-resize";
			cmd[2] = percent;
			cmd[3] = src;
			cmd[4] = dst;

			Runtime rt = Runtime.getRuntime();
			System.out.println("Execing " + cmd[0] + " " + cmd[1] + " " + cmd[2] + " " + cmd[3]
					+ " " + cmd[4]);
			Process proc = rt.exec(cmd);
			// any error message?
			StreamGobbler errorGobbler = new StreamGobbler(proc.getErrorStream(), "ERROR");

			// any output?
			StreamGobbler outputGobbler = new StreamGobbler(proc.getInputStream(), "OUTPUT");

			// kick them off
			errorGobbler.start();
			outputGobbler.start();

			int exitVal = proc.waitFor();
			System.out.println("ExitValue: " + exitVal);

			return 1;
		} catch (Throwable t) {
			t.printStackTrace();
			return -1;
		}
	}

	public int resizeImage(String src, String dst, String x, String y) {

		try {
			String[] cmd = new String[5];
			cmd[0] = "C:\\Program Files\\ImageMagick-6.3.1-Q16\\convert.exe";
			cmd[1] = "-resize";
			cmd[2] = x + "x" + y;
			cmd[3] = src;
			cmd[4] = dst;

			Runtime rt = Runtime.getRuntime();
			System.out.println("Execing " + cmd[0] + " " + cmd[1] + " " + cmd[2] + " " + cmd[3]
					+ " " + cmd[4]);
			Process proc = rt.exec(cmd);
			// any error message?
			StreamGobbler errorGobbler = new StreamGobbler(proc.getErrorStream(), "ERROR");

			// any output?
			StreamGobbler outputGobbler = new StreamGobbler(proc.getInputStream(), "OUTPUT");

			// kick them off
			errorGobbler.start();
			outputGobbler.start();

			int exitVal = proc.waitFor();
			System.out.println("ExitValue: " + exitVal);

			return 1;
		} catch (Throwable t) {
			t.printStackTrace();
			return -1;
		}
	}

	class StreamGobbler extends Thread {
		InputStream is;

		String type;

		StreamGobbler(InputStream is, String type) {
			this.is = is;
			this.type = type;
		}

		public void run() {
			InputStreamReader isr = null;
			BufferedReader br = null;
			try {
				isr = new InputStreamReader(is);
				br = new BufferedReader(isr);
				String line = null;
				while ((line = br.readLine()) != null) {
					System.out.println(type + ">" + line);
				}

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (br != null) {
					try {
						br.close();
					} catch (Exception e2) {
						e2.printStackTrace();
					}
				}
				if (isr != null) {
					try {
						isr.close();
					} catch (Exception e2) {
						e2.printStackTrace();

					}
				}
			}
		}
	}
}