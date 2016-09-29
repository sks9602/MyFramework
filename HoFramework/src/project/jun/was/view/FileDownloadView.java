package project.jun.was.view;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.view.AbstractView;

import project.jun.was.HoSession;

public class FileDownloadView extends AbstractView {
	public static final String HO_FILE_DATA  = "project.jun.was.spring.FileDownloadView.FILE_DATA";

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        File file = (File) model.get(HO_FILE_DATA);
        
        response.setContentType(getContentType());
        response.setContentLength((int)file.length());
         
        String fileName = java.net.URLEncoder.encode(file.getName(), "UTF-8");
         
        response.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
         
        OutputStream out = response.getOutputStream();
        FileInputStream fis = null;

        // 파일이 없을 경우..
        if( file == null ) {
        	request.getSession().setAttribute( HoSession.STATUS_FILE_DOWNLOAD_PROGRESS , String.valueOf(-2));
        } else {
	        request.getSession().setAttribute( HoSession.STATUS_FILE_DOWNLOAD_PROGRESS + HoSession.FILE_NAME_SUFFIX , file.getName());
	        request.getSession().setAttribute( HoSession.STATUS_FILE_DOWNLOAD_PROGRESS + "_TOTAL" , String.valueOf(file.length()));
	
	        try {
	            fis = new FileInputStream(file);
	            
	    		try {
	    			int byteCount = 0;
	    			byte[] buffer = new byte[4096];
	    			int bytesRead = -1;
	
	    			while ((bytesRead = fis.read(buffer)) != -1) {
	    				out.write(buffer, 0, bytesRead);
	    				byteCount += bytesRead;
	    				
	    				request.getSession().setAttribute( HoSession.STATUS_FILE_DOWNLOAD_PROGRESS + "_DOWNLOAD" , String.valueOf(byteCount));
	    				request.getSession().setAttribute( HoSession.STATUS_FILE_DOWNLOAD_PROGRESS , String.valueOf(Math.round(((long) byteCount)*100/file.length())));
	    			}
    				request.getSession().setAttribute( HoSession.STATUS_FILE_DOWNLOAD_PROGRESS + "_DOWNLOAD" , String.valueOf(file.length()));
	    			request.getSession().setAttribute( HoSession.STATUS_FILE_DOWNLOAD_PROGRESS , String.valueOf(100));
	    			out.flush();
	    		} finally {
	    			try {
	    				fis.close();
	    			} catch (IOException localIOException3) {
	    			}
	    			try {
	    				out.close();
	    			} catch (IOException localIOException4) {
	    			}
	    		}
	
	    		
	        } catch (Exception e) {
				request.getSession().setAttribute( HoSession.STATUS_FILE_DOWNLOAD_PROGRESS , String.valueOf(-1));
	            e.printStackTrace();
	        } finally {
	            if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
	        }
	        out.flush();
        }
	}

}
