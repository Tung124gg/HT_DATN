package com.example.sd_36_datn.Controller.KhachHang;

import com.example.sd_36_datn.Model.GiayTheThao;
import com.example.sd_36_datn.Model.GioHangChiTiet;
import com.example.sd_36_datn.Repository.GiayTheThao.ImageRepository;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoChiTietService;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoService;
import com.example.sd_36_datn.Service.SanPham.MauSacService;
import com.example.sd_36_datn.Service.SanPham.SizeService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttributes;

import java.util.List;
import java.util.UUID;

@Controller(value = "khachHangGiayTheThaoController")
@SessionAttributes("gioHang")
@RequiredArgsConstructor
public class GiayTheThaoController {

    private final GiayTheThaoService giayTheThaoService;
    private final ImageRepository imageRepository;
    private final SizeService sizeService;
    private final GiayTheThaoChiTietService giayTheThaoChiTietService;
    private final MauSacService mauSacService;

    @GetMapping("/san-pham/{id}")
    public String sanPham(@PathVariable UUID id, Model model, @ModelAttribute("gioHang") List<GioHangChiTiet> gioHang) throws JsonProcessingException {
        GiayTheThao giayTheThao = giayTheThaoService.getOne(id);
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(giayTheThaoChiTietService.getAllByGiayTheThao(giayTheThao));
        model.addAttribute("giayTheThao", giayTheThao);
        model.addAttribute("gioHang", gioHang);
        model.addAttribute("images", imageRepository.getImageByIdGiayTheThao(id));
        model.addAttribute("sizes", sizeService.getAllByIdGtt(id));
        model.addAttribute("mauSacs", mauSacService.getAllByIdGtt(id));
        model.addAttribute("giayTheThaoChiTiet", json);
        return "SanPham/index";
    }
}
