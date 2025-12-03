package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.entity.Anime;

public class AnimeModel {

	public ArrayList<Anime> findByKeyword(ServletContext context, String word) {
		ArrayList<Anime> result = new ArrayList<>();

		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			// Load SQLite driver
			Class.forName("org.sqlite.JDBC");

			// Get DB path inside WEB-INF
			String path = context.getRealPath("WEB-INF/webapp6.db");

			conn = DriverManager.getConnection("jdbc:sqlite:" + path);

			String sql = "SELECT * " +
					"FROM Animes " +
					"WHERE animename LIKE ? OR genre LIKE ?";

			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + word + "%");
			ps.setString(2, "%" + word + "%");

			rs = ps.executeQuery();

			while (rs.next()) {
				Anime a = new Anime();
				a.setAnimeid(rs.getInt("animeid"));
				a.setAnimename(rs.getString("animename"));
				a.setGenre(rs.getString("genre"));
				a.setImage(rs.getString("image"));
				a.setLink(rs.getString("link"));

				result.add(a);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
			}
			try {
				if (ps != null)
					ps.close();
			} catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}

		return result;
	}
}
