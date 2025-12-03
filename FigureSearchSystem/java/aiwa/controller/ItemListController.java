package aiwa.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.entity.Item;
import aiwa.model.ItemModel;

@WebServlet("/ItemListController")
public class ItemListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//1)PARAMETER
		String word = request.getParameter("word");
		if (word == null) {
			word = "";
		}
		String priceMin = request.getParameter("priceMin");
		if (priceMin == null || priceMin.equals("")) {
			priceMin = "0";

		}
		String priceMax = request.getParameter("priceMax");
		if (priceMax == null || priceMax.equals("")) {
			priceMax = "0";
		}

		String order = request.getParameter("order");
		if (order == null) {
			order = "0";
		}

		//		2)MODEL
		ItemModel im = new ItemModel();
		ArrayList<Item> items = im.findByCondition(getServletContext(),
				word,
				Integer.parseInt(priceMin),
				Integer.parseInt(priceMax),
				Integer.parseInt(order));

		//	3)VIEW
		request.setAttribute("word", word);
		request.setAttribute("items", items);
		request.setAttribute("priceMin", Integer.parseInt(priceMin));
		request.setAttribute("priceMax", Integer.parseInt(priceMax));
		request.setAttribute("order", Integer.parseInt(order));

		request.getRequestDispatcher("/itemListView.jsp").forward(request, response);
	}

}
