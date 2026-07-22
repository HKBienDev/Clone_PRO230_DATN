<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Quản lý sản phẩm | WINX ENCHANTIX</title>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    :root {
        --pink-main: #ff758c;
        --pink-gradient: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
        --pink-soft: #fff0f5;
        --pink-hover: #ff5277;
        --pink-dark: #d81b60;
    }

    body {
        background-color: #fff8fa;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #4a4a4a;
    }

    .main-card {
        background: #ffffff;
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(255, 117, 140, 0.12);
        border: 1px solid #ffe3ec;
        margin-top: 30px;
        margin-bottom: 40px;
    }

    .page-title {
        color: var(--pink-dark);
        font-weight: 700;
        letter-spacing: 0.5px;
        position: relative;
        padding-bottom: 12px;
    }

    .page-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 100px;
        height: 4px;
        background: var(--pink-gradient);
        border-radius: 10px;
    }

    /* Phong cách Bảng (Table) tone hồng */
    .table-pink-header {
        background: var(--pink-gradient) !important;
        color: #ffffff !important;
    }

    .table-pink-header th {
        border: none !important;
        padding: 14px 10px;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.9rem;
        white-space: nowrap; /* Giữ tiêu đề không bị rớt dòng */
    }

    .table-hover tbody tr:hover {
        background-color: var(--pink-soft) !important;
    }

    .table td {
        vertical-align: middle;
        border-color: #ffe3ec;
    }

    /* Chống rớt chữ/số cho cột Giá và Thao tác */
    .text-nowrap-custom {
        white-space: nowrap !important;
    }

    /* Các Nút Bấm (Buttons) */
    .btn-pink-add {
        background: var(--pink-gradient);
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 10px 22px;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(255, 117, 140, 0.3);
        white-space: nowrap;
    }

    .btn-pink-add:hover {
        background: linear-gradient(135deg, #ff5277 0%, #ff68a4 100%);
        color: #fff;
        transform: translateY(-2px);
    }

    .btn-pink-edit {
        background-color: #ffb74d;
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 6px 16px;
        font-weight: 600;
        transition: all 0.2s ease;
        white-space: nowrap;
    }

    .btn-pink-edit:hover {
        background-color: #ffa726;
        color: #fff;
    }

    .btn-pink-delete {
        background-color: #ef5350;
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 6px 16px;
        font-weight: 600;
        transition: all 0.2s ease;
        white-space: nowrap;
    }

    .btn-pink-delete:hover {
        background-color: #e53935;
        color: #fff;
    }

    .btn-home {
        background: #fce4ec;
        color: #c2185b;
        border: none;
        border-radius: 10px;
        padding: 10px 20px;
        font-weight: 600;
        transition: all 0.3s ease;
        white-space: nowrap;
    }

    .btn-home:hover {
        background: #f8bbd0;
        color: #880e4f;
        transform: translateY(-2px);
    }
</style>

</head>
<body>

<div class="container">

    <div class="main-card">

        <h2 class="text-center mb-4 page-title">
            QUẢN LÝ SẢN PHẨM
        </h2>

        <!-- Thanh Thao Tác Đầu Trang -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <a href="product?action=new" class="btn btn-pink-add">
                Thêm sản phẩm
            </a>

            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-home">
                Trang chủ
            </a>
        </div>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">

                <thead>
                    <tr class="table-pink-header text-center">
                        <th style="width: 60px;">ID</th>
                        <th>TÊN SẢN PHẨM</th>
                        <th style="min-width: 170px;">GIÁ</th>
                        <th style="min-width: 100px;">SỐ LƯỢNG</th>
                        <th style="min-width: 80px;">LOẠI</th>
                        <th style="width: 90px;">SỬA</th>
                        <th style="width: 90px;">XÓA</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach items="${list}" var="p">

                        <tr>

                            <td class="text-center fw-bold">${p.productID}</td>

                            <td class="fw-semibold">${p.productName}</td>

                            <td class="text-center text-danger fw-bold text-nowrap-custom">${p.price} VNĐ</td>

                            <td class="text-center">${p.stockQuantity}</td>

                            <td class="text-center"><span class="badge bg-light text-dark border">${p.categoryID}</span></td>

                            <td class="text-center">

                                <a href="product?action=edit&id=${p.productID}"
                                   class="btn btn-pink-edit btn-sm">
                                    Sửa
                                </a>

                            </td>

                            <td class="text-center">

                                <a href="product?action=delete&id=${p.productID}"
                                   class="btn btn-pink-delete btn-sm"
                                   onclick="return confirm('Bạn có muốn xóa không?')">
                                    Xóa
                                </a>

                            </td>

                        </tr>

                    </c:forEach>

                </tbody>

            </table>
        </div>

    </div>

</div>

</body>
</html>