package com.turf.model;

public class Report {
    private String month;
    private int totalBookings;
    private double totalPayments;

    public String getMonth() { return month; }
    public void setMonth(String month) { this.month = month; }

    public int getTotalBookings() { return totalBookings; }
    public void setTotalBookings(int totalBookings) { this.totalBookings = totalBookings; }

    public double getTotalPayments() { return totalPayments; }
    public void setTotalPayments(double totalPayments) { this.totalPayments = totalPayments; }
}
