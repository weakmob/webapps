package aiwa.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import aiwa.entity.Customer;
import aiwa.entity.CustomerClass;
import aiwa.entity.Prefectural;
import aiwa.model.CustomerClassModel;
import aiwa.model.CustomerModel;
import aiwa.model.PrefecturalModel;

@WebServlet("/CustomerListController")
public class CustomerListController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//	1	PARAMETER
		String word = request.getParameter("word");
		if (word == null) {
			word = "";
		}

		String customerclassid = request.getParameter("customerclassid");
		if (customerclassid == null) {
			customerclassid = "0";
		}

		String prefecturalid = request.getParameter("prefecturalid");
		if (prefecturalid == null) {
			prefecturalid = "0";
		}

		//	2	MODEL
		CustomerModel cm = new CustomerModel();
		ArrayList<Customer> customers = cm.findByCondition(getServletContext(),
				word, Integer.parseInt(customerclassid), Integer.parseInt(prefecturalid));

		CustomerClassModel ccm = new CustomerClassModel();

		ArrayList<CustomerClass> customerclasses = ccm.findAll(getServletContext());

		PrefecturalModel pm = new PrefecturalModel();

		ArrayList<Prefectural> prefecturals = pm.findAll(getServletContext());

		//		3.View

		request.setAttribute("customers", customers);
		request.setAttribute("customerclasses", customerclasses);
		request.setAttribute("prefecturals", prefecturals);
		request.setAttribute("word", word);
		request.setAttribute("customerclassid", Integer.parseInt(customerclassid));
		request.setAttribute("prefecturalid", Integer.parseInt(prefecturalid));

		request.getRequestDispatcher("/customerListView.jsp").forward(request, response);

	}

}
