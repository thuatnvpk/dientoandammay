/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javaweb.controller;

import com.javaweb.model.Users;
import com.javaweb.service.EnDeCryption;
import com.javaweb.service.UserService;
import com.javaweb.service.md5;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String email, password;
        
        email = request.getParameter("youremail");
        password = request.getParameter("yourpwd");
        
        boolean kiemTra;
        UserService us = new UserService();
        EnDeCryption maHoa = new EnDeCryption("tuannc");
        String matKhauMaHoa = md5.md5Encryption(password);
        kiemTra = us.CheckLogin(email, matKhauMaHoa);
        
        HttpSession session = request.getSession();
        
        
        if(kiemTra){
            Users user = us.GetUserByEmailOrUsername(email);
            session.setAttribute("fullname", user.getFullName());
            String url = "/trangchu.jsp";
            getServletContext().getRequestDispatcher(url).forward(request, response);
        }else{
            session.setAttribute("errormsg", "Tài khoản hoặc mật khẩu không đúng!");
            String url = "/login.jsp";
            getServletContext().getRequestDispatcher(url).forward(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

}
