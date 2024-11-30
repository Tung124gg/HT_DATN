package com.example.sd_36_datn.Controller.member;

import com.example.sd_36_datn.Model.User;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.UserRepository;
import com.example.sd_36_datn.Service.impl.UserServiceImpl;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.UUID;

@Controller(value = "MemberUserController")
public class UserController {

    @Autowired
    ServletContext context;

    @Autowired
    JavaMailSender mailSender;

    @Autowired
    private UserServiceImpl userServiceImpl;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/TrangChu/ThongTinCaNhan/Admin")
    public String showViewThongTinCaNhanAdmin(Model model,
                                              HttpSession session,
                                              RedirectAttributes attributes){

        if(session.getAttribute("userLog") != null){

            UUID idUser = (UUID) session.getAttribute("idUser");

            if(idUser != null){

                System.out.println("Đăng nhập tài khoản thành công !");
                User user = userRepository.findById(idUser).orElse(null);

                model.addAttribute("user",user);

            }

            return "templates/Admin/Layouts/DangNhap/thongTinCaNhan";

        }else{

            System.out.println("Khách hàng chưa đăng nhập tài khoản !");
            return "redirect:/Admin/NotLoin";
        }
    }
}
