package aiwa.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.entity.Anime;
import aiwa.model.AnimeModel;

@WebServlet("/AnimeListController")
public class AnimeListController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");

		String word = request.getParameter("word");
		if (word == null) {
			word = "";
		}

		AnimeModel am = new AnimeModel();

		ArrayList<Anime> animes = am.findByKeyword(getServletContext(), word);

		request.setAttribute("animes", animes);
		request.setAttribute("word", word);
		request.getRequestDispatcher("/animeListView.jsp").forward(request, response);
	}

}
