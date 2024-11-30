package com.example.sd_36_datn.Controller.KhachHang;

import com.example.sd_36_datn.Model.KhachHang;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class DangKyController {

    @Autowired
    private KhachHangRepository khachHangRepository;

    @GetMapping("/dang-ky-tai-khoan")
    public String dangKyForm(Model model){
        model.addAttribute("khachhang", new KhachHang());
        return "KhachHang/dangky";
    }

    @PostMapping("/dang-ky-tai-khoan")
    public String postDangky(@ModelAttribute KhachHang khachHang, RedirectAttributes redirectAttributes, HttpServletRequest request){
        KhachHang kh = khachHangRepository.findByEmail(khachHang.getEmail());
        if(kh != null){
            redirectAttributes.addFlashAttribute("error", "Email đã được sử dụng!");
            return "redirect:/dang-ky-tai-khoan";
        }

        if(!khachHang.getMatKhau().equals(request.getParameter("repassword"))){
            redirectAttributes.addFlashAttribute("error", "Mât khẩu không trùng khớp!");
            return "redirect:/dang-ky-tai-khoan";
        }
        if(khachHang.getMatKhau().length() < 5){
            redirectAttributes.addFlashAttribute("error", "Mât khẩu phải > 5 ký tự!");
            return "redirect:/dang-ky-tai-khoan";
        }
        khachHang.setMaKhachHang(String.valueOf(System.currentTimeMillis()));
        khachHangRepository.save(khachHang);
        return "redirect:/UserLog/login";
    }
}
