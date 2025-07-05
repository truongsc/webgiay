/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author Chi Tien
 */
public class invoice {
    private  int ivid;
    private int uid;
    private String date;
    private String description;
    private int total;
    private String status;
    
    public invoice(){
        
    }

    public invoice(int ivid, int uid, String date, String description, int total, String status) {
        this.ivid = ivid;
        this.uid = uid;
        this.date = date;
        this.description = description;
        this.total = total;
        this.status = status;
    }

    public int getIvid() {
        return ivid;
    }

    public void setIvid(int ivid) {
        this.ivid = ivid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "invoice{" + "ivid=" + ivid + ", uid=" + uid + ", date=" + date + ", description=" + description + ", total=" + total + ", status=" + status + '}';
    }

    
    
}
