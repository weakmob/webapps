package aiwa.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.entity.Category;
import aiwa.entity.Product;
import aiwa.model.CategoryModel;
import aiwa.model.ProductModel;

/**
 * Servlet implementation class ProductListController
 */
@WebServlet("/ProductListController")
public class ProductListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//	1.Parameter

		String word = request.getParameter("word");
		if (word == null) {
			word = "";
		}
		String categoryId = request.getParameter("categoryId");
		if (categoryId == null) {
			categoryId = "0";

		}
		//		2.Model

		CategoryModel cm = new CategoryModel();
		ArrayList<Category> categories = cm.findAll(getServletContext());

		ProductModel pm = new ProductModel();

		ArrayList<Product> products = pm.findByCondition(getServletContext(),
				word, Integer.parseInt(categoryId));

		//		3.View

		request.setAttribute("products", products);
		request.setAttribute("word", word);
		request.setAttribute("categoryId", Integer.parseInt(categoryId));

		request.setAttribute("categories", categories);

		request.getRequestDispatcher("/productListView.jsp").forward(request, response);

	}

}
