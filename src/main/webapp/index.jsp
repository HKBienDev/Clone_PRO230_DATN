<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cosmetic Store | Mỹ Phẩm Cao Cấp</title>

<!-- Google Fonts & FontAwesome -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<style>
:root {
	--pink-gradient: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
	--pink-soft: #fff0f5;
	--pink-light: #ffe3ec;
	--pink-main: #ff5277;
	--pink-dark: #d81b60;
	--text-color: #4a4a4a;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background-color: #fff8fa;
	color: var(--text-color);
}

.container {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto;
}

/* 1. Top Bar */
.top-bar {
	background: var(--pink-soft);
	border-bottom: 1px solid var(--pink-light);
	font-size: 13px;
	padding: 8px 0;
}

.top-bar .container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.top-left {
	color: var(--pink-dark);
	font-weight: 500;
}

.top-left i {
	margin-right: 6px;
}

.top-right a {
	color: var(--pink-dark);
	text-decoration: none;
	margin-left: 15px;
	font-weight: 500;
	transition: opacity 0.2s;
}

.top-right a:hover {
	opacity: 0.7;
}

.user-info {
	color: var(--pink-dark);
	font-weight: 600;
}

/* 2. Header */
.header {
	background: #ffffff;
	padding: 20px 0;
	box-shadow: 0 4px 15px rgba(255, 117, 140, 0.08);
}

.header-content {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.logo a {
	font-size: 26px;
	font-weight: 700;
	color: var(--pink-dark);
	text-decoration: none;
	letter-spacing: 1px;
}

.search-box form {
	display: flex;
	align-items: center;
	background: var(--pink-soft);
	border: 1px solid var(--pink-light);
	border-radius: 25px;
	padding: 4px 6px 4px 16px;
	width: 380px;
}

.search-box input {
	border: none;
	background: transparent;
	outline: none;
	width: 100%;
	font-size: 14px;
	color: var(--text-color);
}

.search-box button {
	background: var(--pink-gradient);
	border: none;
	color: #fff;
	width: 36px;
	height: 36px;
	border-radius: 50%;
	cursor: pointer;
	transition: transform 0.2s;
}

.search-box button:hover {
	transform: scale(1.05);
}

.header-icon a {
	color: var(--pink-dark);
	text-decoration: none;
	font-weight: 600;
	font-size: 15px;
	display: flex;
	align-items: center;
	gap: 8px;
	background: var(--pink-soft);
	padding: 8px 16px;
	border-radius: 20px;
	border: 1px solid var(--pink-light);
	transition: all 0.3s ease;
}

.header-icon a:hover {
	background: var(--pink-gradient);
	color: #fff;
	border-color: transparent;
}

/* 3. Navbar */
.navbar {
	background: var(--pink-gradient);
	box-shadow: 0 4px 10px rgba(255, 117, 140, 0.2);
}

.navbar ul {
	list-style: none;
	display: flex;
	justify-content: center;
}

.navbar li a {
	display: block;
	padding: 14px 24px;
	color: #ffffff;
	text-decoration: none;
	font-weight: 500;
	font-size: 15px;
	transition: background 0.3s;
}

.navbar li a:hover {
	background: rgba(255, 255, 255, 0.2);
}

/* 4. Banner */
.banner {
	margin: 25px 0;
}

.banner img {
	width: 100%;
	height: auto;
	border-radius: 16px;
	box-shadow: 0 8px 20px rgba(255, 117, 140, 0.15);
	object-fit: cover;
}

/* 5. Main Layout */
.main-content {
	display: flex;
	gap: 30px;
	margin-bottom: 50px;
}

/* Sidebar */
.sidebar {
	width: 260px;
	flex-shrink: 0;
	background: #ffffff;
	padding: 20px;
	border-radius: 16px;
	border: 1px solid var(--pink-light);
	box-shadow: 0 6px 18px rgba(255, 117, 140, 0.06);
	height: fit-content;
}

.sidebar h3 {
	color: var(--pink-dark);
	font-size: 18px;
	margin-bottom: 15px;
	padding-bottom: 10px;
	border-bottom: 2px solid var(--pink-soft);
}

.sidebar ul {
	list-style: none;
}

.sidebar li a {
	display: block;
	padding: 10px 12px;
	color: var(--text-color);
	text-decoration: none;
	border-radius: 8px;
	font-size: 14px;
	transition: all 0.2s ease;
}

.sidebar li a:hover {
	background: var(--pink-soft);
	color: var(--pink-dark);
	font-weight: 600;
	padding-left: 18px;
}

/* Product Area */
.product-area {
	flex-grow: 1;
}

.product-area h2 {
	color: var(--pink-dark);
	font-size: 22px;
	margin-bottom: 20px;
	position: relative;
	padding-bottom: 8px;
}

.product-area h2::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 0;
	width: 60px;
	height: 3px;
	background: var(--pink-gradient);
	border-radius: 2px;
}

.product-list {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
	gap: 20px;
}

.product-card {
	background: #ffffff;
	border-radius: 16px;
	padding: 15px;
	text-align: center;
	border: 1px solid var(--pink-light);
	box-shadow: 0 6px 15px rgba(255, 117, 140, 0.05);
	transition: all 0.3s ease;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 12px 25px rgba(255, 117, 140, 0.18);
}

.product-card img {
	width: 100%;
	height: 180px;
	object-fit: contain;
	border-radius: 10px;
	margin-bottom: 12px;
}

.product-card h4 {
	font-size: 15px;
	color: var(--text-color);
	margin-bottom: 8px;
	font-weight: 600;
}

.product-card .price {
	color: var(--pink-dark);
	font-size: 16px;
	font-weight: 700;
	margin-bottom: 12px;
}

.btn-cart {
	display: block;
	background: var(--pink-gradient);
	color: #ffffff;
	text-decoration: none;
	padding: 10px 0;
	border-radius: 10px;
	font-size: 14px;
	font-weight: 600;
	box-shadow: 0 4px 12px rgba(255, 117, 140, 0.3);
	transition: opacity 0.2s;
}

.btn-cart:hover {
	opacity: 0.9;
}

/* 6. Footer */
.footer {
	background: var(--pink-dark);
	color: #ffffff;
	text-align: center;
	padding: 20px 0;
	margin-top: auto;
	font-size: 14px;
}
</style>
</head>
<body>

	<!-- Top Bar -->
	<div class="top-bar">
		<div class="container">
			<div class="top-left">
				<i class="fa-solid fa-truck"></i> Miễn phí vận chuyển cho đơn từ
				500.000đ
			</div>

			<div class="top-right">
				<c:choose>
					<c:when test="${ 		not empty sessionScope.currentUser}">
						<span class="user-info"> <i class="fa-solid fa-user"></i>
							Xin chào, <c:out
								value="${sessionScope.currentUser.customerName != null ? sessionScope.currentUser.customerName : sessionScope.currentUser.name}" />
						</span>
						<a href="${pageContext.request.contextPath}/logout"> <i
							class="fa-solid fa-right-from-bracket"></i> Đăng xuất
						</a>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/login"><i
							class="fa-solid fa-right-to-bracket"></i> Đăng nhập</a>
						<a href="${pageContext.request.contextPath}/register"><i
							class="fa-solid fa-user-plus"></i> Đăng ký</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<!-- Header -->
	<header class="header">

		<div class="container header-content">

			<div class="logo">
				<a href="home"> WINX </a>
			</div>

			<div class="search-box">
				<form action="product" method="get">
					<input type="text" name="keyword"
						placeholder="Tìm kiếm sản phẩm...">
					<button type="submit">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</form>
			</div>

			<div class="header-icon">
				<a href="cart?action=view"> <i class="fa-solid fa-cart-shopping"></i>
					Giỏ hàng
				</a>
			</div>

		</div>

	</header>

	<!-- Menu -->
	<nav class="navbar">

		<div class="container">

			<ul>
				<li><a href="home">Trang chủ</a></li>
				<li><a href="product">Sản phẩm</a></li>
				<li><a href="news">Tin tức</a></li>
				<li><a href="#">Giới thiệu</a></li>
				<li><a href="#">Liên hệ</a></li>
			</ul>

		</div>

	</nav>

	<!-- Banner -->
	<section class="banner">

		<div class="container">

			<img
				src="${pageContext.request.contextPath}/assets/images/banner.jpg"
				alt="Banner">

		</div>

	</section>

	<!-- Main -->
	<div class="container main-content">

		<!-- Sidebar -->
		<aside class="sidebar">

			<h3>Danh mục</h3>

			<ul>

				<c:forEach var="category" items="${categories}">
					<li><a href="product?category=${category.categoryID}">
							${category.categoryName} </a></li>
				</c:forEach>

			</ul>

		</aside>

		<!-- Product -->
		<section class="product-area">

			<h2>Sản phẩm nổi bật</h2>

			<div class="product-list">

				<c:forEach var="product" items="${products}">

					<div class="product-card">

						<img
							src="${pageContext.request.contextPath}/assets/images/no-image.png"
							alt="${product.productName}">

						<h4>${product.productName}</h4>

						<p class="price">${product.price}VNĐ</p>

						<a href="cart?action=add&productID=${product.productID}"
							class="btn-cart"> Thêm vào giỏ </a>

					</div>

				</c:forEach>

			</div>

		</section>

	</div>

	<!-- Footer -->
	<footer class="footer">

		<div class="container">

			<p>© 2026 Cosmetic Store. All Rights Reserved.</p>

		</div>

	</footer>

</body>
</html>