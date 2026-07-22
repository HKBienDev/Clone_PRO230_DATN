package com.cosmeticstore.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cosmeticstore.utils.JdbcUtil;

import entity.OrderDetail;

public class OrderDetailDao implements CrudDao<OrderDetail, Integer> {

	@Override
	public int create(OrderDetail entity) {
		String sql = "INSERT INTO OrderDetail(OrderID, ProductID, Quantity, UnitPrice) VALUES(?,?,?,?)";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getOrderID(), entity.getProductID(), entity.getQuantity(),
					entity.getUnitPrice());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int update(OrderDetail entity) {
		String sql = "UPDATE OrderDetail SET Quantity=?, UnitPrice=? WHERE OrderID=? AND ProductID=?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getQuantity(), entity.getUnitPrice(), entity.getOrderID(),
					entity.getProductID());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int delete(OrderDetail entity) {
		String sql = "DELETE FROM OrderDetail WHERE OrderID=? AND ProductID=?";
		try {
			return JdbcUtil.executeUpdate(sql, entity.getOrderID(), entity.getProductID());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<OrderDetail> findAll() {
		return findBySql("SELECT * FROM OrderDetail");
	}

	@Override
	public OrderDetail findById(Integer id) {
		List<OrderDetail> list = findBySql("SELECT * FROM OrderDetail WHERE OrderID=?", id);

		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<OrderDetail> findBySql(String sql, Object... value) {

		List<OrderDetail> list = new ArrayList<>();

		try {

			ResultSet rs = JdbcUtil.executeQuery(sql, value);

			while (rs.next()) {

				OrderDetail od = new OrderDetail();

				od.setOrderID(rs.getInt("OrderID"));
				od.setProductID(rs.getInt("ProductID"));
				od.setQuantity(rs.getInt("Quantity"));
				od.setUnitPrice(rs.getDouble("UnitPrice"));

				list.add(od);
			}

			rs.getStatement().getConnection().close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

}
