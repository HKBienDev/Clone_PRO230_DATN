<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Sản phẩm | WINX ENCHANTIX</title>

<!-- Font Awesome Icon & Bootstrap 5 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    :root {
        --pink-main: #ff758c;
        --pink-gradient: linear-gradient(135deg, #ff758c 0%, #ff7eb3 100%);
        --pink-soft: #fff0f5;
        --pink-hover: #ff5277;
        --pink-border: #f8b195;
    }

    body {
        background-color: #fff8fa;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #4a4a4a;
    }

    .form-container {
        max-width: 650px;
        margin: 40px auto;
        background: #ffffff;
        padding: 35px;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(255, 117, 140, 0.15);
        border: 1px solid #ffe3ec;
    }

    .form-title {
        color: #d81b60;
        font-weight: 700;
        letter-spacing: 0.5px;
        position: relative;
        padding-bottom: 15px;
        margin-bottom: 25px;
    }

    .form-title::after {
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

    .form-label {
        font-weight: 600;
        color: #d81b60;
        margin-bottom: 8px;
    }

    .form-control, .form-select {
        border-radius: 10px;
        border: 1.5px solid #ffd1dc;
        padding: 10px 15px;
        transition: all 0.3s ease;
    }

    .form-control:focus, .form-select:focus {
        border-color: var(--pink-main);
        box-shadow: 0 0 8px rgba(255, 117, 140, 0.3);
    }

    /* Các nút bấm (Buttons) */
    .btn-pink-primary {
        background: var(--pink-gradient);
        color: #fff;
        border: none;
        border-radius: 10px;
        padding: 10px 25px;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(255, 117, 140, 0.3);
    }

    .btn-pink-primary:hover {
        background: linear-gradient(135deg, #ff5277 0%, #ff68a4 100%);
        color: #fff;
        transform: translateY(-2px);
    }

    .btn-pink-outline {
        background: transparent;
        color: #d81b60;
        border: 1.5px solid var(--pink-main);
        border-radius: 10px;
        padding: 10px 20px;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn-pink-outline:hover {
        background: var(--pink-soft);
        color: var(--pink-hover);
        border-color: var(--pink-hover);
        transform: translateY(-2px);
    }

    .btn-home {
        background: #fce4ec;
        color: #c2185b;
        border: none;
        border-radius: 10px;
        padding: 10px 20px;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn-home:hover {
        background: #f8bbd0;
        color: #880e4f;
        transform: translateY(-2px);
    }

    .alert-danger {
        background-color: #ffebee;
        border-color: #ffcdd2;
        color: #b71c1c;
        border-radius: 10px;
    }
</style>

</head>

<body>

<div class="container">

    <div class="form-container">

        <h2 class="text-center form-title">
            <i class="fa-solid fa-wand-magic-sparkles me-2"></i>
            ${product == null ? "THÊM SẢN PHẨM" : "CẬP NHẬT SẢN PHẨM"}
        </h2>

        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex align-items-center mb-4">
                <i class="fa-solid fa-circle-exclamation me-2 fs-5"></i>
                <div>${error}</div>
            </div>
        </c:if>

        <form action="product" method="post">

            <input type="hidden"
                   name="productID"
                   value="${product.productID}">

            <div class="mb-3">
                <label class="form-label">
                    <i class="fa-solid fa-box-open me-1"></i> Tên sản phẩm
                </label>

                <input type="text"
                       class="form-control"
                       name="productName"
                       value="${product.productName}"
                       placeholder="Nhập tên sản phẩm..."
                       required>
            </div>

            <div class="mb-3">
                <label class="form-label">
                    <i class="fa-solid fa-tag me-1"></i> Giá (VNĐ)
                </label>

                <input type="number"
                       class="form-control"
                       name="price"
                       value="${product.price}"
                       min="1"
                       placeholder="Nhập giá bán..."
                       required>
            </div>

            <div class="mb-3">
                <label class="form-label">
                    <i class="fa-solid fa-cubes me-1"></i> Số lượng
                </label>

                <input type="number"
                       class="form-control"
                       name="stockQuantity"
                       value="${product.stockQuantity}"
                       min="0"
                       placeholder="Nhập số lượng tồn kho..."
                       required>
            </div>

            <div class="mb-4">
                <label class="form-label">
                    <i class="fa-solid fa-layer-group me-1"></i> Loại sản phẩm
                </label>

                <select class="form-select"
                        name="categoryID"
                        required>

                    <option value="">-- Chọn loại sản phẩm --</option>

                    <c:forEach items="${categories}" var="c">

                        <option value="${c.categoryID}"
                            <c:if test="${product != null && product.categoryID == c.categoryID}">
                                selected
                            </c:if>>

                            ${c.categoryName}

                        </option>

                    </c:forEach>

                </select>
            </div>

            <!-- NHÓM NÚT ĐIỀU HƯỚNG BẤM -->
            <div class="d-flex flex-wrap gap-2 justify-content-between pt-2">
                <div>
                    <button type="submit" class="btn btn-pink-primary">
                        <i class="fa-solid fa-floppy-disk me-1"></i> Lưu
                    </button>

                    <a href="product" class="btn btn-pink-outline ms-1">
                        <i class="fa-solid fa-arrow-left me-1"></i> Quay lại
                    </a>
                </div>

                <!-- NÚT TRANG CHỦ MỚI BỔ SUNG -->
                <a href="${pageContext.request.contextPath}/admin/news" class="btn btn-home">
                    <i class="fa-solid fa-house me-1"></i> Trang chủ
                </a>
            </div>

        </form>

    </div>

</div>

</body>
</html>