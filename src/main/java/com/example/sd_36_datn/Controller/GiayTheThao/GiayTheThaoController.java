package com.example.sd_36_datn.Controller.GiayTheThao;

import com.example.sd_36_datn.Model.*;
import com.example.sd_36_datn.Repository.GiayTheThao.GiayTheThaoChiTietRepository;
import com.example.sd_36_datn.Repository.GiayTheThao.GiayTheThaoRepository;
import com.example.sd_36_datn.Repository.GiayTheThao.ImageRepository;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.*;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.lowagie.text.DocumentException;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
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

    @GetMapping("GiayTheThao/search")
    public String showListSearch(
            Model model,
            @RequestParam(value = "tenGiayTheThao", required = false) String tenGiayTheThao
            ) {

        List<GiayTheThao> listPageFind;

        if (tenGiayTheThao != null) {

            listPageFind = giayTheThaoService.findGiayTheThao(tenGiayTheThao);
            model.addAttribute("listPageFind", listPageFind);

            if (!listPageFind.isEmpty()) {

                model.addAttribute("messageFindDone", "Tìm thấy dữ liệu");

            } else {

                model.addAttribute("messageFindError", "Không tìm thấy dữ liệu");

            }
        } else {

            model.addAttribute("messageFind", "Bạn hãy nhập tên giầy thể thao muốn tìm kiếm!");

        }


        return "GiayTheThao/All_GiayTheThao/list";

    }



    //Todo code save image của giây thể thao



    //Todo code thông tin giầy thể thao
    @GetMapping("GiayTheThao/detailGiayTheThaoViewIndex/{id}")
    public String detailGiayTheThaoViewIndexViewIndex(Model model,
                                                      @PathVariable UUID id){

        model.addAttribute("giayTheThao",giayTheThaoRepository.findById(id).orElse(null));
        return "BanHang/GiayTheThaoDetail";

    }

    //Todo code detail số lượng của size và màu sắc
    @GetMapping("/find/{idGiayTheThao}/{idMauSac}/{idSize}")
    public ResponseEntity<?> find(@PathVariable UUID idGiayTheThao, @PathVariable UUID idMauSac, @PathVariable UUID idSize) {

        System.out.println(idGiayTheThao);
        System.out.println(idMauSac);
        System.out.println(idSize);

        GiayTheThaoChiTiet giayTheThaoChiTiet = giayTheThaoChiTietRepository.findIdByIdGiayTheThaoMauSacSize(idGiayTheThao, idMauSac, idSize);

        return ResponseEntity.ok(giayTheThaoChiTiet.getSoLuong());

    }




    //Todo code thống kê data cho giầy thể thao

    @GetMapping("/thongke-data")
    @ResponseBody
    public String thongKeData() {
        List<GiayTheThaoChiTiet> sanPhams = giayTheThaoChiTietRepository.findAll();

        ObjectMapper objectMapper = new ObjectMapper();

        try {

            String jsonData = objectMapper.writeValueAsString(sanPhams);
            return jsonData;

        } catch (Exception e) {

            e.printStackTrace();
            return "";

        }
    }


    //Todo code các model để lưu lại dữ liệu

    @ModelAttribute("dayGiay")
    public List<DayGiay> getListDayGiay(){

        return dayGiayRepository.findAll();
    }
    @ModelAttribute("size")
    public List<Size> getListSize(){
        return sizeRepository.findAll();
    }
    @ModelAttribute("mauSac")
    public List<MauSac> getListMauSac(){
        return mauSacRepository.findAll();
    }
}
