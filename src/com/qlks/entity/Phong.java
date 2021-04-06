/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.qlks.entity;

import java.util.Date;

/**
 *
 * @author markhyun
 */
public class Phong {

    private String soPhong;
    private int sucChua;
    private double donGia;
    private boolean trangThai;
    private String maLP;

    public Phong() {

    }

    public Phong(String soPhong, int sucChua, double donGia, boolean trangThai, String maLP) {
        this.soPhong = soPhong;
        this.sucChua = sucChua;
        this.donGia = donGia;
        this.trangThai = trangThai;
        this.maLP = maLP;
    }

    public String getSoPhong() {
        return soPhong;
    }

    public int getSucChua() {
        return sucChua;
    }

    public double getDonGia() {
        return donGia;
    }

    public boolean isTrangThai() {
        return trangThai;
    }

    public String getMaLP() {
        return maLP;
    }

    public void setSoPhong(String soPhong) {
        this.soPhong = soPhong;
    }

    public void setSucChua(int sucChua) {
        this.sucChua = sucChua;
    }

    public void setDonGia(double donGia) {
        this.donGia = donGia;
    }

    public void setTrangThai(boolean trangThai) {
        this.trangThai = trangThai;
    }

    public void setMaLP(String maLP) {
        this.maLP = maLP;
    }

}
