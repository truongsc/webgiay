package entity;

import java.util.Date;

public class feedback {
    private int id;
    private int uid;
    private int invoice_id;
    private String content;
    private Date created_at;
    private int rating;

    public feedback() {}

    public feedback(int id, int uid, int invoice_id, String content, Date created_at, int rating) {
        this.id = id;
        this.uid = uid;
        this.invoice_id = invoice_id;
        this.content = content;
        this.created_at = created_at;
        this.rating = rating;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getInvoice_id() {
        return invoice_id;
    }

    public void setInvoice_id(int invoice_id) {
        this.invoice_id = invoice_id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    @Override
    public String toString() {
        return "feedback{" + "id=" + id + ", uid=" + uid + ", invoice_id=" + invoice_id + ", content=" + content + ", created_at=" + created_at + ", rating=" + rating + '}';
    }
} 