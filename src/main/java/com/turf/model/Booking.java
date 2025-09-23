package com.turf.model;

import java.sql.Date;

public class Booking {
    private int id;
    private int userId;
    private String name;
    private String phone;
    private String email;
    private Date bookingDate;
    private String slot;
    private int duration;
    private String status;

    public Booking(int id, int userId, String name, String phone, String email,
                   Date bookingDate, String slot, int duration, String status) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.bookingDate = bookingDate;
        this.slot = slot;
        this.duration = duration;
        this.status = status;
    }

    // ✅ Getters
    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getName() { return name; }
    public String getPhone() { return phone; }
    public String getEmail() { return email; }
    public Date getBookingDate() { return bookingDate; }
    public String getSlot() { return slot; }
    public int getDuration() { return duration; }
    public String getStatus() { return status; }
}
