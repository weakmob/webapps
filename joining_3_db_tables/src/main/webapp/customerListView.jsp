<%@page import="aiwa.entity.Prefectural"%>
<%@page import="aiwa.entity.Customer"%>
<%@page import="aiwa.entity.CustomerClass"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>顧客一覧</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<%
ArrayList<Customer> customers = (ArrayList<Customer>) request.getAttribute("customers");
String word = (String) request.getAttribute("word");

ArrayList<CustomerClass> customerclasses = (ArrayList<CustomerClass>) request.getAttribute("customerclasses");
int customerclassid = (int) request.getAttribute("customerclassid");

ArrayList<Prefectural> prefecturals = (ArrayList<Prefectural>) request.getAttribute("prefecturals");
int prefecturalid = (int) request.getAttribute("prefecturalid");
%>

</head>
<body>

<nav class="nav">
  <a class="nav-link" href="ProductListController">商品リスト</a>
  <a class="nav-link active" href="CustomerListController">顧客リスト</a>
</nav>

<h1>顧客一覧</h1>

<form action="CustomerListController">

    <div class="mb-3">
        <input type="text" name="word" placeholder="キーワード" value="<%= word %>">
    </div>

    <!-- CUSTOMER CLASS SELECT -->
    <div class="mb-3">
        <select name="customerclassid" class="form-select" onchange="this.form.submit()">
            <option value="0">すべて</option>
            <% for (CustomerClass cc : customerclasses) { %>
            <option value="<%= cc.getCustomerclassid() %>" 
                    <%= cc.getCustomerclassid() == customerclassid ? "selected" : "" %>>
                <%= cc.getCustomerclassname() %>
            </option>
            <% } %>
        </select>
    </div>

    <!-- PREFECTURAL SELECT -->
    <div class="mb-3">
        <select name="prefecturalid" class="form-select" onchange="this.form.submit()">
            <option value="0">すべて</option>
            <% for (Prefectural p : prefecturals) { %>
            <option value="<%= p.getPrefecturalid() %>" 
                    <%= p.getPrefecturalid() == prefecturalid ? "selected" : "" %>>
                <%= p.getPrefecturalname() %>
            </option>
            <% } %>
        </select>
    </div>

    <button type="submit" class="btn btn-primary">検索</button>

</form>


<table class="table table-striped mt-3">
<tr>
    <th>顧客ID</th>
    <th>顧客コード</th>
    <th>顧客名</th>
    <th>住所</th>
    <th>顧客クラスID</th>
    <th>都道府県ID</th>
</tr>

<% for(Customer c : customers) { %>
<tr>
    <td><%= c.getCustomerid() %></td>
    <td><%= c.getCustomercode() %></td>
    <td><%= c.getCustomername() %></td>
    <td><%= c.getAddress() %></td>
    <td><%= c.getCustomerclass().getCustomerclassname() %></td>
    <td><%= c.getPrefectural().getPrefecturalname() %></td>
</tr>
<% } %>

</table>

</body>
</html>
