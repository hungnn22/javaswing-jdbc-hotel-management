﻿if OBJECT_ID ('QLKS') is not null
	drop database QLKS
go
USE MASTER
GO
CREATE DATABASE QLKS
GO

USE QLKS
GO

-------------------------------------LOAIPHONG
IF OBJECT_ID ('LOAIPHONG') IS NOT NULL
DROP TABLE LOAIPHONG
GO
CREATE TABLE LOAIPHONG
(
	MALP		VARCHAR(10) PRIMARY KEY,
	TENLP		NVARCHAR(50) NOT NULL,
	MOTA		NVARCHAR(500),
	ISACTIVE	BIT DEFAULT 1,
	CREATEAT	DATE DEFAULT GETDATE(),
	UPDATEAT	DATE DEFAULT GETDATE()
)
GO

DELETE FROM LOAIPHONG
INSERT LOAIPHONG VALUES ('STD', 'Standard', N'Phòng standard (viết tắt là STD) là loại phòng tiêu chuẩn, đơn giản nhất trong các khách sạn hiện nay. Đây là loại phòng có diện tích nhỏ, thường được đặt ở tầng thấp nhất và không có view hoặc view không được đẹp. Trang thiết bị của phòng standard cũng được khách sạn giảm tối thiểu. Chính vì vậy, giá phòng standard nằm ở mức thấp nhất trong các loại phòng khách sạn.', DEFAULT, DEFAULT, DEFAULT)
INSERT LOAIPHONG VALUES ('SUP', 'Superior', N'Phòng superior cao cấp hơn phòng standard với diện tích lớn hơn (từ 20m2 trở lên) bao gồm 1-2 giường, tầm nhìn view cũng đẹp hơn. Trang thiết bị của phòng được khách sạn đầu tư hiện đại. Vì chất lượng tốt hơn nên mức giá cho phòng superior cũng sẽ cao hơn phòng standard.', DEFAULT, DEFAULT, DEFAULT)
INSERT LOAIPHONG VALUES ('DLX', 'Deluxe', N'Phòng deluxe thường ở tầng trên cao với view đẹp (hướng ra núi, biển… ). Diện tích của loại phòng này rộng rãi hơn superior và được đầu tư trang thiết bị cao cấp như tivi, tủ lạnh, bồn rửa mặt cao cấp… Đương nhiên, mức giá niêm yết dành cho phòng deluxe sẽ cao hơn superior.', DEFAULT, DEFAULT, DEFAULT)
INSERT LOAIPHONG VALUES ('SUT', 'Suite', N'Phòng suite là loại phòng cao cấp nhất khách sạn, được đặt ở tầng cao nhất, nơi có không gian thoáng đãng và không khí trong lành. Với diện tích từ 60 – 120m2, phòng suite thường bao gồm 1 phòng khách, 1 phòng ngủ riêng biệt, cửa sổ và ban công để khách ngắm phong cảnh.', DEFAULT, DEFAULT, DEFAULT)
GO
SELECT * FROM LOAIPHONG

-------------------------------------LOAIPHONG
IF OBJECT_ID ('PHONG') IS NOT NULL
	DROP TABLE PHONG
GO
CREATE TABLE PHONG
(
	SOPHONG		VARCHAR(10) NOT NULL PRIMARY KEY,
	SUCCHUA		INT NOT NULL CHECK(SUCCHUA > 0),
	DONGIA		MONEY NOT NULL,
	TRANGTHAI	BIT NOT NULL DEFAULT 0,
	MALP		VARCHAR(10) NOT NULL,
	ISACTIVE	BIT DEFAULT 1,
	CREATEAT	DATE DEFAULT GETDATE(),
	UPDATEAT	DATE DEFAULT GETDATE(),
	FOREIGN KEY (MALP) REFERENCES LOAIPHONG(MALP) ON UPDATE CASCADE
)
GO

DELETE FROM PHONG
INSERT PHONG VALUES ('101', 4, 200000, DEFAULT, 'STD', DEFAULT, DEFAULT, DEFAULT)
INSERT PHONG VALUES ('102', 4, 200000, DEFAULT, 'STD', DEFAULT, DEFAULT, DEFAULT)
INSERT PHONG VALUES ('103', 2, 200000, DEFAULT, 'STD', DEFAULT, DEFAULT, DEFAULT)
INSERT PHONG VALUES ('304', 4, 1000000, DEFAULT, 'DLX', DEFAULT, DEFAULT, DEFAULT)
INSERT PHONG VALUES ('205', 4, 200000, DEFAULT, 'SUP', DEFAULT, DEFAULT, DEFAULT)
INSERT PHONG VALUES ('206', 4, 200000, DEFAULT, 'SUP', DEFAULT, DEFAULT, DEFAULT)
GO
SELECT * FROM PHONG

-------------------------------------BOPHAN
IF OBJECT_ID('BOPHAN') IS NOT NULL
	DROP TABLE BOPHAN
GO
CREATE TABLE BOPHAN
(
	MABP		VARCHAR(10) NOT NULL PRIMARY KEY,
	TENBP		NVARCHAR(50) NOT NULL,
	ISACTIVE	BIT DEFAULT 1,
	CREATEAT	DATE DEFAULT GETDATE(),
	UPDATEAT	DATE DEFAULT GETDATE()
)
GO

DELETE FROM BOPHAN
INSERT BOPHAN VALUES ('QL', N'Quản Lý', DEFAULT, DEFAULT, DEFAULT)
INSERT BOPHAN VALUES ('KT', N'Kế Toán', DEFAULT, DEFAULT, DEFAULT)
INSERT BOPHAN VALUES ('PB', N'Phòng Ban', DEFAULT, DEFAULT, DEFAULT)
INSERT BOPHAN VALUES ('LT', N'Lễ Tân', DEFAULT, DEFAULT, DEFAULT)
SELECT * FROM BOPHAN
GO

-----------------------------------------NHANVIEN
IF OBJECT_ID('NHANVIEN') IS NOT NULL
	DROP TABLE NHANVIEN
GO
CREATE TABLE NHANVIEN
(
	MANV			VARCHAR(10) NOT NULL PRIMARY KEY,
	TENNV			NVARCHAR(50) NOT NULL,
	PASSWORD		VARCHAR(50) NOT NULL,
	NGAYSINH		DATE NOT NULL CHECK ((YEAR(GETDATE()) - YEAR(NGAYSINH)) BETWEEN 18 AND 65),
	GIOITINH		BIT NOT NULL,
	DIACHI			NVARCHAR(50) NOT NULL,
	SDT				VARCHAR(20) NOT NULL,
	EMAIL			VARCHAR(50) NOT NULL,
	ANH				VARCHAR(50),
	MABP			VARCHAR(10) NOT NULL,
	ISACTIVE		BIT DEFAULT 1,
	CREATEAT		DATE DEFAULT GETDATE(),
	UPDATEAT		DATE DEFAULT GETDATE()
	FOREIGN KEY (MABP) REFERENCES BOPHAN(MABP) ON UPDATE CASCADE
)
GO

DELETE FROM NHANVIEN
INSERT NHANVIEN VALUES ('PH01', N'Nguyễn Nhật Hùng', 'hungnn', '1998-03-05', 1, N'Hà Nội', '0984111111', 'hungnnph09719@fpt.edu.vn', DEFAULT, 'QL', DEFAULT, DEFAULT, DEFAULT)
INSERT NHANVIEN VALUES ('PH02', N'Hứa Mạnh Hùng', 'hunghm', '2000-03-05', 1, N'Hà Nội', '0984111112', 'hunghmph09808@fpt.edu.vn', DEFAULT, 'KT', DEFAULT, DEFAULT, DEFAULT)
INSERT NHANVIEN VALUES ('PH03', N'Nguyễn Hữu Quyết', 'quyetnh', '2001-03-05', 1, N'Hà Nội', '0984111113', 'quyetnhph12037@fpt.edu.vn', DEFAULT, 'LT', DEFAULT, DEFAULT, DEFAULT)
SELECT * FROM NHANVIEN
GO

------------------------------MAXACNHAN
IF OBJECT_ID('MAXACNHAN') IS NOT NULL
	DROP TABLE MAXACNHAN
GO
CREATE TABLE MAXACNHAN
(
	ID			INT IDENTITY(1,1) PRIMARY KEY,
	CODE		VARCHAR(10) NOT NULL,
	MANV		VARCHAR(10) NOT NULL,
	CREATEAT	DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV) ON UPDATE CASCADE
)
GO

-----------------------------------
IF OBJECT_ID('DICHVU') IS NOT NULL
	DROP TABLE DICHVU
GO
CREATE TABLE DICHVU
(
	MADV			INT IDENTITY(1,1) PRIMARY KEY,
	TENDV			NVARCHAR(50) NOT NULL,
	DONGIA			MONEY NOT NULL CHECK(DONGIA >= 0),
	MOTA			NVARCHAR(500),
	TRANGTHAI		BIT NOT NULL,
	ISACTIVE		BIT DEFAULT 1,
	CREATEAT		DATE DEFAULT GETDATE(),
	UPDATEAT		DATE DEFAULT GETDATE()
)
GO

DELETE FROM DICHVU
DBCC CHECKIDENT ('DICHVU', RESEED, 0)
INSERT DICHVU VALUES ('Make-up room service', 200000, N'Make-up room service là dịch vụ làm phòng. Trong dịch vụ này, người làm phòng sẽ thay drap giường, khăn tắm và các đồ dùng trong phòng ngủ.', 1, DEFAULT, DEFAULT, DEFAULT)
INSERT DICHVU VALUES ('Turndown service', 50000, N'Là dịch vụ chỉnh trang phòng buổi tối. Người làm phòng sẽ trải thẳng lại drap giường, gấp nếp giường, đặt cành hoa hoặc thiệp chúc ngủ ngon lên giường..', 1, DEFAULT, DEFAULT, DEFAULT)
INSERT DICHVU VALUES ('Laundry service', 200000, N'Laundry service là dịch vụ giặt ủi trong khách sạn.', 1, DEFAULT, DEFAULT, DEFAULT)
SELECT * FROM DICHVU
GO

----------------------------------------

IF OBJECT_ID('KHACHHANG') IS NOT NULL
	DROP TABLE KHACHHANG
GO
CREATE TABLE KHACHHANG
(
	MAKH		INT IDENTITY(1,1) PRIMARY KEY,
	TENKH		NVARCHAR(50) NOT NULL,
	CMND		VARCHAR(20) NOT NULL,
	SDT			VARCHAR(20) NOT NULL,
	GIOITINH	BIT NOT NULL,
	DIACHI		NVARCHAR(50) NOT NULL,
	QUOCTICH	NVARCHAR(50) NOT NULL,
	ISACTIVE	BIT DEFAULT 1,
	CREATEAT	DATE DEFAULT GETDATE(),
	UPDATEAT	DATE DEFAULT GETDATE()
)
GO

DELETE FROM KHACHHANG
DBCC CHECKIDENT ('KHACHHANG', RESEED, 0)
INSERT KHACHHANG VALUES (N'Khách hàng 1', '122122121', '0987654001', 1, N'Hà Nội', N'Việt Nam', DEFAULT, DEFAULT, DEFAULT)
INSERT KHACHHANG VALUES (N'Khách hàng 2', '122122122', '0987654002', 0, N'Hồ Chí Minh', N'Việt Nam', DEFAULT, DEFAULT, DEFAULT)
INSERT KHACHHANG VALUES (N'Khách hàng 3', '122122123', '0987654003', 1, N'Đà Nẵng', N'Việt Nam', DEFAULT, DEFAULT, DEFAULT)
GO
SELECT * FROM KHACHHANG

---------------------------------------------NHACUNGCAP
IF OBJECT_ID('NHACUNGCAP') IS NOT NULL
	DROP TABLE NHACUNGCAP
GO
CREATE TABLE NHACUNGCAP
(
	MANCC		INT IDENTITY(1,1) PRIMARY KEY,
	TENNCC		NVARCHAR(50) NOT NULL,
	DIACHI		NVARCHAR(50) NOT NULL,
	ISACTIVE	BIT DEFAULT 1,
	CREATEAT	DATE DEFAULT GETDATE(),
	UPDATEAT	DATE DEFAULT GETDATE()
)
GO

DELETE FROM NHACUNGCAP
DBCC CHECKIDENT ('NHACUNGCAP', RESEED, 0)
INSERT NHACUNGCAP VALUES ('NCC01', N'Hà Nội', DEFAULT, DEFAULT, DEFAULT)
INSERT NHACUNGCAP VALUES ('NCC02', N'Bắc Ninh', DEFAULT, DEFAULT, DEFAULT)
INSERT NHACUNGCAP VALUES ('NCC03', N'Lạng Sơn', DEFAULT, DEFAULT, DEFAULT)
GO
SELECT * FROM NHACUNGCAP

---------------------NCC_SDT
IF OBJECT_ID('NCC_SDT') IS NOT NULL
	DROP TABLE NCC_SDT
GO
CREATE TABLE NCC_SDT
(
	ID		INT IDENTITY(1,1) PRIMARY KEY,
	MANCC	INT	NOT NULL,
	SDT		VARCHAR(20) NOT NULL,
	FOREIGN KEY (MANCC) REFERENCES NHACUNGCAP(MANCC) ON UPDATE CASCADE
)
GO
DELETE FROM NCC_SDT
DBCC CHECKIDENT ('NCC_SDT', RESEED, 0)
INSERT NCC_SDT VALUES (1, '0999888111')
INSERT NCC_SDT VALUES (1, '0999888112')
INSERT NCC_SDT VALUES (2, '0999888113')
INSERT NCC_SDT VALUES (2, '0999888114')
INSERT NCC_SDT VALUES (3, '0999888115')
GO
SELECT * FROM NCC_SDT

------------------------------------------------HDTHANHTOAN//
IF OBJECT_ID('HDTHANHTOAN') IS NOT NULL
	DROP TABLE HDTHANHTOAN
GO
CREATE TABLE HDTHANHTOAN
(
	MAHD		INT IDENTITY(1,1) PRIMARY KEY,
	NGAYTHUE	DATE NOT NULL,
	NGAYTT		DATE NOT NULL DEFAULT GETDATE(),
	TONGTIEN	MONEY NOT NULL CHECK (TONGTIEN > 0),
	TRANGTHAI	BIT NOT NULL DEFAULT 0,
	MAKH		INT,
	MANV		VARCHAR(10) NOT NULL
	FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
	FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
)
GO

DELETE FROM HDTHANHTOAN
DBCC CHECKIDENT ('HDTHANHTOAN', RESEED, 0)

-----------------------------------------------------HDTT_PHONG
IF OBJECT_ID('HDTT_PHONG') IS NOT NULL
	DROP TABLE HDTT_PHONG
GO
CREATE TABLE HDTT_PHONG
(
	ID			INT IDENTITY(1,1) PRIMARY KEY,
	MAHDTT		INT NOT NULL,
	SOPHONG		VARCHAR(10) NOT NULL
	FOREIGN KEY (MAHDTT) REFERENCES HDTHANHTOAN(MAHD),
	FOREIGN KEY (SOPHONG) REFERENCES PHONG(SOPHONG),
	UNIQUE(MAHDTT, SOPHONG)
)
GO
DELETE FROM HDTT_PHONG
DBCC CHECKIDENT ('HDTT_PHONG', RESEED, 0)

---------------------------------HDTT_DICHVU
IF OBJECT_ID('HDTT_DICHVU') IS NOT NULL
	DROP TABLE HDTT_DICHVU
GO
CREATE TABLE HDTT_DICHVU
(
	ID			INT IDENTITY(1,1) PRIMARY KEY,
	MAHDTT		INT NOT NULL,
	MADV		INT NOT NULL,
	SOLUONG		int NOT NULL,
	FOREIGN KEY (MAHDTT) REFERENCES HDTHANHTOAN(MAHD),
	FOREIGN KEY (MADV) REFERENCES DICHVU(MADV),
	UNIQUE(MAHDTT, MADV)
)
GO
DELETE FROM HDTT_DICHVU
DBCC CHECKIDENT ('HDTT_DICHVU', RESEED, 0)
------------------------------------------TIENNGHI
IF OBJECT_ID ('TIENNGHI') IS NOT NULL
DROP TABLE TIENNGHI
GO
CREATE TABLE TIENNGHI
(
	MATN		INT IDENTITY(1,1) PRIMARY KEY,
	TENTN		NVARCHAR(50) NOT NULL,
	ISACTIVE	BIT DEFAULT 1,
	CREATEAT	DATE DEFAULT GETDATE(),
	UPDATEAT	DATE DEFAULT GETDATE()
)
GO
DELETE FROM TIENNGHI
DBCC CHECKIDENT ('TIENNGHI', RESEED, 0)
INSERT TIENNGHI VALUES (N'Tivi', DEFAULT, DEFAULT, DEFAULT)
INSERT TIENNGHI VALUES (N'Tủ lạnh', DEFAULT, DEFAULT, DEFAULT)
INSERT TIENNGHI VALUES (N'Điều hòa', DEFAULT, DEFAULT, DEFAULT)
INSERT TIENNGHI VALUES (N'Ghế massage', DEFAULT, DEFAULT, DEFAULT)
GO
SELECT * FROM TIENNGHI

------------------------PHONG_TIENNGHI//
IF OBJECT_ID('PHONG_TIENNGHI') IS NOT NULL
	DROP TABLE PHONG_TIENNGHI
GO
CREATE TABLE PHONG_TIENNGHI
(
	ID			INT IDENTITY(1,1) PRIMARY KEY,
	SOPHONG		VARCHAR(10) NOT NULL,
	MATN		INT NOT NULL,
	SOLUONG		INT,
	TINHTRANG	NVARCHAR(50),
	FOREIGN KEY (SOPHONG) REFERENCES PHONG(SOPHONG),
	FOREIGN KEY (MATN) REFERENCES TIENNGHI(MATN),
	UNIQUE (SOPHONG, MATN)
)
GO

DELETE FROM PHONG_TIENNGHI
DBCC CHECKIDENT ('PHONG_TIENNGHI', RESEED, 0)
INSERT PHONG_TIENNGHI VALUES ('101', 1, 1, 'Normal')
INSERT PHONG_TIENNGHI VALUES ('101', 2, 1, 'Normal')
INSERT PHONG_TIENNGHI VALUES ('101', 3, 1, 'Normal')
INSERT PHONG_TIENNGHI VALUES ('101', 4, 1, 'Normal')

INSERT PHONG_TIENNGHI VALUES ('102', 1, 1, 'Normal')
INSERT PHONG_TIENNGHI VALUES ('102', 2, 1, 'Normal')

INSERT PHONG_TIENNGHI VALUES ('103', 3, 1, 'Normal')
INSERT PHONG_TIENNGHI VALUES ('103', 2, 1, 'Normal')

INSERT PHONG_TIENNGHI VALUES ('205', 1, 1, 'Normal')
INSERT PHONG_TIENNGHI VALUES ('205', 2, 3, 'Normal')

INSERT PHONG_TIENNGHI VALUES ('206', 1, 1, 'Normal')

INSERT PHONG_TIENNGHI VALUES ('304', 1, 1, 'Normal')
INSERT PHONG_TIENNGHI VALUES ('304', 2, 1, 'Normal')
GO
SELECT * FROM PHONG_TIENNGHI
SELECT * FROM PHONG
SELECT * FROM TIENNGHI

--------------------------------------------HDNTIENNGHI
IF OBJECT_ID('HDNTIENNGHI') IS NOT NULL
	DROP TABLE HDNTIENNGHI
GO
CREATE TABLE HDNTIENNGHI
(
	MAHD		INT IDENTITY(1,1) PRIMARY KEY,
	NGAYLAP		DATE NOT NULL DEFAULT GETDATE(),
	TONGTIEN	MONEY NOT NULL,
	MANCC		INT NOT NULL,
	MANV		VARCHAR(10) NOT NULL,
	FOREIGN KEY (MANCC) REFERENCES NHACUNGCAP(MANCC),
	FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
)
GO
DELETE FROM HDNTIENNGHI
DBCC CHECKIDENT ('HDNTIENNGHI', RESEED, 0)

----------------HDNTIENNGHICT
IF OBJECT_ID('HDNTIENNGHICT') IS NOT NULL
	DROP TABLE HDNTIENNGHICT
GO
CREATE TABLE HDNTIENNGHICT
(
	ID			INT IDENTITY(1,1) PRIMARY KEY,
	MAHD		INT NOT NULL,
	MATN		INT NOT NULL,
	SOLUONG		INT NOT NULL,
	DONGIA		MONEY NOT NULL CHECK (DONGIA > 0),
	FOREIGN KEY (MAHD) REFERENCES HDNTIENNGHI(MAHD),
	FOREIGN KEY (MATN) REFERENCES TIENNGHI(MATN),
	UNIQUE (MAHD, MATN)
)
GO
DELETE FROM HDNTIENNGHICT
DBCC CHECKIDENT ('HDNTIENNGHICT', RESEED, 0)










