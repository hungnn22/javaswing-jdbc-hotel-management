/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.qlks.dao;

import com.qlks.entity.HDPhong;
import com.qlks.util.XJdbc;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hungn
 */
public class HDPhongDAO extends ManageDAO<HDPhong, Integer> {

    private String insertSql = "insert hdphong values (?, ?)";
    private String updateSql = "update hdphong set mahdtt = ?, sophong = ? where id = ?";
    private String deleteSql = "delete from hdphong where id = ?";
    private String selectAllSql = "select * from hdphong";
    private String selectById = "select * from hdphong where id = ?";
    private String selectByMahd = "select * form hdphong where mahd = ?";
    private String selectDgByHdLgSql = "select DONGIA from hoadon a\n"
            + "join HDPHONG b on a.MAHD = b.MAHD\n"
            + "join phong c on b.SOPHONG = c.SOPHONG\n"
            + "join LOAIPHONG d on c.MALP = d.MALP\n"
            + "join LOAIPHONG_LOAIGIA e on d.MALP = e.MALP\n"
            + "where a.MAHD = ? and e.MALG = ?";

    private String selectSoPhongByHoaDonSql = "select sophong from hdphong where mahd = ?";
    
    private String deleteByHdSql = "{call sp_xoahdp(?)}";
    
    @Override
    public boolean insert(HDPhong entity) {
        return XJdbc.update(insertSql, entity.getMaHd(), entity.getSoPhong());
    }

    @Override
    public boolean update(HDPhong entity) {
        throw new UnsupportedOperationException("Not supported yet."); //To ch/ange body of generated methods, choose Tools | Templates.

    }

    @Override
    public boolean delete(Integer key) {
        return XJdbc.update(deleteSql, key);
    }

    @Override
    public List<HDPhong> selectAll() {
        return selectBySql(selectAllSql);
    }

    @Override
    public HDPhong selectByID(Integer key) {
        List<HDPhong> list = selectBySql(selectById, key);
        return list.size() > 0 ? list.get(0) : null;
    }

    public List<HDPhong> selectByMaHd(Integer ma) {
        return selectBySql(selectByMahd, ma);
    }

    public List<Object> selectDgByHdLg(Integer maHd, Integer maLg) {
        return XJdbc.column(selectDgByHdLgSql, maHd, maLg);
    }
    
    public List<Object> selectSoPhongByHoaDon(Integer maHd) {
        return XJdbc.column(selectSoPhongByHoaDonSql, maHd);
    }
    
    public boolean deleteByHd(Integer maHd) {
        return XJdbc.update(deleteByHdSql, maHd);
    }

    @Override
    protected List<HDPhong> selectBySql(String sql, Object... args) {
        List<HDPhong> list = new ArrayList<>();
        try (
                ResultSet rs = XJdbc.query(sql, args);) {
            while (rs.next()) {
                HDPhong hdp = new HDPhong(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3)
                );
                list.add(hdp);
            }
        } catch (Exception e) {
        }
        return list;
    }

}
