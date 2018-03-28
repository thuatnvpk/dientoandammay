/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javaweb.controller;

import com.javaweb.model.Users;
import com.javaweb.service.FileService;
import com.javaweb.service.UserService;
import com.javaweb.service.md5;
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
import javax.servlet.http.HttpSession;
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
public class RegisterServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads/";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            String email, username, password, repassword, fullname,gioitinh,image;
            
            email = request.getParameter("email");
            username = request.getParameter("username");
            password = request.getParameter("pwd");
            repassword = request.getParameter("repwd");
            fullname = request.getParameter("fullname");
            gioitinh = request.getParameter("gioitinh");
            image = uploadFile(request);
            
            HttpSession session = request.getSession();
            
            UserService userService = new UserService();
            
            String matKhauMaHoa = md5.md5Encryption(password);
            
            Users user = new Users();
            user.setUserName(username);
            user.setEmail(email);
            user.setPwd(matKhauMaHoa);
            user.setFullName(fullname);
            user.setGender(gioitinh);
            user.setAvatar(uploadFile(request));
            
            if (!password.equals(repassword)) {
            session.setAttribute("errormsg", "Nhập lại mật khẩu không đúng!");
            response.sendRedirect("register.jsp");
            } else if (username.length() < 4) {
                session.setAttribute("errormsg", "Username phải lớn hơn 4 ký tự!");
                response.sendRedirect("register.jsp");
            } else if(userService.CheckUserIsExist(user)){
                session.setAttribute("errormsg", "Tài khoản đã tồn tại. Vui lòng nhập email và usename khác!");
                response.sendRedirect("register.jsp");
            }
            else {
                userService.InsertUser(user);
                String url = "/trangchu.jsp";
                getServletContext().getRequestDispatcher(url).forward(request, response);
            }
        } catch (IOException | ServletException e) {
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

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private String uploadFile(HttpServletRequest request) throws IOException, ServletException {
        String fileName = "";
        try {
            Part filePart = request.getPart("photo");
            
            //fileName: picture-001.jpg
            fileName = (String) getFileName(filePart);
            
            //applicationPath: C:\Users\Lonely\Documents\NetBeansProjects\Shop_Bonfire\build\web
            String applicationPath = request.getServletContext().getRealPath("");
            fileName = FileService.ChangeFileName(fileName);
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
