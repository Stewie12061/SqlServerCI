IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP4444]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP4444]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/*
-- Create by Cao Thị Phượng On 25/08/2016
-- Nội dung: Xay dựng tính năng thiết lập Lĩnh vực Kinh doanh POS
-- Modified by Thị Phượng on 10/13/2016 lấy thêm trường cửa hàng và tên cửa hàng
 */
 
CREATE PROCEDURE CIP4444  
(@UserID NVARCHAR(50), --Nhập Lĩnh vực tương ứng
 @DivisionID Varchar(50)
)
AS 
DECLARE 

@ImportExcel INT = 0	--Nhập ImportExcel tương ứng

SELECT EmployeeID AS UserID, POST0010.BusinessArea, POST0010.ShopID, POST0010.ShopName, @ImportExcel FROM POST0026 
LEFT JOIN POST0010 ON POST0010.DivisionID = POST0026.DivisionID AND POST0010.ShopID = POST0026.ShopID 
WHERE  POST0026.DivisionID = @DivisionID AND POST0026.EmployeeID=@UserID
-----------------------DANH MỤC LĨNH VỰC INDEX------------------------------------------------------
 
 ---1: Bar-Nhà hàng- Cafe
 ---2: Thời trang
 ---3: Mẹ và bé
 ---4: Điện thoại & Điện máy
 ---5: Mỹ phẩm
 ---6: Nội thất & Gia dụng
 ---7: Hoa & Quà tặng
 ---8: Xe máy & linh kiện
 ---9: Sách & Văn phòng phẩm
 ---10: Siêu thị mini
 ---11: Nông sản & Thực phẩm
 ---12: Nhà thuốc
 ---13: Vật liệu xây dựng
 ---14: Đồ chơi trẻ em
 ---15: Ngành nghề khác
 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON