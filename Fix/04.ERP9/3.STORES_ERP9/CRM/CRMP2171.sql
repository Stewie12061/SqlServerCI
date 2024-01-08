IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2171]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2171]
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
----<Created by>:Dũng DV on 29/09/2019:
------------------Kết quả trả về: Status = 0 (Loại Message Info), Status = 1 (Loại Message Warning), Status = 2 (Loại Message Error)
----------------------MessageID: 00ML000050 (Kiểm tra khác DivisionID), 00ML000051 (Kiểm tra đã khóa sổ), 00ML000052 (Kiểm tra đã sử dụng)
----------------------Params (Danh sách VoucherNo không xóa được)
------------------Store xử lý: Xóa danh sách một /nhiều @ID, và chỉ Sửa 1 @ID
----------------------Nếu Xóa thành công
----Modify by: Kiều Nga, Date 16/04/2020: Fix lỗi message cảnh báo kiểm tra hoàn tất không cho xóa/ sửa nhưng cảnh báo chưa khóa/ mở sổ. 
---- <Example>
---- EXEC CRMP2171 'NN', 'B34AEDB6-5BCD-49D9-82A0-16C8A7C021C4','1','ADMIN'

CREATE PROCEDURE CRMP2171 ( 
			@DivisionID varchar(50),--Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
			@APKList NVARCHAR(MAX),
			@Mode		tinyint,			--0: Sửa, 1: Xóa
			@UserID		Varchar(50)
			) 
AS 
DECLARE @sSQL NVARCHAR(MAX)
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
								Select 2 as Status, ''00ML000051'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''00ML000052'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''POSFML000098'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''POSFML000099'' as MessageID, Null as Params
								union all
								Select 2 as Status, ''POSFML000119'' as MessageID, Null as Params
	SELECT @DelVoucherNo = VoucherNo FROM CRMT2170 (NOLOCK)	WHERE APK IN ('''+@APKList+''')
	IF EXISTS (SELECT 1 FROM CRMT2170(NOLOCK) WHERE APK IN ('''+@APKList+''') and StatusID IN (6,7))
	BEGIN
	update @POST00801temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'',''  where MessageID = ''POSFML000119''
	END
	ELSE
	BEGIN
		UPDATE CRMT2170 SET DeleteFlg = 1 WHERE APK IN ('''+@APKList+''')
	END
	SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @POST00801temp where Params is not null'
EXEC (@sSQL)
PRINT @sSQL
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
