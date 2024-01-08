IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1413]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP1413]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author: Thanh Tram
-- Create date: 13/12/2010
-- Description:	Tạo dữ liệu từ các bảng standar khi tạo đơn vị
-- =============================================
---- Modified on 13/11/2012 by Le Thi Thu Hien : DELETE AT1412
--- Modified on 17/12/2013 by Khanh Van: them vao module quan ly hoa hong
--- Modified on 20/11/2014 by Quốc Tuấn: xóa thêm bảng CST8888, CST0001
--- Modified by Phương Thảo on 15/05/2017: Sửa danh mục dùng chung
--- Modified by Hoàng Vũ on 28/02/2018: xóa thêm bảng MT0008, HT0010, POST0000
--- Modified by Phương Thảo on 08/03/2018: Chỉnh sửa không xóa những dữ liệu ngầm của bảng dùng chung
--- Modified by Lê Hoàng on 24/08/2020: xóa thêm bảng WT0005

CREATE PROCEDURE [dbo].[AP1413] 
	@DivisionID NVARCHAR(50)
AS
BEGIN

	--Insert dữ liệu từ các bản standar vào table 	
	DELETE FROM AT0000 WHERE DefDivisionID = @DivisionID;
	
	DELETE FROM A00004 WHERE DivisionID = @DivisionID;

	DELETE FROM AT0002 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT0004 WHERE DivisionID = @DivisionID;

	DELETE FROM AT0005 WHERE DivisionID = @DivisionID
	
	DELETE FROM AT0006 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1001 WHERE DivisionID  = @DivisionID
	
	DELETE FROM AT1002 WHERE DivisionID  = @DivisionID

	DELETE FROM AT1004 WHERE DivisionID = @DivisionID
	
	DELETE FROM AT1005 WHERE DivisionID = @DivisionID
	
	DELETE FROM AT1006 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1007 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1008 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1009 WHERE DivisionID = @DivisionID
	
	DELETE FROM AT1010 WHERE DivisionID = @DivisionID
		
	DELETE FROM AT1017 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1201 WHERE DivisionID = @DivisionID
		
	DELETE FROM AT1206 WHERE DivisionID = @DivisionID
	
	DELETE FROM AT1301 WHERE DivisionID = @DivisionID
	
	DELETE FROM AT1304 WHERE DivisionID = @DivisionID
		
	DELETE FROM AT1305 WHERE DivisionID = @DivisionID;
		
	DELETE FROM AT1306 WHERE DivisionID = @DivisionID;
		
	DELETE FROM AT1401 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1402 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1403 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1404 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1405 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1408 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1409 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1410 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1502 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1598 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1599 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT4700 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT4701 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT4710 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT6000 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT6100 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT6101 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT6501 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT6502 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT7410 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT7420 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT7433 WHERE DivisionID = @DivisionID;
				
	DELETE FROM AT7434 WHERE DivisionID = @DivisionID;

	DELETE FROM AT7601 WHERE DivisionID = @DivisionID;

	DELETE FROM AT7602 WHERE DivisionID = @DivisionID;

	DELETE FROM AT7801 WHERE DivisionID = @DivisionID;

	DELETE FROM AT7802 WHERE DivisionID = @DivisionID;

	DELETE FROM AT7901 WHERE DivisionID = @DivisionID;

	DELETE FROM AT7902 WHERE DivisionID = @DivisionID;

	DELETE FROM AT8000 WHERE DivisionID = @DivisionID;

	DELETE FROM AT8001 WHERE DivisionID = @DivisionID;

	DELETE FROM AT8888 WHERE DivisionID = @DivisionID;

	DELETE FROM AT9011 WHERE DivisionID = @DivisionID;

	DELETE FROM CT0005 WHERE DivisionID = @DivisionID;

	DELETE FROM CT2222 WHERE DivisionID = @DivisionID;
	
	DELETE FROM CT8888 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT0001 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT0002 WHERE DivisionID = @DivisionID;
	DELETE FROM HT0003 WHERE DivisionID = @DivisionID;
	DELETE FROM HT0005 WHERE DivisionID = @DivisionID;
	DELETE FROM HT0006 WHERE DivisionID = @DivisionID;
	DELETE FROM HT0017 WHERE DivisionID = @DivisionID;
	DELETE FROM HT0018 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT1000 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT1001 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT1002 WHERE DivisionID = @DivisionID;

	DELETE FROM HT1005 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT1006 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT1007 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT1010 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT1103 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT2222 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT2223 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT2225 WHERE DivisionID = @DivisionID;
	DELETE FROM HT6666 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT8888 WHERE DivisionID = @DivisionID;
	
	DELETE FROM MT0699 WHERE DivisionID = @DivisionID;
	
	--DELETE FROM MT0700 WHERE DivisionID = @DivisionID;
	
	DELETE FROM MT0811 WHERE DivisionID = @DivisionID;
	
	DELETE FROM MT1619 WHERE DivisionID = @DivisionID;
	
	DELETE FROM MT1620 WHERE DivisionID = @DivisionID;
	
	DELETE FROM MT5002 WHERE DivisionID = @DivisionID;

	DELETE FROM MT8888 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT0001 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT1005 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT1006 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT1101 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT4011 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT4012 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT8888 WHERE DivisionID = @DivisionID;
	
	DELETE FROM WT8888 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT1102 WHERE DivisionID = @DivisionID;
	
	-- Tấn Phú add dữ liệu phần hóa đơn tự in
	DELETE FROM AT3000 WHERE DivisionID = @DivisionID;
	DELETE FROM AT7903 WHERE DivisionID = @DivisionID;
	DELETE FROM AT7904 WHERE DivisionID = @DivisionID;
	DELETE FROM AT0008 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT0005 WHERE DivisionID = @DivisionID;
	
	DELETE FROM CT0000 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT0000 WHERE DivisionID = @DivisionID;
	
	DELETE FROM FT0000 WHERE DefDivisionID = @DivisionID;
	
	DELETE FROM WT0000 WHERE DefDivisionID = @DivisionID;
	
	DELETE FROM WT0005 WHERE DivisionID = @DivisionID;
	
	DELETE FROM MT0000 WHERE DivisionID = @DivisionID;
	
	DELETE FROM PT0000 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT0000 WHERE DivisionID = @DivisionID;
	
	DELETE FROM A00005 WHERE DivisionID = @DivisionID;
	
	DELETE FROM A00006 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT0001 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT0009 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1104 WHERE DivisionID in (@DivisionID,'@@@')
	
	DELETE FROM AT1205 WHERE DivisionID in (@DivisionID,'@@@')
	
	DELETE FROM AT1310 WHERE DivisionID in (@DivisionID,'@@@')
	
	DELETE FROM AT3339 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT4711 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT4712 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT6666 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT7905 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT7907 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT7908 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT8889 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT2537 WHERE DivisionID = @DivisionID;
	
	DELETE FROM HT2538 WHERE DivisionID = @DivisionID;
	
	DELETE FROM OT1007 WHERE DivisionID = @DivisionID;
	
	DELETE FROM AT1412 WHERE DivisionID = @DivisionID;
	DELETE FROM CMT0000 WHERE DefDivisionID = @DivisionID;
	DELETE FROM AT1501 WHERE DivisionID = @DivisionID;
	DELETE FROM CMT8888 WHERE DivisionID =@DivisionID;
	DELETE FROM WT1005 WHERE DivisionID =@DivisionID;
	DELETE FROM CST8888 WHERE DivisionID =@DivisionID;
	DELETE FROM CST0001 WHERE DivisionID =@DivisionID;
	DELETE FROM MT0008 WHERE DivisionID =@DivisionID;
	DELETE FROM HT0010 WHERE DivisionID =@DivisionID;
	DELETE FROM POST0000 WHERE DivisionID =@DivisionID;
	
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
