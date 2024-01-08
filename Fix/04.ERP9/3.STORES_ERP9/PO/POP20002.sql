IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP20002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP20002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






----<Summary>
----
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>:Thị Phượng on 28/047/2017:
------------------Kết quả trả về: Status = 0 (Loại Message Info), Status = 1 (Loại Message Warning), Status = 2 (Loại Message Error)
----------------------MessageID: 00ML000050 (Kiểm tra khác DivisionID), 00ML000051 (Kiểm tra đã khóa sổ), 00ML000052 (Kiểm tra đã sử dụng)
----------------------Params (Danh sách VoucherNo không xóa được)
------------------Store xử lý: Xóa danh sách một /nhiều @ID, và chỉ Sửa 1 @ID
----------------------Nếu Xóa thành công
----Modify on 25/03/2019 by Tra Giang: Bổ sung kiểm tra trước khi sửa (Mode = 0) 
----Modify on 01/04/2019 by Tra Giang: Chỉnh sửa truyền Param hiển thị VoucherNo
----Modify on 04/06/2020 by Kiều Nga: Bỏ check duyệt đơn hàng khi sửa
----Modify on 05/08/2020 by Kiều Nga: Thêm đk check duyệt trên erp9.
----Modify on 19/11/2021 by Hoài Bảo: Bỏ check kiểm tra đã khóa sổ.
----Modify on 03/04/2023 by Văn Tài	: Xử lý đặc thù VNA về kiểm.
---- <Example>
---- EXEC POP20002 'MS', 'PO/07/2017/0001', 'OT3001', 1, 'E35C5153-8F04-44ED-8119-975A2AE7B132', ''

CREATE PROCEDURE POP20002
		( @DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
		  @VoucherIDList NVARCHAR(MAX) = NULL, --Truyền váo cho trường hợp xóa
		  @TableName  nvarchar(50),
		  @Mode tinyint,                 --1: Xóa 
		  @VoucherID VARCHAR(50) = NULL,        --Truyền vào cho trường hợp sửa
		  @UserID varchar(50)
		) 
AS 

BEGIN
	DECLARE @sSQL1 NVARCHAR(Max)
	DECLARE @sSQL2 NVARCHAR(Max)
	DECLARE @CustomerIndex INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))

	IF @Mode = 1 
		BEGIN	
		SET @sSQL1 = N'
					DECLARE @Status TINYINT,
							@Message NVARCHAR(1000),
							@Cur CURSOR,
							@ID VARCHAR(50),

							@DelDivisionID VARCHAR(50),
							@DelPOrderID VARCHAR(50),
							@DelVoucherNo VARCHAR(50),
							@DelTranMonth int,
							@DelTranYear int,
							@DelClosing int,
							@DelIsConfirm int,
							@DelIsConfirm01 int,
							@DelIsConfirm02 int

					Declare @OT3001temp table 
							(
							Status tinyint,
							MessageID varchar(100),
							Params varchar(4000)
							)
					
					SET @Status = 0
					SET @Message = ''''
					SET @ID = ''''
					Insert into @OT3001temp (	Status, MessageID, Params) 
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
					SELECT O01.DivisionID, O01.POrderID, O01.VoucherNo, O01.TranMonth, O01.TranYear, O99.Closing
							, Isnull(IsConfirm, 0) as IsConfirm, Isnull(IsConfirm01, 0) as IsConfirm01, Isnull(IsConfirm02, 0) as IsConfirm02
					FROM OT3001 O01 WITH(NOLOCK)
					INNER JOIN OT9999 O99 WITH(NOLOCK) ON O01.DivisionID = O99.DivisionID and O01.TranMonth= O99.TranMonth and O01.TranYear= O99.TranYear
					WHERE O01.POrderID IN ('''+@VoucherIDList+''')

					OPEN @Cur
					FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelPOrderID, @DelVoucherNo, @DelTranMonth, @DelTranYear
											, @DelClosing, @DelIsConfirm, @DelIsConfirm01, @DelIsConfirm02
					WHILE @@FETCH_STATUS = 0 '

		SET @sSQL2 = N'		
							BEGIN

										EXEC SOP90000 @DelDivisionID, @DelTranMonth, @DelTranYear, @DelPOrderID, '''+@TableName+''', 0, @Status output, @Message output
										--Nếu khác DivisionID thì cảnh báo.
										IF @DelDivisionID != '''+@DivisionID+'''
											Begin
												SET @Message = @DelVoucherNo
												update @OT3001temp set Params = ISNULL(Params,'''') + @Message+'','' where MessageID = ''00ML000050''
											End
										--Nếu đã khóa sổ thì cảnh báo.
										--ELSE IF @DelClosing = 1 
										--	Begin
										--		SET @Message = @DelVoucherNo
										--		update @OT3001temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''00ML000051''
										--	End
										--Nếu đã duyệt thì cảnh báo.
										ELSE IF (@DelIsConfirm = 1 or @DelIsConfirm01 = 1 or @DelIsConfirm02 = 1 or (@Status = 2 and @Message = ''OFML000067'')) 
											Begin
												SET @Message = @DelVoucherNo
												update @OT3001temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''OFML000067''
											End
										--- Kiểm tra phiếu đã duyệt erp9
										IF  EXISTS (SELECT TOP 1 1 From OT3001 WITH (NOLOCK)  Where OT3001.DivisionID = @DelDivisionID and OT3001.[Status] = 1 and OT3001.POrderID = @DelPOrderID)
												BEGIN
												SET @Message = @DelVoucherNo
												update @OT3001temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''OFML000067''
											END
										--Nếu đã sử dụng thì cảnh báo.
										ELSE IF @Status != 2 and @Message != ''OFML000067''
											Begin
												SET @Message = @DelVoucherNo
												update @OT3001temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''00ML000052''
											End
										ELSE 
											Begin
									
											-- Đẩy dữ liệu bị xóa vào table lịch sử xóa
											EXEC AP2089 @DelDivisionID, @DelPOrderID,3

											--Xoa thông tin duyệt
											DELETE FROM OOT9001 WHERE APKMaster =(select APKMaster_9000 from OT3001 where POrderID = @DelPOrderID)
											DELETE FROM OOT9000 WHERE APK =(select APKMaster_9000 from OT3001 where POrderID = @DelPOrderID)
												
											--Xoa phieu Detail đơn hàng bán
												DELETE OT3002 WHERE DivisionID = @DelDivisionID AND POrderID = @DelPOrderID

											--Xoa phieu Master đơn hàng bán
												DELETE OT3001 WHERE DivisionID = @DelDivisionID AND POrderID = @DelPOrderID

											-- Xoa phieu ma phan tich so 8 - AT1011
											Delete From AT1011 Where DivisionID = @DelDivisionID and AnaID = @DelVoucherNo AND AnaTypeID = ''A08''

											-- Xóa thông tin vận chuyển,chi phí VNA
												if (select CustomerName from CustomerIndex) = 147
												Begin
													DELETE OT3007 WHERE DivisionID = @DelDivisionID AND POrderID = @DelPOrderID
													DELETE OT3008 WHERE DivisionID = @DelDivisionID AND POrderID = @DelPOrderID
													DELETE OT3010 WHERE DivisionID = @DelDivisionID AND POrderID = @DelPOrderID
												end

											--Xoa phieu Duyệt Master đơn hàng bán
												DELETE OOT9000 WHERE DivisionID = @DelDivisionID AND ID = @DelVoucherNo

											--Xoa phieu Duyệt Detail
												DELETE OOT9001 WHERE APKMaster = ( SELECT TOP 1 APK FROM OOT9000 WITH(NOLOCK) WHERE DivisionID = @DelDivisionID AND ID = @DelVoucherNo)

											--Xóa quy cách
											If exists (SELECT top 1 1  FROM AT0000 WHERE DefDivisionID = '''+@DivisionID+''' AND IsSpecificate = 1)
													Delete From OT8899 where DivisionID = @DelDivisionID and VoucherID = @DelPOrderID and TableID =''OT3002''
											End

		
								FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelPOrderID, @DelVoucherNo, @DelTranMonth, @DelTranYear
													, @DelClosing, @DelIsConfirm, @DelIsConfirm01, @DelIsConfirm02
								Set @Status = 0
							END
							CLOSE @Cur
							SELECT Status, MessageID, Params From  @OT3001temp where Params is not null'
				EXEC (@sSQL1+@sSQL2)
				--print @sSQL1
				--Print @sSQL2

			END

	IF @Mode = 0
	BEGIN
				
		Declare @OT3001temp table 
							(
							Status tinyint,
							MessageID varchar(100),
							Params varchar(4000)
							)
		declare @VoucherNo varchar(4000)  = (SELECT TOP 1 OT3001.VoucherNo From OT3001 WITH (NOLOCK)  Where OT3001.DivisionID = @DivisionID and OT3001.POrderID = @VoucherID)

		---- Kiểm tra khác đơn vị thì cảnh báo 
		IF  EXISTS (SELECT TOP 1 1 From OT3001 WITH (NOLOCK)  Where OT3001.DivisionID != @DivisionID and OT3001.POrderID = @VoucherID)
			BEGIN
				INSERT INTO @OT3001temp (Status, Params, MessageID)
				SELECT 2 AS Status,@VoucherNo , '00ML000050' AS MessageID 
			END
		ELSE
		--- Kiểm tra phiếu đã duyệt
		--IF  EXISTS (SELECT TOP 1 1 From OT3001 WITH (NOLOCK)  Where OT3001.DivisionID = @DivisionID and OT3001.[Status] = 1 and OT3001.POrderID = @VoucherID)
		--		BEGIN
		--		INSERT INTO @OT3001temp (Status, Params, MessageID)
		--		SELECT 2 AS Status,@VoucherNo , '00ML000117' AS MessageID 
		--	END
		--ELSE
		--- Kiểm tra đã khóa sổ 
		--IF  EXISTS (SELECT TOP 1 1 From OT9999 WITH (NOLOCK)  Where OT9999.Closing = 1 and OT9999.TranMonth = (select TOP 1 TranMonth from OT3001 where OT3001.POrderID = @VoucherID ))
		--		BEGIN
		--		INSERT INTO @OT3001temp (Status, Params, MessageID)
		--		SELECT 2 AS Status,@VoucherNo , '00ML000051' AS MessageID 
		--	END
		--- Kiểm tra đã sử dụng 

		IF (@CustomerIndex = 147) -- VNA
		BEGIN
			IF  EXISTS (SELECT TOP 1 1 From AT9000 WITH (NOLOCK)  Where AT9000.DivisionID = @DivisionID and AT9000.OrderID = @VoucherID)
					BEGIN

					-- {0} này đã được sử dụng. Bạn chỉ được chỉnh sửa một số thông tin (Diễn giải, Giá thành sản phẩm).
					INSERT INTO @OT3001temp (Status, Params, MessageID)
					SELECT 1 AS Status,@VoucherNo , '00ML000240' AS MessageID 
				END
		END
		ELSE
		BEGIN
			IF  EXISTS (SELECT TOP 1 1 From AT9000 WITH (NOLOCK)  Where AT9000.DivisionID = @DivisionID and AT9000.OrderID = @VoucherID)
					BEGIN
					INSERT INTO @OT3001temp (Status, Params, MessageID)
					SELECT 2 AS Status,@VoucherNo , '00ML000052' AS MessageID 
				END
		END
	END
END

-- Trả về kết quả: Message.
SELECT * FROM @OT3001temp







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
