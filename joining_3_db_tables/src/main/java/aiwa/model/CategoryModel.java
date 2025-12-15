package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.entity.Category;

public class CategoryModel {

	public ArrayList<Category> findAll(ServletContext context) {

		ArrayList<Category> result = new ArrayList<Category>();

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:"
					+ context.getRealPath("WEB-INF/sample.db"));

			String sql = "SELECT * FROM categories ORDER BY categoryid";

			PreparedStatement stmt = conn.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Category c = new Category();
				c.setCategoryId(rs.getInt("categoryid"));
				c.setCategoryName(rs.getString("categoryname"));
				result.add(c);

			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();

		}

		return result;

	}

}
