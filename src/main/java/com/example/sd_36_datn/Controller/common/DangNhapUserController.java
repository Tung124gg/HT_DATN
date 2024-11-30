package com.example.sd_36_datn.Controller.common;
import com.example.sd_36_datn.Model.User;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.UserRepository;
import jakarta.servlet.ServletContext;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/UserLog")
@RequiredArgsConstructor
public class DangNhapUserController {

    private final UserRepository userRepository;
    private final ServletContext context;
    private final KhachHangRepository khachHangRepository;

    //Todo code login cho user
    @GetMapping(value = "/login")
    public String showLoginForm(Model model){
        model.addAttribute("user",new User());
        return "templates/Admin/Layouts/DangNhap/Login";

    }

    //Todo code log đăng nhập thành công
    @GetMapping("/showSweetAlertLoginAdminSuccess")
    public String showSweetAlertLogLoginAdmin() {

        return "templates/Users/Layouts/Log/DangNhapAdminLog";

    }

    //Todo code log check thông báo tài khoản của bạn không được áp dụng cho chức năng này
    @GetMapping("/showLogTaiKhoanKhongApDung")
    public String viewTaiKhoanKhongDuocApDung(Model model){

        return "templates/Users/Layouts/Log/DangNhapAdminLogTaiKhoan";

    }

}
