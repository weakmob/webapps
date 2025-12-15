<%@page import="aiwa.entity.Category"%>
<%@page import="aiwa.entity.Product"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" >

<% ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("products");
	String word =(String) request.getAttribute("word");
	
	ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
	int categoryId = (int) request.getAttribute("categoryId");
%>

</head>
<body>
<nav class="nav">
  <a class="nav-link active" href="ProductListController">商品リスト</a>
  <a class="nav-link" href="CustomerListController">顧客リスト</a>
</nav>

	<h1> 商品一覧 </h1>
	
	<form action="ProductListController">
		<div class="mb-3">
		<input type = "text" name = "word" placeholder = "キーワード " value ="<%= word %>">
		</div>
		
		<div class="mb-3">
		<select name ="categoryId" class="form-select" onchange="this.form.submit()">
		
		
		<option value="0">すべて</option>
		<% for (Category c : categories) { %>
		
		<option value="<%= c.getCategoryId() %>" <%= c.getCategoryId() == categoryId ? "selected" : "" %>>
		<%= c.getCategoryName() %></option>
		
		<% } %>
		
		</select>
		</div>
		
		<div class="mb-3">
		<button type = "submit" class="btn btn-primary"> 検索 </button>
		</div>
	
	
	</form>
	
	<table class="table table-striped">
	
	<tr> 
	<th>商品ID</th>
	<th>商品名</th>
	<th>キャテゴリー名</th>
	</tr>
	
	<% for(Product p : products){	%>
	<tr>
	<td><%= p.getProductId() %> </td>
	<td><%= p.getProductName() %></td>
	<td><%= p.getCategory().getCategoryName() %></td>
	</tr>
		
	<%} %>
	
	</table>
</body>
</html>