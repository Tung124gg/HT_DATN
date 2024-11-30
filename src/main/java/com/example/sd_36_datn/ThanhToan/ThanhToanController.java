package com.example.sd_36_datn.ThanhToan;

import com.example.sd_36_datn.Model.ChuongTrinhGiamGiaHoaDon;
import com.example.sd_36_datn.Model.GioHangChiTiet;
import com.example.sd_36_datn.Model.KhachHang;
import com.example.sd_36_datn.Repository.GiamGia.ChuongTrinhGiamGiaHoaDonRepository;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import com.example.sd_36_datn.Repository.SanPham.GioHangChiTietRepository;
import com.example.sd_36_datn.Service.GioHangService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
@RequestMapping("/thanh-toan")
public class ThanhToanController {

    @Autowired
    private KhachHangRepository khachHangRepository;

    @Autowired
    private GioHangChiTietRepository gioHangChiTietRepository;

    @Autowired
    private ChuongTrinhGiamGiaHoaDonRepository chuongTrinhGiamGiaHoaDonRepository;

    private final GioHangService gioHangService;


    @GetMapping("{idKhachHang}")
    public String thanhToan(Model model, @RequestParam(required = false) UUID voucher, Principal principal, HttpSession session, @RequestParam(required = false) List<UUID> giohangchitiet){
        KhachHang khachHang = khachHangRepository.findByEmail(principal.getName());
        if(giohangchitiet == null){
            giohangchitiet = new ArrayList<>();
        }
        if(voucher != null){
            ChuongTrinhGiamGiaHoaDon chuongTrinhGiamGiaHoaDon = chuongTrinhGiamGiaHoaDonRepository.findById(voucher).get();
            if(chuongTrinhGiamGiaHoaDon != null){
                model.addAttribute("voucher", chuongTrinhGiamGiaHoaDon);
                session.setAttribute("voucher", chuongTrinhGiamGiaHoaDon);
            }
        }
        else{
            session.removeAttribute("voucher");
        }
        List<GioHangChiTiet> gioHangChiTiets = new ArrayList<>();
        for(UUID id : giohangchitiet){
            gioHangChiTiets.add(gioHangChiTietRepository.findById(id).get());
        }
        model.addAttribute("gioHangChiTiets",gioHangChiTiets);
        session.setAttribute("gioHangChiTiets", gioHangChiTiets);
        return "ThanhToan/index";
    }
}
