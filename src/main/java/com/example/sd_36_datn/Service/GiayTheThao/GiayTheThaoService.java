package com.example.sd_36_datn.Service.GiayTheThao;

import com.example.sd_36_datn.Model.GiayTheThao;
import com.example.sd_36_datn.Repository.GiayTheThao.GiayTheThaoRepository;
import com.example.sd_36_datn.Service.impl.GiayTheThaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class GiayTheThaoService implements GiayTheThaoImpl {

    @Autowired
    private GiayTheThaoRepository giayTheThaoRepository;

    public List<GiayTheThao> findGiayTheThao(String tenGiayTheThao){

        if(tenGiayTheThao !=null){

            return giayTheThaoRepository.findByTenGiayTheThao(tenGiayTheThao);

        }else{

             return giayTheThaoRepository.findAll();

        }

    }

    @Override
    public List<GiayTheThao> getAll() {

        return this.giayTheThaoRepository.findAll();
    }

    @Override
    public List<GiayTheThao> getAllWithoutInCTGGCTSP(UUID id) {
        return this.giayTheThaoRepository.getAllWithoutInCTGGCTSP();
    }

    @Override
    public GiayTheThao getOne(UUID id) {
        return this.giayTheThaoRepository.findById(id).get();
    }

    public List<GiayTheThao> getSanPhamMoi() {
        List<GiayTheThao> giayTheThaos = giayTheThaoRepository.findAll();
        return giayTheThaos;
    }
    public List<GiayTheThao> getSanPhamGiaThanhThap() {
        List<GiayTheThao> giayTheThaos = giayTheThaoRepository.findAll();
        return giayTheThaos.stream().sorted((o1, o2) -> o1.getGiaBan().compareTo(o2.getGiaBan())).limit(3).toList();
    }
    public int countGttInCtgg() {
        return this.giayTheThaoRepository.countGttInCtgg();
    }
    public void update(GiayTheThao gtt){
        giayTheThaoRepository.save(gtt);
    }

    public List<GiayTheThao> findByThuongHieu(UUID id) {
        return giayTheThaoRepository.findByThuongHieu(id);
    }
}
