package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.CartDao;
import com.cosmeticstore.dao.CartDetailDao;
import com.cosmeticstore.dao.OrderDao;
import com.cosmeticstore.dao.OrderDetailDao;

import entity.Cart;
import entity.CartDetail;
import entity.Order;
import entity.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private CartDao cartDao = new CartDao();
	private CartDetailDao cartDetailDao = new CartDetailDao();
	private OrderDao orderDao = new OrderDao();
	private OrderDetailDao orderDetailDao = new OrderDetailDao();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/cart?action=view");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int customerID = 1; 
		int employeeID = 1; 

		Cart cart = cartDao.findByCustomerID(customerID);

		if (cart == null) {
			response.sendRedirect(request.getContextPath() + "/cart?action=view");
			return;
		}

		List<CartDetail> list = cartDetailDao.findByCartID(cart.getCartID());

		if (list.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/cart?action=view");
			return;
		}

		double totalAmount = 0;

		for (CartDetail item : list) {
			totalAmount += item.getPrice() * item.getQuantity();
		}

		Order order = new Order();
		order.setCustomerID(customerID);
		order.setEmployeeID(employeeID);
		order.setTotalAmount(totalAmount);
		order.setStatus("Pending");

		int orderID = orderDao.createOrder(order);

		for (CartDetail item : list) {
			OrderDetail detail = new OrderDetail();
			detail.setOrderID(orderID);
			detail.setProductID(item.getProductID());
			detail.setQuantity(item.getQuantity());
			detail.setUnitPrice(item.getPrice());

			orderDetailDao.create(detail);
		}

		cartDetailDao.deleteByCartID(cart.getCartID());
		response.sendRedirect(request.getContextPath() + "/cart?action=view");
	}

}