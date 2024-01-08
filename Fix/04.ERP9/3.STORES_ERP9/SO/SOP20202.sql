IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20202]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20202]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----<Summary>
----Kiểm tra xóa phiếu báo giá
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Cao Thị Phượng, Date: 23/03/2017
------------------Kết quả trả về: Status = 0 (Loại Message Info), Status = 1 (Loại Message Warning), Status = 2 (Loại Message Error)
----------------------MessageID: 00ML000050 (Kiểm tra khác DivisionID), 00ML000051 (Kiểm tra đã khóa sổ), 00ML000052 (Kiểm tra đã sử dụng)
----------------------Params (Danh sách QuotationNo không xóa được)
------------------Store xử lý: Xóa danh sách một /nhiều @ID, và chỉ Sửa 1 @ID
----------------------Nếu Xóa thành công

---- Modified by Thị Phượng, Date 23/06/2017 Bổ sung set lại giá trị @Status khi chạy con trỏ
---- Modified by Thị Phượng, Date 26/06/2017 fix bug xóa dữ liệu
---- Modified by Trọng Kiên, Date 06/10/2020: Fix lỗi xóa phiếu báo giá (Invalid Column RelatedToID) --> vì Email thay đổi cấu trúc
---- Modified by Văn Tài,	 Date 26/07/2021: [DTI] Bổ sung cập nhật trạng thái công việc về Chưa thực hiện khi xóa.
---- Modified by Văn Tài,	 Date 23/03/2022: [2022/02/IS/0110] Loại bỏ kiểm tra kỳ kế toán cho nghiệp vụ SO, PO trên ERP 9.
---- <Example>
---- exec SOP20202 @DivisionID=N'AS',@TableName=N'OT2101',@QuotationIDList=N'0690c35d-20ab-47c0-a7c7-294d0dcb0f38',@QuotationID=NULL,@Mode=1,@UserID=N'VU'

CREATE PROCEDURE SOP20202
		( @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
		  @QuotationIDList NVARCHAR(MAX) = '', --Truyền váo cho trường hợp xóa
		  @TableName  nvarchar(50),
		  @Mode tinyint,                 --1: Xóa
		  @QuotationID VARCHAR(50) = '',        --Truyền vào cho trường hợp sửa
		  @UserID varchar(50)
		) 
AS 

BEGIN
	DECLARE @sSQL1 NVARCHAR(Max) = '' ,
			@sSQL2 NVARCHAR(Max) = ''
    
	Declare @OT2101temp table 
			(
			Status tinyint,
			MessageID varchar(100),
			Params varchar(4000)
			)

	IF @Mode = 1 
		BEGIN	
		SET @sSQL1 = N'
					DECLARE @Status TINYINT,
							@Message NVARCHAR(1000),
							@Cur CURSOR,
							@ID VARCHAR(50),

							@DelDivisionID VARCHAR(50),
							@DelQuotationID VARCHAR(50),
							@DelQuotationNo VARCHAR(50),
							@DelTranMonth int,
							@DelTranYear int,
							@DelClosing int,
							@DelIsConfirm int

					Declare @OT2101temp table 
							(
							Status tinyint,
							MessageID varchar(100),
							Params varchar(4000)
							)
					
					SET @Status = 0
					SET @Message = ''''
					SET @ID = ''''
					Insert into @OT2101temp (	Status, MessageID, Params) 
								--Nếu khác DivisionID thì cảnh báo.
								Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
								union all
								--Nếu đã khóa sổ thì cảnh báo.
								Select 2 as Status, ''00ML000051'' as MessageID, Null as Params
								union all
								--Nếu đã duyệt thì cảnh báo.
								Select 2 as Status, ''OFML000067'' as MessageID, Null as Params
								union all
								--Nếu đã sử dụng thì cảnh báo.
								Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
				
					SET @Cur = CURSOR SCROLL KEYSET FOR
					SELECT O01.DivisionID, O01.QuotationID, O01.QuotationNo, O01.TranMonth, O01.TranYear, O99.Closing
							, Isnull(IsConfirm, 0) as IsConfirm
					FROM OT2101 O01 inner join OT9999 O99 on O01.DivisionID = O99.DivisionID and O01.TranMonth= O99.TranMonth and O01.TranYear= O99.TranYear
					WHERE O01.QuotationID IN ('''+@QuotationIDList+''') OR O01.QuotationID = '''+@QuotationID+'''

					OPEN @Cur
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelQuotationID, @DelQuotationNo, @DelTranMonth, @DelTranYear
											, @DelClosing, @DelIsConfirm
					WHILE @@FETCH_STATUS = 0 '
		SET @sSQL2 = N'
					BEGIN

								EXEC SOP90000 @DelDivisionID, @DelTranMonth, @DelTranYear, @DelQuotationID, '''+@TableName+''', 0, @Status output, @Message output
								--Nếu khác DivisionID thì cảnh báo.
								IF @DelDivisionID != '''+@DivisionID+'''
									Begin
										SET @Message = @DelQuotationNo
										update @OT2101temp set Params = ISNULL(Params,'''') + @Message+'','' where MessageID = ''00ML000050''
									End
								--Nếu đã khóa sổ thì cảnh báo.
								--ELSE IF @DelClosing = 1 
								--	BEGIN
								--		SET @Message = @DelQuotationNo
								--		update @OT2101temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''00ML000051''
								--	END
								--Nếu đã duyệt thì cảnh báo.
								ELSE IF (@DelIsConfirm = 1 or (@Status = 2 and @Message = ''SOFML000015'')) 
									Begin
										SET @Message = @DelQuotationNo
										update @OT2101temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''OFML000067''
									End
								--Nếu đã sử dụng thì cảnh báo.
								ELSE IF ((@Status = 2 or @Status = 3) and @Message != ''SOFML000015'')
									Begin
										SET @Message = @DelQuotationNo
										update @OT2101temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''00ML000052''
									End
								ELSE 
									Begin			
										DECLARE @CustomerIndex INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))
										
										--Xoa phieu Master đơn hàng bán
										DELETE FROM OOT9001
										WHERE APKMaster =(select APKMaster_9000 from OT2101 where QuotationID =@DelQuotationID)
										DELETE FROM OOT9000
										WHERE APK = (select APKMaster_9000 from OT2101 where QuotationID = @DelQuotationID)

										IF (@CustomerIndex = 114) -- DUCTIN
										BEGIN
											UPDATE OT21
											SET OT21.StatusID = N''TTCV0001'' -- Chưa thực hiện
											FROM OOT2110 OT21
											INNER JOIN OT2101 WITH (NOLOCK) ON OT2101.DivisionID = OT21.DivisionID
																				AND OT2101.TaskID IS NOT NULL
																				AND OT2101.TaskID = OT21.TaskID
																				AND OT2101.QuotationID = @DelQuotationID
																				
										END

										Delete From OT2101 Where DivisionID = @DelDivisionID and QuotationID = @DelQuotationID
										Delete From OT2102 Where DivisionID = @DelDivisionID and QuotationID = @DelQuotationID

										DELETE FROM CRMT90051_REL WHERE RelatedToID = @DelQuotationID
										--DELETE FROM CMNT90051_REL WHERE RelatedToID = @DelQuotationID
										DELETE FROM CRMT00002_REL WHERE RelatedToID = @DelQuotationID
										DELETE FROM CRMT00003 WHERE RelatedToID = @DelQuotationID
										DELETE FROM CRMT90031_REL WHERE RelatedToID = @DelQuotationID
										If exists (SELECT top 1 1  FROM AT0000 WHERE DefDivisionID = '''+@DivisionID+''' AND IsSpecificate = 1)
											Delete From OT8899 where DivisionID = @DelDivisionID and VoucherID = @DelQuotationID and TableID =''OT2102''

									End

		
						FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelQuotationID, @DelQuotationNo, @DelTranMonth, @DelTranYear
											, @DelClosing, @DelIsConfirm
						Set @Status = 0
					END
					CLOSE @Cur
					SELECT Status, MessageID, Params From  @OT2101temp where Params is not null'

		Print @sSQL1
		Print @sSQL2

	EXEC (@sSQL1+@sSQL2)
	END
	IF @Mode = 0
	    BEGIN
				
		--Declare @OT2101temp table 
		--					(
		--					Status tinyint,
		--					MessageID varchar(100),
		--					Params varchar(4000)
		--					)
		declare @QuotationNo varchar(4000)  = (SELECT TOP 1 OT2101.QuotationNo From OT2101 WITH (NOLOCK)  Where OT2101.DivisionID = @DivisionID and OT2101.QuotationID = @QuotationID)

		---- Kiểm tra khác đơn vị thì cảnh báo 
		IF  EXISTS (SELECT TOP 1 1 From OT2101 WITH (NOLOCK)  Where OT2101.DivisionID != @DivisionID )
			BEGIN
				INSERT INTO @OT2101temp (Status, Params, MessageID)
				SELECT 2 AS Status,@QuotationNo , '00ML000050' AS MessageID 
			END
		ELSE
		--- Kiểm tra phiếu đã duyệt
		IF  EXISTS (SELECT TOP 1 1 From OT2101 WITH (NOLOCK) 
		Left join OT2102 on OT2101.QuotationID = OT2102.QuotationID
		Where OT2101.DivisionID = @DivisionID and OT2101.QuotationID = @QuotationID and OT2101.[Status] = 1)
				BEGIN
				INSERT INTO @OT2101temp (Status, Params, MessageID)
				SELECT 2 AS Status,@QuotationNo , '00ML000117' AS MessageID 
			END
		ELSE
		--- Kiểm tra đã khóa sổ 
		--IF  EXISTS (SELECT TOP 1 1 From OT9999 WITH (NOLOCK)  Where OT9999.Closing = 1 and OT9999.TranMonth = (select TOP 1 TranMonth from OT2101 where OT2101.QuotationID = @QuotationID )
		--and OT9999.TranYear = (select TOP 1 TranYear from OT2101 where OT2101.QuotationID = @QuotationID ))
		--		BEGIN
		--		INSERT INTO @OT2101temp (Status, Params, MessageID)
		--		SELECT 2 AS Status,@QuotationNo , '00ML000051' AS MessageID 
		--	END
		--- Kiểm tra đã sử dụng 
		IF  EXISTS (SELECT TOP 1 1 From AT9000 WITH (NOLOCK)  Where AT9000.DivisionID = @DivisionID and AT9000.OrderID = @QuotationID)
				BEGIN
				INSERT INTO @OT2101temp (Status, Params, MessageID)
				SELECT 2 AS Status,@QuotationNo , '00ML000052' AS MessageID 
			END

	SELECT * FROM @OT2101temp
	END
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
