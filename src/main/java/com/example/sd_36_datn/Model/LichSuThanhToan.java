package com.example.sd_36_datn.Model;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@Entity
@Table(name = "LichSuThanhToan")
public class LichSuThanhToan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "tongTien")
    private Integer tongTien;

    @Column(name = "vnpOrderInfo")
    private String vnpOrderInfo;
}
