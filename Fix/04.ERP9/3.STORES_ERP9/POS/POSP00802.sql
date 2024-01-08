IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00802]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00802]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----<Summary>
---- Kiểm tra xóa/sửa phiếu thu
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>:Thị Phượng on 04/08/2017:
------------------Kết quả trả về: Status = 0 (Loại Message Info), Status = 1 (Loại Message Warning), Status = 2 (Loại Message Error)
----------------------MessageID: 00ML000050 (Kiểm tra khác DivisionID), 00ML000051 (Kiểm tra đã khóa sổ), 00ML000052 (Kiểm tra đã sử dụng)
----------------------Params (Danh sách VoucherNo không xóa được)
------------------Store xử lý: Xóa danh sách một /nhiều @ID, và chỉ Sửa 1 @ID
----------------------Nếu Xóa thành công
--Modified by Thị Phượng on 08/12/2017: Bổ sung kiểm tra phiếu thu sinh ra từ phiếu cọc thì ko cho xóa
--Modified by Hoàng Vũ on 16/03/2018: Kiểm tra, nếu phiếu thu sinh ngầm từ phiếu bán hàng/ đổi hàng/ đặt coc thì không cho xóa/sửa
--Modified by Hoàng Vũ on 07/12/2018: Kiểm tra, nếu phiếu thu sinh ngầm từ phiếu bán hàng/ đổi hàng/ đặt coc thì không cho xóa/sửa
---- <Example>
---- EXEC POSP00802 'MS', '8468FA48-0025-4FCB-BFA9-D11DA8A4AEAB', 'MA',1, 'POSF0080'

CREATE PROCEDURE POSP00802 ( 
			@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
			@APKList NVARCHAR(MAX),
			@ShopID varchar(50),
			@Mode tinyint,--1: Xóa, 0 :Sửa
			@FormID nvarchar(50) -- "POSF0080"	
			) 
AS 
DECLARE @sSQL NVARCHAR(MAX)
IF @Mode = 1
BEGIN
SET @sSQL = '
	DECLARE @Status TINYINT,
			@Message NVARCHAR(1000),
			@Cur CURSOR,
			@DelShopID VARCHAR(50),
			@DelDivisionID VARCHAR(50),
			@DelAPK VARCHAR(50),
			@DelVoucherNo VARCHAR(50),
			@TranMonth int = null,
			@TranYear int = null,
			@IsDeposit int = null,
			@IsPayInvoice int = null,
			@APK uniqueidentifier=NULL

	Declare @POST00801temp table 
							(
							Status tinyint,
							MessageID varchar(100),
							Params varchar(4000)
							)
	SET @Status = 0
	SET @Message = ''''
	Insert into @POST00801temp (	Status, MessageID, Params) 
								Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''POSM000025'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''POSFML000098'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''POSFML000099'' as MessageID, Null as Params
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT DivisionID, APK, ShopID, VoucherNo, Isnull(IsDeposit, 0) as IsDeposit, isnull(IsPayInvoice,0) as IsPayInvoice FROM POST00801 With (NOLOCK)
	WHERE APK IN ('''+@APKList+''')

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAPK, @DelShopID, @DelVoucherNo, @IsDeposit, @IsPayInvoice
	WHILE @@FETCH_STATUS = 0
	BEGIN
		Exec POSP9000   @DelDivisionID, @DelShopID, @TranMonth, @TranYear,  @DelAPK, @APK , '''+@FormID+''', @Status OUTPUT 		
		IF @DelDivisionID != '''+@DivisionID+''' 
									Begin
										update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'','' where MessageID = ''00ML000050''
									End
		ELSE IF @DelShopID != '''+@ShopID+'''
									Begin
										update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'','' where MessageID = ''POSM000025''
									End
		--Sinh ngầm từ phiếu cọc
		ELSE IF (@IsDeposit = 1  and @IsPayInvoice = 1 )
				update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'',''  where MessageID = ''POSFML000098''
		---Sinh ngầm từ phiếu bán hàng hoặc đổi hàng
		ELSE IF (@IsDeposit = 0 and  @IsPayInvoice =2 )
				update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'',''  where MessageID = ''POSFML000099''
		---Đã kế thừa từ phiếu đề nghị chi
		ELSE IF ((Select @Status) = 1)
				update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'',''  where MessageID = ''00ML000052''
		ELSE IF (Select @Status) = 0 and @DelShopID = '''+@ShopID+'''
		Begin 
				Update POST00801 set DeleteFlg = 1 WHERE  APK = @DelAPK				
				Update POST00802 set DeleteFlg = 1 WHERE  APKMaster = @DelAPK
		END
		FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAPK, @DelShopID, @DelVoucherNo, @IsDeposit, @IsPayInvoice
	END
	CLOSE @Cur
	SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @POST00801temp where Params is not null'
EXEC (@sSQL)
END
IF @Mode = 0
BEGIN
SET @sSQL = '
	DECLARE @Status TINYINT,
			@Message NVARCHAR(1000),
			@Cur CURSOR,
			@DelShopID VARCHAR(50),
			@DelDivisionID VARCHAR(50),
			@DelAPK VARCHAR(50),
			@DelVoucherNo VARCHAR(50),
			@TranMonth int = null,
			@TranYear int = null,
			@IsDeposit int = null,
			@IsPayInvoice int = null,
			@APK uniqueidentifier=NULL

	Declare @POST00801temp table 
							(
							Status tinyint,
							MessageID varchar(100),
							Params varchar(4000)
							)
	SET @Status = 0
	SET @Message = ''''
	Insert into @POST00801temp (	Status, MessageID, Params) 
								Select 2 as Status, ''00ML000050'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''POSM000025'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''POSFML000098'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''POSFML000099'' as MessageID, Null as Params
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT DivisionID, APK, ShopID, VoucherNo, Isnull(IsDeposit, 0) as IsDeposit, isnull(IsPayInvoice,0) as IsPayInvoice FROM POST00801 With (NOLOCK)
	WHERE APK IN ('''+@APKList+''')

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAPK, @DelShopID, @DelVoucherNo, @IsDeposit, @IsPayInvoice
	WHILE @@FETCH_STATUS = 0
	BEGIN
		Exec POSP9000   @DelDivisionID, @DelShopID, @TranMonth, @TranYear,  @DelAPK, @APK , '''+@FormID+''', @Status OUTPUT 		
		IF @DelDivisionID != '''+@DivisionID+''' 
									Begin
										update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'','' where MessageID = ''00ML000050''
									End
		ELSE IF @DelShopID != '''+@ShopID+'''
									Begin
										update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'','' where MessageID = ''POSM000025''
									End
		--Sinh ngầm từ phiếu cọc
		ELSE IF (@IsDeposit = 1  and @IsPayInvoice = 1 )
									Begin
										update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'',''  where MessageID = ''POSFML000098''
									END
		---Sinh ngầm từ phiếu bán hàng hoặc đổi hàng
		ELSE IF (@IsDeposit = 0 and  @IsPayInvoice =2 )
									Begin
										update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'',''  where MessageID = ''POSFML000099''
									End
		ELSE IF (Select @Status) = 1
				update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'',''  where MessageID = ''00ML000052''
			 
		FETCH NEXT FROM @Cur INTO @DelDivisionID, @DelAPK, @DelShopID, @DelVoucherNo, @IsDeposit, @IsPayInvoice
	END
	CLOSE @Cur
	SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @POST00801temp where Params is not null'
EXEC (@sSQL)
END
