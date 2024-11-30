package com.example.sd_36_datn.dto;

import com.example.sd_36_datn.Model.GiayTheThao;
import lombok.Getter;

@Getter
public class ProductDTO {
    private String name;
    private String description;
    private String price;
    private String image;
    private String link;

    public ProductDTO(GiayTheThao product) {
        this.name = product.getTenGiayTheThao();
        this.description = product.getMoTa();
        this.price = product.getGiaBan() + " VND";
        this.image = product.getAnhDau();
        this.link = "/san-pham/" + product.getId();
    }

}
