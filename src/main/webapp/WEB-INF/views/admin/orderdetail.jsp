<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Đơn Hàng | WINX ENCHANTIX</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        :root {
            --pink-gradient: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
            --pink-soft: #fff0f5;
            --pink-dark: #d81b60;
            --primary-pink: #ff66a3;
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

        .table-pink-header {
            background: var(--pink-gradient) !important;
            color: #ffffff !important;
        }

        .table-pink-header th {
            border: none !important;
            padding: 14px 10px;
            font-weight: 600;
        }

        .btn-home {
            background: #fce4ec;
            color: #c2185b;
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-home:hover {
            background: #f8bbd0;
            color: #880e4f;
        }

        /* Styling nút thao tác nhỏ gọn */
        .btn-action-confirm {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            text-decoration: none;
            background-color: #e8f5e9;
            color: #2e7d32;
            transition: all 0.2s ease;
        }

        .btn-action-confirm:hover {
            background-color: #2e7d32;
            color: #ffffff;
            transform: translateY(-2px);
        }

        .btn-action-cancel {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            text-decoration: none;
            background-color: #ffebee;
            color: #c62828;
            transition: all 0.2s ease;
        }

        .btn-action-cancel:hover {
            background-color: #c62828;
            color: #ffffff;
            transform: translateY(-2px);
        }

        .btn-action-delete {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 34px;
            height: 34px;
            border-radius: 50%;
            text-decoration: none;
            background-color: #fff3e0;
            color: #ef6c00;
            transition: all 0.2s ease;
        }

        .btn-action-delete:hover {
            background-color: #ef6c00;
            color: #ffffff;
            transform: translateY(-2px);
        }

        /* Badge Trạng thái */
        .badge-status {
            font-size: 13px;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="main-card">
        
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div></div>
            <h2 class="page-title text-center m-0">CHI TIẾT ĐƠN HÀNG</h2>
            <a href="${pageContext.request.contextPath}/admin/order" class="btn btn-home">
                <i class="fa-solid fa-arrow-left me-1"></i> Quản Lý Đơn Hàng
            </a>
        </div>

        <!-- Bảng Danh Sách Chi Tiết Đơn Hàng -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead>
                    <tr class="table-pink-header text-center">
                        <th>MÃ ĐƠN</th>
                        <th>SẢN PHẨM</th>
                        <th>SỐ LƯỢNG</th>
                        <th>ĐƠN GIÁ</th>
                        <th>THÀNH TIỀN</th>
                        <th>TRẠNG THÁI</th>
                        <th>THAO TÁC</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty list}">
                            <tr>
                                <td colspan="7" class="text-center text-muted">Không có dữ liệu chi tiết đơn hàng.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${list}" var="od">
                                <!-- Lấy trạng thái riêng của từng món od.status -->
                                <c:set var="statusVal" value="${not empty od.status ? od.status : orderStatus}" />

                                <tr>
                                    <td class="text-center fw-bold">#${od.orderID}</td>
                                    <td class="text-center">${od.productID}</td>
                                    <td class="text-center">${od.quantity}</td>

                                    <!-- 1. ĐỊNH DẠNG GIÁ TIỀN chuẩn Việt Nam (650.000 VNĐ) -->
                                    <td class="text-center text-muted">
                                        <fmt:formatNumber value="${od.unitPrice}" type="number" groupingUsed="true"/> VNĐ
                                    </td>
                                    
                                    <!-- 2. THÀNH TIỀN (1.300.000 VNĐ) -->
                                    <td class="text-center text-danger fw-bold">
                                        <fmt:formatNumber value="${od.quantity * od.unitPrice}" type="number" groupingUsed="true"/> VNĐ
                                    </td>

                                    <!-- 3. HIỂN THỊ TRẠNG THÁI TỪNG MÓN -->
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${statusVal == 'Completed' || statusVal == 'Đã xác nhận'}">
                                                <span class="badge bg-success badge-status">
                                                    <i class="fa-solid fa-circle-check me-1"></i>Đã xác nhận
                                                </span>
                                            </c:when>
                                            <c:when test="${statusVal == 'Cancelled' || statusVal == 'Đã hủy'}">
                                                <span class="badge bg-danger badge-status">
                                                    <i class="fa-solid fa-circle-xmark me-1"></i>Đã hủy
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning text-dark badge-status">
                                                    <i class="fa-solid fa-clock me-1"></i>Chờ xác nhận
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- 4. THAO TÁC TRÊN TỪNG SẢN PHẨM (Truyền cả orderID và productID) -->
                                    <td class="text-center">
                                        <div class="d-flex justify-content-center gap-2">
                                            
                                            <!-- Nút XÁC NHẬN MÓN NÀY -->
                                            <c:if test="${statusVal != 'Completed' && statusVal != 'Đã xác nhận' && statusVal != 'Cancelled' && statusVal != 'Đã hủy'}">
                                                <a href="${pageContext.request.contextPath}/admin/orderdetail?action=updateItemStatus&orderID=${od.orderID}&productID=${od.productID}&status=Completed" 
                                                   class="btn-action-confirm" 
                                                   onclick="return confirm('Xác nhận sản phẩm #${od.productID} trong đơn #${od.orderID}?')" 
                                                   title="Xác nhận món này">
                                                    <i class="fa-solid fa-check"></i>
                                                </a>
                                            </c:if>

                                            <!-- Nút HỦY MÓN NÀY -->
                                            <c:if test="${statusVal != 'Cancelled' && statusVal != 'Đã hủy'}">
                                                <a href="${pageContext.request.contextPath}/admin/orderdetail?action=updateItemStatus&orderID=${od.orderID}&productID=${od.productID}&status=Cancelled" 
                                                   class="btn-action-cancel" 
                                                   onclick="return confirm('Hủy sản phẩm #${od.productID} trong đơn #${od.orderID}?')" 
                                                   title="Hủy món này">
                                                    <i class="fa-solid fa-xmark"></i>
                                                </a>
                                            </c:if>

                                            <!-- Nút XÓA MÓN NÀY -->
                                            <a href="${pageContext.request.contextPath}/admin/orderdetail?action=delete&orderID=${od.orderID}&productID=${od.productID}" 
                                               class="btn-action-delete" 
                                               onclick="return confirm('Xóa sản phẩm này khỏi đơn hàng?')" 
                                               title="Xóa món này">
                                                <i class="fa-solid fa-trash"></i>
                                            </a>

                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

    </div>
</div>

</body>
</html>