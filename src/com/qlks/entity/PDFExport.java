/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.qlks.entity;

/**
 *
 * @author markhyun
 */
public class PDFExport {

    //room
    private String tenLG;
    private int thoigianThue;
    private String tenLP;
    private String soPhong;

    //services
    private int soLuong;
    private String tenDV;
    private double donGia;
    private double tongTien;

    public PDFExport(String tenLG, int thoigianThue, String tenLP, String soPhong) {
        this.tenLG = tenLG;
        this.thoigianThue = thoigianThue;
        this.tenLP = tenLP;
        this.soPhong = soPhong;
    }

    public PDFExport(int soLuong, String tenDV, double donGia, double tongTien) {
        this.soLuong = soLuong;
        this.tenDV = tenDV;
        this.donGia = donGia;
        this.tongTien = tongTien;
    }

    public String getTenLG() {
        return tenLG;
    }

    public void setTenLG(String tenLG) {
        this.tenLG = tenLG;
    }

    public int getThoigianThue() {
        return thoigianThue;
    }

    public void setThoigianThue(int thoigianThue) {
        this.thoigianThue = thoigianThue;
    }

    public String getTenLP() {
        return tenLP;
    }

    public void setTenLP(String tenLP) {
        this.tenLP = tenLP;
    }

    public String getSoPhong() {
        return soPhong;
    }

    public void setSoPhong(String soPhong) {
        this.soPhong = soPhong;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public String getTenDV() {
        return tenDV;
    }

    public void setTenDV(String tenDV) {
        this.tenDV = tenDV;
    }

    public double getDonGia() {
        return donGia;
    }

    public void setDonGia(double donGia) {
        this.donGia = donGia;
    }

    public double getTongTien() {
        return tongTien;
    }

    public void setTongTien(double tongTien) {
        this.tongTien = tongTien;
    }

}
