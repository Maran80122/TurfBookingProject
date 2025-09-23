package com.turf.dao;

import java.sql.*;
import java.util.*;
import com.turf.model.Payment;

public class PaymentDAO {
    private Connection getConnection() throws Exception {
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/turfdb", "root", "Maran@9095");
    }

    public List<Payment> getPaymentsByUser(int userId) throws Exception {
        List<Payment> list = new ArrayList<>();
        String sql = "SELECT * FROM payments1 WHERE user_id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Payment p = new Payment();
                p.setId(rs.getInt("id"));
                p.setBookingId(rs.getInt("booking_id"));
                p.setAmount(rs.getBigDecimal("amount"));
                p.setPaymentMethod(rs.getString("payment_method"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(p);
            }
        }
        return list;
    }
}
