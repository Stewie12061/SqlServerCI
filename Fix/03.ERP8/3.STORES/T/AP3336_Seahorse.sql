IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3336_Seahorse]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3336_Seahorse]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created on 23/08/2018 by Kim Thư
--- Customize Seahorse: Lấy thông tin hóa đơn dịch vụ từ phần mềm ASA
--- Modified by Kim Thư on 25/9/2018: Bổ sung lọc theo VoucherID xem phiếu đã kế thừa trường hợp edit hóa đơn
--- Modified by Kim Thư on 24/10/2018: Sửa điều kiện dữ liệu phòng ảo: MaHoaDonBanHang, NgayDi, NgayDen = NULL
--- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
--- Modified by Huỳnh Thử on 23/06/2021: Bổ sung WITH (NOLOCK)
--- Modified by Thanh Lượng on 05/01/2023:[2023/01/IS/0004]: Bổ sung thêm cột UnitID và Quantity cho View AV3336
--- Modified by Nhựt Trường on 06/01/2023: [2023/01/IS/0038] - Bổ sung làm tròn theo thiết lập các trường NetAmount, OriginalAmount, ServiceCharge.

CREATE PROCEDURE AP3336_Seahorse @Date as datetime, @Room as varchar(20), @Filter as varchar(4000) = '', @VoucherID as varchar(100)=''

AS

Declare @sql varchar(max)
Declare @sql1 varchar(max)
Declare @ConvertDecimal varchar(5)

SET @ConvertDecimal = (Select TOP 1 ConvertedDecimals FROM AT1101 WITH (NOLOCK))
Set @Room = Case When @Room = '' Then '%' Else @Room End
Set @Filter = Case When @Filter = '' Then '' Else ' And A01.Ma In(' +  @Filter +')'  End

Set @sql = '
SELECT 
	(Case When ISNULL(A01.Phong,'''') = '''' Then cast(A01.MaDangKy2 as varchar(100)) Else A01.Phong End) AS [RoomNo],
	A01.Ten AS [ObjectName], 
	A01.Ngay AS [Date],
	A01.MaHoaDonTay AS [BillNo],   
	A01.MaHoaDonBanHang AS [SalesBillNo],   
	A01.MaDichVu AS [InventoryID],
	A01.Outlet AS [Outlet],
	T01.InventoryName AS [InventoryName], 
	A01.MoTaDichVu AS [Description],
	isnull(A01.HD_TienQuyDoi, 0)  AS [BillAmount],
	A01.MaThanhToan AS [PaymentID],
	A01.CongTyDuLich AS [CompanyID], 
	A01.CongTy AS [CompanyName],
	A01.MaBoPhan AS [DepartmentID],
	--A01.NgayDen AS [Ngaøy check in],
	--A01.NgayTraPhong AS [Ngaøy check out],
	Case When ISNULL(A01.Phong,'''') <>'''' Then A01.NgayDenThuc Else A01.NgayDen End AS [CheckInDate],
	Case When ISNULL(A01.MaHoaDonBanHang,'''') = '''' and ISNULL(A01.NgayDi,'''') = '''' and ISNULL(A01.NgayDen,'''') = '''' Then ''1900-01-01''
		Else Case When ISNULL(A01.Phong,'''') <>'''' Then DateAdd(d,A01.SoNgayThuc,A01.NgayDenThuc) Else DateAdd(d,A01.SoNgay,A01.NgayDen) End End AS [CheckOutDate],
	A01.Ma As [ID]
FROM    SeahorsePT_FO..vwALV4101 A01 
	LEFT OUTER JOIN AT1302 T01 WITH (NOLOCK) ON  A01.MaDichVu = T01.InventoryID
WHERE ISNULL(A01.MaThanhToan,'''') <> '''' And A01.Ma In (Select Ma From AT3333 Where VoucherID= '''+@VoucherID+''') 

UNION ALL

SELECT * FROM (
	SELECT TOP 100 PERCENT
		(Case When ISNULL(A01.Phong,'''') = '''' Then cast(A01.MaDangKy2 as varchar(100)) Else A01.Phong End) AS [RoomNo],
		A01.Ten AS [ObjectName], 
		A01.Ngay AS [Date],
		A01.MaHoaDonTay AS [BillNo],   
		A01.MaHoaDonBanHang AS [SalesBillNo],   
		A01.MaDichVu AS [InventoryID],
		A01.Outlet AS [Outlet],
		T01.InventoryName AS [InventoryName], 
		A01.MoTaDichVu AS [Description],
		isnull(A01.HD_TienQuyDoi, 0)  AS [BillAmount],
		A01.MaThanhToan AS [PaymentID],
		A01.CongTyDuLich AS [CompanyID], 
		A01.CongTy AS [CompanyName],
		A01.MaBoPhan AS [DepartmentID],
		--A01.NgayDen AS [Ngaøy check in],
		--A01.NgayTraPhong AS [Ngaøy check out],
		Case When ISNULL(A01.Phong,'''') <> '''' Then A01.NgayDenThuc Else A01.NgayDen End AS [CheckInDate],
		Case When ISNULL(A01.MaHoaDonBanHang,'''') = '''' and ISNULL(A01.NgayDi,'''') = '''' and ISNULL(A01.NgayDen,'''') = '''' Then ''1900-01-01''
			Else Case When ISNULL(A01.Phong,'''') <> '''' Then DateAdd(d,A01.SoNgayThuc,A01.NgayDenThuc) Else DateAdd(d,A01.SoNgay,A01.NgayDen) End End AS [CheckOutDate],
		A01.Ma As [ID]
	FROM    SeahorsePT_FO..vwALV4101 A01 
		LEFT OUTER JOIN AT1302 T01 WITH (NOLOCK) ON  A01.MaDichVu = T01.InventoryID
	WHERE ISNULL(A01.MaThanhToan,'''') <> '''' And A01.Ma Not In (Select Ma From AT3333) ' + 
		Case When Left(@Room,1) = '#' Then ' And A01.MaHoaDonBanHang Like ''' + right(@Room,len(@Room) - 1) + '''' 
		Else 
			Case When @Date = '1900-01-01' Then ' And ISNULL(A01.MaHoaDonBanHang,'''') = '''' and ISNULL(A01.NgayDi,'''') = '''' and ISNULL(A01.NgayDen,'''') = '''' ' 
				Else 'And Case When ISNULL(A01.MaHoaDonBanHang,'''') = '''' and ISNULL(A01.NgayDi,'''') = '''' and ISNULL(A01.NgayDen,'''') = '''' Then ''1900-01-01''
						Else Case When ISNULL(A01.Phong,'''') <> '''' Then DateAdd(d,A01.SoNgayThuc,A01.NgayDenThuc) Else DateAdd(d,A01.SoNgay,A01.NgayDen) End End = '''+LTRIM(@Date)+''' ' End +'
						
			And (Case When ISNULL(A01.Phong,'''') = '''' Then cast(A01.MaDangKy2 as varchar(100)) Else A01.Phong End)  Like ''' + @Room  + ''''
		End + @Filter  + ' ORDER BY Case When ISNULL(A01.Phong,'''') <> '''' Then A01.Phong Else cast(A01.MaDangKy2 as varchar(100)) End, A01.MaSoKhach2, A01.MaDichVu, A01.Ngay 
) A'

--And Case When ISNULL(A01.Phong,'''') <> '''' Then DateAdd(d,A01.SoNgayThuc,A01.NgayDenThuc) Else DateAdd(d,A01.SoNgay,A01.NgayDen) End = '''+LTRIM(@Date)+''' ' End +'
--select @sql
EXEC (@sql)
--	' And Case When A01.Phong Is Not Null Then (Case When A01.Phong <> ''000'' Then DateAdd(d,A01.SoNgayThuc,A01.NgayDenThuc) Else ''01/01/1900'' End) Else DateAdd(d,A01.SoNgay,A01.NgayDen) End = ' + Case When @Date <> '01/01/1900' Then '''' + ltrim(@Date) + '''' Else 'Case When A01.Phong Is Not Null Then (Case When A01.Phong <> ''000'' Then DateAdd(d,A01.SoNgayThuc,A01.NgayDenThuc) Else ''01/01/1900'' End) Else DateAdd(d,A01.SoNgay,A01.NgayDen) End ' End + ' 
Set @sql1 = '
SELECT TOP 100 PERCENT
	(Case When ISNULL(A01.Phong,'''') = '''' Then cast(A01.MaDangKy2 as varchar(100)) Else A01.Phong End) AS RoomNo,
	A01.Ten AS [ObjectName], 
	A01.Ngay AS [Date],
	A01.MaHoaDonTay AS [BillNo], 
	A01.MaHoaDonBanHang AS [SalesBillNo],  
	A01.MaDichVu AS [InventoryID],
	A01.Outlet AS [Outlet],
	T01.InventoryName AS [InventoryName], 
	A01.MoTaDichVu AS [Description],
	A01.DonViTinh AS [UnitID],
    A01.SoLuong AS [Quantity],
	isnull(A01.HD_TienQuyDoi,0) AS [BillAmount],

	Round(isnull(A01.HD_TienQuyDoi,0)  * 100 / (100 + A01.Thue) * 100 / (100 + A01.ThueDB) * 100 / (100 + A01.PhiPhucVu),'+@ConvertDecimal+') AS [NetAmount],

	Round(isnull(A01.HD_TienQuyDoi,0)  * 100 / (100 + A01.Thue) * 100 / (100 + A01.PhiPhucVu),'+@ConvertDecimal+') AS [OriginalAmount],

	Round(isnull(A01.HD_TienQuyDoi,0)  * 100 / (100 + A01.Thue) * A01.PhiPhucVu / (100 + A01.PhiPhucVu),'+@ConvertDecimal+') AS [ServiceCharge],

	A01.MaThanhToan AS PaymentID,
	A01.CongTyDuLich AS CompanyID, 
	A01.CongTy AS [CompanyName],
	A01.MaBoPhan AS DepartmentID,
	--A01.NgayDen,
	--A01.NgayTraPhong,
	Case When ISNULL(A01.Phong,'''') <> '''' Then A01.NgayDenThuc Else A01.NgayDen End AS CheckInDate,
	Case When ISNULL(A01.MaHoaDonBanHang,'''') = '''' and ISNULL(A01.NgayDi,'''') = '''' and ISNULL(A01.NgayDen,'''') = '''' Then ''1900-01-01''
		Else Case When ISNULL(A01.Phong,'''') <> '''' Then DateAdd(d,A01.SoNgayThuc,A01.NgayDenThuc) Else DateAdd(d,A01.SoNgay,A01.NgayDen) End End AS [CheckOutDate],
	A01.Ma AS ID
FROM   SeahorsePT_FO..vwALV4101 A01 
	LEFT OUTER JOIN AT1302 T01 WITH (NOLOCK) ON  A01.MaDichVu = T01.InventoryID
WHERE ISNULL(A01.MaThanhToan,'''') <> '''' And A01.Ma Not In (Select Ma From AT3333) ' + 
	Case When Left(@Room,1) = '#' Then ' And A01.MaHoaDonBanHang Like ''' + right(@Room,len(@Room) - 1) + '''' 
	Else 
		Case When @Date = '1900-01-01' Then ' And ISNULL(A01.MaHoaDonBanHang,'''') = '''' and ISNULL(A01.NgayDi,'''') = '''' and ISNULL(A01.NgayDen,'''') = '''' ' 
			Else  'And Case When ISNULL(A01.MaHoaDonBanHang,'''') = '''' and ISNULL(A01.NgayDi,'''') = '''' and ISNULL(A01.NgayDen,'''') = '''' Then ''1900-01-01''
						Else Case When ISNULL(A01.Phong,'''') <> '''' Then DateAdd(d,A01.SoNgayThuc,A01.NgayDenThuc) Else DateAdd(d,A01.SoNgay,A01.NgayDen) End End = '''+LTRIM(@Date)+''' ' End +'
		And (Case When ISNULL(A01.Phong,'''') = '''' Then cast(A01.MaDangKy2 as varchar(100)) Else A01.Phong End)  Like ''' + @Room  + ''''
	End + @Filter  + ' ORDER BY Case When ISNULL(A01.Phong,'''') <> '''' Then A01.Phong Else cast(A01.MaDangKy2 as varchar(100)) End, A01.MaSoKhach2, A01.MaDichVu, A01.Ngay 
' 

If exists (Select Top 1 1 From sysobjects Where Id = Object_ID('AV3336') And xType = 'V')
Begin
	Drop View AV3336
End
EXEC('Create View AV3336 --Create by AP3336_Seahorse
		As  ' + @sql1)	
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO