package tw.com.sysview.upload;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

public class ImageMagickResize {
	
	public int resizeImageByPercent(String src, String dst, String percent) {

		try {
			String[] cmd = new String[5];
			//cmd[0] = "C:\\Program Files\\ImageMagick-6.3.1-Q16\\convert.exe";
			//for linux
			cmd[0] = "/usr/bin/convert";
			cmd[1] = "-resize";
			cmd[2] = percent;
			cmd[3] = src;
			cmd[4] = dst;

			Runtime rt = Runtime.getRuntime();
			
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