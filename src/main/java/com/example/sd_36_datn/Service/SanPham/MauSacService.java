package com.example.sd_36_datn.Service.SanPham;


import com.example.sd_36_datn.Model.GiayTheThao;
import com.example.sd_36_datn.Model.MauSac;
import com.example.sd_36_datn.Repository.SanPham.ThuocTinh.MauSacRepository;
import com.example.sd_36_datn.Service.GiayTheThao.GiayTheThaoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class MauSacService {
    @Autowired
    private MauSacRepository mauSacRepository;
    @Autowired
    private GiayTheThaoService gttService;


    public List<MauSac> findMauSac(String tenMauSac) {
        if (tenMauSac != null) {
            return mauSacRepository.findByTenMauSac(tenMauSac);
        } else {
            return mauSacRepository.findAll();
        }
    }
    public List<MauSac> getAllByIdGtt(UUID idGtt) {
        GiayTheThao gtt = gttService.getOne(idGtt);
        return mauSacRepository.findByGtt(gtt);
    }

    public List<MauSac> getAll() {
        return mauSacRepository.findAll();
    }

}
