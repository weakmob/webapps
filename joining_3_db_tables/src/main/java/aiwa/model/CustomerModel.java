package aiwa.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import aiwa.entity.Customer;
import aiwa.entity.CustomerClass;
import aiwa.entity.Prefectural;

public class CustomerModel {

	public ArrayList<Customer> findByCondition(ServletContext context, String word, int customerclassid,
			int prefecturalid) {
		ArrayList<Customer> result = new ArrayList<Customer>();

		try {
			Class.forName("org.sqlite.JDBC");

			Connection conn = DriverManager.getConnection("jdbc:sqlite:"
					+ context.getRealPath("WEB-INF/sample.db"));

			String sql = "SELECT * FROM customers c "
					+ "INNER JOIN customerclasses cc ON c.customerclassid = cc.customerclassid "
					+ "INNER JOIN prefecturals p ON c.prefecturalid = p.prefecturalid "
					+ "WHERE (customername LIKE ? or address LIKE ?)  ";

			if (customerclassid > 0) {
				sql += " AND c.customerclassid = ? ";
			}
			if (prefecturalid > 0) {
				sql += " AND c.prefecturalid = ? ";
			}

			sql += " ORDER BY customerid";

			PreparedStatement stmt = conn.prepareStatement(sql);

			int index = 1;
			stmt.setString(index++, "%" + word + "%");
			stmt.setString(index++, "%" + word + "%");

			if (customerclassid > 0) {
				stmt.setInt(index++, customerclassid);
			}

			if (prefecturalid > 0) {
				stmt.setInt(index++, prefecturalid);
			}

			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Customer c = new Customer();
				c.setCustomerid(rs.getInt("customerid"));
				c.setCustomername(rs.getString("customername"));
				c.setCustomercode(rs.getInt("customercode"));
				c.setAddress(rs.getString("address"));

				CustomerClass cc = new CustomerClass();
				cc.setCustomerclassid(rs.getInt("customerclassid"));
				cc.setCustomerclassname(rs.getString("customerclassname"));

				Prefectural p = new Prefectural();
				p.setPrefecturalid(rs.getInt("prefecturalid"));
				p.setPrefecturalname(rs.getString("prefecturalname"));

				c.setCustomerclass(cc);
				c.setPrefectural(p);

				result.add(c);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
