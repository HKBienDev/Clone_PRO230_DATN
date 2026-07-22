<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Giỏ hàng | WINX ENCHANTIX</title>

<!-- Font Google & FontAwesome Icons -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
:root {
	--pink-gradient: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
	--pink-soft: #fff0f5;
	--pink-dark: #d81b60;
	--pink-hover: #ff5277;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background-color: #fff8fa;
	color: #4a4a4a;
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 40px 20px;
}

.cart-container {
	width: 100%;
	max-width: 900px;
	background: #ffffff;
	padding: 35px;
	border-radius: 20px;
	box-shadow: 0 10px 30px rgba(255, 117, 140, 0.12);
	border: 1px solid #ffe3ec;
}

h2 {
	color: var(--pink-dark);
	font-size: 26px;
	font-weight: 700;
	text-align: center;
	margin-bottom: 25px;
	position: relative;
	padding-bottom: 12px;
}

h2::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 80px;
	height: 4px;
	background: var(--pink-gradient);
	border-radius: 10px;
}

/* Bảng giỏ hàng */
.table-responsive {
	overflow-x: auto;
	margin-bottom: 25px;
}

table {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0;
	border-radius: 12px;
	overflow: hidden;
	border: 1px solid #ffe3ec !important;
}

thead th {
	background: var(--pink-gradient);
	color: #ffffff;
	padding: 16px;
	font-size: 14px;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	border: none !important;
}

tbody tr {
	transition: background-color 0.2s ease;
}

tbody tr:hover {
	background-color: var(--pink-soft);
}

tbody td {
	padding: 16px;
	border-bottom: 1px solid #ffe3ec !important;
	border-top: none !important;
	border-left: none !important;
	border-right: none !important;
	vertical-align: middle;
	font-size: 14px;
}

/* Tăng giảm số lượng */
.qty-btn {
	display: inline-block;
	width: 28px;
	height: 28px;
	line-height: 26px;
	background-color: #ffffff;
	color: var(--pink-dark);
	border: 1px solid #ffccd5;
	border-radius: 50%;
	text-decoration: none;
	font-weight: 700;
	transition: all 0.2s ease;
	margin: 0 6px;
}

.qty-btn:hover {
	background-color: var(--pink-dark);
	color: #ffffff;
	border-color: var(--pink-dark);
}

/* Nút xóa */
.btn-delete {
	color: #ff4d4d;
	text-decoration: none;
	font-weight: 600;
	padding: 6px 12px;
	border-radius: 8px;
	background-color: #fff0f0;
	transition: all 0.2s ease;
}

.btn-delete:hover {
	background-color: #ff4d4d;
	color: #ffffff;
}

/* Giá tiền */
.price-text {
	color: var(--pink-dark);
	font-weight: 700;
}

/* Nút Thanh toán */
.checkout-box {
	display: flex;
	justify-content: flex-end;
	margin-top: 15px;
}

.btn-checkout {
	background: var(--pink-gradient);
	color: #ffffff;
	border: none;
	padding: 14px 32px;
	font-size: 15px;
	font-weight: 600;
	border-radius: 12px;
	cursor: pointer;
	box-shadow: 0 6px 15px rgba(255, 117, 140, 0.3);
	transition: all 0.3s ease;
}

.btn-checkout:hover {
	transform: translateY(-2px);
	box-shadow: 0 8px 20px rgba(255, 117, 140, 0.4);
}

.empty-msg {
	color: #888;
	font-style: italic;
	padding: 30px !important;
}
</style>
</head>
<body>

	<div class="cart-container">

		<h2>GIỎ HÀNG</h2>

		<div class="table-responsive">
			<table border="1" style="width: 100%; border-collapse: collapse; text-align: center;">
				<thead>
					<tr>
						<th>Mã giỏ</th>
						<th>Mã sản phẩm</th>
						<th>Số lượng</th>
						<th>Đơn giá</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list}">
							<tr>
								<td colspan="5" class="empty-msg">Giỏ hàng trống</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list}" var="item">
								<tr>
									<td style="font-weight: 600; color: #666;">${item.cartID}</td>
									<td>${item.productID}</td>
									<td>
										<a href="${pageContext.request.contextPath}/cart?action=decrease&cartID=${item.cartID}&productID=${item.productID}" class="qty-btn">-</a>
										<span style="font-weight: 600; font-size: 15px;">${item.quantity}</span>
										<a href="${pageContext.request.contextPath}/cart?action=increase&cartID=${item.cartID}&productID=${item.productID}" class="qty-btn">+</a>
									</td>
									<td class="price-text">
										<fmt:formatNumber value="${item.price}" type="currency" currencySymbol="VNĐ"/>
									</td>
									<td>
										<a href="${pageContext.request.contextPath}/cart?action=remove&cartID=${item.cartID}&productID=${item.productID}" 
										   onclick="return confirm('Bạn có muốn xóa sản phẩm này khỏi giỏ?');" class="btn-delete">Xóa</a>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

		<!-- Nút Thanh toán -->
		<div class="checkout-box">
			<form action="${pageContext.request.contextPath}/checkout" method="post">
				<button type="submit" class="btn-checkout">Thanh toán ngay <i class="fa-solid fa-arrow-right style="margin-left: 5px;""></i></button>
			</form>
		</div>

	</div>

</body>
</html>