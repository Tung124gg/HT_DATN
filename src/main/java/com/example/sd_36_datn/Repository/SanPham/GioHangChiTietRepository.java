package com.example.sd_36_datn.Repository.SanPham;


import com.example.sd_36_datn.Model.GiayTheThaoChiTiet;
import com.example.sd_36_datn.Model.GioHang;
import com.example.sd_36_datn.Model.GioHangChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface GioHangChiTietRepository extends JpaRepository<GioHangChiTiet, UUID> {
    Optional<GioHangChiTiet> findByGioHangAndGiayTheThaoChiTiet(GioHang gioHang, GiayTheThaoChiTiet giay);

    List<GioHangChiTiet> findAllByGioHang(GioHang gioHang);

    @Query("select g from GioHangChiTiet g where g.gioHang.khachHang.id = ?1")
    List<GioHangChiTiet> findByIdKhachHang(UUID idKh);
}
