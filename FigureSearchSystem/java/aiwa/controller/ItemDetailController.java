package aiwa.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.entity.Item;
import aiwa.model.ItemModel;

@WebServlet("/ItemDetailController")
public class ItemDetailController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//1.Parameter
		String itemId = request.getParameter("itemId");

		//2.Model
		ItemModel im = new ItemModel();
		Item item = im.findByID(getServletContext(), Integer.parseInt(itemId));

		//3.View
		request.setAttribute("item", item);
		request.getRequestDispatcher("/itemDetailView.jsp").forward(request, response);

	}
}
