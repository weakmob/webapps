package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.entity.Prefectural;

public class PrefecturalModel {

	public ArrayList<Prefectural> findAll(ServletContext context) {

		ArrayList<Prefectural> result = new ArrayList<Prefectural>();

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:"
					+ context.getRealPath("WEB-INF/sample.db"));

			String sql = "SELECT * FROM prefecturals ORDER BY prefecturalid";

			PreparedStatement stmt = conn.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Prefectural p = new Prefectural();
				p.setPrefecturalid(rs.getInt("prefecturalid"));
				p.setPrefecturalname(rs.getString("prefecturalname"));
				result.add(p);
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
