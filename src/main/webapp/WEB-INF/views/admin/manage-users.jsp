<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, entity.User" %>
<html>
<head>
    <title>Quản lý người dùng - Cửa hàng WINX</title>
    <style>
        :root {
            --primary-pink: #ff69b4;       /* Hồng đậm chủ đạo */
            --dark-pink: #e04d98;          /* Hồng đậm hơn khi hover */
            --soft-bg: #fff0f5;             /* Nền hồng pastel sáng nhẹ */
            --text-color: #3a3a3a;         /* Màu chữ xám đậm dễ nhìn */
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--soft-bg);
            margin: 0;
            padding: 40px 20px;
            color: var(--text-color);
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 35px;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(255, 105, 180, 0.2);
        }

        .header-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #ffb6c1;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }

        .header-actions {
            display: flex;
            gap: 10px; /* Khoảng cách giữa 2 nút */
            align-items: center;
        }

        h2 {
            color: #d81b60;                /* Hồng mận đậm cho tiêu đề */
            margin: 0;
            font-size: 24px;
            font-weight: 700;
            letter-spacing: 0.5px;
        }

        /* Nút Quay lại Admin Dashboard */
        .btn-back {
            background-color: #ffffff;
            color: var(--primary-pink);
            border: 2px solid var(--primary-pink);
            text-decoration: none;
            padding: 7px 16px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background-color: #ffe4e1;
            color: #d81b60;
            border-color: #d81b60;
        }

        .btn-logout {
            background-color: var(--primary-pink);
            color: white;
            text-decoration: none;
            padding: 9px 18px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(255, 105, 180, 0.3);
        }

        .btn-logout:hover {
            background-color: var(--dark-pink);
            transform: translateY(-1px);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background-color: #ffffff;
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #ffe4e1;
            font-size: 15px;
        }

        th {
            background-color: #fff0f5;
            color: #d81b60;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }

        tr:hover {
            background-color: #fffafb;     /* Hiệu ứng sáng dòng khi di chuột qua */
        }

        td strong {
            color: #2b2b2b;
        }

        .btn-delete {
            color: #c62828;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            padding: 6px 12px;
            border-radius: 6px;
            transition: all 0.2s;
        }

        .btn-delete:hover {
            background-color: #ffebee;
            color: #b71c1c;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-box">
        <h2>DANH SÁCH NGƯỜI DÙNG TRONG HỆ THỐNG</h2>
        <div class="header-actions">
            <!-- Nút quay lại trang Dashboard Admin -->
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">‹ Trang chủ</a>
            <!-- Nút đăng xuất -->
            <a href="${pageContext.request.contextPath}/login" class="btn-logout">Đăng xuất</a>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th style="width: 10%">ID</th>
                <th style="width: 40%">Tên người dùng</th>
                <th style="width: 35%">Email</th>
                <th style="width: 15%">Phép thuật</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<User> userList = (List<User>) request.getAttribute("userList");
                if (userList != null) {
                    for (User u : userList) {
            %>
            <tr>
                <td><%= u.getId() %></td>
                <td><strong><%= u.getName() %></strong></td>
                <td><%= u.getEmail() %></td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/users?action=delete&id=<%= u.getId() %>" 
                       class="btn-delete"
                       onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này?')">Xóa</a>
                </td>
            </tr>
            <% 
                    }
                } 
            %>
        </tbody>
    </table>
</div>

</body>
</html>