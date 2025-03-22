package dto;

import java.util.Date;
import java.util.List;

public class Order {

    private int orderId;
    private Date createDate;
    private int accountId;
    private boolean status;
    private float total;
    private List<OrderDetail> orderDetails; // List of DTOs for OrderDetails

    // Constructors, Getters, and Setters...
    public Order() {
    }

    public Order(int orderId, Date createDate, int accountId, boolean status, float total, List<OrderDetail> orderDetails) {
        this.orderId = orderId;
        this.createDate = createDate;
        this.accountId = accountId;
        this.status = status;
        this.total = total;
        this.orderDetails = orderDetails;
    }

    // Getters and Setters for all attributes
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public boolean getStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
}
