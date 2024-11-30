package com.example.sd_36_datn.Controller.KhachHang;

import com.example.sd_36_datn.Model.*;
import com.example.sd_36_datn.Repository.GiayTheThao.GiayTheThaoChiTietRepository;
import com.example.sd_36_datn.Repository.HoaDon.HoaDonChiTietRepository;
import com.example.sd_36_datn.Repository.HoaDon.HoaDonRepository;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import com.example.sd_36_datn.Repository.LichSuThanhToanRepository;
import com.example.sd_36_datn.Repository.SanPham.GioHangChiTietRepository;
import com.example.sd_36_datn.Service.GioHangService;
import com.example.sd_36_datn.vnpay.VNPayService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Controller
public class DatHangController {

    @Autowired
    private KhachHangRepository khachHangRepository;

    @Autowired
    private GioHangService gioHangService;

    @Autowired
    private HoaDonRepository hoaDonRepository;

    @Autowired
    private VNPayService vnPayService;

    @Autowired
    private HoaDonChiTietRepository hoaDonChiTietRepository;

    @Autowired
    private GiayTheThaoChiTietRepository giayTheThaoChiTietRepository;

    @Autowired
    private LichSuThanhToanRepository lichSuThanhToanRepository;

    @Autowired
    private GioHangChiTietRepository gioHangChiTietRepository;

    @RequestMapping(value = {"/checkout"}, method = RequestMethod.POST)
    public String checkoutPost(RedirectAttributes redirectAttributes, HttpServletRequest request,
                               @RequestParam String note, @RequestParam String paytype, @RequestParam String tinh,
                               @RequestParam String huyen, @RequestParam String xa,
                               @RequestParam String tenduong, Principal principal, HttpSession session) {
        KhachHang khachHang = khachHangRepository.findByEmail(principal.getName());
        List<GioHangChiTiet> list = (List<GioHangChiTiet>) session.getAttribute("gioHangChiTiets");
        if(list.size() == 0){
            redirectAttributes.addFlashAttribute("error", "Chưa chọn sản phẩm nào để thanh toán");
            String referer = request.getHeader("Referer");
            return "redirect:" + referer;
        }
        Double d = 0D;
        List<HoaDonChiTiet> hoaDonChiTiets = new ArrayList<>();
        for(GioHangChiTiet g : list){
            d += Integer.valueOf(g.getSoLuong()) * Double.valueOf(g.getGiayTheThaoChiTiet().getGiayTheThao().getGiaBan());
            if(Integer.valueOf(g.getSoLuong()) > Integer.valueOf(g.getGiayTheThaoChiTiet().getSoLuong())){
                redirectAttributes.addFlashAttribute("warning", "Số lượng sản phẩm "+g.getGiayTheThaoChiTiet().getGiayTheThao().getTenGiayTheThao()+" không được vượt quá: "+g.getGiayTheThaoChiTiet().getSoLuong());
                String referer = request.getHeader("Referer");
                return "redirect:" + referer;
            }
            HoaDonChiTiet hoaDonChiTiet = new HoaDonChiTiet();
            hoaDonChiTiet.setDonGia(new BigDecimal(g.getGiayTheThaoChiTiet().getGiayTheThao().getGiaBan()));
            hoaDonChiTiet.setGhiChu(note);
            hoaDonChiTiet.setNgayTao(LocalDateTime.now());
            hoaDonChiTiet.setSoLuong(g.getSoLuong());
            hoaDonChiTiet.setGiayTheThaoChiTiet(g.getGiayTheThaoChiTiet());
            hoaDonChiTiet.setTrangThai(1);
            hoaDonChiTiets.add(hoaDonChiTiet);
        }

        ChuongTrinhGiamGiaHoaDon voucher = null;
        if(session.getAttribute("voucher") != null){
            ChuongTrinhGiamGiaHoaDon chuongTrinhGiamGiaHoaDon = (ChuongTrinhGiamGiaHoaDon) session.getAttribute("voucher");
            if(new BigDecimal(d).intValue() > chuongTrinhGiamGiaHoaDon.getSoTienHoaDon().intValue()){
                d = new BigDecimal(d).doubleValue() - (new BigDecimal(d).doubleValue() * Integer.valueOf(chuongTrinhGiamGiaHoaDon.getPhanTramGiam()) / 100);
            }
            voucher = chuongTrinhGiamGiaHoaDon;
        }

        HoaDon invoice = new HoaDon();
        invoice.setGhiChu(note);
        invoice.setKhachHang(khachHang);
        invoice.setMaHoaDon(String.valueOf(System.currentTimeMillis()));
        invoice.setThanhTien(new BigDecimal(d));
        invoice.setNgayTao(LocalDateTime.now());
        invoice.setDiaChi(tenduong+", "+xa+", "+huyen+", "+tinh);
        invoice.setHinhThucThanhToan(0); // online
//        invoice.setHinhThuc(0);// online
        if (paytype.equals("vnpay")) {
            invoice.setHinhThuc(1); // Thanh toán VNPay
        } else {
            invoice.setHinhThuc(0); // Thanh toán khi nhận hàng
        }
        invoice.setChuongTrinhGiamGiaHoaDon(voucher);

        if(paytype.equals("vnpay")){
            invoice.setTrangThaiMoney(1);
            String url = vnPayService.createOrder(d.intValue(), String.valueOf(System.currentTimeMillis()), "http://localhost:8080/kiemtrathanhtoan");
            session.setAttribute("hoadon", invoice);
            session.setAttribute("hoadonchitiets", hoaDonChiTiets);
            return "redirect:"+url;
        }
        else{
            invoice.setTrangThaiMoney(0); // thanh toán khi nhận hàng
            hoaDonRepository.save(invoice);
            for(HoaDonChiTiet h : hoaDonChiTiets){
                h.setHoaDon(invoice);
                h.getGiayTheThaoChiTiet().setSoLuong(String.valueOf(Integer.valueOf(h.getGiayTheThaoChiTiet().getSoLuong()) - Integer.valueOf(h.getSoLuong())));
                giayTheThaoChiTietRepository.save(h.getGiayTheThaoChiTiet());
            }
            hoaDonChiTietRepository.saveAll(hoaDonChiTiets);
            session.removeAttribute("voucher");
            deleteGioHang(list);
            redirectAttributes.addFlashAttribute("dathangthanhcong", "Đặt hàng thành công");
            return "redirect:/donhangcuatoi";
        }
    }

    @GetMapping("/kiemtrathanhtoan")
    public String checkThanhToanOnline(HttpServletRequest request, HttpSession session, RedirectAttributes redirectAttributes){
        String vnPayOrderInfor = request.getParameter("vnp_OrderInfo");
        Optional<LichSuThanhToan> ls = lichSuThanhToanRepository.findByOrderId(vnPayOrderInfor);
        if(ls.isPresent()){
            return "redirect:/donhangcuatoi";
        }
        int check = vnPayService.orderReturn(request);
        if(check != 1){
            redirectAttributes.addFlashAttribute("error", "Đặt hàng thất bại!");
            return "redirect:/donhangcuatoi";
        }
        else{
            HoaDon hoaDon = (HoaDon) session.getAttribute("hoadon");
            hoaDonRepository.save(hoaDon);
            List<HoaDonChiTiet> hoaDonChiTiets = (List<HoaDonChiTiet>) session.getAttribute("hoadonchitiets");
            for(HoaDonChiTiet h : hoaDonChiTiets){
                h.setHoaDon(hoaDon);
                h.getGiayTheThaoChiTiet().setSoLuong(String.valueOf(Integer.valueOf(h.getGiayTheThaoChiTiet().getSoLuong()) - Integer.valueOf(h.getSoLuong())));
                giayTheThaoChiTietRepository.save(h.getGiayTheThaoChiTiet());
            }
            hoaDonChiTietRepository.saveAll(hoaDonChiTiets);
            session.removeAttribute("voucher");
            session.removeAttribute("hoadon");
            List<GioHangChiTiet> list = (List<GioHangChiTiet>) session.getAttribute("gioHangChiTiets");
            deleteGioHang(list);
            session.removeAttribute("hoadonchitiets");
        }
        return "redirect:/donhangcuatoi";
    }

    public void deleteGioHang(List<GioHangChiTiet> list){
        for(GioHangChiTiet g : list){
            gioHangChiTietRepository.delete(g);
        }
    }
}
