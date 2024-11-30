//package com.example.sd_57_datn.Repository.SanPham.ThuocTinh;
//
//import com.example.sd_57_datn.Model.CoGiay;
//import java.util.List;
//import java.util.UUID;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.data.jpa.repository.Query;
//import org.springframework.stereotype.Repository;
//
//@Repository
//public interface CoGiayRepository extends JpaRepository<CoGiay, UUID> {
//
//    @Query("select cg from CoGiay cg where cg.id = ?1")
//    CoGiay getCoGiayById(UUID id);
//
//    Page<CoGiay> findByTrangThai(int trangThai, Pageable pageable);
//
//    List<CoGiay> findByTenCoGiayContaining(String tenCoGiay);
//
//}
