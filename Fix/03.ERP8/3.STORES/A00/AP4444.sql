IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP4444]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP4444]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Viết lại bởi Thanh Sơn on 20/10/2014
-- Nội dung: Bổ sung tính năng tự động lấy lại CustomerName cũ, 
--			 Không cần phải chạy lại store AP4444 mỗi khi chạy fix lại cho khách hàng
 */
 
CREATE PROCEDURE AP4444 AS
DECLARE @CustomerName INT = -1, --Nhập CustomerName tương ứng
		@ImportExcel INT = 0	--Nhập ImportExcel tương ứng

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CustomerIndex]') AND TYPE IN (N'U'))
CREATE TABLE CustomerIndex (CustomerName INT, ImportExcel INT)
IF NOT EXISTS (SELECT TOP 1 1 FROM CustomerIndex)
	INSERT INTO CustomerIndex (CustomerName, ImportExcel)
	VALUES (@CustomerName, @ImportExcel)
ELSE 
	BEGIN
		IF @CustomerName <> -1 
		UPDATE CustomerIndex SET CustomerName = @CustomerName
		IF @ImportExcel <> 0  
		UPDATE CustomerIndex SET ImportExcel = @ImportExcel
	END	
SELECT CustomerName, ImportExcel FROM CustomerIndex
-----------------------DANH MỤC KHÁCH HÀNG CUSTOMIZE------------------------------------------------------
/*
		-1______Standard
		 0______MVI
		 1______Minh Phương
		 2______Ngọc Tề
		 3______Trung Dũng
		 4______Viễn Tín
		 5______Toàn Thắng
		 6______Đông Quang
		 7______Quang Huy
		 8______Binh Tay
		 9______KonDo
		10______An Tin
		11______EUROVIE
		12______Thuận Lợi
		13______Tiên Tiến
		14______Tân Thành
		15______2T
		16______Cường Thanh, Siêu Thanh
		17______IPL
		18______Fine Fruit Asia
		19______Cảng Sài Gòn
		20______Sinolife
		21______Unicare
		22______Dacin
		23______Viện Gut
		24______Long Trường Vũ
		25______King Com (Hoàng Vũ)
		26______PrintTech
		27______An Phúc Thịnh
		28______Sun Viet
		29______TBIV
		30______Hưng Vượng
		31______Vimec
		32______PHÚC LONG (Hoàng Vũ)
		33______Minh Tiến (Quốc Tuấn)
		34______XƯƠNG RỒNG (Thanh Sơn)
		35______EIS 
		36______Sài Gòn Petro (Thị Hạnh)
		37______SOFA (Quốc Tuấn)
		38______BBL - BounBon Bến Lức (Trí Thiện)
		39______Vân Khánh (Trí Thiện)
		40______Long Giang (Thanh Sơn)
		41______QTC		
		42______HUA HEONG VN
		43______SECOIN (Hoàng Vũ)
		44______SAVIPHARM 
		45______ABA (Thị Hạnh)
		46______HUYNDAE (Thanh Sơn)
		47______Đại Nam Phát (Quốc Tuấn)
		48______An Phú Gia (Tiểu Mai)
		49______Figla(Thịnh)
		50______MeiKo (Kim Vũ)
		51______Hoàng Trần (Hoàng Vũ)
		52______KOYO (Tiểu Mai)
		53______OFFICIENCE
		54______An Phát (Tiểu Mai)
		55______SAMSUN (Bảo Đăng)
		56______TMDVQ3 (Hoàng Vũ POS)
		57______ANGEL (Bảo Anh)
		58______NGANHA (Phương Thảo)
		59______DFURNI (Kim Vũ)
		60______HOA SÁNG (Tiểu Mai)
		61______FUYUEH (Kim Vũ)
		62______PMT (Bảo Thy)
		63______VPS (Bảo Thy)
		64______An Bình (Bảo Anh)
		65______THÀNH CÔNG (Phương Thảo)
		66______Đồng Việt (Bảo Anh)	
		67______Kim Hoàn Vũ (Bảo Đăng)	
		68______Nguyễn Tất Thành (Phương Thảo)	
		69______Mạnh Phương (Hải Long)	
		70______EIMSKIP (Bảo Thy)
		71______Hiệp Hòa Phát (Hải Long)
		72______TUV (Phương Thảo)
		73______Đông Dương (Phương Thảo)
		74______Godrej (Phương Thảo)
		75______PACIFIC (Hải Long)
		76______Chí Thành (Bảo Anh)	
		77______Đại Phước (Tiểu Mai)
		78______Bông Sen (Bảo Anh)	
		79______Minh Sang (Cao Thị Phượng)
		80______Bê Tông Long An (Hải Long)		
		81______NEWTOYO (Hoàng Vũ)	
		82______KIM YẾN (Cao Thị Phượng)		
		83______PanalPina (Bảo Thy)
		84______BASON (Khả Vi)
		85______Thuận gia (Bảo Thy)
		86______GX (Bảo Đăng)
		87______OKIA (Cao Thị Phượng)
		88______VIETFIRST (Bảo Thy)
		89______MINHTRI(Kim Vu)
		90______TIẾN HƯNG (Bảo Anh)
		91______BLUESKY (Phương Thảo)
		92______CTY Cổ phần ASOFT (Cao Thị Phượng)
		93______Làng Tre (Bảo Anh)
		94______KAJIMA (Bảo Anh)
		95______LITTLE (Bảo Anh)
		96______VIỆT LINH (Bảo Anh)
		97______Vườn Sạch (Tiểu Mai)
		98______ATTOM (Tiểu Mai)
		99______HUỲNH Gia(Tấn Phú)
		100_____Seahorse (Kim Thư)
		101_____AIC (Hồng Thảo)
		102_____Mỹ Phong ( Hồng Thảo)
		103_____Chợ Bình Điền (Bảo Anh)
		104_____Nguyên Nguyên Phước (Trà Giang)
		105_____LIENQUAN (Trà Giang)
		106_____Đạt Vĩnh Tiến (Kim Thư)
		107_____VIỆT NAM FOOD (Hoàng Vũ)
		108_____NHÂN NGỌC (Hoàng Vũ)
		109_____SEABORNES (Kim Thư)
		110_____SONG BÌNH (Kim Thư)
		111_____PHẠM TƯỜNG (Kim Thư)
		112_____JYESHING (Kim Thư)
		113_____ALLJET (Kim Thư)
		114_____Đức Tín
		115_____MTE (Lương Mỹ)
		116_____CAAN (Văn Tài)
		117_____MAITHU (Trà Giang)
		118_____BMC (Văn Tài)
		119_____Đại Đăng (Văn Tài)
		120_____THTP (Tổng hợp Thịnh Phát) (Văn Tài)
		121_____BKE (Văn Tài)
		122_____TÂN HÒA LỢI (Trà Giang)
		123_____HIẾU HẢO
		124_____Đệ Nhất Liên Bang
		125_____Đạt Vĩnh Thép
		126_____Đông Tiến Hưng
		127_____TechNo
		128_____VINAPAPER
		129_____Hưng Thịnh
		130_____Central Business Development (Đình Hòa)
		131_____Nguyễn Quang Huy (Huỳnh Thử)
		132_____Hạ tầng Tân Cảng (Đức Thông)
		133_____KRUGER (Đức Thông)
		134_____ĐỨC PHÁT BAKERY (Văn Tài)
		135_____TELLBE (Huỳnh Thử)
		136_____Quí Dần (Đức Thông)
		137_____MECI (Đình Hòa)
		138_____LESA (Tấn Lộc)
		139_____Hiệp Hưng (Nhựt Trường)
		140_____GOTEC (Nhựt Trường)
		141_____Sài Gòn Nam Phát (Đình Ly)
		142_____Vĩnh Hưng (Huỳnh Thử)
		143_____Hữu Phú (Tấn Lộc)
		144_____Nam Hoa (Nhựt Trường)
		145_____Đại Phát Tài (Văn Tài)
		146_____Thabico Hậu Giang (Văn Tài)
		147_____Vĩnh Nam Anh (Văn Tài)
		148_____Đông Á (Văn Tài)
		149_____JINYANG (Kiều Nga)
		150_____GIALAI (Văn Tài]
		151_____EXEDY (Văn Tài)
		152_____Cảng Sài Gòn (Văn Tài)
		153_____SIKICO (Kiều Nga)
		154_____CANG DĨNH (Văn Tài) // 154 nhưng tạm thời đang là 32 chung với Phúc Long.
		155_____PERSTIMA (Văn Tài)
		156_____Vôi Càng Long (Văn Tài)
		157_____Bảo Bảo An (Văn Tài)
		158_____HIPC - Cao Cấp Hà Nội (Văn Tài)
		159_____RUDHOLM (Nhựt Trường)
		160_____GOLEADER (Thanh Lượng)
		161_____INNOTEK (Nhật Thanh)
		162_____Gree (Nhật Thanh)
		163_____Thanh Liêm (Nhật Thanh)
		164_____PAN GLOBE ENTERPRISE (Đức Tuyên)
		165_____Phước Điền (Xuân Nguyên)
		166_____Nệm Kim Cương (Nhật Thanh)
		167_____Cai Mei (Thanh Lượng)
*/

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
