/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.qlks.dao;

import com.qlks.entity.PDFExport;
import com.qlks.util.XJdbc;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author markhyun
 */
public class PDFExportDAO {

    private String selectRoomInforSql = "{call sp_phongthue(?,?)}";
    private String selectRoomMoneySql = "{call sp_tienphong(?,?)}";
    private String selectServicesSql = "SELECT TENDV, SOLUONG, DONGIA, dongia*SOLUONG as TONGTIEN from HOADON a\n"
            + "	JOIN HDDICHVU b on b.MAHD = a.MAHD \n"
            + "	JOIN DICHVU c on c.MADV = b.MADV\n"
            + "WHERE b.MAHD = ?";

    public List<Double> selectTienPhong(Integer key, Integer type) {
        List<Double> list = selectNumValue(selectRoomMoneySql, "tienphong", key, type);
        return list;
    }

    public List<PDFExport> selectRooms(Integer key, Integer type) {
        List<PDFExport> list = selectBySqlRoom(selectRoomInforSql, key, type);
        return list;
    }

    public List<PDFExport> selectServices(Integer key) {
        List<PDFExport> list = selectBySqlServices(selectServicesSql, key);
        return list;
    }

    protected List<String> selectColumn(String sql, String column, Object... args) {
        List<String> list = new ArrayList<String>();
        try (
                ResultSet rs = XJdbc.query(sql, args);) {
            while (rs.next()) {
                String item = rs.getString(column);
                list.add(item);
            }
        } catch (Exception e) {
        }
        return list;
    }

    protected List<Double> selectNumValue(String sql, String column, Object... args) {
        List<Double> list = new ArrayList<Double>();
        try (
                ResultSet rs = XJdbc.query(sql, args);) {
            while (rs.next()) {
                double item = rs.getDouble(column);
                list.add(item);
            }
        } catch (Exception e) {
        }
        return list;
    }

    protected List<Integer> selectNumIntValue(String sql, String column, Object... args) {
        List<Integer> list = new ArrayList<Integer>();
        try (
                ResultSet rs = XJdbc.query(sql, args);) {
            while (rs.next()) {
                int item = rs.getInt(column);
                list.add(item);
            }
        } catch (Exception e) {
        }
        return list;
    }

    protected Integer selectColumInt(String sql, String column, Object... args) {
        try (
                ResultSet rs = XJdbc.query(sql, args);) {
            while (rs.next()) {
                return rs.getInt(column);
            }
        } catch (Exception e) {
        }
        return -1;
    }

    protected List<PDFExport> selectBySqlRoom(String sql, Object... args) {
        List<PDFExport> list = new ArrayList<>();
        try (
                ResultSet rs = XJdbc.query(sql, args);) {
            while (rs.next()) {
                PDFExport room = new PDFExport(
                        rs.getString(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4)
                );
                list.add(room);
            }
        } catch (Exception e) {
        }
        return list;
    }

    protected List<PDFExport> selectBySqlServices(String sql, Object... args) {
        List<PDFExport> list = new ArrayList<>();
        try (
                ResultSet rs = XJdbc.query(sql, args);) {
            while (rs.next()) {
                PDFExport services = new PDFExport(
                        rs.getInt(2),
                        rs.getString(1),
                        rs.getDouble(3),
                        rs.getDouble(4)
                );
                list.add(services);
            }
        } catch (Exception e) {
        }
        return list;
    }
}
