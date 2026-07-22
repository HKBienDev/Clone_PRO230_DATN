package com.cosmeticstore.controller.auth;

import java.io.IOException;
import java.sql.ResultSet;

import com.cosmeticstore.utils.JdbcUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); 

        try {
            String checkSql = "SELECT CustomerID FROM Customer WHERE Email = ?";
            ResultSet rs = JdbcUtil.executeQuery(checkSql, email);
            
            if (rs.next()) {
                rs.getStatement().getConnection().close(); 
                request.setAttribute("error", "Email này đã được sử dụng");
                request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
                return;
            }
            rs.getStatement().getConnection().close();
            String insertSql = "INSERT INTO Customer (CustomerName, Phone, Address, Email) VALUES (?, '0000000000', N'Chưa cập nhật', ?)";
            int rowsAffected = JdbcUtil.executeUpdate(insertSql, name, email);

            if (rowsAffected > 0) {
                request.setAttribute("success", "Đăng ký thành viên WINX thành công!");
            } else {
                request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại.");
            }
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}