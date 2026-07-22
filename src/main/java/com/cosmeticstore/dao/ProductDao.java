package com.cosmeticstore.dao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import entity.Product;

import com.cosmeticstore.utils.JdbcUtil;

public class ProductDao implements CrudDao<Product, Integer> {

    private static final String INSERT_SQL =
            "INSERT INTO Product(ProductName, Price, StockQuantity, CategoryID) VALUES (?, ?, ?, ?)";

    private static final String UPDATE_SQL =
            "UPDATE Product SET ProductName=?, Price=?, StockQuantity=?, CategoryID=? WHERE ProductID=?";

    private static final String DELETE_SQL =
            "DELETE FROM Product WHERE ProductID=?";

    private static final String SELECT_ALL_SQL =
            "SELECT * FROM Product";

    private static final String SELECT_BY_ID_SQL =
            "SELECT * FROM Product WHERE ProductID=?";

    @Override
    public int create(Product entity) {

        try {

            return JdbcUtil.executeUpdate(
                    INSERT_SQL,
                    entity.getProductName(),
                    entity.getPrice(),
                    entity.getStockQuantity(),
                    entity.getCategoryID());

        } catch (Exception e) {

            e.printStackTrace();
            return 0;

        }

    }

    @Override
    public int update(Product entity) {

        try {

            return JdbcUtil.executeUpdate(
                    UPDATE_SQL,
                    entity.getProductName(),
                    entity.getPrice(),
                    entity.getStockQuantity(),
                    entity.getCategoryID(),
                    entity.getProductID());

        } catch (Exception e) {

            e.printStackTrace();
            return 0;

        }

    }

    @Override
    public int delete(Product entity) {

        try {

            return JdbcUtil.executeUpdate(
                    DELETE_SQL,
                    entity.getProductID());

        } catch (Exception e) {

            e.printStackTrace();
            return 0;

        }

    }

    @Override
    public List<Product> findAll() {
        return findBySql(SELECT_ALL_SQL);
    }

    @Override
    public Product findById(Integer id) {

        List<Product> list = findBySql(SELECT_BY_ID_SQL, id);

        if (list.isEmpty()) {
            return null;
        }

        return list.get(0);
    }

    @Override
    public List<Product> findBySql(String sql, Object... args) {

        List<Product> list = new ArrayList<>();

        ResultSet rs = null;
        Statement st = null;
        Connection con = null;

        try {

            rs = JdbcUtil.executeQuery(sql, args);

            while (rs.next()) {

                Product p = new Product();

                p.setProductID(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getBigDecimal("Price"));
p.setStockQuantity(rs.getInt("StockQuantity"));
                p.setCategoryID(rs.getInt("CategoryID"));

                list.add(p);

            }

            st = rs.getStatement();
            con = st.getConnection();

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            try {
                if (rs != null)
                    rs.close();
            } catch (Exception e) {
            }

            try {
                if (st != null)
                    st.close();
            } catch (Exception e) {
            }

            try {
                if (con != null)
                    con.close();
            } catch (Exception e) {
            }

        }

        return list;

    }

}