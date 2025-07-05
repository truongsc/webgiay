/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Chi Tien
 */
public class cart {
    private int CartID;
    private int AccountID;
    private int ProductID;
    private int Amount;
    private String Color;
    private int Size;

    
    public cart(){
    }

    public cart(int CartID, int AccountID, int ProductID, int Amount, String Color, int Size) {
        this.CartID = CartID;
        this.AccountID = AccountID;
        this.ProductID = ProductID;
        this.Amount = Amount;
        this.Color = Color;
        this.Size = Size;
    }

    public int getCartID() {
        return CartID;
    }

    public void setCartID(int CartID) {
        this.CartID = CartID;
    }

    public int getAccountID() {
        return AccountID;
    }

    public void setAccountID(int AccountID) {
        this.AccountID = AccountID;
    }

    public int getProductID() {
        return ProductID;
    }

    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public int getAmount() {
        return Amount;
    }

    public void setAmount(int Amount) {
        this.Amount = Amount;
    }

    public String getColor() {
        return Color;
    }

    public void setColor(String Color) {
        this.Color = Color;
    }

    public int getSize() {
        return Size;
    }

    public void setSize(int Size) {
        this.Size = Size;
    }

    @Override
    public String toString() {
        return "cart{" + "CartID=" + CartID + ", AccountID=" + AccountID + ", ProductID=" + ProductID + ", Amount=" + Amount + ", Color=" + Color + ", Size=" + Size + '}';
    }
    
    
}

