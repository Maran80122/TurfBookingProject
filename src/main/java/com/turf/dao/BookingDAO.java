package com.turf.dao;

import java.sql.*;
import java.util.*;
import com.turf.model.Booking;

public class BookingDAO {
    private Connection getConnection() throws Exception {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/turfdb", "root", "Maran@9095");
    }

    public List<Booking> getBookingsByUser(int userId) throws Exception {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setSlot(rs.getString("slot"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                b.setDuration(rs.getInt("duration"));
                b.setStatus(rs.getString("status"));
                list.add(b);
            }
        }
        return list;
    }
}
