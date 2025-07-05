/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Chi Tien
 */
public class userinfor {
    private int uid;
    private String name;
    private int age;
    private String email;
    private String phonenumber;
    private String address;

    public userinfor() {
    }

    public userinfor(int uid, String name, int age, String email, String phonenumber, String address) {
        this.uid = uid;
        this.name = name;
        this.age = age;
        this.email = email;
        this.phonenumber = phonenumber;
        this.address = address;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "userinfor{" + "uid=" + uid + ", name=" + name + ", age=" + age + ", email=" + email + ", phonenumber=" + phonenumber + ", address=" + address + '}';
    }

   
    
    
}
