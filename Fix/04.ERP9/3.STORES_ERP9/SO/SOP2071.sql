IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2071]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2071]
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
----<Created by>:Dũng DV on 16/11/2019:
------------------Kết quả trả về: Status = 0 (Loại Message Info), Status = 1 (Loại Message Warning), Status = 2 (Loại Message Error)
----------------------MessageID: 00ML000050 (Kiểm tra khác DivisionID), 00ML000051 (Kiểm tra đã khóa sổ), 00ML000052 (Kiểm tra đã sử dụng)
----------------------Params (Danh sách VoucherNo không xóa được)
------------------Store xử lý: Xóa danh sách một /nhiều @ID, và chỉ Sửa 1 @ID
----------------------Nếu Xóa thành công
---- <Example>
---- EXEC SOP2071 'NN', 'B34AEDB6-5BCD-49D9-82A0-16C8A7C021C4','1','ADMIN'

CREATE PROCEDURE SOP2071 ( 
			@DivisionID VARCHAR(50),
			@APK VARCHAR(50), --Trường hợp sửa
			@APKList NVARCHAR(MAX), --Trường hợp xóa hoặc xử lý enable/disable
			@TableID VARCHAR(50),
			@Mode TINYINT, --0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable), 3: Sửa: kiểm tra đã sử dụng để check dùng chung 
			@IsDisable TINYINT, --1: Disable; 0: Enable
			@UserID NVARCHAR(50) 
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

	Declare @SOT2070temp table 
							(
							Status tinyint,
							MessageID varchar(100),
							Params varchar(4000)
							)
	SET @Status = 0
	SET @Message = ''''
	Insert into @SOT2070temp (	Status, MessageID, Params) 
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
	SELECT @DelVoucherNo = VoucherNo FROM SOT2070(NOLOCK)	WHERE APK IN ('''+@APKList+''')
	IF NOT EXISTS (SELECT 1 FROM SOT2070(NOLOCK) WHERE APK IN ('''+@APKList+'''))
	BEGIN	
	update @SOT2070temp set Params = ISNULL(Params,'''') + @DelVoucherNo+'',''  where MessageID = ''00ML000051''
	END
	ELSE
	BEGIN	
	UPDATE dbo.SOT2070 SET DeleteFlg = 1 WHERE APK IN ('''+@APKList+''');
		--IF EXISTS (SELECT 1 FROM dbo.SOT2071 WHERE APKMaster IN ('''+@APKList+'''))
		--BEGIN
		--DELETE dbo.SOT2071 WHERE APKMaster IN ('''+@APKList+''');
		--		IF @@ROWCOUNT > 0
		--		DELETE dbo.SOT2070 WHERE APK IN ('''+@APKList+'''); 
		--END
		--ELSE
		--BEGIN
		--DELETE dbo.SOT2070 WHERE APK IN ('''+@APKList+'''); 
		--END
	END
	SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @SOT2070temp where Params is not null'
EXEC (@sSQL)
PRINT @sSQL
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


