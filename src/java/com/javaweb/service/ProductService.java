/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.javaweb.service;

import com.javaweb.hibernate.ulti.HibernateUtil;
import com.javaweb.model.Sanpham;
import java.util.ArrayList;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Nguyễn Chí Tuấn
 */
public class ProductService {
    
    public boolean InsertProduct(Sanpham sp){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        
        try {
            tx = session.getTransaction();
            tx.begin();
            session.saveOrUpdate(sp);
            tx.commit();
            return true;
        } catch (Exception e) {
            if(tx != null){
                tx.rollback();
            }
            System.out.println(e.toString());
        } finally{
            session.close();
        }
        return false;
    }
    
    public boolean DeleteProduct(Sanpham sp){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        
        try {
            tx = session.getTransaction();
            tx.begin();
            
            session.delete(sp);
            tx.commit();
            return true;
        } catch (Exception e) {
            if(tx != null){
                tx.rollback();
            }
            System.out.println(e.toString());
        } finally{
            session.close();
        }
        return false;
    }
    
    public Sanpham GetSanPhamByID(String idsp){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Sanpham sp = null;
        Transaction tx = null;
        
        try {
            tx = session.getTransaction();
            tx.begin();
            
            Query query = session.createQuery("from Sanpham where id =" + idsp);
            sp = (Sanpham) query.uniqueResult();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }else{
                System.out.println(e.toString());
            }
        } finally{
            session.close();
        }
        return sp;
    }
    
    public ArrayList<Sanpham> GetAllSanpham(){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        
        ArrayList<Sanpham> ListSanpham = new ArrayList<>();
        try {
            tx = session.getTransaction();
            tx.begin();
            
            Query query = session.createQuery("from Sanpham");
            ListSanpham = (ArrayList) query.list();
            tx.commit();
        } catch (Exception e) {
            if(tx!=null){
                tx.rollback();
            }
            System.out.println(e.toString());
        } finally{
            session.close();
        }
        return ListSanpham;
    }
    
    public int usercount = 0;
    public ArrayList<Sanpham> getAllSanpham(int pageSize, int pageNumber){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;
        ArrayList listUsers = new ArrayList<Sanpham>();
        
        try {
            tx = session.getTransaction();
            tx.begin();
            
            Query query = session.createQuery("from Sanpham");
            usercount = query.list().size();
            query = query.setFirstResult(pageSize * (pageNumber - 1));
            query.setMaxResults(pageSize);            
            listUsers = (ArrayList) query.list();
            
            tx.commit();
            
        } catch (Exception e) {
            if(tx!=null){
                tx.rollback();
            }
            
        }finally{
            session.close();
        }
        
        return listUsers;
    }
}
