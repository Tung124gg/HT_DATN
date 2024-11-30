package com.example.sd_36_datn.Controller.member;

import com.example.sd_36_datn.Model.GiayTheThao;
import com.example.sd_36_datn.Repository.GiayTheThao.GiayTheThaoChiTietRepository;
import com.example.sd_36_datn.Repository.GiayTheThao.GiayTheThaoRepository;
import com.example.sd_36_datn.Repository.GiayTheThao.ImageRepository;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.DayGiayRepository;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.MauSacRepository;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.SizeRepository;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Controller(value = "memberGiayTheThaoController")
public class GiayTheThaoController {
    @Autowired
    ServletContext context;


    @Autowired
    private DayGiayRepository dayGiayRepository;


    @Autowired
    private GiayTheThaoRepository giayTheThaoRepository;

    @Autowired
    private GiayTheThaoChiTietRepository giayTheThaoChiTietRepository;

    @Autowired
    private ImageRepository imageRepository;

    @Autowired
    private SizeRepository sizeRepository;

    @Autowired
    private MauSacRepository mauSacRepository;

    @Autowired
    private GiayTheThaoService giayTheThaoService;

    //Todo code list giầy thể thao
    @GetMapping("GiayTheThao/listGiayTheThao")
    public String listShowViewGiayTheThao(Model model,
                                          HttpSession session,
                                          @RequestParam(name = "tab", required = false, defaultValue = "active") String tab,
                                          @RequestParam(name = "pageNum", required = false, defaultValue = "1") Integer pageNum,
                                          @RequestParam(name = "pageSize", required = false, defaultValue = "3") Integer pageSize,
                                          @RequestParam(name = "sort", required = false, defaultValue = "asc") String sort) {


        //Todo code tab trạng thái và phân trang
        int trangThai = tab.equals("active") ? 1 : 0;
        Pageable pageable = PageRequest.of(pageNum - 1, pageSize);
        Page<GiayTheThao> page = giayTheThaoRepository.findByTrangThai(trangThai, pageable);
        //listPage sẽ dùng cho trạng thái giầy thể thao kích hoạt hay chưa
        model.addAttribute("totalPage", page.getTotalPages());
        model.addAttribute("listPage", page.getContent());
        List<Integer> pageNumbers = getPageNumbers(page, pageNum);
        model.addAttribute("pageNumbers", pageNumbers);
        model.addAttribute("currentPage", pageNum);


        // Lấy danh sách giày thể thao từ cơ sở dữ liệu
        List<GiayTheThao> listPageFind = giayTheThaoRepository.findAll();

        // Sắp xếp danh sách theo giá bán
        if ("asc".equals(sort)) {
            Collections.sort(listPageFind, Comparator.comparing(GiayTheThao::getGiaBan));
        } else if ("desc".equals(sort)) {
            Collections.sort(listPageFind, Comparator.comparing(GiayTheThao::getGiaBan).reversed());
        }

        model.addAttribute("listPageFind", listPageFind);

        return "GiayTheThao/All_GiayTheThao/list";

    }




    private List<Integer> getPageNumbers(Page<?> page, int currentPage) {
        List<Integer> pageNumbers = new ArrayList<>();
        int totalPages = page.getTotalPages();
        int startPage, endPage;

        if (totalPages <= 5) {
            startPage = 1;
            endPage = totalPages;
        } else {
            if (currentPage <= 2) {
                startPage = 1;
                endPage = 5;
            } else if (currentPage + 2 >= totalPages) {
                startPage = totalPages - 4;
                endPage = totalPages;
            } else {
                startPage = currentPage - 2;
                endPage = currentPage + 2;
            }
        }

        for (int i = startPage; i <= endPage; i++) {
            pageNumbers.add(i);
        }

        return pageNumbers;
    }

}
