package com.example.sd_36_datn.Controller.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller(value = "memberHomeController")
public class HomeController {

    @RequestMapping(value = "/TrangChu/Admin/home")
    public String homeAdmin(){
        return "TrangChuAdmin/home";

    }
}
