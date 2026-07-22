package com.cosmeticstore.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.cosmeticstore.utils.DateUtil;
import com.cosmeticstore.utils.JdbcUtil;

import entity.BestSellingProduct;
import entity.RevenueByDay;

public class RevenueDAO {
	public List<BestSellingProduct> getTop5BestSellingProducts(Date fromDate, Date toDate) throws SQLException {
		List<BestSellingProduct> result = new ArrayList<>();
		String sql = "{CALL sp_top_5_best_selling_products(?,?)}";

		String fromDateString = DateUtil.toString(fromDate, "yyyy-MM-dd");
		String toDateString = DateUtil.toString(toDate, "yyyy-MM-dd");

		ResultSet rs = JdbcUtil.executeQuery(sql, fromDate == null ? null : fromDateString,
				toDate == null ? null : toDateString);

		while (rs.next()) {
			BestSellingProduct dto = new BestSellingProduct();
			dto.setProductID(rs.getInt("product_id"));
			dto.setProductName(rs.getString("product_name"));
			dto.settotalQuantitySold(rs.getInt("total_quantity_sold"));
			dto.setTotalRevenue(rs.getLong("total_revenue"));

			result.add(dto);
		}
		return result;
	}

	public List<RevenueByDay> getRevenueByDay(Date fromDate, Date toDate) throws SQLException {
		List<RevenueByDay> result = new ArrayList<>();

		String sql = "{CALL sp_revenue_by_day(?,?)}";

		String fromDateString = DateUtil.toString(fromDate, "yyyy-MM-dd");
		String toDateString = DateUtil.toString(toDate, "yyyy-MM-dd");

		ResultSet rs = JdbcUtil.executeQuery(sql, fromDate == null ? null : fromDateString,
				toDate == null ? null : toDateString);

		while (rs.next()) {
			RevenueByDay dto = new RevenueByDay();
			dto.setRevenueDate(rs.getDate("revenue_date"));
			dto.setTotalBills(rs.getInt("total_bills"));
			dto.setTotalRevenue(rs.getLong("total_revenue"));

			result.add(dto);
		}
		return result;
	}
}
