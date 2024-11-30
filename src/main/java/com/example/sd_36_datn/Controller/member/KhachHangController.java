package com.example.sd_36_datn.Controller.member;

import com.example.sd_36_datn.Model.KhachHang;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import com.example.sd_36_datn.Service.KhachHang.KhachHangImpl;
import com.example.sd_36_datn.Service.KhachHang.KhachHangService;
import jakarta.servlet.ServletContext;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller(value = "memberKhachHangController")
public class KhachHangController {

    @Autowired
    ServletContext context;

    @Autowired
    JavaMailSender mailSender;

    @Autowired
    private KhachHangRepository khachHangRepository;

    @Autowired
    private KhachHangService khachHangService;

//    @Autowired
//    private GioHangRepository gioHangRepository;

    @Autowired
    private KhachHangImpl khachHangImpl;


    @Data
    public static class SearchKH{
        String keyword;
        String tenKhachHang;
        String email;
        String matKhau;
        String gioiTinh;
        String ngaySinh;
        String soDienThoai;
        String diaChi;
    }

    @GetMapping("/KhachHang/list")
    public String viewKhachHang(Model model,
                                @RequestParam(name = "pageNumber", required = false, defaultValue = "1") Integer pageNumber,
                                @RequestParam(name = "pageSize", required = false, defaultValue = "5") Integer pageSize,
                                @ModelAttribute("searchKH") SearchKH searchKH)
    {
        List<KhachHang> listKH = khachHangRepository.findAll();
        model.addAttribute("listKH", listKH);

        Pageable pageable = PageRequest.of(pageNumber-1, pageSize);
        Page<KhachHang> page = khachHangService.searchKH(searchKH.keyword, searchKH.tenKhachHang, searchKH.email, searchKH.matKhau, searchKH.gioiTinh, searchKH.ngaySinh, searchKH.soDienThoai, searchKH.diaChi, pageable);

        model.addAttribute("totalPage", page.getTotalPages());
        model.addAttribute("listPage", page.getContent());

        return "KhachHang/index";
    }
}
