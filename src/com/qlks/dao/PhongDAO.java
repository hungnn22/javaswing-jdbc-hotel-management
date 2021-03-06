/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.qlks.dao;

import com.qlks.entity.Phong;
import com.qlks.util.XJdbc;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author markhyun
 */
public class PhongDAO extends ManageDAO<Phong, String> {

    private String insertSql = "insert phong values (?, ?, default, ?)";
    private String updateSql = "update phong set sucChua = ?, trangThai = ?, malp = ? where soPhong = ?";
    private String deleteSql = "delete from phong where soPhong = ?";
    private String selectAllSql = "select * from phong";
    private String selectByIdSql = "select * from phong where soPhong = ?";
    private String selectbByLoaiPhongSql = "select * from phong where malp = ?";
    private String selectByLpAndSucChuaSql = "select * from phong where malp = ? and succhua >= ? and trangthai = 0";
    private String updateAfterChooseOrRemoveSql = "update phong set trangthai = ? where sophong = ?";
    private String selectIdsSql = "select sophong from phong";
    private String selectByKeywordSql = "select * from phong where malp like ? and sophong like ?";

    @Override
    public boolean insert(Phong entity) {
        return XJdbc.update(insertSql, entity.getSoPhong(), entity.getSucChua(), entity.getMaLP());
    }

    @Override
    public boolean update(Phong entity) {
        return XJdbc.update(updateSql, entity.getSucChua(), entity.isTrangThai(), entity.getMaLP(), entity.getSoPhong());
    }

    @Override
    public boolean delete(String key) {
        return XJdbc.update(deleteSql, key);
    }

    public boolean updateAfterChooseOrRemove(Phong p, boolean isAdd) {
        return XJdbc.update(updateAfterChooseOrRemoveSql, isAdd, p.getSoPhong());
    }

    @Override
    public List<Phong> selectAll() {
        return selectBySql(selectAllSql);
    }

    public List<Phong> selectByLoaiPhong(String id) {
        return selectBySql(selectbByLoaiPhongSql, id);
    }

    @Override
    public Phong selectByID(String key) {
        List<Phong> list = selectBySql(selectByIdSql, key);
        return list.size() > 0 ? list.get(0) : null;
    }

    public List<String> selectIds() {
        return selectColumn(selectIdsSql);
    }

    public List<Phong> selectByLpAndSucChua(String lp, Integer sucChua) {
        return selectBySql(selectByLpAndSucChuaSql, lp, sucChua);
    }

    public List<Phong> selectByKeyword(String maLP, String key) {
        return selectBySql(selectByKeywordSql, maLP, "%" + key + "%");
    }

    @Override
    protected List<Phong> selectBySql(String sql, Object... args) {
        List<Phong> list = new ArrayList<>();
        try (
                ResultSet rs = XJdbc.query(sql, args);) {
            while (rs.next()) {
                Phong phong = new Phong(
                        rs.getString(1),
                        rs.getInt(2),
                        rs.getBoolean(3),
                        rs.getString(4));
                list.add(phong);
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<String> selectColumn(String sql, Object... args) {
        List<String> list = new ArrayList<>();
        try (
                ResultSet rs = XJdbc.query(sql, args);) {
            while (rs.next()) {
                String item = rs.getString(1);
                list.add(item);
            }
        } catch (Exception e) {
        }
        return list;
    }

}
