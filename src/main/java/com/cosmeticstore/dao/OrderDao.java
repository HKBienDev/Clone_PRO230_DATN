package com.cosmeticstore.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cosmeticstore.utils.JdbcUtil;

import entity.Order;

public class OrderDao implements CrudDao<Order, Integer> {

	@Override
	public int create(Order entity) {
		String sql = "INSERT INTO [Order](OrderDate, CustomerID, EmployeeID, TotalAmount, Status) VALUES(?,?,?,?,?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getOrderDate(), entity.getCustomerID(), entity.getEmployeeID(),
					entity.getTotalAmount(), entity.getStatus());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int update(Order entity) {
		String sql = "UPDATE [Order] SET Status=? WHERE OrderID=?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getStatus(), entity.getOrderID());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(Order entity) {
		String sql = "DELETE FROM [Order] WHERE OrderID=?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getOrderID());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<Order> findAll() {
		return findBySql("SELECT * FROM [Order]");
	}

	@Override
	public Order findById(Integer id) {
		List<Order> list = findBySql("SELECT * FROM [Order] WHERE OrderID=?", id);
		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<Order> findBySql(String sql, Object... value) {

		List<Order> list = new ArrayList<>();

		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, value);

			while (rs.next()) {
				Order order = new Order();

				order.setOrderID(rs.getInt("OrderID"));
				order.setOrderDate(rs.getDate("OrderDate"));
				order.setCustomerID(rs.getInt("CustomerID"));
				order.setEmployeeID(rs.getInt("EmployeeID"));
				order.setTotalAmount(rs.getDouble("TotalAmount"));
				order.setStatus(rs.getString("Status"));

				list.add(order);
			}

			rs.getStatement().getConnection().close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public int createOrder(Order order) {

		String sql = "INSERT INTO [Order](OrderDate, CustomerID, EmployeeID, TotalAmount, Status) VALUES(GETDATE(),?,?,?,?)";

		try {
			JdbcUtil.executeUpdate(sql, order.getCustomerID(), order.getEmployeeID(), order.getTotalAmount(),
					order.getStatus());

			ResultSet rs = JdbcUtil.executeQuery("SELECT MAX(OrderID) AS OrderID FROM [Order]");

			if (rs.next()) {
				return rs.getInt("OrderID");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int updateTotalAmount(int orderID, double totalAmount) {

		String sql = "UPDATE [Order] SET TotalAmount=? WHERE OrderID=?";

		try {
			return JdbcUtil.executeUpdate(sql, totalAmount, orderID);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}
}
