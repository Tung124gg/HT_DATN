package com.example.sd_36_datn.Repository.SanPham;

import com.example.sd_36_datn.Model.GioHang;
import com.example.sd_36_datn.Model.KhachHang;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface GioHangRepository extends JpaRepository<GioHang, UUID> {

    Optional<GioHang> findGioHangByKhachHang(KhachHang khachHang);

}
