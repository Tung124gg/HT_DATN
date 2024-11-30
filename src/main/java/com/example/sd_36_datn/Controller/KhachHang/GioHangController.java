package com.example.sd_36_datn.Controller.KhachHang;

import com.example.sd_36_datn.Model.GioHangChiTiet;
import com.example.sd_36_datn.Model.HoaDonChiTiet;
import com.example.sd_36_datn.Model.KhachHang;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import com.example.sd_36_datn.Service.GiamGia.ChuongTrinhGiamGiaHoaDonService;
import com.example.sd_36_datn.Service.GioHangService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller()
@RequestMapping("/gio-hang")
@RequiredArgsConstructor
public class GioHangController {
    private final GioHangService cartService;

    @Autowired
    private KhachHangRepository khachHangRepository;;

    private final ChuongTrinhGiamGiaHoaDonService chuongTrinhGiamGiaHoaDonService;

    @GetMapping
    public String gioHang(Model model, Principal principal){
        KhachHang khachHang = khachHangRepository.findByEmail(principal.getName());
        List<GioHangChiTiet> list = cartService.getListGioHangChiTiet(khachHang.getId());

        Double d = 0D;
        for(GioHangChiTiet g : list){
            d += Integer.valueOf(g.getSoLuong()) * Double.valueOf(g.getGiayTheThaoChiTiet().getGiayTheThao().getGiaBan());
        }

        BigDecimal big = new BigDecimal(d);
        model.addAttribute("gioHang", list);
        model.addAttribute("chuongTrinhGiamGiaHoaDon", chuongTrinhGiamGiaHoaDonService.findByTongTienHoaDon(big));
        return "GioHang/index";
    }

    @PostMapping
    public String themSanPhamVaoGioHang(
            @RequestParam UUID chiTietId,
            @RequestParam int soLuong,
            RedirectAttributes model,
            HttpSession session, Principal principal) {
        try {
            // Kiểm tra xem có maKhachHang trong session hay không (người dùng đã đăng nhập)
            KhachHang khachHang = khachHangRepository.findByEmail(principal.getName());

            // Thêm sản phẩm vào giỏ hàng
            GioHangChiTiet gioHangChiTiet = cartService.addToCart(chiTietId, soLuong, khachHang.getId());

            // Cập nhật giỏ hàng trong session
            session.setAttribute("gioHang", cartService.getListGioHangChiTiet(khachHang.getId()));

            // Thêm thông báo thành công
            model.addFlashAttribute("success", "Thêm sản phẩm vào giỏ hàng thành công");

            // Chuyển hướng đến trang chi tiết sản phẩm
            return "redirect:/san-pham/" + gioHangChiTiet.getGiayTheThaoChiTiet().getGiayTheThao().getId();
        } catch (Exception e) {
            // Xử lý ngoại lệ và thông báo lỗi
            model.addFlashAttribute("error", "Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng: " + e.getMessage());
        }

        // Quay lại trang chủ hoặc trang khác khi có lỗi
        return "redirect:/";
    }


    @GetMapping("/delete/{id}")
    public String xoaSanPhamKhoiGioHang(@PathVariable UUID id, HttpSession session, Principal principal) {
        KhachHang khachHang = khachHangRepository.findByEmail(principal.getName());
        cartService.delete(id);
        session.setAttribute("gioHang", cartService.getListGioHangChiTiet(khachHang.getId()));
        return "redirect:/gio-hang";
    }

}
