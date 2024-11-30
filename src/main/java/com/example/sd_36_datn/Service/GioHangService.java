package com.example.sd_36_datn.Service;

import com.example.sd_36_datn.Model.GiayTheThaoChiTiet;
import com.example.sd_36_datn.Model.GioHang;
import com.example.sd_36_datn.Model.GioHangChiTiet;
import com.example.sd_36_datn.Model.KhachHang;
import com.example.sd_36_datn.Repository.GiayTheThao.GiayTheThaoChiTietRepository;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import com.example.sd_36_datn.Repository.SanPham.GioHangChiTietRepository;
import com.example.sd_36_datn.Repository.SanPham.GioHangRepository;
import com.example.sd_36_datn.dto.CartItemDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class GioHangService {
    private final GioHangRepository gioHangRepository;
    private final GioHangChiTietRepository gioHangChiTietRepository;
    private final KhachHangRepository khachHangRepository;
    private final GiayTheThaoChiTietRepository giayTheThaoChiTietRepository;

    public GioHangChiTiet addToCart(UUID giayTheThaoChiTietId, int quantity, UUID khId) {

        KhachHang khachHang = khachHangRepository.findById(khId)
                .orElseThrow(() -> new RuntimeException("Khách hàng không tồn tại"));

        GioHang gioHang = gioHangRepository.findGioHangByKhachHang(khachHang)
                .orElseGet(() -> gioHangRepository.save(GioHang.builder()
                        .khachHang(khachHang)
                                .ngayTao(String.valueOf(LocalDate.now()))
                                .ngaySua(String.valueOf(LocalDate.now()))
                                .trangThai(1)
                        .build()));

        GiayTheThaoChiTiet giay = giayTheThaoChiTietRepository.findById(giayTheThaoChiTietId)
                .orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại"));

        if (Integer.valueOf(giay.getSoLuong()) < quantity) {
            throw new RuntimeException("Số lượng sản phẩm không đủ");
        }

        GioHangChiTiet cartItem = gioHangChiTietRepository.findByGioHangAndGiayTheThaoChiTiet(gioHang, giay)
                .orElse(GioHangChiTiet.builder()
                        .gioHang(gioHang)
                        .giayTheThaoChiTiet(giay)
                        .soLuong(quantity + "")
                        .donGia(BigDecimal.valueOf(Long.parseLong(giay.getGiayTheThao().getGiaBan())))
                        .ngayTao(String.valueOf(LocalDate.now()))
                        .ngaySua(String.valueOf(LocalDate.now()))
                        .donGiaKhiGiam(BigDecimal.valueOf(0))
                        .build());


        if (cartItem.getId() != null) {
            cartItem.setSoLuong(String.valueOf(Integer.parseInt(cartItem.getSoLuong()) + quantity));
        }

        gioHangChiTietRepository.save(cartItem);
        return cartItem;
    }

    public List<GioHangChiTiet> getListGioHangChiTiet(UUID idKhachHang) {
        GioHang gioHang = gioHangRepository.findGioHangByKhachHang(khachHangRepository.findById(idKhachHang).get())
                .orElse(null);
        return gioHangChiTietRepository.findAllByGioHang(gioHang);
    }

    public void delete(UUID id) {
        gioHangChiTietRepository.deleteById(id);
    }

    public void update(List<CartItemDTO> items) {
        for (CartItemDTO item : items) {
            GioHangChiTiet gioHangChiTiet = gioHangChiTietRepository.findById(item.getId()).get();
            gioHangChiTiet.setSoLuong(item.getQuantity());
            gioHangChiTietRepository.save(gioHangChiTiet);
        }
    }

}
