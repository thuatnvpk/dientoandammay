/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javaweb.controller;

import com.javaweb.model.Users;
import com.javaweb.service.FileService;
import com.javaweb.service.UserService;
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
public class EditUserServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads/";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String id = "";
        
        try {
            id = request.getParameter("IdUser");
            UserService us = new UserService();
            Users user = us.GetUserByIdUser(id);
            
            String linkhinhanh = user.getAvatar();
            user.setFullName(request.getParameter("Fullname"));
            user.setEmail(request.getParameter("email"));
            user.setUserName(request.getParameter("username"));
            user.setGender(request.getParameter("Gender"));
            try {
                user.setAvatar(uploadFile(request, linkhinhanh));
            }catch(Exception ex){
                user.setAvatar(linkhinhanh);
            }
            
            boolean kiemTra = us.InsertUser(user);
            if(kiemTra){
                response.sendRedirect("usermanagement.jsp");
            }
            
        } catch (NumberFormatException  e) {
            System.out.println(e.toString());
        }
        
        
        
        
        
        
//        String FullName,Email,UserName,GenDer,birthday,ID;
//        
//        ID = request.getParameter("IdUser");
//        FullName = request.getParameter("Fullname");
//        Email = request.getParameter("email");
//        UserName = request.getParameter("username");
//        GenDer = request.getParameter("Gender");
//        
//        boolean gt = true;
//        if (GenDer.equals("0")) {
//            gt = false;
//        }
//        
//        
//        
//        HttpSession session = request.getSession();
//        session.removeAttribute("errorreg");
//        
//        UserService us = new UserService();
//        Users user = us.GetUserByIdUser(ID);
//        
//        user.setFullName(FullName);
//        user.setEmail(Email);
//        user.setUserName(UserName);
//        user.setGender(gt);
//
//        
//        boolean kiemTra = us.InsertUser(user);
//        if(kiemTra){
//            response.sendRedirect("usermanagement.jsp");
//        }      
        
        
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet EditUserServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet EditUserServlet at " + FullName + Email + gt + birthday + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
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
    }// </editor-fold>

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
