package com.turf.model;

import java.sql.Timestamp;

public class Payment {
    private int id;
    private int bookingId;
    private String name;
    private String email;
    private String phone;
    private String slot;
    private int duration;
    private double amount;
    private String paymentMethod;   // ✅ must exist
    private Timestamp createdAt;

    // Constructor
    public Payment(int id, int bookingId, String name, String email, String phone,
                   String slot, int duration, double amount, String paymentMethod, Timestamp createdAt) {
        this.id = id;
        this.bookingId = bookingId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.slot = slot;
        this.duration = duration;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.createdAt = createdAt;
    }

    // ✅ Getters & Setters
    public int getId() { return id; }
    public int getBookingId() { return bookingId; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getSlot() { return slot; }
    public int getDuration() { return duration; }
    public double getAmount() { return amount; }

    public String getPaymentMethod() { return paymentMethod; }  // ✅ FIXED
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public Timestamp getCreatedAt() { return createdAt; }
}
