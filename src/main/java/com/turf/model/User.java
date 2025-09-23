package com.turf.model;

public class User {
    private int id;
    private String name;
    private String email;
    private String phone;
    private boolean active;

    public User(int id, String name, String email, String phone, boolean active) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.active = active;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public boolean isActive() { return active; }
}
