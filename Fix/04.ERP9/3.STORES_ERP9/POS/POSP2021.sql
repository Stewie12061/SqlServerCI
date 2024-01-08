IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Kiểm tra trước khi xóa/sửa phiếu đề nghị chi 
-- Nếu ID chưa được sử dụng thì cho phép xóa (Xóa ngầm) ngược lại thì báo messageID đã sử dụng không được phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thi Phượng, Date: 08/12/2017
-- Edit by: Cao Thi Phượng, Date: 14/03/2018 Chỉnh sửa trường hợp xóa sữa dữ liệu
-- <Example> EXEC POSP2021 'HCM', '', '', '', 'POST2020', 1, NULL

CREATE PROCEDURE POSP2021 ( 
	@DivisionID varchar(50), 
	@ShopID		varchar(50), 
	@APK		NVARCHAR(MAX),
	@APKList	NVARCHAR(MAX),
	@TableID	NVARCHAR(MAX),	--POST2020
	@Mode		tinyint,			--0: Sửa, 1: Xóa
	@UserID		Varchar(50)
	) 
AS 
BEGIN
	DECLARE @sSQL1 NVARCHAR(MAX)
	DECLARE @sSQL2 NVARCHAR(MAX)
	
	IF @Mode = 1 
	BEGIN
		SET @sSQL1 = '	DECLARE @Status TINYINT,
								@Message NVARCHAR(1000),
								@Cur CURSOR,
								@ID VARCHAR(50),
								@DelAPK   VARCHAR(50),
								@DelShopID VARCHAR(50),
								@DelDivisionID VARCHAR(50),
								@DelVoucherNo VARCHAR(50),
								@DelTranMonth int,
								@DelTranYear int,
								@Closing int,
								@IsConfirm int,
								@SuggestType int

						SET @Status = 0
						SET @Message = ''''
						SET @ID = ''''
						--Luu tru ID message
						Declare @POST2020temp table (
									Status tinyint,
									MessageID varchar(100),
									Params varchar(4000))
						Insert into @POST2020temp (	Status, MessageID, Params) 
									Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
									union all
									Select 2 as Status, ''POSM000025'' as MessageID, Null as Params
									union all
									Select 2 as Status, ''00ML000051'' as MessageID, Null as Params
									union all
									Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
									union all
									Select 2 as Status, ''POSFML000096'' as MessageID, Null as Params
									union all
									Select 2 as Status, ''POSFML000097'' as MessageID, Null as Params
									'									

		SET @sSQL2 = '	SET @Cur = CURSOR SCROLL KEYSET FOR
						SELECT P.APK, P.DivisionID, P.ShopID, P.VoucherNo, P.TranMonth, P.TranYear, Q.Closing, P.IsConfirm, P.SuggestType
						FROM POST2020 P  WITH (NOLOCK) inner join POST9999 Q  WITH (NOLOCK) on P.DivisionID = Q.DivisionID and P.TranMonth=Q.TranMonth and P.TranYear=Q.TranYear
									
						WHERE Cast(P.APK  as nvarchar(100)) IN ('''+@APKList+''')

						OPEN @Cur
						FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelShopID, @DelVoucherNo, @DelTranMonth, @DelTranYear, @Closing , @IsConfirm, @SuggestType
						WHILE @@FETCH_STATUS = 0
						BEGIN
								--Trước tiên chay Store kiem tra da su dung
									Exec POSP9000 @DelDivisionID, @DelShopID, @DelTranMonth, @DelTranYear, @ID, @DelAPK, '''+@TableID+''', @Status  output
								--Kiem tra khac DivisionID
									IF @DelDivisionID != '''+@DivisionID+'''
										Begin
											SET @Message = @DelVoucherNo
											update @POST2020temp set Params = ISNULL(Params,'''') + @Message+'','' where MessageID = ''00ML000050''
										End
								--Kiem tra khac ShopID
									ELSE IF @DelShopID != '''+@ShopID+'''
										Begin
											SET @Message = @DelVoucherNo
											update @POST2020temp set Params = ISNULL(Params,'''') + @Message+'','' where MessageID = ''POSM000025''
										End
								--Kiem tra bi khoa so
									ELSE IF @Closing = 1 
										Begin
											SET @Message = @DelVoucherNo
											update @POST2020temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''00ML000051''
										End
								--Kiem tra đã duyệt
									ELSE IF @Closing = 0 and (Select @Status) = 1 and @IsConfirm = 1 and @SuggestType = 0
										Begin
											SET @Message = @DelVoucherNo
											update @POST2020temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''POSFML000096''
										End
								--Kiem tra kế thừa từ phiếu bán hàng
									ELSE IF @Closing = 0 and (Select @Status) = 1 and @IsConfirm = 1 and @SuggestType != 0
										Begin
											SET @Message = @DelVoucherNo
											update @POST2020temp set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''POSFML000097''
										End
								--Cho phep xoa
									ELSE 
										Begin
											--Delete [phieu nhap kho] ben POS
											UPDATE POST2020 SET DeleteFlg = 1 WHERE  Cast(APK  as nvarchar(100))  = @DelAPK			
											UPDATE POST2021 SET DeleteFlg = 1 WHERE APKMaster = @DelAPK				
										End
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelShopID, @DelVoucherNo, @DelTranMonth, @DelTranYear, @Closing , @IsConfirm, @SuggestType
			END
			CLOSE @Cur
			SELECT Status, MessageID, Params From  @POST2020temp where Params is not null'
		EXEC (@sSQL1 + @sSQL2) 
		--PRINT @sSQL1 
		--PRINT @sSQL2
	END
	IF @Mode = 0
		BEGIN
					DECLARE @Status TINYINT,
							@Status1 TINYINT,
							@Message NVARCHAR(1000),
							@Params Varchar(100),
							@DelDivisionID Varchar(50), 
							@DelShopID Varchar(50), 
							@DelTranMonth int, 
							@DelTranYear int, 
							@ID Varchar(50), 
							@DelAPK  VARCHAR(50),
							@Closing tinyint,
							@IsConfirm tinyint,
							@ConfirmUserID Varchar(50),
							@SuggestType tinyint
					Declare @POST2020temp table 
							(
								Status tinyint,
								MessageID varchar(100),
								Params varchar(4000)
							)
					SELECT	@DelAPK = P.APK, @DelDivisionID = P.DivisionID, @DelShopID = P.ShopID, @ID=P.VoucherNo, @DelTranMonth= P.TranMonth, 
							@DelTranYear = P.TranYear, @Closing = Q.Closing , @IsConfirm = IsConfirm , @ConfirmUserID = ConfirmUserID, @SuggestType = SuggestType
					FROM POST2020 P WITH (NOLOCK) inner join POST9999 Q WITH (NOLOCK) on P.DivisionID = Q.DivisionID  and P.TranMonth=Q.TranMonth and P.TranYear=Q.TranYear
					Where Cast(P.APK  as nvarchar(100)) = @APK and P.DeleteFlg = 0

					Exec POSP9000 @DelDivisionID, @DelShopID, @DelTranMonth, @DelTranYear, @ID, @DelAPK, @TableID, @Status  output
					
					IF @DelDivisionID != @DivisionID
						Begin --{0} không thuộc đơn vị hiện tại. Bạn không thể Sửa / Xóa
							SET @Message = '00ML000050' 
							SET	@Status1 = 2
							SET @Params = @ID
						End 
					IF @DelShopID != @ShopID
						Begin --{0} không thuộc cửa hàng hiện tại. Bạn không thể Sửa / Xóa
							SET @Message = 'POSM000025' 
							SET	@Status1 = 2
							SET @Params = @ID
						End 
					IF @Closing = 1 
						Begin --{0} đã khóa sổ. Bạn mở khóa sổ trước khi Sửa / Xóa
							SET @Message = '00ML000051'  
							SET	@Status1 = 2
							SET @Params = @ID
						End
					IF @Closing = 0 and (Select @Status) = 1 and @IsConfirm = 1 and @SuggestType <> 0
						Begin --{0} này đã được sử dụng. Bạn không thể Sửa / Xóa
							SET @Message = 'POSFML000096' 
							SET	@Status1 = 2
							SET @Params = @ID
						End
					IF @Closing = 0 and (Select @Status) = 1 and @IsConfirm = 1 and @SuggestType = 0 and @ConfirmUserID <>@UserID
						Begin --{0} này đã được sử dụng. Bạn không thể Sửa / Xóa
							SET @Message = 'POSFML000096' 
							SET	@Status1 = 2
							SET @Params = @ID
						End
					Insert into @POST2020temp (	Status, MessageID, Params) 
					Select	@Status1 as Status, @Message as MessageID, @Params as Params
					SELECT Status, MessageID, Params From  @POST2020temp where Params is not null
		END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
