package com.example.sd_36_datn.config;


import com.example.sd_36_datn.Model.Enum.RoleEnum;
import com.example.sd_36_datn.Model.KhachHang;
import com.example.sd_36_datn.Repository.KhachHang.KhachHangRepository;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class WebSecurityConfig  {


    @Autowired
    private CustomLoginSuccessHandler customLoginSuccessHandler;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private KhachHangRepository khachHangRepository;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http.csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/admin/**").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/BanHangTaiQuay").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/GiayTheThao/listGiayTheThao").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/GiayTheThao/create").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/dayGiay/hien-thi").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/MauSac/hien-thi").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/Size/hien-thi").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/thuongHieu/hien-thi").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/user/hien-thi").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/khachhang").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/chuongTrinhGiamGia/sanPham").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/chuongTrinhGiamGia/hoaDon").hasAuthority("ROLE_ADMIN")
//                                .requestMatchers("/TrangChu/ThongTinCaNhan/Admin").hasAuthority("ROLE_ADMIN")
                                .requestMatchers("/BanHangTaiQuay/Admin/xacNhanDonHangKhachHangAll").hasAuthority("ROLE_ADMIN")

                        //customer
                        .requestMatchers("/gio-hang/**").hasAuthority("ROLE_CUSTOMER")
                        .requestMatchers("/thanh-toan/**").hasAuthority("ROLE_CUSTOMER")
                        .requestMatchers("/user/hien-thi").hasAnyAuthority("ROLE_ADMIN","ROLE_MEMBER")
                        .requestMatchers("/checkout").hasAuthority("ROLE_CUSTOMER")
                        .anyRequest().permitAll()
                )
                .exceptionHandling(exception-> exception.accessDeniedPage("/UserLog/login"))
                .formLogin(form -> form
                        .loginPage("/UserLog/login")
                        .loginProcessingUrl("/spring-security-login")
                        .successHandler(customLoginSuccessHandler)
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/UserLog/logout")  // URL xử lý logout
                        .logoutSuccessUrl("/UserLog/login")  // Chuyển hướng sau khi logout thành công
                        .invalidateHttpSession(true)  // Xóa session
                        .deleteCookies("JSESSIONID")  // Xóa cookie nếu cần
                        .permitAll()

//                .headers(headers -> headers
//                        .cacheControl(cache -> cache.disable()) // Vô hiệu hóa cache

                ).authenticationProvider(authenticationProvider())
                .build();
    }




    @Bean
    public UserDetailsService userDetailsService() {
        return username -> {
            System.out.println("username login: "+username);
            com.example.sd_36_datn.Model.User user = userRepository.findByEmail(username);
            KhachHang khachHang = khachHangRepository.findByEmail(username);
            String password = null;
            String role = null;
            if (user == null && khachHang == null) {
                throw new UsernameNotFoundException("User " + username + " was not found in the database");
            }
            if (user != null) {
                System.out.println("la user");
                if(user.getRole().equals(RoleEnum.ADMIN)){
                    role = "ROLE_ADMIN";
                }
                if(user.getRole().equals(RoleEnum.MEMBER)){
                    role = "ROLE_MEMBER";
                }
                password = user.getMatKhau();
            }
            if (khachHang != null) {
                System.out.println("la khachhang");
                role = "ROLE_CUSTOMER";
                password = khachHang.getMatKhau();
            }
            System.out.println("Mat khau dang nhap: "+password);
            List<GrantedAuthority> grantList = new ArrayList<GrantedAuthority>();
            GrantedAuthority authority = new SimpleGrantedAuthority(role);
            grantList.add(authority);
            UserDetails userDetails = (UserDetails) new User(username,password, grantList);
            return userDetails;
        };
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return  NoOpPasswordEncoder.getInstance();
    }

}
