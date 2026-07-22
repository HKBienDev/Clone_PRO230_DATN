package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.AccountDAO;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class UserController extends HttpServlet {
    private AccountDAO accountDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        if (action.equals("list")) {
            List<User> list = accountDAO.findAll();
            request.setAttribute("userList", list);
            request.getRequestDispatcher("/WEB-INF/views/admin/manage-users.jsp").forward(request, response);
            
        } else if (action.equals("delete")) {
        	try {
            int id = Integer.parseInt(request.getParameter("id"));
            User userToDelete = accountDAO.findById(id);
            
            if (userToDelete != null) {
                accountDAO.delete(userToDelete);
            }
        	} catch (NumberFormatException e) {
                e.printStackTrace(); 
            }
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}
