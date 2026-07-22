package com.cosmeticstore.dao;

import java.sql.ResultSet;
import com.cosmeticstore.utils.JdbcUtil;
import entity.Customer;

public class CustomerDAO {

    public Customer checkLogin(String email, String password) {
        if (email == null || password == null) return null;
        
        String sql = "SELECT * FROM Customer WHERE LOWER(Email) = LOWER(?) AND Password = ?";
        try {
            ResultSet rs = JdbcUtil.executeQuery(sql, email.trim(), password.trim());
            if (rs.next()) {
                Customer c = new Customer();
                c.setCustomerID(rs.getInt("CustomerID"));
                c.setCustomerName(rs.getString("CustomerName"));
                c.setPhone(rs.getString("Phone"));
                c.setAddress(rs.getString("Address"));
                c.setEmail(rs.getString("Email"));
                c.setPassword(rs.getString("Password"));
                
                rs.getStatement().getConnection().close();
                return c;
            }
            rs.getStatement().getConnection().close();
        } catch (Exception e) {
            System.err.println(">>> Lỗi truy vấn bảng Customer:");
            e.printStackTrace();
        }
        return null;
    }
}