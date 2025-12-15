package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.entity.Category;
import aiwa.entity.Product;

public class ProductModel {

	public ArrayList<Product> findByCondition(ServletContext context, String word, int categoryId) {
		ArrayList<Product> result = new ArrayList<Product>();

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:"
					+ context.getRealPath("WEB-INF/sample.db"));

			String sql = "SELECT "
					+ "* "
					+ "FROM "
					+ "products p "
					+ "INNER JOIN "
					+ "categories c "
					+ "ON "
					+ " p.categoryid = c.categoryid "
					+ "where "
					+ "productname LIKE ? ";

			if (categoryId > 0) {
				sql += "AND p.categoryid = ? ";
			}

			sql += "ORDER BY productid";

			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setString(1, "%" + word + "%");

			if (categoryId > 0) {
				stmt.setInt(2, categoryId);
			}

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Product p = new Product();
				p.setProductId(rs.getInt("productid"));
				p.setProductName(rs.getString("productname"));

				Category c = new Category();
				c.setCategoryId(rs.getInt("categoryid"));
				c.setCategoryName(rs.getString("categoryname"));

				p.setCategory(c);

				result.add(p);
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
