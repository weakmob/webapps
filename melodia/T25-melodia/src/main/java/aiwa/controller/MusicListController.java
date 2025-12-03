package aiwa.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.entity.Music;
import aiwa.model.MusicModel;

@WebServlet("/MusicListController")
public class MusicListController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        // 1) Get parameters
        String word = request.getParameter("word");
        String lang = request.getParameter("lang");
        String genre = request.getParameter("genre");
        String sort = request.getParameter("sort");

        if (word == null) word = "";
        if (lang == null) lang = "";
        if (genre == null) genre = "";
        if (sort == null) sort = "";

        // 2) Call new model search()
        MusicModel mm = new MusicModel();
        ArrayList<Music> musics = mm.search(getServletContext(), word, lang, genre, sort);

        // 3) Send to JSP
        request.setAttribute("musics", musics);
        request.setAttribute("word", word);
        request.setAttribute("lang", lang);
        request.setAttribute("genre", genre);
        request.setAttribute("sort", sort);

        // 4) Forward
        request.getRequestDispatcher("/MusicListView.jsp").forward(request, response);
    }
}
