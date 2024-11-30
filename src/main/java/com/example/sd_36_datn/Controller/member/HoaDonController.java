package com.example.sd_36_datn.Controller.member;

import com.example.sd_36_datn.Model.HoaDon;
import com.example.sd_36_datn.Model.HoaDonChiTiet;
import com.example.sd_36_datn.Model.TrangThaiDonHang;
import com.example.sd_36_datn.Model.User;
import com.example.sd_36_datn.Repository.GiayTheThao.GiayTheThaoChiTietRepository;
import com.example.sd_36_datn.Repository.HoaDon.HoaDonChiTietRepository;
import com.example.sd_36_datn.Repository.HoaDon.HoaDonRepository;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.UserRepository;
import com.example.sd_36_datn.Repository.TrangThaiDonHangRepository;
import com.example.sd_36_datn.Service.GiamGia.ChuongTrinhGiamGiaHoaDonService;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoChiTietService;
import com.example.sd_36_datn.Service.HoaDon.HoaDonChiTietServie;
import com.example.sd_36_datn.Service.HoaDon.HoaDonService;
import com.example.sd_36_datn.Service.HoaDon.HoaDonServiceImpl;
import com.example.sd_36_datn.Service.KhachHang.KhachHangService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller(value = "memberHoaDonController")
@RequestMapping("/BanHangTaiQuay")
public class HoaDonController {

    @Autowired
    private GiayTheThaoChiTietService gttctService;

    @Autowired
    private HoaDonService hoaDonService;

    @Autowired
    private HoaDonChiTietServie hoaDonChiTietservie;

    @Autowired
    private KhachHangService khachHangService;

    @Autowired
    private ChuongTrinhGiamGiaHoaDonService ctggHDService;

    @Autowired
    private HoaDonRepository hoaDonRepository;

    @Autowired
    private HoaDonServiceImpl hoaDonServiceImpl;

    @Autowired
    private TrangThaiDonHangRepository trangThaiDonHangRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private HoaDonChiTietRepository hoaDonChiTietRepository;

    @Autowired
    private GiayTheThaoChiTietRepository giayTheThaoChiTietRepository;

    @GetMapping("")
    public String getView(Model model) {
        model.addAttribute("list", gttctService.getAll());
        model.addAttribute("listHDC", hoaDonService.hoaDonCho());
        model.addAttribute("listKH", khachHangService.getAll());
        return "BanHangTaiQuay/BanHangTaiQuayTest";
    }

    @GetMapping("/Admin/xacNhanDonHangKhachHangAll")
    public String showViewXacNhanDonHangAllKhachHang(Model model, @RequestParam(required = false) Integer trangthai) {
        List<HoaDon> list = null;
        if(trangthai == null){
            list = hoaDonRepository.findAllDesc();
        }
        else{
            list = hoaDonRepository.findByTrangThai(trangthai);
        }
        model.addAttribute("listHoaDon", list);
        return "templates/Admin/TrangThaiDonHang/viewHoaDonTrangThaiAll";
    }

    @PostMapping("/capnhattrangthai")
    public String capNhatTrangThai(RedirectAttributes redirectAttributes, HttpServletRequest request, @RequestParam("idhoadon") UUID id){
        HoaDon hoaDon = hoaDonRepository.findById(id).get();
        if(hoaDon.getTrangThai() == 3 || hoaDon.getTrangThai() == 4 || hoaDon.getTrangThai() == 5){
            redirectAttributes.addFlashAttribute("error", "Không thẻ cập nhật trạng thai");
            String referer = request.getHeader("Referer");
            return "redirect:" + referer;
        }
        hoaDon.setTrangThai(hoaDon.getTrangThai() + 1);
        if(hoaDon.getTrangThai() == 3){
            hoaDon.setNgayThanhToan(LocalDateTime.now());
            hoaDon.setTrangThaiMoney(1);
        }
        hoaDonRepository.save(hoaDon);
        TrangThaiDonHang trangThaiDonHang = new TrangThaiDonHang();
        trangThaiDonHang.setTrangThai(hoaDon.getTrangThai());
        trangThaiDonHang.setHoaDon(hoaDon);
        trangThaiDonHang.setNgayCapNhat(LocalDateTime.now());
        trangThaiDonHangRepository.save(trangThaiDonHang);
        redirectAttributes.addFlashAttribute("message", "Cập nhật trạng thái "+getTrangThai(hoaDon.getTrangThai())+" thành công");
        String referer = request.getHeader("Referer");
        return "redirect:" + referer;
    }

    @PostMapping("/huyDon")
    public String huyDon(RedirectAttributes redirectAttributes, HttpServletRequest request, @RequestParam("idhoadon") UUID id){
        HoaDon hoaDon = hoaDonRepository.findById(id).get();
        if(hoaDon.getTrangThai() == 3 || hoaDon.getTrangThai() == 4 || hoaDon.getTrangThai() == 5){
            redirectAttributes.addFlashAttribute("error", "Không thẻ cập nhật trạng thai");
            String referer = request.getHeader("Referer");
            return "redirect:" + referer;
        }
        hoaDon.setTrangThai(4);
        hoaDonRepository.save(hoaDon);
        TrangThaiDonHang trangThaiDonHang = new TrangThaiDonHang();
        trangThaiDonHang.setTrangThai(hoaDon.getTrangThai());
        trangThaiDonHang.setHoaDon(hoaDon);
        trangThaiDonHang.setNgayCapNhat(LocalDateTime.now());
        trangThaiDonHangRepository.save(trangThaiDonHang);
        List<HoaDonChiTiet> hoaDonChiTiets = hoaDonChiTietRepository.findByHoaDon_Id(hoaDon.getId());
        for(HoaDonChiTiet h : hoaDonChiTiets){
            h.getGiayTheThaoChiTiet().setSoLuong(String.valueOf(Integer.valueOf(h.getGiayTheThaoChiTiet().getSoLuong()) + Integer.valueOf(h.getSoLuong())));
            giayTheThaoChiTietRepository.save(h.getGiayTheThaoChiTiet());
        }
        redirectAttributes.addFlashAttribute("message", "Cập nhật trạng thái "+getTrangThai(hoaDon.getTrangThai())+" thành công");
        String referer = request.getHeader("Referer");
        return "redirect:" + referer;
    }

    @PostMapping("/khongNhanHang")
    public String khongNhanHang(RedirectAttributes redirectAttributes, HttpServletRequest request, @RequestParam("idhoadon") UUID id){
        HoaDon hoaDon = hoaDonRepository.findById(id).get();
        if(hoaDon.getTrangThai() == 3 || hoaDon.getTrangThai() == 4 || hoaDon.getTrangThai() == 5){
            redirectAttributes.addFlashAttribute("error", "Không thẻ cập nhật trạng thai");
            String referer = request.getHeader("Referer");
            return "redirect:" + referer;
        }
        hoaDon.setTrangThai(5);
        hoaDonRepository.save(hoaDon);
        TrangThaiDonHang trangThaiDonHang = new TrangThaiDonHang();
        trangThaiDonHang.setTrangThai(hoaDon.getTrangThai());
        trangThaiDonHang.setHoaDon(hoaDon);
        trangThaiDonHang.setNgayCapNhat(LocalDateTime.now());
        trangThaiDonHangRepository.save(trangThaiDonHang);
        List<HoaDonChiTiet> hoaDonChiTiets = hoaDonChiTietRepository.findByHoaDon_Id(hoaDon.getId());
        for(HoaDonChiTiet h : hoaDonChiTiets){
            h.getGiayTheThaoChiTiet().setSoLuong(String.valueOf(Integer.valueOf(h.getGiayTheThaoChiTiet().getSoLuong()) + Integer.valueOf(h.getSoLuong())));
            giayTheThaoChiTietRepository.save(h.getGiayTheThaoChiTiet());
        }
        redirectAttributes.addFlashAttribute("message", "Cập nhật trạng thái "+getTrangThai(hoaDon.getTrangThai())+" thành công");
        String referer = request.getHeader("Referer");
        return "redirect:" + referer;
    }


    @GetMapping("/Admin/xacNhanDonHangKhachHang")
    public ModelAndView adminXacNhanDonHangChoKhachHang(
            Model model,
            @RequestParam(value = "pageNo", required = false, defaultValue = "0") Integer pageNo,
            HttpServletRequest request
    ) {
        // Sắp xếp danh sách đơn hàng theo ngày thanh toán tăng dần (cũ nhất lên đầu tiên)
        List<HoaDon> sortedList = hoaDonServiceImpl.listHoaDonFindByTrangThai(pageNo, 5, 1)
                .getContent()
                .stream()
                .sorted(Comparator.comparing(HoaDon::getNgayThanhToan))
                .collect(Collectors.toList());

        Page<HoaDon> page = new PageImpl<>(sortedList);
        ModelAndView mav = new ModelAndView("/templates/Admin/TrangThaiDonHang/choXacNhan");
        mav.addObject("page", page);
        return mav;
    }

    @GetMapping("/Admin/HoaDon/XacNhanHoaDonDangDongGoi")
    public ModelAndView showFormHoaDonXacNhanGiaoHangThanhCong(

            @RequestParam(value = "pageNo", required = false, defaultValue = "0") Integer pageNo,
            HttpServletRequest request,
            Model model
    ) {
        Page<HoaDon> page = hoaDonServiceImpl.listHoaDonFindByTrangThai(pageNo, 5, 2);
        ModelAndView mav = new ModelAndView("/templates/Admin/TrangThaiDonHang/dangDongGoi");
        mav.addObject("page", page);
        return mav;
    }


    @PostMapping("/Admin/HoaDon/XacNhanHoaDonKhachHangDangGiao")
    public String adminDangGiaoHang(
            HttpServletRequest request,
            HttpSession session
    ) {
        if (session.getAttribute("userLog") != null) {
            User user = (User) session.getAttribute("userLog");

            String thanhCong = request.getParameter("thanhCong");

            HoaDon hoaDon = hoaDonServiceImpl.findId(UUID.fromString(thanhCong));
            HoaDon hd = new HoaDon();

            System.out.println("Đơn hàng chuyển sang trạng thái giao hàng");
            hd.setUser(user);
            hd.setMaHoaDon(hoaDon.getMaHoaDon());
            hd.setThanhTien(hoaDon.getThanhTien());
            hd.setNgayThanhToan(hoaDon.getNgayThanhToan());
            hd.setNgayTao(hoaDon.getNgayTao());
            hd.setKhachHang(hoaDon.getKhachHang());
            hd.setGhiChu(hoaDon.getGhiChu());
            hd.setTrangThai(3);

            hoaDonServiceImpl.update(hoaDon.getId(), hd);
        }

        return "redirect:/Admin/dongGoiThanhCong";

    }


    @GetMapping("/Admin/HoaDon/XacNhanHoaDonGiaoHangThanhCongHoanThanh")
    public ModelAndView showGiaoHangHoanThanh(

            @RequestParam(value = "pageNo", required = false, defaultValue = "0") Integer pageNo,
            HttpServletRequest request,
            Model model

    ) {

        Page<HoaDon> page = hoaDonServiceImpl.listHoaDonFindByTrangThai(pageNo, 5, 4);
        ModelAndView mav = new ModelAndView("/templates/Admin/TrangThaiDonHang/hoanThanh");
        mav.addObject("page", page);
        return mav;

    }


    @GetMapping("thanhToan/{id}")
    public String getViewPay(Model model, @PathVariable("id") UUID id, HttpSession session, Principal principal) {
        User user = userRepository.findByEmail(principal.getName());
        UUID idUser = user.getId();
        hoaDonService.luuIdUserVaoHoaDon(id, idUser);
        List<HoaDonChiTiet> listHDCT = hoaDonChiTietservie.getListByID(id);
        int sl = 0;
        BigDecimal tt = new BigDecimal(0);
        for (HoaDonChiTiet hoaDonChiTiet : listHDCT) {
            sl+=Integer.parseInt(hoaDonChiTiet.getSoLuong());
            BigDecimal soLuong = new BigDecimal(hoaDonChiTiet.getSoLuong());
            tt = tt.add(hoaDonChiTiet.getDonGia().multiply(soLuong));
        }
        model.addAttribute("list", listHDCT);
        model.addAttribute("tt", tt);
        model.addAttribute("listCtgg", ctggHDService.getAllBySlTT(String.valueOf(sl), tt));
        model.addAttribute("id", id);
        return "BanHangTaiQuay/thanhToan";
    }

    public String getTrangThai(int i){
        if(i==0){
            return "Đang chờ xác nhận";
        }
        if(i==1){
            return "Đã xác nhận";
        }
        if(i==2){
            return "Đã được gửi đi";
        }
        if(i==3){
            return "Đã nhận được hàng";
        }
        if(i==4){
            return "Đã hủy";
        }
        if(i==5){
            return "Không nhận hàng";
        }

        return "không xác định";
    }

}
