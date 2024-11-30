package com.example.sd_36_datn.dto;

import lombok.Data;

import java.util.UUID;

@Data
public class GioHangDto {
    private UUID chiTietId;

    private int soLuong;

    private UUID khachHangId;
}
