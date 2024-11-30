package com.example.sd_36_datn.Home;


import com.example.sd_36_datn.Model.GiayTheThao;
import com.example.sd_36_datn.Model.GiayTheThaoChiTiet;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoChiTietService;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoService;
import com.example.sd_36_datn.Service.SanPham.MauSacService;
import com.example.sd_36_datn.Service.SanPham.SizeService;
import com.example.sd_36_datn.Service.SanPham.ThuongHieuService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
@RequestMapping("/hanghoa")
public class TheLoaiController {
    private final GiayTheThaoService giayTheThaoService;
    private final ThuongHieuService thuongHieuService;
    private final GiayTheThaoChiTietService giayTheThaoChiTietService;
    private final SizeService sizeService;
    private final MauSacService mauSacService;

    @GetMapping("/{id}")
    public String danhSachHangHoaTheoNhanHang(@PathVariable UUID id, Model model) {
        model.addAttribute("danhSachGiayTheThao", giayTheThaoService.findByThuongHieu(id));
        model.addAttribute("thuongHieu", thuongHieuService.getOne(id).getTenThuongHieu());
        model.addAttribute("thuongHieus", thuongHieuService.findAll());
        model.addAttribute("sizes", sizeService.getAll());
        model.addAttribute("mauSacs", mauSacService.getAll());
        return "DanhSachSanPham/index";
    }

    @GetMapping("/all")
    public String danhSachHangHoaTheoNhanHang(@RequestParam(value = "sizes", required = false) String sizes, Model model) {
        List<GiayTheThao> danhSachGiayTheThao = giayTheThaoService.getAll();
        if (sizes != null && !sizes.isEmpty()) {
            List<String> sizeList = Arrays.asList(sizes.split(","));
            danhSachGiayTheThao = danhSachGiayTheThao.stream()
                    .filter(product -> {
                        List<GiayTheThaoChiTiet> giayTheThaoChiTiet = giayTheThaoChiTietService.getAllByGiayTheThao(product);
                        return giayTheThaoChiTiet.stream()
                                .anyMatch(giayTheThaoChiTiet1 -> sizeList.contains(giayTheThaoChiTiet1.getSize().getSize()));
                    })
                    .collect(Collectors.toList());
        }
        model.addAttribute("thuongHieus", thuongHieuService.findAll());
        model.addAttribute("sizes", sizeService.getAll());
        model.addAttribute("mauSacs", mauSacService.getAll());
        model.addAttribute("danhSachGiayTheThao", danhSachGiayTheThao);
        model.addAttribute("thuongHieu", "Tất cả");
        return "DanhSachSanPham/index";
    }
}
