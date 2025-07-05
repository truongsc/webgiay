/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Chi Tien
 */
public class invoice_detail {
    private int id;
    private  int ivoiceid;
    private int productid;
    private int amount;
    private double priceAtPurchase;
    private product productByProductId; // Thêm field để lưu thông tin product

    public invoice_detail() {
    }

    public invoice_detail(int id, int ivoiceid, int productid, int amount, double priceAtPurchase) {
        this.id = id;
        this.ivoiceid = ivoiceid;
        this.productid = productid;
        this.amount = amount;
        this.priceAtPurchase = priceAtPurchase;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIvoiceid() {
        return ivoiceid;
    }

    public void setIvoiceid(int ivoiceid) {
        this.ivoiceid = ivoiceid;
    }

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public double getPriceAtPurchase() {
        return priceAtPurchase;
    }

    public void setPriceAtPurchase(double priceAtPurchase) {
        this.priceAtPurchase = priceAtPurchase;
    }

    public product getProductByProductId() {
        return productByProductId;
    }

    public void setProductByProductId(product productByProductId) {
        this.productByProductId = productByProductId;
    }

    @Override
    public String toString() {
        return "invoice_detail{" + "id=" + id + ", ivoiceid=" + ivoiceid + ", productid=" + productid + ", amount=" + amount + ", priceAtPurchase=" + priceAtPurchase + '}';
    }

    
    
    
}
