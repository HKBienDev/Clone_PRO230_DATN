package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.OrderDao;

import entity.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	OrderDao dao = new OrderDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action == null) {
			action = "list";
		}

		switch (action) {

		case "list":
			listOrder(request, response);
			break;

		case "delete":
			deleteOrder(request, response);
			break;

		default:
			listOrder(request, response);
			break;
		}

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("add".equals(action)) {

			addOrder(request, response);

		} else if ("update".equals(action)) {

			updateOrder(request, response);

		}

	}

	private void listOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Order> list = dao.findAll();

		request.setAttribute("list", list);

		request.getRequestDispatcher("/views/bill/Order.jsp").forward(request, response);

	}

	private void addOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {

		Order order = new Order();

		order.setCustomerID(Integer.parseInt(request.getParameter("customerID")));
		order.setEmployeeID(Integer.parseInt(request.getParameter("employeeID")));
		order.setTotalAmount(Double.parseDouble(request.getParameter("totalAmount")));
		order.setStatus(request.getParameter("status"));

		dao.create(order);

		response.sendRedirect("order?action=list");

	}

	private void updateOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {

		Order order = new Order();

		order.setOrderID(Integer.parseInt(request.getParameter("orderID")));
		order.setStatus(request.getParameter("status"));

		dao.update(order);

		response.sendRedirect("order?action=list");

	}

	private void deleteOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {

		Order order = new Order();

		order.setOrderID(Integer.parseInt(request.getParameter("orderID")));

		dao.delete(order);

		response.sendRedirect("order?action=list");

	}

}
