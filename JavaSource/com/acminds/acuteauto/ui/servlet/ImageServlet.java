package com.acminds.acuteauto.ui.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.acminds.acuteauto.persistence.BaseDAO;
import com.acminds.acuteauto.persistence.dto.Image;
import com.acminds.acuteauto.utils.Utils;

/**
 * 
 * @author MANSUR
 *
 */
public class ImageServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
	 * mime types:
	 * image/bmp
	 * image/gif
	 * image/jpeg
	 * image/png
	 * 
	 * image/tiff
	 * image/svg
	 */
	private Log logger = LogFactory.getLog(ImageServlet.class);
	
	
	public void init() throws ServletException {
		super.init();
		logger.info("Image rendering servlet initialized");
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		try {
			String imageId = request.getParameter("imgId");
			if(Utils.isEmpty(imageId))
				return;
			Image image = new BaseDAO().get(Image.class, Integer.valueOf(imageId));
			if(image == null)
			{
				response.getWriter().print("No image [" + imageId + 
						"] found");
				response.setContentType("text/plain");
				return;
			}
			response.setContentType(image.getMimeType());
		//	response.setContentType("image/jpg");
			OutputStream out = response.getOutputStream();
		//	out.write(IOUtils.toByteArray(new FileInputStream(new File("/acuteauto/images/slide1.jpg"))));
			out.write(IOUtils.toByteArray(new FileInputStream(new File(image.getImageLocation()))));
		} catch (NumberFormatException e) {
			logger.error(e.getMessage(), e);
			throw new ServletException(e);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
			throw new ServletException(e);
		}
	}
	
	protected void doPost(HttpServletRequest arg0, HttpServletResponse arg1) 
		throws ServletException, IOException 
	{
		doGet(arg0, arg1);
	}
}