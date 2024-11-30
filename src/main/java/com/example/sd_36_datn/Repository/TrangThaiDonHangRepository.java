package com.example.sd_36_datn.Repository;

import com.example.sd_36_datn.Model.TrangThaiDonHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface TrangThaiDonHangRepository extends JpaRepository<TrangThaiDonHang, Long> {

    @Query("SELECT t from TrangThaiDonHang t where t.hoaDon.id = ?1")
    public List<TrangThaiDonHang> findByDonHang(UUID idDonHang);
}
