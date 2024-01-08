IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Nguyen Van Nhan.
---- Created Date Sunday 06/06/2004
---- Purpose: Kiem tra rang buoc du lieu cho phep Sua, Xoa
---- Edit by: Dang Le Bao Quynh Date 16/05/2007
---- Purpose: Kiem tra chung tu da duoc chon phan bo DTNT & CPTT truoc khi xoa
---- Edit by B.Anh, date 25/07/2009, bo sung kiem tra doi voi nhap kho mua hang, xuat kho ba'n hang
---- Modified on 10/05/2012 by Lê Thị Thu Hiền : Bổ sung kiểm tra Định nghĩa vị trí (Lô) FormID = WF0081
---- Modified on 10/05/2012 by Lê Thị Thu Hiền : Bổ sung kiểm tra vị trí (Lô) FormID = WF0079
---- Modified on 21/10/2012 by Bao Anh : Kiểm tra khi bỏ duyệt tạm chi/tạm chi qua ngân hàng
---- Modified on 11/12/2012 by Bao Anh : Kiểm tra khi sua/xoa phieu mua/ban hang co ke thua lap phieu chi/thu
---- Modified on 22/01/2013 by Bao Anh : Sửa lỗi Status trả về sai khi sua/xoa phieu mua/ban hang co ke thua lap phieu chi/thu
---- Modified on 11/06/2014 by Lê Thị Thu Hiền : Bổ sung kiểm tra Phiếu kết chuyển từ POS
---- Modified on 19/06/2014 by Lê Thị Thu Hiền : Status = 3 Bạn được sửa 1 số thông tin
---- Modified on 30/06/2014 by Trần Quốc Tuấn : Status = 3 thay tableID thành ReTableID
---- Modified on 21/07/2014 by Lê Thị Thu Hiền : Kiểm tra hàng bán trả lại được chuyển từ POS
---- Modified on 04/03/2015 by Lê Thị Hạnh: Bổ sung kiểm tra trước khi sửa, xoá AF0080, AF0072, AF0085, AF0094 [Phân bổ chi phí mua hàng - LAVO]
---- Modified on 21/12/2015 by Phương Thảo : Kiểm tra tại màn hình phiếu Chi (bỏ qua không kiểm tra dòng Thuế nhà thầu 'T43')
---- Modified on 19/01/2016 by Phương Thảo : Kiểm tra không cho phép sửa xóa phiếu hạch toán bằng loại tiền sử dụng BQGQ di động
---- Modified on 27/01/2016 by Hoàng vũ: Fixbug bản chuẩn khi xóa/sửa hóa đơn bán hàng theo bộ thì không kiểm tra đã giải trừ (Và fix code bên DEV xóa báo lỗi...)
---- Modified on 27/01/2016 by Hoàng vũ: Fixbug bản chuẩn nếu danh sách hóa đơn bàn hàng không được phép xóa/sửa hóa đơn bán hàng theo bộ
---- Modified on 19/02/2016 by Hoàng vũ: Fixbug bản chuẩn nếu danh sách hóa đơn bàn hàng/bán hàng theo bo không được phép xóa/sửa vì đã kế thừa trả hàng
---- Modified on 25/05/2016 by Quốc Tuấn: bổ sung customer cho khác hàng VIMEC không kiểm tra màn hình AF0093 kế thừa từ phiếu thu
---- Modified on 30/05/2016 by Bảo Thy: Bổ sung WITH (NOLOCK)
---- Modified on 25/11/2016 by Bảo Thy: Bổ sung kiểm tra sửa, xóa đối với những chứng từ đã tập hợp chi phí ở Module-M cho màn hình AF0094, AF0072
---- Modified on 21/06/2017 by Bảo Thy: Bổ sung kiểm tra sửa, xóa phiếu mua hàng đã được kế thừa lập Phiếu tạm chi/Tam chi qua ngân hàng chưa
---- Modified on 26/07/2017 by Hải Long: Bổ sung kiểm tra sửa, xóa phiếu mua hàng, phiếu tổng hợp đã được kế thừa sang bên phân hệ tài sản cố định hay chưa
---- Modified on 03/08/2017 by Bảo Anh: Bổ sung kiểm tra sửa, xóa phiếu thu/chi qua ngân hàng đã được kế thừa qua quản lý vay chưa
---- Modified on 31/08/2017 by Hải Long: Bổ sung kiểm tra hóa đơn điện tử
---- Modified on 12/10/2017 by Hải Long: Bổ sung kiểm tra hóa đơn điện tử cho hàng mua trả lại, hàng bán trả lại
---- Modified on 2018/04/20 by Phát Danh: Bổ sung kiểm tra bảng giá bán, bảng giá gói
---- Modified on 09/05/2018 by Bảo Anh: Đưa phần kiểm tra các bảng module POS vào chuỗi để không bị lỗi cho khách hàng không dùng ERP 9.0
---- Modified on 13/07/2018 by Bảo Anh: Bổ sung kiểm tra WM đã khóa sổ thì không cho sửa phiếu mua hàng/bán hàng đã nhập/xuất kho
---- Modified on 12/12/2018 by Kim Thư: Set Status =3 cho hóa đơn điện tử => được phép sửa 1 số trường
---- Modified on 10/01/2019 by Kim Thư: Bổ sung kiểm tra WM đã khóa sổ thì không cho sửa phiếu mua hàng/bán hàng đã nhập/xuất kho, đưa câu kiểm tra về option của mỗi màn hình, không kiểm tra chung
---- Modified on 15/02/2019 by Kim Thư: Bổ sung hoá đơn điện tử chờ ký vẫn cho sửa, nếu đã ký (có số hóa đơn) thì cho sửa 1 số cột
---- Modified on 11/03/2019 by Kim Thư: Sửa lỗi kiểm tra bảng giá bán
---- Modified on 26/04/2019 by Kim Thư: Bổ sung message trường hợp phiếu đã được tập hợp chi phí
---- Modified on 08/05/2019 by Kim Thư: Cho sửa 1 số cột đối với hóa đơn hàng mua trả lại đã phát hành EInvoice
---- Modified on 16/03/2020 by Huỳnh Thử: Check đã xuất kho TableID AT9000
---- Modified on 16/03/2020 by Huỳnh Thử: Check đã xuất kho TransactionTypeID Not In ('T33','T22')
---- Modified on 16/03/2020 by Huỳnh Thử: Kiểm tra là hóa đơn điện tử
---- Modified on 29/10/2020 by Hoài Phong: Cho Thay thế sửa HDDT bộ Phát hành hóa đơn điện tử.
---- Modified on 18/11/2020 by Văn Tài: Điều chỉnh lại kiểm tra kế thừa từ bảng AT9010 ReVoucherID = @VoucherID
---- Modified on 02/0-2/2021 by Đức Thông: [KRUGER] 2021/02/IS/0010: AF0097: Xác nhận phiếu là HDDT nếu có số hóa đơn
---- Modified on 05/03/2021 by Đức Thông: [Phúc Long] 2021/03/IS/0041: Bổ sung điều kiện kiểm tra phiếu đã giải trừ hay chưa
---- Modified on 16/02/2022 by Kiều Nga: Fix Lỗi không sửa được Phiếu thu - chi qua ngân hàng
---- Modified on 01/04/2022 by Nhật Thanh : Customize những trường hợp angel không chặn thao tác
---- Modified on 20/04/2022 by Nhựt Trường: Bổ sung điều kiện check hóa đơn 8 số theo thông tư 78.
/********************************************
'* Edited by: [GS] [Hoàng Phước] [29/07/2010]
'********************************************/
/* 
exec AP9000 @Divisionid=N'LV',@Tranmonth=2,@Tranyear=2015,@Voucherid=N'TVff78d783-729c-409e-b0cf-b3e975c7fb9f',@Tableid=N'AT9000',@Batchid=N'TB2111f898-bf16-46b1-9ffa-4a8fc691bd9b',@Fromid=N'AF0080'

*/


CREATE PROCEDURE [dbo].[AP9000] 	
				@DivisionID nvarchar(50),
				@TranMonth int,
				@TranYear int,
				@VoucherID nvarchar(50),
				@TableID  nvarchar(50),
				@BatchID as nvarchar(50),
				@FromID as nvarchar(50)
AS

Declare @Status as tinyint,
	@EngMessage as nvarchar(250),
	@VieMessage as nvarchar(250),
	@TypeID NVARCHAR(250) = '',
	@VoucherNo NVARCHAR(250) = '',
	@sSQL01 NVARCHAR(4000) = ''

	SET @Status =0
	SET @EngMessage =''
	SET @VieMessage=''

--Add by Dang Le Bao Quynh; Date 02/05/2013
--Purpose: Kiem tra customize cho Sieu Thanh

Declare @AP4444 Table(CustomerName Int, Export Int)
Insert Into @AP4444(CustomerName,Export) EXEC('AP4444')

DECLARE @BaseCurrencyID NVarchar(50), @VoucherDate Datetime, @CreateDate Datetime

/*
If (Select CustomerName From @AP4444)=16
	----- Xu ly chung
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT9000 Where 	VoucherID =@VoucherID and TableID = @TableID and DivisionID =@DivisionID and 
								TranMonth =@TranMonth And TranYear =@TranYear and (IsCost<>0 or IsAudit <>0 ))
			BEGIN
				SET @Status =1
				SET @VieMessage =N'AFML000042'
				SET @EngMessage =N'AFML000042'
				Goto EndMess
			End
	End	
Else
*/
	BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE DivisionID =@DivisionID And TranYear =@TranYear and TranMonth =@TranMonth AND TableID = @TableID 
														AND VoucherID =@VoucherID and ISNULL(ExpenseID,'') <>'' AND ISNULL(MaterialTypeID,'') <>'' )
		BEGIN --Trường hợp phiếu đã được tập hợp chi phí
			SET @Status =1
			SET @VieMessage =N'AFML000541'
			SET @EngMessage =N'AFML000541'
			Goto EndMess
		End
	
	IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where VoucherID =@VoucherID and @FromID = 'AF0097' AND (TableID = @TableID or TableID = 'AT1326' or TableID = 'MT1603') and DivisionID =@DivisionID and 
							TranMonth =@TranMonth And TranYear =@TranYear and (Status <>0 or IsCost<>0 or IsAudit <>0 ))
		BEGIN --Không được phép xóa/sửa nếu đã giải trừ
			SET @Status =4
			SET @VieMessage =N'AFML000042'
			SET @EngMessage =N'AFML000042'
			Goto EndMess
		End
	

	IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where VoucherID =@VoucherID and (TableID = @TableID or TableID = 'AT1326' or TableID = 'MT1603') and DivisionID =@DivisionID and 
							TranMonth =@TranMonth And TranYear =@TranYear and (Status <>0 or IsCost<>0 or IsAudit <>0 ))
		BEGIN --Không được phép xóa/sửa nếu đã giải trừ
			SET @Status =1
			SET @VieMessage =N'AFML000042'
			SET @EngMessage =N'AFML000042'
			Goto EndMess
		End
	End
	
	IF EXISTS (SELECT TOP 1 1 FROM AT1703 WITH (NOLOCK) WHERE VoucherID =@VoucherID AND DivisionID =@DivisionID)
		BEGIN
			SET @Status =1
			SET @VieMessage =N'AFML000043'
			SET @EngMessage =N'AFML000043'
			Goto EndMess
		End
		
	IF @FromID ='AF0094' OR @FromID = 'AF0080'	----- Danh sách bút toán tổng hợp - phiếu mua hàng
	BEGIN
		----Kiểm tra đã được kế thừa qua phân hệ tài sản cố định hay chưa?
		IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) 
					INNER JOIN AT1533 WITH (NOLOCK) ON AT9000.TransactionID = AT1533.ReTransactionID AND AT9000.DivisionID = AT1533.DivisionID
					WHERE AT9000.VoucherID = @VoucherID AND AT9000.DivisionID = @DivisionID)
			BEGIN
				SET @Status =1
				SET @VieMessage =N'AFML000433'
				SET @EngMessage =N'AFML000433'
				Goto EndMess
			End		
	END		
			
				
	IF @FromID ='WF0008'		----- Danh sách phieu nhập-xuất-VCNB
		BEGIN
			Exec AP0701 @DivisionID,@TranMonth,	@TranYear,@VoucherID, @FromID, @Status  output, @EngMessage  output, @VieMessage output
			Goto EndMess
		End

	IF @FromID ='AF0058' OR @FromID ='WF0014'		----- Danh sách phieu Nhập-xuất kho theo bộ
		BEGIN
			Exec AP0701 @DivisionID,@TranMonth,	@TranYear,@VoucherID,@FromID,@Status  output, @EngMessage  output, @VieMessage output
			Goto EndMess
		End


	IF @FromID ='AF0091' or @FromID ='AF0096'		----- Phieu mua hang, ba'n hang, nhap kho mua hang, xuat kho ba'n hang
		BEGIN
			Exec  AP3033 	@VoucherID, @BatchID, @DivisionID, @TranMonth, @TranYear,	@Status output, @VieMessage output, @EngMessage output
			Goto EndMess
		End

	If @FromID ='WF0007'   ---- So du hang ton kho
		BEGIN
			 Exec AP1701 @DivisionID,@TranMonth, @TranYear,@VoucherID, @Status output, @EngMessage output, @VieMessage output	
			Goto EndMess			
		End
	If @FromID ='AF0072' -- Truy vấn phiếu thu chi
		BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where TransactionTypeID not in ('T01','T02','T11','T43','T10') and VoucherID =@VoucherID and BatchID = @BatchID and TableID = @TableID and DivisionID =@DivisionID)
				BEGIN
					SET @Status =1
					SET @VieMessage =N'AFML000044'
					SET @EngMessage =N'AFML000044'
					Goto EndMess
				End
			IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where VoucherID =@VoucherID and BatchID = @BatchID and TableID = 'CMT0015' and DivisionID =@DivisionID)
				BEGIN
					SET @Status =1
					SET @VieMessage =N'AFML000044'
					SET @EngMessage =N'AFML000044'
					Goto EndMess
				END
				-- Kiểm tra phiếu đã thực hiện phân bổ chi phí mua hàng hay chưa?
			IF EXISTS (SELECT TOP 1 1 FROM AT0321 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND POCVoucherID = @VoucherID )
				BEGIN
						SET @Status = 1
						SET @VieMessage ='AFML000420'
						SET @EngMessage ='AFML000420'
						GOTO EndMess
				END 	
				---- Kiểm tra phiếu đã được tập hợp chi phí ở ASOFT-M chưa
			IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) 
						WHERE DivisionID = @DivisionID
						AND VoucherID = @VoucherID
						AND IsNull(MaterialTypeID,'') <>''
						AND IsNull(PeriodID,'')<>''
						AND ExpenseID IN ('COST001','COST002', 'COST003') )
				BEGIN

						SET @Status = 1
						SET @VieMessage ='WFML000176'
						SET @EngMessage ='WFML000176'
						GOTO EndMess
				END
				
		End
	If @FromID ='AF0085' -- Truy vấn thu chi ngân hàng
		BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where VoucherID =@VoucherID and BatchID = @BatchID and TableID = 'CMT0015' and DivisionID =@DivisionID)
				BEGIN
					SET @Status =1
					SET @VieMessage =N'AFML000044'
					SET @EngMessage =N'AFML000044'
					Goto EndMess
				END
				-- Kiểm tra phiếu đã thực hiện phân bổ chi phí mua hàng hay chưa?
			IF EXISTS (SELECT TOP 1 1 FROM AT0321 WHERE DivisionID = @DivisionID AND POCVoucherID = @VoucherID )
				BEGIN
						SET @Status = 1
						SET @VieMessage ='AFML000420'
						SET @EngMessage ='AFML000420'
						GOTO EndMess
				END
			IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS TAB WHERE TAB.Name like 'lmt%')											
			BEGIN		
				--- Kiểm tra phiếu đã được kế thừa qua nghiệp vụ phong tỏa của quản lý vay chưa
				SET @sSQL01 = N'			
				IF EXISTS (SELECT TOP 1 1 FROM LMT2011 WHERE DivisionID = '''+@DivisionID+''' AND InheritVoucherID = '''+@VoucherID+''')
					BEGIN
							SET @sStatus = 1
							SET @sVieMessage =''AFML000435''
							SET @sEngMessage =''AFML000435''						
					END

				--- Kiểm tra phiếu đã được kế thừa qua nghiệp vụ thanh toán của quản lý vay chưa
				IF EXISTS (SELECT TOP 1 1 FROM LMT2031 WHERE DivisionID = '''+@DivisionID+''' AND InheritVoucherID = '''+@VoucherID+''')
					BEGIN
							SET @sStatus = 1
							SET @sVieMessage =''AFML000436''
							SET @sEngMessage =''AFML000436''						
					END						
				'			

				EXEC sp_executesql @sSQL01, N'@sStatus as tinyint output, @sEngMessage as nvarchar(250) output, @sVieMessage as nvarchar(250) output', 
					@Status output, @EngMessage output, @VieMessage output
				IF(@Status = 1)				
					GOTO EndMess
			END
				
		End
	------------------ Định nghĩa vị trí------------
	IF @FromID = 'WF0081'
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT2007 WITH (NOLOCK) WHERE SourceNo = @VoucherID AND DivisionID = @DivisionID)
		BEGIN
			SET @Status = 1
			SET @VieMessage = N'WFML000042'
			SET @EngMessage = N'WFML000042'
			GOTO EndMess
		END
	END
	------------------ Vị trí------------
	IF @FromID = 'WF0079'
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM WT1006 WITH (NOLOCK) WHERE (	Location01ID = @VoucherID OR 
														Location02ID = @VoucherID OR 
														Location03ID = @VoucherID OR 
														Location04ID = @VoucherID OR 
														Location05ID = @VoucherID ) 
														AND DivisionID = @DivisionID)
		BEGIN
			SET @Status = 1
			SET @VieMessage = N'WFML000042'
			SET @EngMessage = N'WFML000042'
			GOTO EndMess
		END
	END
	--- kiem tra khong cho bo duyet tam chi/tam chi qua ngan hang
	IF @FromID ='AF0098' or @FromID ='AF0257'
		BEGIN
			--- [Văn Tài]	Updated	[18/11/2020] - Điều chỉnh kiểm tra kế thừa: ReVoucherID = @VoucherID
			IF EXISTS (SELECT TOP 1 1 FROM AT9010 WITH (NOLOCK) Where Isnull(ReVoucherID,'') = @VoucherID And DivisionID = @DivisionID)
				BEGIN
					SET @Status =1
					SET @VieMessage =N'AFML000365'
					SET @EngMessage =N'AFML000365'
					Goto EndMess
				End
				
			IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where VoucherID = @VoucherID and DivisionID = @DivisionID and 
							TranMonth =@TranMonth And TranYear =@TranYear and (Status <>0 or IsCost<>0 or IsAudit <>0 ) )
				BEGIN
					SET @Status =1
					SET @VieMessage =N'AFML000370'
					SET @EngMessage =N'AFML000370'
					Goto EndMess
				End
		END
	
	IF @FromID = 'AF0093'
		BEGIN
				--Kiểm tra là hóa đơn điện tử
				IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE AT9000.DivisionID = @DivisionID AND AT9000.VoucherID = @VoucherID AND IsEInvoice = 1 
							AND EInvoiceStatus = 1 AND InvoiceNo<>'0000000' AND InvoiceNo<>'00000000')
					BEGIN
						--SET @Status =1
						SET @Status =3
						SET @VieMessage =N'AFML000458'
						SET @EngMessage =N'AFML000458'
						Goto EndMess
					END	
								
				--Tại màn hình hóa đơn bán hàng không được phép sửa/xóa hóa đơn bán hàng theo bộ
				--IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where TableID = 'AT1326' and TransactionTypeID in( 'T04') 
				--					And VoucherID = @VoucherID and DivisionID =@DivisionID)
				--	BEGIN
				--		SET @Status =1
				--		SET @VieMessage =N'AFML000098'
				--		SET @EngMessage =N'AFML000098'
				--		Goto EndMess
				--	END
				If (Select CustomerName From @AP4444) not in (31,57)
				BEGIN
					IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where TransactionTypeID in( 'T01','T21') And Isnull(TVoucherID,'') = @VoucherID and DivisionID =@DivisionID)
					BEGIN
						SET @Status =1
						SET @VieMessage =N'AFML000371'
						SET @EngMessage =N'AFML000371'
						Goto EndMess
					END
				END
				
				--Tại màn hình hóa đơn bán hàng không được xóa/sửa nếu đã kế thưa qua Hàng bán trả lại
				IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where TransactionTypeID in( 'T24') and TableID = 'AT9000'
								And Isnull(ReVoucherID,'') = @VoucherID and DivisionID =@DivisionID)
					BEGIN
						SET @Status =1
						SET @VieMessage =N'AFML000399'
						SET @EngMessage =N'AFML000399'
						Goto EndMess
					End
									
				IF EXISTS (SELECT TOP 1 1 FROM CMT0010 WITH (NOLOCK) Where VoucherID = @VoucherID and DivisionID =@DivisionID)
					BEGIN
						SET @Status =1
						SET @VieMessage =N'AFML000379'
						SET @EngMessage =N'AFML000379'
						Goto EndMess
					End
				Else
					Exec  AP3033 	@VoucherID, @BatchID, @DivisionID, @TranMonth, @TranYear,	@Status output, @VieMessage output, @EngMessage output
				
				-- Phiếu kết chuyển từ POS
				IF EXISTS (SELECT TOP 1 1 FROM AT9000  WITH (NOLOCK)
							Where AT9000.DivisionID =@DivisionID AND AT9000.ReTableID = 'POST0016' AND AT9000.VoucherID = @VoucherID)
					BEGIN
						SET @Status = 3
						SET @VieMessage =N'AFML000381' 
						SET @EngMessage =N'AFML000381'
						
					End
				Goto EndMess

				--- Kiểm tra WM đã khóa sổ thì không cho sửa phiếu mua/bán hàng đã nhập/xuất kho
				IF ISNULL((SELECT DISTINCT IsStock FROM AT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID  AND TableID = 'AT9000'  and TransactionTypeID Not In ('T33','T23','T13')),0) = 1
					AND (SELECT Closing FROM WT9999 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear) = 1
				BEGIN
					SET @Status =1
					SET @VieMessage =N'WFML000255'
					SET @EngMessage =N'WFML000255'
					Goto EndMess
				END
				
		End
	
	IF @FromID = 'AF0145' or  @FromID = 'AF0144'
		BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE AT9000.DivisionID = @DivisionID AND AT9000.VoucherID = @VoucherID AND IsEInvoice = 1 
							AND EInvoiceStatus = 1 AND InvoiceNo<>'0000000' AND InvoiceNo<>'00000000')
					BEGIN
						--SET @Status =1
						SET @Status =3
						SET @VieMessage =N'AFML000458'
						SET @EngMessage =N'AFML000458'
						Goto EndMess
					END
				--Tại màn hình hóa đơn bán hàng theo bộ không được xóa/sửa nếu đã kế thưa qua thu/chi
				IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where TransactionTypeID in( 'T01','T21') And Isnull(TVoucherID,'') = @VoucherID and DivisionID =@DivisionID  And Status = 1)
					BEGIN
						SET @Status =1
						SET @VieMessage =N'AFML000371'
						SET @EngMessage =N'AFML000371'
						Goto EndMess
					End
				--Tại màn hình hóa đơn bán hàng theo bộ không được xóa/sửa nếu đã kế thưa qua Hàng bán trả lại theo bộ
				IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where TransactionTypeID in( 'T24') and TableID in ('AT1326', 'MT1603')
									And Isnull(ReVoucherID,'') = @VoucherID and DivisionID =@DivisionID)
					BEGIN
						SET @Status =1
						SET @VieMessage =N'AFML000400'
						SET @EngMessage =N'AFML000400'
						Goto EndMess
					End
				Goto EndMess
				
			
		End

	IF @FromID = 'AF0080' -- Truy vấn phiếu mua hàng
		BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where TransactionTypeID = 'T02' And Isnull(TVoucherID,'') = @VoucherID and DivisionID =@DivisionID)
				BEGIN
					SET @Status =1
					SET @VieMessage =N'AFML000372'
					SET @EngMessage =N'AFML000372'
				End
			else
				Exec  AP3033 	@VoucherID, @BatchID, @DivisionID, @TranMonth, @TranYear,	@Status output, @VieMessage output, @EngMessage output
			
			
				-- Kiểm tra phiếu đã thực hiện phân bổ chi phí mua hàng hay chưa?
			IF EXISTS (SELECT TOP 1 1 FROM AT0321 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND POVoucherID = @VoucherID )
				BEGIN
						SET @Status = 1
						SET @VieMessage ='AFML000420'
						SET @EngMessage ='AFML000420'
				END
			----Kiểm tra đã được kế thừa lập Phiếu tạm chi chưa?
			IF EXISTS ( SELECT TOP 1 1 FROM AT9010 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND InheritVoucherID = @VoucherID AND TransactionTypeID = 'T02')
			BEGIN
				SET @Status = 1

				SET @VieMessage = 'AFML000432'
				SET @EngMessage = 'AFML000432'
			END

			----Kiểm tra đã được kế thừa lập Phiếu tạm chi/Tam chi qua ngân hàng chưa?
			If (Select CustomerName From @AP4444)<>57
			IF EXISTS ( SELECT TOP 1 1 FROM AT9010 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND InheritVoucherID = @VoucherID AND TransactionTypeID ='T22')
			BEGIN
				SET @Status = 1

				SET @VieMessage = 'AFML000485'
				SET @EngMessage = 'AFML000485'
			END
						
			Goto EndMess

			--- Kiểm tra WM đã khóa sổ thì không cho sửa phiếu mua/bán hàng đã nhập/xuất kho
			IF ISNULL((SELECT DISTINCT IsStock FROM AT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID  AND TableID = 'AT9000'  and TransactionTypeID Not In ('T33','T23','T13') ),0) = 1
				AND (SELECT Closing FROM WT9999 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear) = 1
			BEGIN
				SET @Status =1
				SET @VieMessage =N'WFML000255'
				SET @EngMessage =N'WFML000255'
				Goto EndMess
			END
		END
		
		
	If @FromID ='AF0097'  ---- Hàng bán trả lại
		BEGIN
			--Kiểm tra là hóa đơn điện tử (đã có số hóa đơn)
			IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE AT9000.DivisionID = @DivisionID AND AT9000.VoucherID = @VoucherID AND IsEInvoice = 1 AND EInvoiceStatus = 1 AND ISNULL(InvoiceNo, '') != '0000000' AND ISNULL(InvoiceNo, '') != '00000000')
				BEGIN
					SET @Status =1
					SET @VieMessage =N'AFML000458'
					SET @EngMessage =N'AFML000458'
					Goto EndMess
				END			
					
			------------ Phiếu kết chuyển từ POS
				IF EXISTS (SELECT TOP 1 1 FROM AT9000  WITH (NOLOCK)
							Where AT9000.DivisionID =@DivisionID AND AT9000.ReTableID = 'POST0016' AND AT9000.VoucherID = @VoucherID)
					BEGIN
						SET @Status = 3
						SET @VieMessage =N'AFML000381' 
						SET @EngMessage =N'AFML000381'
					END
					
				Goto EndMess
				
		End

IF @FromID ='AF0094' -- Bút toán tổng hợp
	BEGIN
		-- Kiểm tra phiếu đã thực hiện phân bổ chi phí mua hàng hay chưa?
			IF EXISTS (SELECT TOP 1 1 FROM AT0321 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND POCVoucherID = @VoucherID )
				BEGIN
						SET @Status = 1
						SET @VieMessage ='AFML000420'
						SET @EngMessage ='AFML000420'
						GOTO EndMess
				END
		
			IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) 
						WHERE DivisionID = @DivisionID
						AND VoucherID = @VoucherID
						AND IsNull(MaterialTypeID,'') <>''
						AND IsNull(PeriodID,'')<>''
						AND ExpenseID IN ('COST001','COST002', 'COST003') )
				BEGIN

						SET @Status = 1
						SET @VieMessage ='WFML000176'
						SET @EngMessage ='WFML000176'
						GOTO EndMess
				END
				
	END
	
	IF @FromID = 'AF0372' -- Hóa đơn điện tử
		BEGIN					
				--Tại màn hình hóa đơn bán hàng không được phép sửa/xóa hóa đơn bán hàng theo bộ
				--IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where TableID = 'AT1326' and TransactionTypeID in( 'T04') 
				--					And VoucherID = @VoucherID and DivisionID =@DivisionID)
				--	BEGIN
				--		SET @Status =1
				--		SET @VieMessage =N'AFML000098'
				--		SET @EngMessage =N'AFML000098'
				--		Goto EndMess
				--	END
				If (Select CustomerName From @AP4444)<>31
				BEGIN
					IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where TransactionTypeID in( 'T01','T21') And Isnull(TVoucherID,'') = @VoucherID and DivisionID =@DivisionID)
					BEGIN
						SET @Status =1
						SET @VieMessage =N'AFML000371'
						SET @EngMessage =N'AFML000371'
						Goto EndMess
					END
				END
				
				--Tại màn hình hóa đơn bán hàng không được xóa/sửa nếu đã kế thưa qua Hàng bán trả lại
				IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) Where TransactionTypeID in( 'T24') and TableID = 'AT9000'
								And Isnull(ReVoucherID,'') = @VoucherID and DivisionID =@DivisionID)
					BEGIN
						SET @Status =1
						SET @VieMessage =N'AFML000399'
						SET @EngMessage =N'AFML000399'
						Goto EndMess
					End
									
				IF EXISTS (SELECT TOP 1 1 FROM CMT0010 WITH (NOLOCK) Where VoucherID = @VoucherID and DivisionID =@DivisionID)
					BEGIN
						SET @Status =1
						SET @VieMessage =N'AFML000379'
						SET @EngMessage =N'AFML000379'
						Goto EndMess
					End
				Else
					Exec  AP3033 	@VoucherID, @BatchID, @DivisionID, @TranMonth, @TranYear,	@Status output, @VieMessage output, @EngMessage output
				
				-- Phiếu kết chuyển từ POS
				IF EXISTS (SELECT TOP 1 1 FROM AT9000  WITH (NOLOCK)
							Where AT9000.DivisionID =@DivisionID AND AT9000.ReTableID = 'POST0016' AND AT9000.VoucherID = @VoucherID)
					BEGIN
						SET @Status = 3
						SET @VieMessage =N'AFML000381' 
						SET @EngMessage =N'AFML000381'
						
					End
				Goto EndMess
				
		END
		
	IF @FromID = 'AF0095' -- Hàng mua trả lại
		BEGIN
			--Kiểm tra là hóa đơn điện tử
			IF EXISTS (SELECT TOP 1 1 FROM AT9000 WITH (NOLOCK) WHERE AT9000.DivisionID = @DivisionID AND AT9000.VoucherID = @VoucherID AND IsEInvoice = 1 AND EInvoiceStatus = 1 AND InvoiceNo<>'0000000' AND InvoiceNo<>'00000000')
				BEGIN
					SET @Status =3
					SET @VieMessage =N'AFML000458'
					SET @EngMessage =N'AFML000458'
					Goto EndMess
				END					
		END				

	
	IF @FromID = 'OF0018' AND @TableID = 'POST00161' -- Bảng giá bán
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS TAB WHERE TAB.Name like 'POST%')											
		BEGIN
			--SET @sSQL01 = N'
			--Kiểm tra đã được sử dụng: thiết lập ở cửa hàng
			IF EXISTS (SELECT TOP 1 1 FROM POST0010 WITH (NOLOCK) WHERE POST0010.PriceTable = ''' + @VoucherID + ''')
			BEGIN
				SET @Status =1
				SET @VieMessage =N'CFML000228'
				SET @EngMessage =N'CFML000228'	
				GOTO EndMess			
			END

			--EXEC sp_executesql @sSQL01, N'@sStatus as tinyint output, @sEngMessage as nvarchar(250) output, @sVieMessage as nvarchar(250) output', 
			--		@Status output, @EngMessage output, @VieMessage output
			--IF(@Status = 1)				
			--	GOTO EndMess
		END
	END

	IF @FromID = 'CF0190' AND @TableID = 'POST00161' -- Bảng giá gói
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS TAB WHERE TAB.Name like 'POST%')											
		BEGIN
			SET @sSQL01 = N'
			--Kiểm tra đã được sử dụng: thiết lập ở cửa hàng
			IF EXISTS (SELECT TOP 1 1 FROM POST0010 WITH (NOLOCK) WHERE POST0010.PackagePriceID = ''' + @VoucherID + ''')
			BEGIN
				SET @Status =1
				SET @VieMessage =N''CFML000228''
				SET @EngMessage =N''CFML000228''				
			END		
					
			--Kiểm tra đã được sử dụng: Bán hàng trên POS
			IF EXISTS (SELECT TOP 1 1 FROM POST00161 WITH (NOLOCK) WHERE POST00161.PackagePriceID = ''' + @VoucherID + ''' and DeleteFlg <> 1)
			BEGIN
				SET @Status =1
				SET @VieMessage =N''CFML000229''
				SET @EngMessage =N''CFML000229''				
			END			
					
			--Kiểm tra đã được sử dụng: Đặt cọc trên POS
			IF EXISTS (SELECT TOP 1 1 FROM POST2011 WITH (NOLOCK) WHERE POST2011.PackagePriceID = ''' + @VoucherID + ''' and DeleteFlg <> 1)
			BEGIN
				SET @Status =1
				SET @VieMessage =N''CFML000230''
				SET @EngMessage =N''CFML000230''				
			END'
			
			EXEC sp_executesql @sSQL01, N'@sStatus as tinyint output, @sEngMessage as nvarchar(250) output, @sVieMessage as nvarchar(250) output', 
					@Status output, @EngMessage output, @VieMessage output
			IF(@Status = 1)				
				GOTO EndMess
		END
	END		
	
	IF @FromID = 'CF0191' AND @TableID = 'POST00161' -- Bảng giá gói (Sửa chi tiết)
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS TAB WHERE TAB.Name like 'POST%')											
		BEGIN
			SET @sSQL01 = N'
			--Kiểm tra đã được sử dụng: Bán hàng trên POS
			IF EXISTS (SELECT TOP 1 1 FROM POST00161 WITH (NOLOCK) WHERE POST00161.PackagePriceID = ''' + @VoucherID + ''' and PackageID = ''' + @BatchID + ''' and DeleteFlg <> 1)
			BEGIN
				SET @Status =1
				SET @VieMessage =N''CFML000229''
				SET @EngMessage =N''CFML000229''
				Goto EndMess
			END			
					
			--Kiểm tra đã được sử dụng: Đặt cọc trên POS
			IF EXISTS (SELECT TOP 1 1 FROM POST2011 WITH (NOLOCK) WHERE POST2011.PackagePriceID = ''' + @VoucherID + ''' and PackageID = ''' + @BatchID + ''' and DeleteFlg <> 1)
			BEGIN
				SET @Status =1
				SET @VieMessage =N''CFML000230''
				SET @EngMessage =N''CFML000230''
				Goto EndMess
			END'

			EXEC sp_executesql @sSQL01, N'@sStatus as tinyint output, @sEngMessage as nvarchar(250) output, @sVieMessage as nvarchar(250) output', 
					@Status output, @EngMessage output, @VieMessage output
			IF(@Status = 1)				
				GOTO EndMess
		END
	END						
	
	--IF @FromID = 'AF0080' OR @FromID = 'AF0093'	--- Kiểm tra WM đã khóa sổ thì không cho sửa phiếu mua/bán hàng đã nhập/xuất kho
	--BEGIN
	--	--- Kiểm tra WM đã khóa sổ thì không cho sửa phiếu mua/bán hàng đã nhập/xuất kho
	--	IF ISNULL((SELECT IsStock FROM AT9000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID),0) = 1
	--		AND (SELECT Closing FROM WT9999 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear) = 1
	--	BEGIN
	--		SET @Status =1
	--		SET @VieMessage =N'WFML000255'
	--		SET @EngMessage =N'WFML000255'
	--		Goto EndMess
	--	END
	--END

--================================================
	EndMess:
	Select @FromID, @Status as Status, @EngMessage as EngMessage, @VieMessage as VieMessage, @TypeID TypeID, @VoucherNo VoucherNo
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
