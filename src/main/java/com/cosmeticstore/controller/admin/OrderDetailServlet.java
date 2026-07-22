package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.OrderDetailDao;
import entity.OrderDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/orderdetail")
public class OrderDetailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderDetailDao dao = new OrderDetailDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {

        case "list":
            listOrderDetail(request, response);
            break;

        case "delete":
            deleteOrderDetail(request, response);
            break;

        default:
            listOrderDetail(request, response);
            break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addOrderDetail(request, response);
        } else if ("update".equals(action)) {
            updateOrderDetail(request, response);
        }

    }

    private void listOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<OrderDetail> list = dao.findAll();

        request.setAttribute("list", list);
        // Trỏ chính xác vào file orderdetail.jsp trong WEB-INF/views/admin
        request.getRequestDispatcher("/WEB-INF/views/admin/orderdetail.jsp").forward(request, response);
    }

    private void addOrderDetail(HttpServletRequest request, HttpServletResponse response) throws IOException {

        OrderDetail od = new OrderDetail();

        od.setOrderID(Integer.parseInt(request.getParameter("orderID")));
        od.setProductID(Integer.parseInt(request.getParameter("productID")));
        od.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        od.setUnitPrice(Double.parseDouble(request.getParameter("unitPrice")));

        dao.create(od);
        response.sendRedirect(request.getContextPath() + "/admin/orderdetail?action=list");
    }

    private void updateOrderDetail(HttpServletRequest request, HttpServletResponse response) throws IOException {

        OrderDetail od = new OrderDetail();

        od.setOrderID(Integer.parseInt(request.getParameter("orderID")));
        od.setProductID(Integer.parseInt(request.getParameter("productID")));
        od.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        od.setUnitPrice(Double.parseDouble(request.getParameter("unitPrice")));

        dao.update(od);
        response.sendRedirect(request.getContextPath() + "/admin/orderdetail?action=list");
    }

    private void deleteOrderDetail(HttpServletRequest request, HttpServletResponse response) throws IOException {

        OrderDetail od = new OrderDetail();

        od.setOrderID(Integer.parseInt(request.getParameter("orderID")));
        od.setProductID(Integer.parseInt(request.getParameter("productID")));

        dao.delete(od);
        response.sendRedirect(request.getContextPath() + "/admin/orderdetail?action=list");
    }

}