<%@ page import="aiwa.entity.Item"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>フィギュア検索システム</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
        }
        
        .main-container {
            background: linear-gradient(to bottom, #f5f3ff 0%, #ede9fe 100%);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 40px;
        }
        
        .page-title {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 800;
            margin-bottom: 30px;
        }
        
        .search-card {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
            padding: 20px;
            border: none;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            max-width: 800px;
            margin: 0 auto 2rem auto;
        }
        
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            padding: 10px 12px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-search {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.4);
        }
        
        .item-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            height: 100%;
        }
        
        .item-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }
        
        .item-card img {
            height: 400px;
            object-fit: contain;
            transition: transform 0.3s ease;
            background: white;
        }
        
        .item-card:hover img {
            transform: scale(1.05);
        }
        
        .card-title {
            font-weight: 700;
            color: #2d3748;
            font-size: 1.1rem;
            height: 3em;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        .price-tag {
            font-size: 1.3rem;
            font-weight: 800;
            color: #667eea;
            margin: 10px 0;
        }
        
        .btn-show {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            font-weight: 600;
            padding: 10px;
            transition: all 0.3s ease;
        }
        
        .btn-show:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .result-count {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border-radius: 50px;
            display: inline-block;
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: #718096;
        }
        
        .no-results i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        /* Mobile responsive styles */
        @media (max-width: 768px) {
            body {
                padding: 10px 0;
            }
            
            .main-container {
                padding: 20px;
                border-radius: 15px;
            }
            
            .page-title {
                font-size: 1.75rem;
                margin-bottom: 20px;
            }
            
            .search-card {
                padding: 15px;
                border-radius: 10px;
            }
            
            .item-card img {
                height: 250px;
            }
            
            .card-title {
                font-size: 1rem;
            }
            
            .price-tag {
                font-size: 1.1rem;
            }
            
            .no-results {
                padding: 40px 20px;
            }
            
            .no-results i {
                font-size: 3rem;
            }
            
            .result-count {
                font-size: 0.9rem;
                padding: 8px 16px;
            }
        }
        
        @media (max-width: 576px) {
            .main-container {
                padding: 15px;
                border-radius: 10px;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .search-card {
                padding: 15px;
            }
            
            .item-card img {
                height: 200px;
            }
            
            .form-control, .form-select {
                padding: 10px 12px;
            }
            
            .btn-search, .btn-show {
                padding: 10px;
                font-size: 0.9rem;
            }
            
            .card-body {
                padding: 15px;
            }
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
        
        .btn-reset {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            border: none;
            border-radius: 10px;
            padding: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
            color: white;
        }
        
        .btn-reset:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(245, 87, 108, 0.4);
            color: white;
        }
        
        /* Prevent hover effects on touch devices */
        @media (hover: none) {
            .item-card:hover {
                transform: none;
            }
            
            .item-card:hover img {
                transform: none;
            }
            
            .btn-search:hover,
            .btn-show:hover,
            .btn-reset:hover,
            .btn-top:hover {
                transform: none;
            }
        }
        
        @media (max-width: 576px) {
            .btn-top {
                width: 45px;
                height: 45px;
                bottom: 20px;
                right: 20px;
                font-size: 1.3rem;
            }
        }
    </style>
    
    <%
        @SuppressWarnings("unchecked")
        ArrayList<Item> items = (ArrayList<Item>)request.getAttribute("items");
        String word = (String)request.getAttribute("word");
        int priceMin = (int)request.getAttribute("priceMin");
        int priceMax = (int)request.getAttribute("priceMax");
        int order = (int)request.getAttribute("order");
        
        // Null safety
        if (word == null) word = "";
        if (items == null) items = new ArrayList<Item>();
    %>
</head>
<body>
    <div class="container my-4">
        <div class="main-container">
            <h1 class="page-title display-4 text-center">
                <i class="bi bi-stars"></i> フィギュア検索システム
            </h1>
            
            <div class="search-card mb-4">
                <form action="ItemListController" method="get">
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label fw-bold">
                                <i class="bi bi-search"></i> キーワード
                            </label>
                            <input class="form-control" type="text" name="word" 
                                   value="<%= word %>" placeholder="商品名で検索...">
                        </div>
                        
                        <div class="col-md-6">
                            <label class="form-label fw-bold">
                                <i class="bi bi-currency-yen"></i> 価格最小
                            </label>
                            <input class="form-control" type="number" name="priceMin"
                                   value="<%= priceMin > 0 ? priceMin : "" %>" 
                                   placeholder="例: 1000" min="0">
                        </div>
                        
                        <div class="col-md-6">
                            <label class="form-label fw-bold">
                                <i class="bi bi-currency-yen"></i> 価格最大
                            </label>
                            <input class="form-control" type="number" name="priceMax"
                                   value="<%= priceMax > 0 ? priceMax : "" %>" 
                                   placeholder="例: 10000" min="0">
                        </div>
                        
                        <div class="col-12">
                            <label class="form-label fw-bold">
                                <i class="bi bi-sort-down"></i> 並び順
                            </label>
                            <select class="form-select" name="order">
                                <option value="0" <%= order == 0 ? "selected" : "" %>>
                                    商品ID順
                                </option>
                                <option value="1" <%= order == 1 ? "selected" : "" %>>
                                    価格の安い順
                                </option>
                                <option value="2" <%= order == 2 ? "selected" : "" %>>
                                    価格の高い順
                                </option>
                            </select>
                        </div>
                        
                        <div class="col-12">
                            <div class="row g-2">
                                <div class="col-md-8">
                                    <button class="btn btn-search btn-primary w-100" type="submit">
                                        <i class="bi bi-search-heart-fill"></i> 検索する
                                    </button>
                                </div>
                                <div class="col-md-4">
                                    <a href="ItemListController" class="btn btn-reset w-100">
                                        <i class="bi bi-arrow-clockwise"></i> リセット
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            
            <% if (items.size() > 0) { %>
                <div class="result-count">
                    <i class="bi bi-check-circle-fill"></i> <%= items.size() %>件の商品が見つかりました
                </div>
                
                <div class="row g-4">
                    <% for (Item item : items) { %>
                        <div class="col-lg-4 col-md-6 col-sm-12">
                            <div class="card item-card">
                                <img src="<%= item.getImage1() %>" class="card-img-top" 
                                     alt="<%= item.getItemname() %>">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title"><%= item.getItemname() %></h5>
                                    <div class="price-tag">
                                        <i class="bi bi-tag-fill"></i> <%= String.format("%,d", item.getPrice()) %>円
                                    </div>
                                    <a href="ItemDetailController?itemId=<%= item.getItemid() %>" 
                                       class="btn btn-show btn-primary w-100 mt-auto">
                                        <i class="bi bi-eye-fill"></i> 詳細を見る
                                    </a>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <div class="no-results">
                    <i class="bi bi-emoji-frown"></i>
                    <h3>検索結果が見つかりませんでした</h3>
                    <p>別のキーワードや条件で検索してみてください</p>
                </div>
            <% } %>
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