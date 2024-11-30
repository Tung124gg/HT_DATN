package com.example.sd_36_datn.Controller.KhachHang;


import com.example.sd_36_datn.Service.GioHangService;
import com.example.sd_36_datn.dto.CartItemDTO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/gio-hang")
public class GioHangRestController {

    private final GioHangService gioHangService;

    @PostMapping("/cap-nhat-gio-hang")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateCart(@RequestBody List<CartItemDTO> items, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            gioHangService.update(items);
            UUID maKhachHang = UUID.fromString(session.getAttribute("maKh").toString());
            session.setAttribute("gioHang", gioHangService.getListGioHangChiTiet(maKhachHang));
            response.put("success", true);
            response.put("message", "Giỏ hàng đã được cập nhật thành công!");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Có lỗi xảy ra khi cập nhật giỏ hàng.");
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/xoa-gio-hang")
    public ResponseEntity<Map<String, Object>> deleteCart(@RequestBody Map<String, UUID> body, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        try {
            UUID id = body.get("id");
            gioHangService.delete(id);
            UUID maKhachHang = UUID.fromString(session.getAttribute("maKh").toString());
            session.setAttribute("gioHang", gioHangService.getListGioHangChiTiet(maKhachHang));
            response.put("success", true);
            response.put("message", "Giỏ hàng đã được xóa thành công!");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Có lỗi xảy ra khi xóa giỏ hàng.");
        }
        return ResponseEntity.ok(response);
    }
}
