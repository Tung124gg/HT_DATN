package com.example.sd_36_datn.Service;

import com.example.sd_36_datn.Model.Enum.RoleEnum;
import com.example.sd_36_datn.Model.KhachHang;
import com.example.sd_36_datn.Model.User;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.sql.Date;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private KhachHangRepository khachHangRepository;

    @Override
    public void run(String... args) throws Exception {
        String email = "admin@gmail.com";
        String password = "admin";
        String emailkh = "khachhang@gmail.com";
        String passwordkh = "12345";

//         Kiểm tra xem tài khoản đã tồn tại chưa
//        if (userRepository.findByEmail(email) == null) {
//            User user = new User();
//            user.setEmail(email);
//            user.setMatKhau(password);
//            user.setRole(RoleEnum.ADMIN);
//            userRepository.save(user);
//        }
//        if (khachHangRepository.findByEmail(emailkh) == null) {
//            KhachHang khachHang = new KhachHang();
//            khachHang.setEmail(email);
//            khachHang.setMatKhau(passwordkh);
//            khachHangRepository.save(khachHang);
//        }
    }
}
