<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Tin tức - WINX ENCHANTIX</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <style>
        :root {
            --primary-pink: #ff66a3;
            --light-pink: #fff0f5;
            --dark-pink: #d11a5b;
            --soft-white: #ffffff;
            --gray-text: #757575;
            --border-color: #ffe4e1;
            --shadow: 0 4px 15px rgba(255, 102, 163, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--light-pink);
            min-height: 100vh;
        }

        /* --- MAIN CONTENT STYLE --- */
        .main {
            flex: 1;
            padding: 40px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .topbar h1 {
            color: var(--dark-pink);
            font-size: 28px;
            font-weight: 700;
        }

        .topbar p {
            color: var(--gray-text);
            font-size: 14px;
            margin-top: 5px;
        }

        .topbar-buttons {
            display: flex;
            gap: 12px;
        }

        /* BUTTONS */
        .btn-home {
            background-color: #ffe6f0;
            color: var(--dark-pink);
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
        }

        .btn-home:hover {
            background-color: var(--primary-pink);
            color: var(--soft-white);
        }

        .btn-add {
            background-color: var(--primary-pink);
            color: var(--soft-white);
            text-decoration: none;
            padding: 10px 22px;
            border-radius: 25px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: var(--shadow);
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-add:hover {
            background-color: var(--dark-pink);
            transform: translateY(-2px);
        }

        .btn-delete {
            background-color: #fff0f0;
            color: #ff4d4d;
            padding: 10px 22px;
            border-radius: 25px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .btn-delete:hover {
            background-color: #ff4d4d;
            color: var(--soft-white);
        }

        /* --- CARD & FORM STYLE --- */
        .card {
            background-color: var(--soft-white);
            border-radius: 15px;
            padding: 35px;
            box-shadow: var(--shadow);
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--dark-pink);
            font-weight: 600;
            font-size: 15px;
        }

        .form-group label i {
            margin-right: 6px;
            color: var(--primary-pink);
        }

        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 12px 18px;
            border: 1px solid var(--border-color);
            border-radius: 12px;
            outline: none;
            background-color: #fffafc;
            font-size: 14px;
            color: #444;
            transition: all 0.3s;
        }

        .form-group input[type="text"]:focus,
        .form-group textarea:focus {
            border-color: var(--primary-pink);
            background-color: var(--soft-white);
            box-shadow: 0 0 8px rgba(255, 102, 163, 0.25);
        }

        .form-group input[type="file"] {
            font-size: 14px;
            color: var(--gray-text);
        }

        .image-preview {
            width: 220px;
            height: 140px;
            object-fit: cover;
            border-radius: 12px;
            border: 2px solid var(--border-color);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-top: 10px;
        }
    </style>
</head>

<body>

<!-- MAIN -->
<div class="main">

    <div class="topbar">
        <div>
            <h1>Thêm Tin tức</h1>
            <p>WINX ENCHANTIX Cosmetics Admin</p>
        </div>

        <div class="topbar-buttons">
            <!-- NÚT VỀ TRANG CHỦ -->
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-home">
                <i class="fa fa-home"></i> Trang chủ
            </a>

            <!-- NÚT QUAY LẠI DANH SÁCH -->
            <a href="${pageContext.request.contextPath}/admin/news" class="btn-add">
                <i class="fa fa-arrow-left"></i> Danh sách
            </a>
        </div>
    </div>

    <div class="card">
        <form action="${pageContext.request.contextPath}/admin/news/create"
              method="post"
              enctype="multipart/form-data">

            <div class="form-group">
                <label>
                    <i class="fa fa-heading"></i> Tiêu đề
                </label>
                <input type="text"
                       name="title"
                       placeholder="Nhập tiêu đề tin tức..."
                       required>
            </div>

            <div class="form-group">
                <label>
                    <i class="fa fa-align-left"></i> Tóm tắt
                </label>
                <textarea rows="3"
                          name="summary"
                          placeholder="Nhập nội dung tóm tắt ngắn..."
                          required></textarea>
            </div>

            <div class="form-group">
                <label>
                    <i class="fa fa-file-lines"></i> Nội dung
                </label>
                <textarea rows="8"
                          name="content"
                          placeholder="Nhập nội dung chi tiết bài viết..."
                          required></textarea>
            </div>

            <div class="form-group">
                <label>
                    <i class="fa fa-image"></i> Hình ảnh
                </label>
                <input type="file"
                       name="photo"
                       accept="image/*"
                       id="photo">
                <br>
                <img id="preview"
                     class="image-preview"
                     src="https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=600"
                     alt="Preview">
            </div>

            <div style="display: flex; gap: 15px; margin-top: 25px;">
                <button type="submit" class="btn-add">
                    <i class="fa fa-floppy-disk"></i> Lưu bài viết
                </button>

                <button type="reset" class="btn-delete" style="border: none; cursor: pointer;">
                    <i class="fa fa-rotate"></i> Làm mới
                </button>
            </div>

        </form>
    </div>

</div>

<script>
    const photo = document.getElementById("photo");
    const preview = document.getElementById("preview");

    photo.onchange = function () {
        const file = this.files[0];
        if (file) {
            preview.src = URL.createObjectURL(file);
        }
    }
</script>

</body>
</html>