package com.example.sd_36_datn.Repository.SanPham.ThuocTinh;


import java.util.List;
import java.util.UUID;

import com.example.sd_36_datn.Model.DayGiay;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DayGiayRepository extends JpaRepository<DayGiay, UUID> {

    List<DayGiay> findByTenDayGiayContainingOrderById(String tenDayGiay);

}
