package com.example.sd_36_datn.Service;

import com.example.sd_36_datn.Model.GioHangChiTiet;
import com.example.sd_36_datn.Model.KhachHang;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import com.example.sd_36_datn.Repository.SanPham.GioHangChiTietRepository;
import com.example.sd_36_datn.Repository.SanPham.GioHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.security.Principal;
import java.util.List;

@ControllerAdvice
public class ModelService {

    @Autowired
    KhachHangRepository khachHangRepository;

    @Autowired
    GioHangChiTietRepository gioHangChiTietRepository;

    @Autowired
    GioHangRepository gioHangRepository;

    @ModelAttribute
    public void addGlobalAttributes(Model model, Principal principal) {
        if(principal != null){
            KhachHang khachHang = khachHangRepository.findByEmail(principal.getName());
            if(khachHang != null){
                List<GioHangChiTiet> gioHangChiTiets = gioHangChiTietRepository.findByIdKhachHang(khachHang.getId());
                model.addAttribute("gioHang", gioHangChiTiets);
            }
        }
    }
}
