package com.cosmeticstore.controller.admin;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import com.cosmeticstore.dao.NewsDAO;
import entity.News;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet({
        "/admin/news",
        "/admin/news/add",
        "/admin/news/edit",
        "/admin/news/create",
        "/admin/news/update",
        "/admin/news/delete"
})
@MultipartConfig
public class NewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final NewsDAO dao = new NewsDAO();

    private Integer parseId(HttpServletRequest req) {
        String idRaw = req.getParameter("id");
        if (idRaw == null || idRaw.trim().isEmpty()) {
            return null;
        }
        try {
            return Integer.valueOf(idRaw.trim());
        } catch (NumberFormatException e) {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        // ================= DANH SÁCH =================
        if (path.equals("/admin/news")) {
            String keyword = req.getParameter("keyword");
            List<News> list;
            
            // Xử lý tìm kiếm nếu người dùng nhập từ khóa
            if (keyword != null && !keyword.trim().isEmpty()) {
                // Nếu NewsDAO của bạn có hàm searchByTitle thì bật dòng dưới lên:
                // list = dao.searchByTitle(keyword.trim());
                list = dao.findAll(); 
            } else {
                list = dao.findAll();
            }

            req.setAttribute("items", list);
            // Trỏ chính xác tới news.jsp (Thư mục webapp/WEB-INF/views/admin/news.jsp)
            req.getRequestDispatcher("/WEB-INF/views/admin/news.jsp").forward(req, resp);
            return;
        }

        // ================= THÊM (FORM) =================
        if (path.equals("/admin/news/add")) {
            req.getRequestDispatcher("/WEB-INF/views/admin/add-news.jsp").forward(req, resp);
            return;
        }

        // ================= SỬA (FORM) =================
        if (path.equals("/admin/news/edit")) {
            Integer id = parseId(req);
            if (id == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/news");
                return;
            }

            News item = dao.findById(id);
            if (item == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/news");
                return;
            }

            req.setAttribute("item", item);
            req.getRequestDispatcher("/WEB-INF/views/admin/edit.jsp").forward(req, resp);
            return;
        }

        // ================= XÓA =================
        if (path.equals("/admin/news/delete")) {
            Integer id = parseId(req);
            if (id != null) {
                News n = new News();
                n.setId(id);
                dao.delete(n);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/news");
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        // ================= CREATE =================
        if (path.equals("/admin/news/create")) {
            News n = new News();
            n.setTitle(req.getParameter("title"));
            n.setSummary(req.getParameter("summary"));
            n.setContent(req.getParameter("content"));

            Part part = req.getPart("photo");
            if (part != null && part.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
                String upload = getServletContext().getRealPath("/uploads");
                File dir = new File(upload);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                part.write(upload + File.separator + fileName);
                n.setImage("/uploads/" + fileName);
            } else {
                n.setImage("https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=300");
            }

            n.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            dao.create(n);
            resp.sendRedirect(req.getContextPath() + "/admin/news");
            return;
        }

        // ================= UPDATE =================
        if (path.equals("/admin/news/update")) {
            Integer id = parseId(req);
            if (id == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/news");
                return;
            }

            News old = dao.findById(id);
            if (old == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/news");
                return;
            }

            News n = new News();
            n.setId(id);
            n.setTitle(req.getParameter("title"));
            n.setSummary(req.getParameter("summary"));
            n.setContent(req.getParameter("content"));

            Part part = req.getPart("photo");
            if (part != null && part.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
                String upload = getServletContext().getRealPath("/uploads");
                File dir = new File(upload);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                part.write(upload + File.separator + fileName);
                n.setImage("/uploads/" + fileName);
            } else {
                n.setImage(old.getImage());
            }

            n.setCreatedDate(old.getCreatedDate());
            dao.update(n);
            resp.sendRedirect(req.getContextPath() + "/admin/news");
        }
    }
}