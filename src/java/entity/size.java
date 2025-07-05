/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Chi Tien
 */
public class size {
    private int sid;
    private int pid;
    private int size;
    private int stock;
 
    public size() {
    }

    public size(int sid, int pid, int size, int stock) {
        this.sid = sid;
        this.pid = pid;
        this.size = size;
        this.stock = stock;
    }

    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }
    
    @Override
    public String toString() {
        return "size{" + "sid=" + sid + ", pid=" + pid + ", size=" + size + ", stock=" + stock + '}';
    }
    
}
