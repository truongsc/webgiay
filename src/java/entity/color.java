/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Chi Tien
 */
public class color {
    private int cid;
    private int pid;
    private String color;
    
    public color() {
        
    }

    public color(int cid, int pid, String color) {
        this.cid = cid;
        this.pid = pid;
        this.color = color;
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    @Override
    public String toString() {
        return "color{" + "cid=" + cid + ", pid=" + pid + ", color=" + color + '}';
    }
    
}
