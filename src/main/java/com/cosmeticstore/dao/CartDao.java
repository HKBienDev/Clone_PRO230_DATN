package com.cosmeticstore.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.cosmeticstore.utils.JdbcUtil;

import entity.Cart;

public class CartDao implements CrudDao<Cart, Integer> {

	@Override
	public int create(Cart entity) {
		String sql = "INSERT INTO Cart(CustomerID) VALUES(?)";

		try {
			return JdbcUtil.executeUpdate(sql, entity.getCustomerID());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	@Override
	public int update(Cart entity) {
		return 0;
	}

	@Override
	public int delete(Cart entity) {
		String sql = "DELETE FROM Cart WHERE CartID=?";

		try {
			return JdbcUtil.executeUpdate(sql, entity.getCartID());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	@Override
	public List<Cart> findAll() {
		return findBySql("SELECT * FROM Cart");

	}

	@Override
	public Cart findById(Integer id) {
		List<Cart> list = findBySql("SELECT * FROM Cart WHERE CartID=?", id);

		return list.isEmpty() ? null : list.get(0);
	}

	@Override
	public List<Cart> findBySql(String sql, Object... value) {
		List<Cart> list = new ArrayList<>();

		try {
			ResultSet rs = JdbcUtil.executeQuery(sql, value);

			while (rs.next()) {
				Cart cart = new Cart();

				cart.setCartID(rs.getInt("CartID"));
				cart.setCustomerID(rs.getInt("CustomerID"));

				list.add(cart);
			}

			rs.getStatement().getConnection().close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Cart findByCustomerID(int customerID) {

		List<Cart> list = findBySql("SELECT * FROM Cart WHERE CustomerID=?", customerID);

		return list.isEmpty() ? null : list.get(0);
	}


}
