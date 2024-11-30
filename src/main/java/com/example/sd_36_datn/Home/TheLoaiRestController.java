package com.example.sd_36_datn.Home;

import com.example.sd_36_datn.Model.GiayTheThao;
import com.example.sd_36_datn.Model.GiayTheThaoChiTiet;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoChiTietService;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoService;
import com.example.sd_36_datn.dto.ProductDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/theloai")
public class TheLoaiRestController {
    private final GiayTheThaoService giayTheThaoService;
    private final GiayTheThaoChiTietService giayTheThaoChiTietService;

    @PostMapping("/all")
    public ResponseEntity<List<ProductDTO>> getFilteredProducts(@RequestBody Map<String, String> payload) {
        String sizes = payload.get("sizes");
        String brands = payload.get("brands");
        String colors = payload.get("colors");

        // Retrieve all products
        List<GiayTheThao> danhSachGiayTheThao = giayTheThaoService.getAll();

        // Apply size filter if sizes are provided
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

        // Apply brand filter if brands are provided
        if (brands != null && !brands.isEmpty()) {
            List<String> brandList = Arrays.asList(brands.split(","));
            danhSachGiayTheThao = danhSachGiayTheThao.stream()
                    .filter(product -> brandList.contains(product.getThuongHieu().getTenThuongHieu()))
                    .collect(Collectors.toList());
        }

        // Apply color filter if colors are provided
        if (colors != null && !colors.isEmpty()) {
            List<String> colorList = Arrays.asList(colors.split(","));
            danhSachGiayTheThao = danhSachGiayTheThao.stream()
                    .filter(product -> {
                        List<GiayTheThaoChiTiet> giayTheThaoChiTiet = giayTheThaoChiTietService.getAllByGiayTheThao(product);
                        return giayTheThaoChiTiet.stream()
                                .anyMatch(giayTheThaoChiTiet1 -> colorList.contains(giayTheThaoChiTiet1.getMauSac().getTenMauSac()));
                    })
                    .collect(Collectors.toList());
        }

        // Map the filtered products to DTOs (a simplified representation)
        List<ProductDTO> productDTOs = danhSachGiayTheThao.stream()
                .map(ProductDTO::new)
                .collect(Collectors.toList());

        return ResponseEntity.ok(productDTOs);
    }
}
