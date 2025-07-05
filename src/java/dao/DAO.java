/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import context.DBContext;
import entity.account;
import entity.cart;
import entity.category;
import entity.color;
import entity.invoice;
import entity.invoice_detail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import entity.product;
import entity.size;
import entity.type;
import entity.userinfor;
import java.sql.SQLException;
import java.util.ArrayList;
import entity.feedback;

/**
 *
 * @author Chi Tien
 */
public class DAO {
    
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    public List<product> getAllProduct() {
        List<product> list = new ArrayList<>();
        String query = "select * from product";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<cart> getAllCart() {
        List<cart> list = new ArrayList<>();
        String query = "select * from cart";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new cart(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    
    
    public List<cart> getCartByAccountID(int AccountID) {
        List<cart> list = new ArrayList<>();
        String query = "select * from cart\n" +
                        "where AccountID =?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, AccountID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new cart(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<invoice> getInvoicebyID(int uid) {
        List<invoice> list = new ArrayList<>();
        String query = "SELECT * FROM invoice\n" +
                        "where uid = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, uid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new invoice(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    
    public List<product> getProductBycid(String cid) {
        List<product> list = new ArrayList<>();
        String query = "SELECT * FROM product\n" 
                        +"WHERE cateID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, cid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<product> getProductBytid(String tid) {
        List<product> list = new ArrayList<>();
        String query = "SELECT * FROM product\n" +
                        "WHERE typeid = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, tid);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<userinfor> getAllUserinfor() {
        List<userinfor> list = new ArrayList<>();
        String query = "select * from userinfor";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new userinfor(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<account> getAllAccount() {
        List<account> list = new ArrayList<>();
        String query = "SELECT * FROM account;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new account(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getInt(5)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    
    public userinfor getUserinforByuid(String uid) {
        String query = "select * from userinfor\n" +
                        "where uID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, uid);
            rs = ps.executeQuery();
            while (rs.next()) {
               return  new userinfor(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (Exception e) {
        }
        return null; 
    }
    
    public void editUserinfor(int uid, String name, String age, String email, String phonenumber, String address){
        String query = "update userinfor\n" +
                        "set \n" +
                        "name = ?,\n" +
                        "age = ?,\n" +
                        "email = ?,\n" +
                        "phonenumber = ?,\n" +
                        "address = ?\n" +
                        "where uID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, age);
            ps.setString(3, email);
            ps.setString(4, phonenumber);
            ps.setString(5, address);
            ps.setInt(6, uid);
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    
    
    public List<product> searchByname(String txtSearch) {
        List<product> list = new ArrayList<>();
        String query = "SELECT * FROM product\n" +
                        "WHERE name like ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1,"%"+ txtSearch+"%");
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public product getProductByid(String id) {
        String query = "SELECT * FROM product\n" 
                        +"WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9));
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public List<size> getSizeByid(String id) {
        List<size> list = new ArrayList<>();
        String query = "SELECT * FROM size\n" +
                        "where pid = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new size(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<color> getColorByid(String id) {
        List<color> list = new ArrayList<>();
        String query = "SELECT * FROM color\n" +
                        "where pid = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new color(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3)));
            }
        } catch (Exception e) {
        }
        return list; 
    }

        


    
    public List<category> getAllCategory() {
        List<category> list = new ArrayList<>();
        String query = "SELECT * FROM category;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new category(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<type> getAllType() {
        List<type> list = new ArrayList<>();
        String query = "SELECT * FROM type;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new type(rs.getInt(1),
                        rs.getString(2)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<product> getTop3Product() {
        List<product> list = new ArrayList<>();
        String query = 
                        "SELECT \n" +
                        "    p.id,\n" +
                        "    p.name,\n" +
                        "    p.image,\n" +
                        "    p.price,\n" +
                        "    p.title,\n" +
                        "    p.description,\n" +
                        "    p.cateID,\n" +
                        "    p.typeid,\n" +
                        "    p.stock,\n" +
                        "    SUM(d.amount) AS total_sold\n" +
                        "FROM invoice_detail d\n" +
                        "JOIN product p \n" +
                        "  ON d.product_id = p.id\n" +
                        "GROUP BY \n" +
                        "    p.id, p.name, p.image, p.price, p.title, p.description, p.cateID\n" +
                        "ORDER BY total_sold DESC\n" +
                        "LIMIT 3;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    
    public List<category> getTop3Category() {
        List<category> list = new ArrayList<>();
        String query = "SELECT \n" +
                        "    cat.cid,\n" +
                        "    cat.cname,\n" +
                        "    cat.cimage,\n" +
                        "    SUM(c.Amount) AS total_sold\n" +
                        "FROM \n" +
                        "    cart c\n" +
                        "JOIN \n" +
                        "    product p ON c.ProductID = p.id\n" +
                        "JOIN \n" +
                        "    category cat ON p.cateID = cat.cid\n" +
                        "GROUP BY \n" +
                        "    cat.cid, cat.cname, cat.cimage\n" +
                        "ORDER BY \n" +
                        "    total_sold DESC\n" +
                        "LIMIT 3;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new category(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    
    
    
    
    public account login(String user, String pass) {
        String query = "SELECT * FROM account WHERE user = ? AND pass = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            
            System.out.println("Executing login query for user: " + user);
            
            if (rs.next()) {
                account acc = new account(rs.getInt(1),
                                    rs.getString(2),
                                    rs.getString(3),
                                    rs.getInt(4),
                                    rs.getInt(5));
                System.out.println("Login successful for user: " + user + ", ID: " + acc.getId());
                return acc;
            } else {
                System.out.println("No account found for user: " + user);
            }
        } catch (Exception e) {
            System.out.println("Database error during login: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.out.println("Error closing database connections: " + e.getMessage());
            }
        }
        return null;
    }
    
    public account checkacountexist(String user) {
        String query = "SELECT * FROM account\n" + "WHERE user = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new account(rs.getInt(1),
                                    rs.getString(2),
                                    rs.getString(3),
                                    rs.getInt(4),
                                    rs.getInt(5));
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public void signup(String user, String pass){
        String query = "insert into account (user,pass,isSell, isAdmin)\n" +
                        "values  (?,?,0,0);";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    
    public void insertUserinfor(int uID,String name, String age, String email, String phonenumber, String address){
        String query = "insert into userinfor(uID,name,age,email,phonenumber,address)\n" +
                        "values (?,?,?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, uID);
            ps.setString(2, name);
            ps.setString(3, age);
            ps.setString(4, email);
            ps.setString(5, phonenumber);
            ps.setString(6, address);
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    
    
    public void deleteProduct(String pid){
        String query = "delete  FROM product\n" +
                        "where id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, pid);
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    
    public void insertProduct(String name, String image, String price, String title, String description, String cateID){
        String query = "insert into product (name,image,price,title,description,cateID)\n" +
                        "values(?,?,?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setString(3, price);
            ps.setString(4, title);
            ps.setString(5, description);
            ps.setString(6, cateID);
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    public void editProduct(String name, String image, String price, String title, String description, String cateID, String id){
        StringBuilder query = new StringBuilder("update product set name = ?, image = ?, ");
        boolean updatePrice = (price != null && !price.trim().isEmpty());
        if (updatePrice) {
            query.append("price = ?, ");
        }
        query.append("title = ?, description = ?, cateID = ? where id = ?;");
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query.toString());
            int idx = 1;
            ps.setString(idx++, name);
            ps.setString(idx++, image);
            if (updatePrice) {
                ps.setString(idx++, price);
            }
            ps.setString(idx++, title);
            ps.setString(idx++, description);
            ps.setString(idx++, cateID);
            ps.setString(idx++, id);
            ps.executeUpdate();     
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    public cart checkpCartExist(String AccountID, String ProductID, String Size, String Color) {
        String query = "SELECT * FROM cart\n" +
                        "where AccountID = ? And ProductID = ? And Size = ? And Color = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, AccountID);
            ps.setString(2, ProductID);
            ps.setString(3, Size);
            ps.setString(4, Color);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new cart(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6));
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public void insertProductToCart(String AccountID, String ProductID, String Amount,String Color,String Size){
        String query = "insert into cart (AccountID, ProductID, Amount, Color, Size)\n" +
                        "values (?,?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, AccountID);
            ps.setString(2, ProductID);
            ps.setString(3, Amount);
            ps.setString(4, Color);
            ps.setString(5, Size);
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    
    public void updateAmountProductInCart(String AccountID, String ProductID, String Size, String Color, String Amount){
        String query = "UPDATE cart \n" +
                        "SET Amount = Amount + ? \n" +
                        "WHERE AccountID = ? AND ProductID = ? And Size = ? And Color = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            
            ps.setString(1, Amount);
            ps.setString(2, AccountID);
            ps.setString(3, ProductID);
            ps.setString(4, Size);
            ps.setString(5, Color);
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    
    public cart checkCartBeforePayment(int uid) {
        String query = "SELECT * FROM cart\n" +
                        "where AccountID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, uid);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new cart(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6));
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public void updateCartAfterPayment(int uid){
        String query = "delete from cart\n" +
                        "where AccountID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query); 
            ps.setInt(1, uid);       
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    

    
    
    public void insertInvoice(int uid, String date, String description,String total){
        String query = "insert into invoice(uid,date, description,total,status)\n" +
                        "values(?,?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, uid);
            ps.setString(2, date);
            ps.setString(3, description);
            ps.setString(4, total);
            ps.setString(5, "Chờ xác nhận"); // Đặt status khi khách hàng đặt hàng
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    
    
    public int getLatestInvoiceId(int uid) {
    String query = "SELECT MAX(ivid) AS latest_id FROM invoice WHERE uid = ?";
    try {
        conn = new DBContext().getConnection();
        ps = conn.prepareStatement(query);
        ps.setInt(1, uid);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("latest_id");
        }
    } catch (SQLException e) {
    }
    return -1; 
    }
    
    public void insertInvoiceDetail(int invoiceID, int productID, int amount){
        Double priceAtPurchase = getLatestPriceByProductId(productID);
        if (priceAtPurchase == null) {
            product p = getProductByid(String.valueOf(productID));
            priceAtPurchase = (p != null) ? p.getPrice() : 0.0;
        }
        String query = "insert into invoice_detail (invoice_id, product_id, amount, price_at_purchase) values (?,?,?,?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, invoiceID);
            ps.setInt(2, productID);
            ps.setInt(3, amount);
            ps.setDouble(4, priceAtPurchase);
            ps.executeUpdate();     
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<invoice_detail> getInvoiceDetailsByInvoiceId(int invoiceId) {
        List<invoice_detail> list = new ArrayList<>();
        String query = "SELECT id.*, p.* FROM invoice_detail id JOIN product p ON id.product_id = p.id WHERE id.invoice_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, invoiceId);
            rs = ps.executeQuery();
            while (rs.next()) {
                invoice_detail detail = new invoice_detail(
                    rs.getInt("id"),
                    rs.getInt("invoice_id"), 
                    rs.getInt("product_id"),
                    rs.getInt("amount"),
                    rs.getDouble("price_at_purchase")
                );
                // Tạo object product cho detail
                product prod = new product(
                    rs.getInt("product_id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getDouble("price"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("cateID"),
                    rs.getInt("typeid"),
                    rs.getInt("stock")
                );
                detail.setProductByProductId(prod);
                list.add(detail);
            }
        } catch (Exception e) {
        }
        return list;
    }
    
    public List<invoice_detail> getSOLD() {
        List<invoice_detail> list = new ArrayList<>();
        String query = "SELECT product_id, SUM(amount) AS amount\n" +
                        "FROM invoice_detail\n" +
                        "GROUP BY product_id;";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new invoice_detail(0,0,
                        rs.getInt(1),
                        rs.getInt(2),
                        0.0));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    public List<product> getProductSold3Month() {
        List<product> list = new ArrayList<>();
        String query = "SELECT DISTINCT p.*\n" +
                        "FROM Product p\n" +
                        "JOIN invoice_detail id ON p.id = id.product_id\n" +
                        "JOIN invoice i ON id.invoice_id = i.ivid\n" +
                        "WHERE i.date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<product> getProductUNSold3Month() {
        List<product> list = new ArrayList<>();
        String query = "SELECT p.*\n" +
"FROM product p\n" +
"WHERE NOT EXISTS (\n" +
"  SELECT 1\n" +
"  FROM invoice_detail id\n" +
"  JOIN invoice i \n" +
"    ON id.invoice_id = i.ivid\n" +
"  WHERE id.product_id = p.id\n" +
"    AND STR_TO_DATE(i.`date`, '%Y-%m-%d') \n" +
"        >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)\n" +
");";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new product(rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getDouble(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getInt(9)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public void deleteCart(int AccountID,String ProductID, String Amount, String Color, String Size ){
        String query = "delete from cart\n" +
                        "where AccountID = ? and ProductID = ? and Amount = ? and Color = ? and Size = ? ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, AccountID);
            ps.setString(2, ProductID);
            ps.setString(3, Amount);
            ps.setString(4, Color);
            ps.setString(5, Size);
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    
    public static void main(String[] args) {
        DAO dao = new DAO();
        List<product> list = dao.getTop3Product();
        List<color> lists = dao.getColorByid("1");
        List<invoice_detail> list2 = dao.getSOLD();
        for (product o : list){
            System.out.println(o);
        }
        int a = dao.getLatestInvoiceId(8);
        System.out.println(a);
    }
    
    // =============== FEEDBACK METHODS ===============
    public List<feedback> getAllFeedback() {
        List<feedback> list = new ArrayList<>();
        String query = "SELECT * FROM feedback ORDER BY created_at DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new feedback(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getTimestamp(5),
                        rs.getInt(6)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<feedback> getFeedbackByProductId(int productId) {
        List<feedback> list = new ArrayList<>();
        String query = "SELECT f.* FROM feedback f " +
                       "JOIN invoice_detail id ON f.invoice_id = id.invoice_id " +
                       "WHERE id.product_id = ? ORDER BY f.created_at DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new feedback(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getTimestamp(5),
                        rs.getInt(6)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public void insertFeedback(int uid, int invoiceId, String content, int rating) {
        String query = "INSERT INTO feedback (uid, invoice_id, content, created_at, rating) " +
                       "VALUES (?, ?, ?, NOW(), ?)";
        try {
            System.out.println("=== DAO INSERT FEEDBACK ===");
            System.out.println("Query: " + query);
            System.out.println("Parameters: uid=" + uid + ", invoiceId=" + invoiceId + ", content=" + content + ", rating=" + rating);
            
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, uid);
            ps.setInt(2, invoiceId);
            ps.setString(3, content);
            ps.setInt(4, rating);
            
            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            System.out.println("Insert feedback SUCCESS!");
            
        } catch (Exception e) {
            System.err.println("ERROR in insertFeedback: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Lỗi insert feedback: " + e.getMessage(), e);
        }
    }
    
    public void updateFeedback(int feedbackId, String content, int rating) {
        String query = "UPDATE feedback SET content = ?, rating = ?, created_at = NOW() WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, content);
            ps.setInt(2, rating);
            ps.setInt(3, feedbackId);
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    
    public feedback getFeedbackByInvoiceId(int invoiceId) {
        String query = "SELECT * FROM feedback WHERE invoice_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, invoiceId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new feedback(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getTimestamp(5),
                        rs.getInt(6));
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    public List<feedback> getFeedbackByUserId(int userId) {
        List<feedback> list = new ArrayList<>();
        String query = "SELECT f.* FROM feedback f " +
                       "JOIN invoice i ON f.invoice_id = i.ivid " +
                       "WHERE i.uid = ? ORDER BY f.created_at DESC";
        try {
            System.out.println("=== DAO GET FEEDBACK BY USER ===");
            System.out.println("Query: " + query);
            System.out.println("UserId: " + userId);
            
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new feedback(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getTimestamp(5),
                        rs.getInt(6)));
            }
            
            System.out.println("Found " + list.size() + " feedback records for user " + userId);
            
        } catch (Exception e) {
            System.err.println("ERROR in getFeedbackByUserId: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    
    public double getAverageRatingByProductId(int productId) {
        String query = "SELECT AVG(f.rating) as avg_rating FROM feedback f " +
                       "JOIN invoice_detail id ON f.invoice_id = id.invoice_id " +
                       "WHERE id.product_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("avg_rating");
            }
        } catch (Exception e) {
        }
        return 0.0;
    }
    
    public int getFeedbackCountByProductId(int productId) {
        String query = "SELECT COUNT(*) as count FROM feedback f " +
                       "JOIN invoice_detail id ON f.invoice_id = id.invoice_id " +
                       "WHERE id.product_id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (Exception e) {
        }
        return 0;
    }
    
    // =============== INVOICE MANAGEMENT METHODS ===============
    public void updateInvoiceStatus(int invoiceId, String status) {
        String query = "UPDATE invoice SET status = ? WHERE ivid = ?";
        try {
            // Debug connection
            System.out.println("=== DEBUG updateInvoiceStatus ===");
            System.out.println("Input - InvoiceID: " + invoiceId + ", Status: '" + status + "'");
            
            conn = new DBContext().getConnection();
            if (conn == null) {
                throw new RuntimeException("Không thể kết nối database!");
            }
            System.out.println("Database connected successfully");
            
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, invoiceId);
            
            System.out.println("Executing query: " + query);
            System.out.println("Parameters: status='" + status + "', invoiceId=" + invoiceId);
            
            int rowsAffected = ps.executeUpdate();
            
            System.out.println("Query executed - Rows affected: " + rowsAffected);
            
            if (rowsAffected == 0) {
                throw new RuntimeException("Không tìm thấy đơn hàng với ID: " + invoiceId);
            }
            
            System.out.println("Update successful!");
            
        } catch (Exception e) {
            System.err.println("ERROR in updateInvoiceStatus:");
            System.err.println("Error type: " + e.getClass().getSimpleName());
            System.err.println("Error message: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Lỗi cập nhật status đơn hàng: " + e.getMessage(), e);
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                System.err.println("Error closing connections: " + e.getMessage());
            }
        }
    }
    
    public void insertInvoiceTest(String query) {
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.executeUpdate();     
        } catch (Exception e) {
        }
    }
    
     public List<invoice> getAllInvoice() {
        List<invoice> list = new ArrayList<>();
        String query = "SELECT * FROM invoice ORDER BY ivid DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                invoice inv = new invoice(rs.getInt("ivid"),
                        rs.getInt("uid"),
                        rs.getString("date"),
                        rs.getString("description"),
                        rs.getInt("total"),
                        rs.getString("status"));
                list.add(inv);
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<invoice> getAllInvoiceWithUserInfo() {
        List<invoice> list = new ArrayList<>();
        String query = "SELECT i.*, u.name as user_name FROM invoice i " +
                       "LEFT JOIN userinfor u ON i.uid = u.uid " +
                       "ORDER BY i.date DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                invoice inv = new invoice(rs.getInt("ivid"),
                        rs.getInt("uid"),
                        rs.getString("date"),
                        rs.getString("description"),
                        rs.getInt("total"),
                        rs.getString("status"));
                list.add(inv);
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public List<invoice> getInvoicesByStatus(String status) {
        List<invoice> list = new ArrayList<>();
        String query = "SELECT i.* FROM invoice i WHERE i.status = ? ORDER BY i.date DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, status);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new invoice(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
        }
        return list; 
    }
    
    public userinfor getUserinforByInvoiceId(int invoiceId) {
        String query = "SELECT u.* FROM userinfor u " +
                       "JOIN invoice i ON u.uid = i.uid " +
                       "WHERE i.ivid = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, invoiceId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new userinfor(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (Exception e) {
        }
        return null;
    }
    
    // Method to check if account exists before creating (improved version)
    public boolean isUsernameAvailable(String username) {
        String query = "SELECT COUNT(*) FROM account WHERE username = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0; // true if username is available
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Method to create complete user (account + userinfo) in transaction
    public boolean createCompleteUser(String username, String password, String name, String age, String email, String phonenumber, String address) {
         String accountQuery = "INSERT INTO account (user, pass, isAdmin) VALUES (?, ?, 0)";
        String userinfoQuery = "INSERT INTO userinfor (uID, name, age, email, phonenumber, address) VALUES (?, ?, ?, ?, ?, ?)";
        
        try {
            conn = new DBContext().getConnection();
            
            // Start transaction
            conn.setAutoCommit(false);
            
            // Create account
            PreparedStatement ps1 = conn.prepareStatement(accountQuery, PreparedStatement.RETURN_GENERATED_KEYS);
            ps1.setString(1, username);
            ps1.setString(2, password);
            int accountResult = ps1.executeUpdate();
            
            if (accountResult > 0) {
                // Get the generated account ID
                ResultSet generatedKeys = ps1.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int accountId = generatedKeys.getInt(1);
                    
                    // Create userinfo
                    PreparedStatement ps2 = conn.prepareStatement(userinfoQuery);
                    ps2.setInt(1, accountId);
                    ps2.setString(2, name);
                    ps2.setString(3, age);
                    ps2.setString(4, email);
                    ps2.setString(5, phonenumber);
                    ps2.setString(6, address);
                    int userinfoResult = ps2.executeUpdate();
                    
                    if (userinfoResult > 0) {
                        // Both operations successful, commit transaction
                        conn.commit();
                        return true;
                    }
                }
            }
            
            // If we reach here, something failed, rollback
            conn.rollback();
            
        } catch (Exception e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    
    // =============== STOCK MANAGEMENT METHODS ===============
    
    // Get stock for specific product and size
    public int getStockByProductAndSize(int productId, int sizeValue) {
        String query = "SELECT stock FROM size WHERE pid = ? AND size = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            ps.setInt(2, sizeValue);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("stock");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Update stock for specific product and size
    public boolean updateSizeStock(int productId, int sizeValue, int newStock) {
        String query = "UPDATE size SET stock = ? WHERE pid = ? AND size = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newStock);
            ps.setInt(2, productId);
            ps.setInt(3, sizeValue);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Decrease stock when order is placed
    public boolean decreaseStock(int productId, int sizeValue, int quantity) {
        String query = "UPDATE size SET stock = stock - ? WHERE pid = ? AND size = ? AND stock >= ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, sizeValue);
            ps.setInt(4, quantity); // Ensure we don't go negative
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Increase stock when restocking
    public boolean increaseStock(int productId, int sizeValue, int quantity) {
        String query = "UPDATE size SET stock = stock + ? WHERE pid = ? AND size = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.setInt(3, sizeValue);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get all sizes with stock for a product
    public List<size> getSizeWithStockByProductId(int productId) {
        List<size> list = new ArrayList<>();
        String query = "SELECT * FROM size WHERE pid = ? ORDER BY size ASC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new size(rs.getInt("sid"),
                        rs.getInt("pid"),
                        rs.getInt("size"),
                        rs.getInt("stock")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Get low stock alerts (stock <= threshold)
    public List<size> getLowStockAlerts(int threshold) {
        List<size> list = new ArrayList<>();
        String query = "SELECT s.*, p.name as product_name FROM size s " +
                       "JOIN product p ON s.pid = p.id " +
                       "WHERE s.stock <= ? ORDER BY s.stock ASC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, threshold);
            rs = ps.executeQuery();
            while (rs.next()) {
                size sizeItem = new size(rs.getInt("sid"),
                        rs.getInt("pid"),
                        rs.getInt("size"),
                        rs.getInt("stock"));
                list.add(sizeItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Update product overall stock (sum of all sizes)
    public boolean updateProductStock(int productId) {
        String query = "UPDATE product SET stock = (SELECT COALESCE(SUM(stock), 0) FROM size WHERE pid = ?) WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            ps.setInt(2, productId);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Check if enough stock available for order
    public boolean isStockAvailable(int productId, int sizeValue, int requestedQuantity) {
        int currentStock = getStockByProductAndSize(productId, sizeValue);
        return currentStock >= requestedQuantity;
    }
    
    // Get stock summary for admin dashboard
    public List<Object[]> getStockSummary() {
        List<Object[]> list = new ArrayList<>();
        String query = "SELECT p.id, p.name, p.stock as total_stock, " +
                       "COUNT(s.sid) as size_variants, " +
                       "MIN(s.stock) as min_stock, " +
                       "MAX(s.stock) as max_stock " +
                       "FROM product p " +
                       "LEFT JOIN size s ON p.id = s.pid " +
                       "GROUP BY p.id, p.name, p.stock " +
                       "ORDER BY p.name ASC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Object[] row = {
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("total_stock"),
                    rs.getInt("size_variants"),
                    rs.getInt("min_stock"),
                    rs.getInt("max_stock")
                };
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy giá mới nhất từ price_table cho một sản phẩm
     */
    public Double getLatestPriceByProductId(int productId) {
        String query = "SELECT price FROM price_table WHERE id = ? ORDER BY time_price DESC LIMIT 1";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("price");
            }
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Thêm giá mới vào price_table cho sản phẩm
     */
    public void insertPriceTable(int productId, double price) {
        String query = "INSERT INTO price_table (price, time_price, id) VALUES (?, CURRENT_TIMESTAMP, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, (int) price);
            ps.setInt(2, productId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Cập nhật thông tin sản phẩm KHÔNG cập nhật trường price
     */
    public void updateProductInfoWithoutPrice(String name, String image, String title, String description, String cateID, String id) {
        String query = "update product set name = ?, image = ?, title = ?, description = ?, cateID = ? where id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, image);
            ps.setString(3, title);
            ps.setString(4, description);
            ps.setString(5, cateID);
            ps.setString(6, id);
            ps.executeUpdate();
        } catch (Exception e) {}
    }

    /**
     * Lấy tổng doanh số từ các đơn đã xác nhận
     */
    public int getTotalRevenue() {
        String query = "SELECT SUM(total) FROM invoice WHERE status = 'Đã xác nhận'";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Lấy danh sách các đơn hàng đã xác nhận
     */
    public List<invoice> getConfirmedInvoices() {
        List<invoice> list = new ArrayList<>();
        String query = "SELECT * FROM invoice WHERE status = 'Đã xác nhận' ORDER BY date DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new invoice(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
             // 1. Đếm đơn hàng hôm nay
    public int getOrdersToday() {
        int count = 0;
        String query = 
            "SELECT COUNT(*) " +
            "FROM invoice " +
            "WHERE DATE(STR_TO_DATE(`date`, '%Y-%m-%d')) = CURDATE()";
        try {
            conn = new DBContext().getConnection();
            ps   = conn.prepareStatement(query);
            rs   = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            // bạn có thể log e.printStackTrace() nếu muốn
        }
        return count;
    }

    // 2. Tổng doanh thu tháng hiện tại
    public double getRevenueThisMonth() {
        double total = 0.0;
        String query =
            "SELECT IFNULL(SUM(`total`),0) " +
            "FROM invoice " +
            "WHERE YEAR(STR_TO_DATE(`date`, '%Y-%m-%d')) = YEAR(CURDATE()) " +
            "  AND MONTH(STR_TO_DATE(`date`, '%Y-%m-%d')) = MONTH(CURDATE())";
        try {
            conn = new DBContext().getConnection();
            ps   = conn.prepareStatement(query);
            rs   = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (Exception e) {
        }
        return total;
    }

    // 3. Doanh thu 7 ngày gần nhất
    public List<Object[]> getRevenueLast7Days() {
        List<Object[]> list = new ArrayList<>();
        String query =
            "SELECT dt.d AS day, COALESCE(t.rev,0) AS rev " +
            "FROM ( " +
            "  SELECT DATE_SUB(CURDATE(), INTERVAL seq DAY) AS d " +
            "  FROM (SELECT 0 seq UNION ALL SELECT 1 UNION ALL SELECT 2 " +
            "        UNION ALL SELECT 3 UNION ALL SELECT 4 " +
            "        UNION ALL SELECT 5 UNION ALL SELECT 6) x " +
            ") dt " +
            "LEFT JOIN ( " +
            "  SELECT DATE(STR_TO_DATE(`date`, '%Y-%m-%d')) AS d, SUM(`total`) AS rev " +
            "  FROM invoice " +
            "  WHERE `date` >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) " +
            "  GROUP BY d " +
            ") t ON dt.d = t.d " +
            "ORDER BY dt.d";
        try {
            conn = new DBContext().getConnection();
            ps   = conn.prepareStatement(query);
            rs   = ps.executeQuery();
            while (rs.next()) {
                // ngày dưới dạng String "yyyy-MM-dd", và doanh thu double
                list.add(new Object[]{
                    rs.getString("day"),
                    rs.getDouble("rev")
                });
            }
        } catch (Exception e) {
        }
        return list;
    }
    // 4. Số khách hàng mới hôm nay
    public int getNewUsersToday() {
        int count = 0;
        String sql = "SELECT COUNT(*)\n" +
                        "FROM userinfor\n" +
                        "WHERE DATE(created_at) = CURDATE()";
        try { 
          conn = new DBContext().getConnection();
          ps   = conn.prepareStatement(sql);
          rs   = ps.executeQuery();
          if(rs.next()) count = rs.getInt(1);
        } catch(Exception e) {}
        return count;
    }

// 5. Số phản hồi 7 ngày qua
public int getFeedbackLast7Days() {
    int count = 0;
    String sql = "SELECT COUNT(*)\n"+
      "FROM feedback\n"+
      "WHERE created_at >= NOW() - INTERVAL 7 DAY";
    try { 
      conn = new DBContext().getConnection();
      ps   = conn.prepareStatement(sql);
      rs   = ps.executeQuery();
      if(rs.next()) count = rs.getInt(1);
    } catch(Exception e) {}
    return count;
}

// 6. Điểm đánh giá trung bình
public double getAvgRating() {
    double avg = 0;
    String sql = "SELECT IFNULL(AVG(rating),0) FROM feedback";
    try { 
      conn = new DBContext().getConnection();
      ps   = conn.prepareStatement(sql);
      rs   = ps.executeQuery();
      if(rs.next()) avg = rs.getDouble(1);
    } catch(Exception e) {}
    return avg;
}

// 7. Top N sản phẩm bán chạy nhất
public List<Object[]> getTopProducts(int topN) {
    List<Object[]> list = new ArrayList<>();
    String sql = "SELECT p.name, SUM(d.amount) AS sold " +
    "FROM invoice_detail d " +
    "JOIN product p ON d.product_id = p.id " +
    "GROUP BY p.name " +
    "ORDER BY sold DESC " +
    "LIMIT ?";
    try {
      conn = new DBContext().getConnection();
      ps   = conn.prepareStatement(sql);
      ps.setInt(1, topN);
      rs   = ps.executeQuery();
      while(rs.next()) {
        list.add(new Object[]{ rs.getString("name"), rs.getInt("sold") });
      }
    } catch(Exception e) {}
    return list;
}

// 8. Sản phẩm tồn kho thấp (<10)
public List<Object[]> getLowStock() {
    List<Object[]> list = new ArrayList<>();
    String sql = "SELECT id, name, stock\n"+
      "FROM product\n"+
      "WHERE stock < 10";
    try {
      conn = new DBContext().getConnection();
      ps   = conn.prepareStatement(sql);
      rs   = ps.executeQuery();
      while(rs.next()) {
        list.add(new Object[]{
          rs.getInt("id"), rs.getString("name"), rs.getInt("stock")
        });
      }
    } catch(Exception e) {}
    return list;
}
}

