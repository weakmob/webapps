package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.entity.Item;

public class ItemModel {

	///////////	/////////////////////////////////
	////////////////////////////	find by ID////////////////////
	///////////	/////////////////////////////////	
	public Item findByID(ServletContext context, int itemId) {

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:"
					+ context.getRealPath("WEB-INF/webapp7.db"));

			String sql = "SELECT * FROM items WHERE itemid = ?";

			PreparedStatement stmt = conn.prepareStatement(sql);

			stmt.setInt(1, itemId);

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {

				Item item = new Item();

				item.setItemid(rs.getInt("itemid"));
				item.setItemname(rs.getString("itemname"));
				item.setPrice(rs.getInt("price"));
				item.setDetail(rs.getString("detail"));
				item.setImage1(rs.getString("image1"));
				item.setImage2(rs.getString("image2"));
				item.setImage3(rs.getString("image3"));
				item.setYoutube(rs.getString("youtube"));

				conn.close();

				return item;
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	///////////	/////////////////////////////////
	///////////	find by condition/////////////////////////
	//////////////////////////////////////////////////
	public ArrayList<Item> findByCondition(ServletContext context, String word,
			int priceMin, int priceMax, int order) {
		ArrayList<Item> result = new ArrayList<Item>();

		try {

			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:"
					+ context.getRealPath("WEB-INF/webapp7.db"));

			String sql = "select * from items where (itemname like ? or detail like ?) ";

			if (priceMin > 0) {
				sql += "and price >= ? ";
			}
			if (priceMax > 0) {
				sql += "and price <= ? ";
			}

			if (order == 0) {
				sql += "order by itemid";
			} else if (order == 1) {
				sql += "order by price";
			} else if (order == 2) {
				sql += "order by price desc";
			}

			PreparedStatement stmt = conn.prepareStatement(sql);

			int index = 1;

			stmt.setString(index++, "%" + word + "%");
			stmt.setString(index++, "%" + word + "%");

			if (priceMin > 0) {
				stmt.setInt(index++, priceMin);
			}

			if (priceMax > 0) {
				stmt.setInt(index++, priceMax);
			}

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Item item = new Item();

				item.setItemid(rs.getInt("itemid"));
				item.setItemname(rs.getString("itemname"));
				item.setPrice(rs.getInt("price"));
				item.setDetail(rs.getString("detail"));
				item.setImage1(rs.getString("image1"));
				item.setImage2(rs.getString("image2"));
				item.setImage3(rs.getString("image3"));
				item.setYoutube(rs.getString("youtube"));

				result.add(item);
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
