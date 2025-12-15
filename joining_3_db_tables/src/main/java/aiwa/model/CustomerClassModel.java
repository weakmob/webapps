package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.entity.CustomerClass;

public class CustomerClassModel {

	public ArrayList<CustomerClass> findAll(ServletContext context) {

		ArrayList<CustomerClass> result = new ArrayList<CustomerClass>();

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:"
					+ context.getRealPath("WEB-INF/sample.db"));

			String sql = "SELECT * FROM customerclasses ORDER BY customerclassid";

			PreparedStatement stmt = conn.prepareStatement(sql);

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				CustomerClass cc = new CustomerClass();
				cc.setCustomerclassid(rs.getInt("customerclassid"));
				cc.setCustomerclassname(rs.getString("customerclassname"));
				result.add(cc);
			}

			conn.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
