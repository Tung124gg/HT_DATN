package com.example.sd_36_datn.Repository;

import com.example.sd_36_datn.Model.LichSuThanhToan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LichSuThanhToanRepository extends JpaRepository<LichSuThanhToan, Long> {

    @Query("select h from LichSuThanhToan h where h.vnpOrderInfo = ?1")
    Optional<LichSuThanhToan> findByOrderId(String vnpOrderInfo);
}
