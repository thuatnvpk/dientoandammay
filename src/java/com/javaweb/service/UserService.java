/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javaweb.service;

import com.javaweb.hibernate.ulti.HibernateUtil;
import com.javaweb.model.Users;
import java.util.ArrayList;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Nguyễn Chí Tuấn
 */
public class UserService {
    public boolean InsertUser(Users user){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        
        try {
            tx = session.getTransaction();
            tx.begin();
            session.saveOrUpdate(user);
            tx.commit();
            return true;
        } catch (Exception e) {
            if(tx != null){
                tx.rollback();
            }
            System.out.println(e.toString());
        }finally{
            session.close();
        }
        return false;
    }
    
    public boolean DeleteUser(int IdUser){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            Users user = new Users();
            user.setIdUser(IdUser);
            session.delete(user);
            tx.commit();
            return true;
        } catch (Exception e) {
            if(tx != null){
                tx.rollback();
            }
            System.out.println(e.toString());
        }finally{
            session.close();
        }
        return false;
    }
    
    public Users GetUserByEmailOrUserid(String strInput) {
        Users user = null;
        Transaction tx = null;
        Session session = HibernateUtil.getSessionFactory().openSession();

        try {
            tx = session.getTransaction();
            tx.begin();
            String str = "from  Users where Email = '" + strInput + "' or IdUser='" + strInput + "'";
            Query query = session.createQuery(str);
            user = (Users) query.uniqueResult();
            tx.commit();

        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
        }

        return user;
    }
    
    public Users GetUserByEmailOrUsername(String giatri){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        
        try{
            tx = session.getTransaction();
            tx.begin();
            
            String strQuery = "from Users where email = '"+giatri+"'"
                    + " or username = '"+giatri+"'";
            Query query = session.createQuery(strQuery);
            Users user = (Users) query.uniqueResult();
            tx.commit();
            return user;
            
        }catch (Exception e) {
            if(tx != null){
                tx.rollback();
            }
            System.out.println(e.toString());
        }finally{
            session.close();
        }
        return null;
    }
    
    public boolean CheckLogin(String giaTri, String matKhau){
        Users user = GetUserByEmailOrUsername(giaTri);
        if(user == null){
            return false;
        }else{
            if(user.getPwd().equals(matKhau)){
                return true;
            }else{
                return false;
            }
        }
    }
    
    public boolean CheckUserIsExist(Users user) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.getTransaction();
            tx.begin();
            String str = "from  Users where IdUser = '" + user.getIdUser() + "' or Email = '" + user.getEmail() + "'";
            Query query = session.createQuery(str);
            Users userTemp = (Users) query.uniqueResult();
            if (userTemp != null) {
                return true;
            }
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            } else {
                System.out.println("LOI:" + e.toString());
            }
        } finally {
            session.close();
        }
        return false;

    }
    
    
    
    public ArrayList<Users> GetAllUsers(){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        
        ArrayList<Users> ListUsers = new ArrayList<>();
        try {
            tx = session.getTransaction();
            tx.begin();
            
            Query query = session.createQuery("from Users");
            ListUsers = (ArrayList<Users>) query.list();
            tx.commit();
        } catch (Exception e) {
            if(tx != null){
                tx.rollback();
            }
            System.out.println(e.toString());
        } finally{
            session.close();
        }
        return ListUsers;
    }
    
    public Users GetUserByIdUser(String IdUser){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Users user = null;
        Transaction tx = null;
        try {
            tx = session.getTransaction();
            tx.begin();
            
            Query query  = session.createQuery("from Users where IdUser = "+IdUser);
            user = (Users) query.uniqueResult();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            System.out.println(e.toString());
        } finally{
            session.close();
        }
        return user;
    }
    
}
