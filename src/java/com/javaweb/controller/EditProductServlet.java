/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javaweb.controller;

import com.javaweb.model.Sanpham;
import com.javaweb.service.FileService;
import com.javaweb.service.ProductService;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Nguyễn Chí Tuấn
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 10,
        maxFileSize = 1024 * 1024 * 50,
        maxRequestSize = 1024 * 1024 * 100
)

public class EditProductServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads/";
    
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Fix lỗi tiếng việt
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String id = "";
        
        
        try {
            id = request.getParameter("idsp");
            ProductService ps = new ProductService();
            Sanpham sp = ps.GetSanPhamByID(id);
            
            String linkhinhanh = sp.getImage();
            sp.setTen(request.getParameter("tensanpham"));
            sp.setChucnang(request.getParameter("chucnang"));
            sp.setGia(Double.parseDouble(request.getParameter("gia")));
            sp.setGhichu(request.getParameter("mota"));
            try{
                sp.setImage(uploadFile(request,linkhinhanh));
            }catch(Exception e){
                sp.setImage(linkhinhanh);
            }
            
            boolean rs = ps.InsertProduct(sp);
            if(rs){
                response.sendRedirect("products.jsp");
            }   
        } catch (NumberFormatException  e) {
            System.out.println(e.toString());
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
    private String uploadFile(HttpServletRequest request,String image) throws IOException, ServletException {
        String fileName = "";
        try {
            Part filePart = request.getPart("photo");
            
            //fileName: picture-001.jpg
            fileName = (String) getFileName(filePart);
            fileName = FileService.ChangeFileName(fileName);
            //applicationPath: C:\Users\Lonely\Documents\NetBeansProjects\Shop_Bonfire\build\web
            String applicationPath = request.getServletContext().getRealPath("");

            //File.separator: \ 
            String basePath = applicationPath + File.separator + UPLOAD_DIR + File.separator;

            InputStream inputStream = null;
            OutputStream outputStream = null;
            try {
                File outputFilePath = new File(basePath + fileName);
                inputStream = filePart.getInputStream();
                outputStream = new FileOutputStream(outputFilePath);
                int read = 0;
                final byte[] bytes = new byte[1024];
                while ((read = inputStream.read(bytes)) != -1) {
                    outputStream.write(bytes, 0, read);
                }
            } catch (Exception e) {
                e.printStackTrace();
                fileName = "";
            } finally {
                if (inputStream != null) {
                    inputStream.close();
                }
                if (outputStream != null) {
                    outputStream.close();
                }
            }
        } catch (Exception e) {
            fileName = "";
        }
        if(fileName=="")
            return image;
        return fileName;
    }

    private String getFileName(Part part) {
        final String partHeader = part.getHeader("content-disposition");
        System.out.println("*****partHeader :" + partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
    
}
