package com.cosmeticstore.controller.admin;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.cosmeticstore.dao.CategoryDao;
import com.cosmeticstore.dao.ProductDao;

import entity.Category;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
    "/product",
    "/admin/product",
    "/admin/products",
    "/admin/product/new",
    "/admin/product/edit",
    "/admin/product/delete"
})
public class ProductServlet extends HttpServlet {

    private ProductDao productDao = new ProductDao();
    private CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showForm(request, response);
                break;

            case "edit":
                editProduct(request, response);
                break;

            case "delete":
                deleteProduct(request, response);
                break;

            default:
                showList(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("productID");
        String productName = request.getParameter("productName");
        String price = request.getParameter("price");
        String stock = request.getParameter("stockQuantity");
        String category = request.getParameter("categoryID");

        Product p = new Product();
        p.setProductName(productName);

        try {
            if (productName == null || productName.trim().isEmpty()) {
                throw new Exception("Tên sản phẩm không được để trống.");
            }

            if (price == null || price.trim().isEmpty()) {
                throw new Exception("Vui lòng nhập giá.");
            }

            p.setPrice(new BigDecimal(price));

            if (p.getPrice().compareTo(BigDecimal.ZERO) <= 0) {
                throw new Exception("Giá phải lớn hơn 0.");
            }

            if (stock == null || stock.trim().isEmpty()) {
                throw new Exception("Vui lòng nhập số lượng.");
            }

            p.setStockQuantity(Integer.parseInt(stock));

            if (p.getStockQuantity() < 0) {
                throw new Exception("Số lượng không được âm.");
            }

            if (category == null || category.trim().isEmpty()) {
                throw new Exception("Vui lòng chọn loại sản phẩm.");
            }

            p.setCategoryID(Integer.parseInt(category));

            if (id == null || id.isBlank()) {
                productDao.create(p);
            } else {
                p.setProductID(Integer.parseInt(id));
                productDao.update(p);
            }

            response.sendRedirect("product");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu số không hợp lệ.");

            List<Category> categories = categoryDao.findAll();
            request.setAttribute("categories", categories);
            request.setAttribute("product", p);
            request.getRequestDispatcher("/WEB-INF/views/admin/products/form.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());

            List<Category> categories = categoryDao.findAll();
            request.setAttribute("categories", categories);
            request.setAttribute("product", p);
            request.getRequestDispatcher("/WEB-INF/views/admin/products/form.jsp")
                    .forward(request, response);
        }
    }

    private void showList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> list = productDao.findAll();
        request.setAttribute("list", list);
        request.getRequestDispatcher("/WEB-INF/views/admin/products/list-sp.jsp")
                .forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = categoryDao.findAll();
        System.out.println("Category size = " + categories.size());

        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/admin/products/form.jsp")
                .forward(request, response);
    }

    private void editProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDao.findById(id);
            List<Category> categories = categoryDao.findAll();

            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/WEB-INF/views/admin/products/form.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            response.sendRedirect("product");
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDao.findById(id);
            if (product != null) {
                productDao.delete(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("product");
    }
}