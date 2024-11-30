package com.example.sd_36_datn.Home;
import com.example.sd_36_datn.Model.GioHangChiTiet;
import com.example.sd_36_datn.Repository.GiayTheThao.GiayTheThaoRepository;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoService;
import com.example.sd_36_datn.Service.GioHangService;
import com.example.sd_36_datn.Service.SanPham.ThuongHieuService;
import com.oracle.wls.shaded.org.apache.bcel.generic.ATHROW;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
@SessionAttributes("gioHang")
public class HomeController {
    private final ThuongHieuService thuongHieuService;
    private final GiayTheThaoService giayTheThaoService;
    private final GiayTheThaoRepository giayTheThaoRepository;
    private final GioHangService cartService;

    @ModelAttribute("gioHang")
    public List<GioHangChiTiet> createGioHang(HttpSession session) {
        Object maKhachHangAttr = session.getAttribute("maKH");
        if (maKhachHangAttr != null) {
            UUID maKhachHang = UUID.fromString(maKhachHangAttr.toString());
            return cartService.getListGioHangChiTiet(maKhachHang);
        } else {
            // Xử lý khi maKH là null (trả về danh sách rỗng hoặc logic khác nếu cần)
            return  new ArrayList<>(); // hoặc throw exception tùy vào yêu cầu của bạn
        }
    }

    @GetMapping("/")
    public String home(Model model, @ModelAttribute("gioHang") List<GioHangChiTiet> gioHang, HttpSession session, @RequestParam(required = false) String search) {
        model.addAttribute("gioHang", gioHang);
        session.setAttribute("thuongHieus", thuongHieuService.findAll());
        model.addAttribute("giayTheThaoMoi", giayTheThaoService.getSanPhamMoi());
        model.addAttribute("giayTheThaoGiaRe", giayTheThaoService.getSanPhamGiaThanhThap());
        if(search != null){
            model.addAttribute("search", search);
            model.addAttribute("giayTheThaoSearch", giayTheThaoRepository.search("%"+search+"%"));
        }
        return "index";
    }
}
