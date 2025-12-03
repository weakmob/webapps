<%@page import="aiwa.entity.Item"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>商品詳細 - フィギュア検索システム</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 30px 0;
        }
        
        .main-container {
            background: linear-gradient(to bottom, #f5f3ff 0%, #ede9fe 100%);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 40px;
            margin: 0 auto;
        }
        
        .page-title {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 800;
            margin-bottom: 30px;
        }
        
        .btn-back {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 10px 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            color: white;
        }
        
        .btn-back:hover {
            transform: translateX(-5px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        .detail-card {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
            padding: 30px;
            margin-top: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        
        .info-table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .info-table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-weight: 600;
            padding: 15px 20px;
            width: 150px;
            vertical-align: middle;
        }
        
        .info-table td {
            padding: 15px 20px;
            vertical-align: middle;
        }
        
        .info-table tr {
            border-bottom: 1px solid #e0e0e0;
        }
        
        .info-table tr:last-child {
            border-bottom: none;
        }
        
        .price-display {
            font-size: 1.8rem;
            font-weight: 800;
            color: #667eea;
        }
        
        .carousel-container {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        
        .carousel-item img {
            height: 450px;
            object-fit: contain;
            background-color: #f8f9fa;
        }
        
        .carousel-control-prev,
        .carousel-control-next {
            width: 50px;
            height: 50px;
            background: rgba(102, 126, 234, 0.8);
            border-radius: 50%;
            top: 50%;
            transform: translateY(-50%);
            opacity: 1;
        }
        
        .carousel-control-prev {
            left: 20px;
        }
        
        .carousel-control-next {
            right: 20px;
        }
        
        .carousel-control-prev:hover,
        .carousel-control-next:hover {
            background: rgba(102, 126, 234, 1);
        }
        
        .video-container {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            position: relative;
            padding-bottom: 56.25%;
            height: 0;
        }
        
        .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
        }
        
        .section-icon {
            margin-right: 8px;
            color: #667eea;
        }
        
        .item-id-badge {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 600;
        }
        
        .detail-text {
            line-height: 1.8;
            color: #4a5568;
        }
        
        /* Go to top button */
        .btn-top {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 50%;
            font-size: 1.5rem;
            display: none;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
            z-index: 1000;
        }
        
        .btn-top.show {
            display: flex;
        }
        
        .btn-top:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.5);
        }
        
        /* Mobile responsive styles */
        @media (max-width: 768px) {
            body {
                padding: 15px 0;
            }
            
            .main-container {
                padding: 25px;
                border-radius: 15px;
            }
            
            .page-title {
                font-size: 1.75rem;
                margin-bottom: 20px;
            }
            
            .btn-back {
                padding: 8px 20px;
                font-size: 0.9rem;
            }
            
            .detail-card {
                padding: 20px;
                border-radius: 10px;
            }
            
            .carousel-item img {
                height: 300px;
            }
            
            .info-table th {
                width: 100px;
                font-size: 0.9rem;
                padding: 12px 15px;
            }
            
            .info-table td {
                padding: 12px 15px;
                font-size: 0.95rem;
            }
            
            .price-display {
                font-size: 1.5rem;
            }
            
            .carousel-control-prev,
            .carousel-control-next {
                width: 40px;
                height: 40px;
            }
            
            .carousel-control-prev {
                left: 10px;
            }
            
            .carousel-control-next {
                right: 10px;
            }
        }
        
        @media (max-width: 576px) {
            body {
                padding: 10px 0;
            }
            
            .main-container {
                padding: 15px;
                border-radius: 10px;
            }
            
            .page-title {
                font-size: 1.5rem;
                margin-bottom: 15px;
            }
            
            .btn-back {
                padding: 8px 15px;
                font-size: 0.85rem;
            }
            
            .detail-card {
                padding: 15px;
            }
            
            .carousel-item img {
                height: 250px;
            }
            
            .info-table th {
                width: 80px;
                font-size: 0.85rem;
                padding: 10px;
            }
            
            .info-table td {
                padding: 10px;
                font-size: 0.9rem;
            }
            
            .info-table th,
            .info-table td {
                display: block;
                width: 100%;
            }
            
            .info-table th {
                border-bottom: none;
                padding-bottom: 8px;
            }
            
            .info-table td {
                padding-top: 0;
            }
            
            .info-table tr {
                display: block;
                margin-bottom: 15px;
            }
            
            .price-display {
                font-size: 1.3rem;
            }
            
            .item-id-badge {
                padding: 4px 12px;
                font-size: 0.9rem;
            }
            
            .section-icon {
                font-size: 0.9rem;
            }
            
            .btn-top {
                width: 45px;
                height: 45px;
                bottom: 20px;
                right: 20px;
                font-size: 1.3rem;
            }
        }
        
        /* Prevent hover effects on touch devices */
        @media (hover: none) {
            .btn-back:hover {
                transform: none;
            }
            
            .btn-top:hover {
                transform: none;
            }
            
            .carousel-control-prev:hover,
            .carousel-control-next:hover {
                background: rgba(102, 126, 234, 0.8);
            }
        }
    </style>
    
    <%
        Item item = (Item) request.getAttribute("item");
        if (item == null) {
            response.sendRedirect("ItemListController");
            return;
        }
    %>
</head>
<body>
    <div class="container">
        <div class="main-container col-lg-10 col-12 mx-auto">
            <h1 class="page-title display-4">
                <i class="bi bi-box-seam"></i> 商品詳細
            </h1>
            
            <a href="#" class="btn btn-back" onclick="history.back(); return false;">
                <i class="bi bi-arrow-left-circle-fill"></i> 戻る
            </a>
            
            <div class="detail-card">
                <table class="table info-table mb-0">
                    <tr>
                        <th><i class="section-icon bi bi-hash"></i>商品ID</th>
                        <td>
                            <span class="item-id-badge">#<%= item.getItemid() %></span>
                        </td>
                    </tr>
                    
                    <tr>
                        <th><i class="section-icon bi bi-tag-fill"></i>商品名</th>
                        <td>
                            <strong style="font-size: 1.2rem; color: #2d3748;">
                                <%= item.getItemname() %>
                            </strong>
                        </td>
                    </tr>
                    
                    <tr>
                        <th><i class="section-icon bi bi-currency-yen"></i>価格</th>
                        <td>
                            <span class="price-display">
                                <%= String.format("%,d", item.getPrice()) %>円
                            </span>
                        </td>
                    </tr>
                    
                    <tr>
                        <th><i class="section-icon bi bi-file-text-fill"></i>説明</th>
                        <td>
                            <div class="detail-text">
                                <%= item.getDetail().replace("\r\n", "<br>") %>
                            </div>
                        </td>
                    </tr>
                    
                    <tr>
                        <th><i class="section-icon bi bi-images"></i>画像</th>
                        <td>
                            <div id="carouselExample" class="carousel slide carousel-container">
                                <div class="carousel-indicators">
                                    <button type="button" data-bs-target="#carouselExample" 
                                            data-bs-slide-to="0" class="active"></button>
                                    <button type="button" data-bs-target="#carouselExample" 
                                            data-bs-slide-to="1"></button>
                                    <button type="button" data-bs-target="#carouselExample" 
                                            data-bs-slide-to="2"></button>
                                </div>
                                
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <img src="<%= item.getImage1() %>" class="d-block w-100" 
                                             alt="<%= item.getItemname() %> - 画像1">
                                    </div>
                                    <div class="carousel-item">
                                        <img src="<%= item.getImage2() %>" class="d-block w-100" 
                                             alt="<%= item.getItemname() %> - 画像2">
                                    </div>
                                    <div class="carousel-item">
                                        <img src="<%= item.getImage3() %>" class="d-block w-100" 
                                             alt="<%= item.getItemname() %> - 画像3">
                                    </div>
                                </div>
                                
                                <button class="carousel-control-prev" type="button"
                                        data-bs-target="#carouselExample" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon"></span>
                                    <span class="visually-hidden">前へ</span>
                                </button>
                                <button class="carousel-control-next" type="button"
                                        data-bs-target="#carouselExample" data-bs-slide="next">
                                    <span class="carousel-control-next-icon"></span>
                                    <span class="visually-hidden">次へ</span>
                                </button>
                            </div>
                        </td>
                    </tr>
                    
                    <% if (item.getYoutube() != null && !item.getYoutube().trim().isEmpty()) { %>
                    <tr>
                        <th><i class="section-icon bi bi-play-circle-fill"></i>動画</th>
                        <td>
                            <div class="video-container">
                                <iframe 
                                    src="https://www.youtube.com/embed/<%= item.getYoutube() %>" 
                                    title="YouTube video player" 
                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                    referrerpolicy="strict-origin-when-cross-origin" 
                                    allowfullscreen>
                                </iframe>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Go to top button -->
    <button class="btn-top" id="btnTop" onclick="scrollToTop()">
        <i class="bi bi-arrow-up"></i>
    </button>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Show/hide go to top button
        window.addEventListener('scroll', function() {
            const btnTop = document.getElementById('btnTop');
            if (window.pageYOffset > 300) {
                btnTop.classList.add('show');
            } else {
                btnTop.classList.remove('show');
            }
        });
        
        // Smooth scroll to top
        function scrollToTop() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        }
    </script>
</body>
</html>