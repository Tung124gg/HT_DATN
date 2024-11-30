package com.example.sd_36_datn.config;

import com.example.sd_36_datn.Model.Enum.RoleEnum;
import com.example.sd_36_datn.Model.KhachHang;
import com.example.sd_36_datn.Model.User;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Optional;

@Component

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private KhachHangRepository khachHangRepository;


    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        String email = authentication.getName();

        User user = userRepository.findByEmail(email);
        KhachHang khachHang = khachHangRepository.findByEmail(email);
        if(user != null){
            if(user.getRole().equals(RoleEnum.ADMIN)){
                response.sendRedirect("/user/hien-thi");
            }
            if(user.getRole().equals(RoleEnum.MEMBER)){
                response.sendRedirect("/KhachHang/list");
            }
        }
        if(khachHang != null){
            response.sendRedirect("/");
        }
    }
}
