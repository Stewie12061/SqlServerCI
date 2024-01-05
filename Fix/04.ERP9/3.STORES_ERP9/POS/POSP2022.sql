IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Kiểm tra trước khi Duyệt phiếu, nếu là phiếu của người đc duyệt thì sẽ cho phép duyệt người lại thì cảnh báo và không duyệt
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Thi Phượng, Date: 08/12/2017
-- <Example> EXEC POSP2022 'HCM', '50S1101', '751AB7B6-BEC5-43A6-87D6-8092EA3B158B', 1, N'Phượng test kiểm tra dữ liệu', 1 , 'HOANG'

CREATE PROCEDURE POSP2022 ( 
	@DivisionID varchar(50), 
	@ShopID		varchar(50), 
	@APKList	NVARCHAR(MAX),
	@IsConfirm Varchar(50),
	@Notes NVarchar(Max),
	@IscheckALL Tinyint,
	@UserID		Varchar(50)
	) 
AS 
BEGIN
	DECLARE @sSQL1 NVARCHAR(MAX)
	DECLARE @sSQL2 NVARCHAR(MAX)
	DECLARE @sSQL3 NVARCHAR(MAX)
	IF @IscheckALL = 1 
	Set @sSQL3 = N'SELECT P.APK, P.DivisionID, P.ShopID, P.VoucherNo, P.TranMonth, P.TranYear, Q.Closing, P.ConfirmUserID, P.SuggestType
						FROM POST2020 P  WITH (NOLOCK) inner join POST9999 Q  WITH (NOLOCK) on P.DivisionID = Q.DivisionID and P.TranMonth=Q.TranMonth and P.TranYear=Q.TranYear		
						WHERE P.DivisionID = '''+@DivisionID+''' and P.ShopID = '''+@ShopID+''' and P.SuggestType = 0 and P.IsConfirm = 0	'
	ELSE 
	SET  @sSQL3 = N'SELECT P.APK, P.DivisionID, P.ShopID, P.VoucherNo, P.TranMonth, P.TranYear, Q.Closing, P.ConfirmUserID, P.SuggestType
						FROM POST2020 P  WITH (NOLOCK) inner join POST9999 Q  WITH (NOLOCK) on P.DivisionID = Q.DivisionID and P.TranMonth=Q.TranMonth and P.TranYear=Q.TranYear		
						WHERE Cast(P.APK  as nvarchar(100)) IN ('''+@APKList+''')'

	SET @sSQL1 = '	DECLARE @Status TINYINT,
								@Message NVARCHAR(1000),
								@Cur CURSOR,
								@ID VARCHAR(50),
								@ConfirmAPK   VARCHAR(50),
								@ConfirmShopID VARCHAR(50),
								@ConfirmDivisionID VARCHAR(50),
								@ConfirmVoucherNo VARCHAR(50),
								@ConfirmTranMonth int,
								@ConfirmTranYear int,
								@Closing int,
								@ConfirmUserID  VARCHAR(50),
								@SuggestType int

						SET @Status = 0
						SET @Message = ''''
						SET @ID = ''''
						--Luu tru ID message
						Declare @POST2020TEM table (
									Status tinyint,
									MessageID varchar(100),
									Params varchar(4000))
						Insert into @POST2020TEM (	Status, MessageID, Params) 
									Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
									union all
									Select 2 as Status, ''POSM000025'' as MessageID, Null as Params
									union all
									Select 2 as Status, ''POSFML000106'' as MessageID, Null as Param
									union all
									Select 2 as Status, ''00ML000051'' as MessageID, Null as Param
									'									

		SET @sSQL2 = '	SET @Cur = CURSOR SCROLL KEYSET FOR
						
						'+@sSQL3+'

						OPEN @Cur
						FETCH NEXT FROM @Cur INTO @ConfirmAPK, @ConfirmDivisionID, @ConfirmShopID, @ConfirmVoucherNo, @ConfirmTranMonth, @ConfirmTranYear, @Closing , @ConfirmUserID, @SuggestType
						WHILE @@FETCH_STATUS = 0
						BEGIN
								--Kiem tra khac DivisionID
									IF @ConfirmDivisionID != '''+@DivisionID+'''
										Begin
											SET @Message = @ConfirmVoucherNo
											update @POST2020TEM set Params = ISNULL(Params,'''') + @Message+'','' where MessageID = ''00ML000050''
										End
								--Kiem tra khac ShopID
									ELSE IF @ConfirmShopID != '''+@ShopID+'''
										Begin
											SET @Message = @ConfirmVoucherNo
											update @POST2020TEM set Params = ISNULL(Params,'''') + @Message+'','' where MessageID = ''POSM000025''
										End
								--Kiem tra bi khoa so
									ELSE IF @Closing = 1 
										Begin
											SET @Message = @ConfirmVoucherNo
											update @POST2020TEM set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''00ML000051''
										End
								--Kiem tra khac người duyệt
									ELSE IF @ConfirmUserID != '''+@UserID+''' and @SuggestType = 0
										Begin
											SET @Message = @ConfirmVoucherNo
											update @POST2020TEM set Params = ISNULL(Params,'''') + @Message+'', '' where MessageID = ''POSFML000106''
										End
								
								--Cho phep xoa
									ELSE 
										Begin
											--Delete [phieu nhap kho] ben POS
											UPDATE POST2020 SET ConfirmUserID = '''+@UserID+''' ,
											ConfirmDate = GETDATE(),
											IsConfirm =Cast ('+@IsConfirm+' as INT) ,
											Description = N'''+@Notes+'''
											WHERE  Cast(APK  as nvarchar(100))  = @ConfirmAPK	and SuggestType = 0		
													
										End
				FETCH NEXT FROM @Cur INTO @ConfirmAPK, @ConfirmDivisionID, @ConfirmShopID, @ConfirmVoucherNo, @ConfirmTranMonth, @ConfirmTranYear, @Closing , @ConfirmUserID, @SuggestType
			END
			CLOSE @Cur
			SELECT Status, MessageID, Params From  @POST2020TEM where Params is not null'
		EXEC (@sSQL1 + @sSQL2) 
		--PRINT @sSQL1 
	
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
