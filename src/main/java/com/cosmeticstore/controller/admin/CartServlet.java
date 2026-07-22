package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.util.List;

import com.cosmeticstore.dao.CartDao;
import com.cosmeticstore.dao.CartDetailDao;

import entity.Cart;
import entity.CartDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private CartDao cartDao = new CartDao();
	private CartDetailDao cartDetailDao = new CartDetailDao();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action == null) {
			action = "view";
		}

		switch (action) {
		case "view":
			viewCart(request, response);
			break;

		case "increase":
			increaseQuantity(request, response);
			break;

		case "decrease":
			decreaseQuantity(request, response);
			break;

		case "remove":
			removeProduct(request, response);
			break;

		default:
			viewCart(request, response);
			break;
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("add".equals(action)) {
			addProduct(request, response);
		}
	}

	private void viewCart(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int customerID = 1; // test

		Cart cart = cartDao.findByCustomerID(customerID);

		if (cart != null) {
			List<CartDetail> list = cartDetailDao.findByCartID(cart.getCartID());
			request.setAttribute("list", list);
		}
		request.getRequestDispatcher("/WEB-INF/views/customer/cart.jsp").forward(request, response);
	}

	private void addProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int customerID = 1;
		int productID = Integer.parseInt(request.getParameter("productID"));

		Cart cart = cartDao.findByCustomerID(customerID);

		if (cart == null) {
			cart = new Cart();
			cart.setCustomerID(customerID);
			cartDao.create(cart);
			cart = cartDao.findByCustomerID(customerID);
		}

		CartDetail detail = cartDetailDao.findByCartAndProduct(cart.getCartID(), productID);

		if (detail == null) {
			detail = new CartDetail();
			detail.setCartID(cart.getCartID());
			detail.setProductID(productID);
			detail.getQuantity(); 
			detail.setQuantity(1);

			cartDetailDao.create(detail);
		} else {
			cartDetailDao.increaseQuantity(cart.getCartID(), productID);
		}

		response.sendRedirect(request.getContextPath() + "/cart?action=view");
	}

	private void increaseQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int cartID = Integer.parseInt(request.getParameter("cartID"));
		int productID = Integer.parseInt(request.getParameter("productID"));

		cartDetailDao.increaseQuantity(cartID, productID);

		response.sendRedirect(request.getContextPath() + "/cart?action=view");
	}

	private void decreaseQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int cartID = Integer.parseInt(request.getParameter("cartID"));
		int productID = Integer.parseInt(request.getParameter("productID"));

		CartDetail detail = cartDetailDao.findByCartAndProduct(cartID, productID);

		if (detail != null) {

			if (detail.getQuantity() > 1) {
				cartDetailDao.updateQuantity(cartID, productID, detail.getQuantity() - 1);
			} else {
				cartDetailDao.delete(detail);
			}
		}

		response.sendRedirect(request.getContextPath() + "/cart?action=view");
	}

	private void removeProduct(HttpServletRequest request, HttpServletResponse response) throws IOException {

		CartDetail detail = new CartDetail();

		detail.setCartID(Integer.parseInt(request.getParameter("cartID")));
		detail.setProductID(Integer.parseInt(request.getParameter("productID")));

		cartDetailDao.delete(detail);

		response.sendRedirect(request.getContextPath() + "/cart?action=view");
	}
}