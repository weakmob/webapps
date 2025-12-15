package aiwa.entity;

public class Customer {

	private int customerid;
	private int customercode;
	private String customername;
	private String address;
	private int customerclassid;
	private int prefecturalid;
	private CustomerClass customerclass;
	private Prefectural prefectural;

	public int getCustomerid() {
		return customerid;
	}

	public CustomerClass getCustomerclass() {
		return customerclass;
	}

	public void setCustomerclass(CustomerClass customerclass) {
		this.customerclass = customerclass;
	}

	public Prefectural getPrefectural() {
		return prefectural;
	}

	public void setPrefectural(Prefectural prefectural) {
		this.prefectural = prefectural;
	}

	public void setCustomerid(int customerid) {
		this.customerid = customerid;
	}

	public int getCustomercode() {
		return customercode;
	}

	public void setCustomercode(int customercode) {
		this.customercode = customercode;
	}

	public String getCustomername() {
		return customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getCustomerclassid() {
		return customerclassid;
	}

	public void setCustomerclassid(int customerclassid) {
		this.customerclassid = customerclassid;
	}

	public int getPrefecturalid() {
		return prefecturalid;
	}

	public void setPrefecturalid(int prefecturalid) {
		this.prefecturalid = prefecturalid;
	}

}
