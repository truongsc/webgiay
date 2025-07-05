package entity;

public class price_table {
    private int id_price_table;
    private double price;
    private String time_price;
    private int id;

    public price_table() {}

    public price_table(int id_price_table, double price, String time_price, int id) {
        this.id_price_table = id_price_table;
        this.price = price;
        this.time_price = time_price;
        this.id = id;
    }

    public int getId_price_table() {
        return id_price_table;
    }

    public void setId_price_table(int id_price_table) {
        this.id_price_table = id_price_table;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getTime_price() {
        return time_price;
    }

    public void setTime_price(String time_price) {
        this.time_price = time_price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "price_table{" + "id_price_table=" + id_price_table + ", price=" + price + ", time_price=" + time_price + ", id=" + id + '}';
    }
} 