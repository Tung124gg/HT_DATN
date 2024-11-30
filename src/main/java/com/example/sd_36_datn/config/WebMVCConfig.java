package com.example.sd_36_datn.config;

import com.example.sd_36_datn.filter.adminInterceptor;
import com.example.sd_36_datn.filter.LogGinInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class WebMVCConfig implements WebMvcConfigurer {

	//Cấu hình cho file ảnh
	@Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
          .addResourceHandler("/resources/**")
          .addResourceLocations("/resources/");	
        registry
        .addResourceHandler("/upload/**")
        .addResourceLocations("/upload/");
    }


    //Todo code quên mật khẩu khách hàng



    //Todo code phân quyền cho bên Admin

    @Autowired
    LogGinInterceptor logGinInterceptor;

    @Autowired
    adminInterceptor adminInterceptor;

    public void addInterceptors(InterceptorRegistry registry){

        //Member
//        registry.addInterceptor(logGinInterceptor)
//                .addPathPatterns(
//                        //Phiếu giao hàng
//                        "/PhieuGiaoHang/listPhieuGiaoHang",
//
//
//                );
//
//        //Dành cho Admin
//        registry.addInterceptor(adminInterceptor)
//                .addPathPatterns(
//                        //Todo gắn link check phân quyền admin
//                        "/BanHangTaiQuay",
//                        //Xóa đơn hàng khi hủy
//                        "/Admin/HoaDon/DonHangBiHuy"
//
//                        );
    }
}
