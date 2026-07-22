package entity;

import java.util.Date;

public class Order {

	private int orderID;
	private Date orderDate;
	private int customerID;
	private int employeeID;
	private double totalAmount;
	private String status;

	public Order() {
	}

	public Order(int orderID, Date orderDate, int customerID, int employeeID, double totalAmount, String status) {

		this.orderID = orderID;
		this.orderDate = orderDate;
		this.customerID = customerID;
		this.employeeID = employeeID;
		this.totalAmount = totalAmount;
		this.status = status;
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public int getCustomerID() {
		return customerID;
	}

	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}

	public int getEmployeeID() {
		return employeeID;
	}

	public void setEmployeeID(int employeeID) {
		this.employeeID = employeeID;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
