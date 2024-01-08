IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP0005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP0005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Form CMNP0005: Kiểm tra dữ liệu đã được sử dụng hoặc khóa sổ thì không được duyệt hoặc bỏ duyệt
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao thị Phượng, Date: 15/09/2017
----Modify by: Tấn Đạt, Date: 20/03/2018: Bổ sung thêm các kiểm tra sử dụng
-- <Example> Exec CMNP0005 'AS','DAT', 'SO', '53768ed9-81df-40a8-b663-a1b0cdd4b0d0', 1
---- 
/*
 
*/
CREATE PROCEDURE dbo.CMNP0005
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@VoucherTypeID VARCHAR(50),
	@VoucherID VARCHAR(50), --- APK của bảng đang duyệt
	@IsConfirm VARCHAR(50) 
)
AS 
DECLARE 
		@TableID NVARCHAR(MAX)='',
		@ModuleID NVARCHAR(MAX)='',
		@sSQL NVARCHAR(MAX)='',
		@VoucherNO NVARCHAR(MAX)='',
		@FormID Nvarchar(max)=''

set @TableID = (Select TableID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
set @ModuleID = (Select ModuleID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
set @FormID = (Select ScreenID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
SET @sSQL =N'
DECLARE 
		@MessageID VARCHAR(50),
		@StatusID TINYINT,
		@Params VARCHAR(50),
		@APKMaster VARCHAR(50),
		@TranMonth INT = NULL,
		@TranYear INT  = NULL 
Declare
		@CMNP0005temp table (
						Status tinyint,
						Message varchar(100),
						Params varchar(4000))
		Insert into @CMNP0005temp ( Status, Message, Params) 
											Select 3 as Status, ''SOFML000018'' as Message, Null as Params
											union all
											Select 3 as Status, ''SOFML000019'' as Message, Null as Params
											union all
											Select 2 as Status, ''SOFML000020'' as Message, Null as Params
											union all
											Select 2 as Status, ''OFML000215'' as Message, Null as Params
											union all
											Select 2 as Status, ''00ML000050'' as Message, Null as Params
											union all
											Select 2 as Status, ''00ML000052'' as Message, Null as Params
											
SET @TranMonth = (SELECT Month(CreateDate) From '+@TableID+' where VoucherID ='''+@VoucherID+''')
SET @TranYear = (SELECT  Year(CreateDate) as TranYear From '+@TableID+' where VoucherID ='''+@VoucherID+''')

BEGIN
	If '''+@ModuleID+'''=''ASOFTSO'' 
	BEGIN
	---Kiểm tra khoá sổ kế toán
	IF EXISTS (SELECT TOP 1 1 FROM OT9999 WHERE TranMonth = @TranMonth and TranYear =@TranYear and Closing =1)
		BEGIN
		       SET @MessageID=''00ML000124''
		       SET @StatusID= 1
		       SET @Params ='''+@VoucherID+'''
		END
	ELSE
		SET @APKMaster =NULL 
	
	---Kiểm tra đã sử dụng
	Exec SOP90000 '''+@DivisionID+''', @TranMonth, @TranYear, '''+@VoucherID+''', '''+@TableID+''', 1, @Status Output, @Message Output
		Update @CMNP0005temp set Params = ISNULL(Params,'''') where Message = ''SOFML000018''
		Update @CMNP0005temp set Params = ISNULL(Params,'''') where Message = ''SOFML000019''
		Update @CMNP0005temp set Params = ISNULL(Params,'''') where Message = ''SOFML000020''
		Update @CMNP0005temp set Params = ISNULL(Params,'''') where Message = ''OFML000215''

		Set @MessageID = @Message
		Set @StatusID = @Status
		Begin
		IF (Select @Status) = 1
			Set @Params = '''+@VoucherID+'''
		Else
			Set @Params = Null
		End
	END
	Else If '''+@ModuleID+'''=''ASOFTWM'' 
	
	
	BEGIN
	-----Kiểm tra khoá sổ
	IF EXISTS (SELECT TOP 1 1 FROM WT9999 WHERE TranMonth = @TranMonth and TranYear =@TranYear and Closing =1)
		BEGIN
		       SET @MessageID=''00ML000124''
		       SET @StatusID=1
		       SET @Params ='''+@VoucherID+'''
		END
	ELSE
		SET @APKMaster =NULL 
	----Kiểm tra sử dụng
	Exec WMP9000 @DivisionID = ''CH'', @APK = ''1B0C92E4-CFB5-47FA-867B-41291B513910'', @APKList = ''1B0C92E4-CFB5-47FA-867B-41291B513910'', @FormID = ''WMF1012'', 
	@Mode = 0 , @IsDisable = '''', @UserID = ''ASOFTADMIN''
	Begin
		IF (@Status = 1)
			Begin
			Set @MessageID = MessageID
			Set @StatusID = Status
			Set @Params = '''+@VoucherID+'''
			End
		Else
			Set @Params = Null
		End 

	END
	Else If '''+@ModuleID+'''=''ASOFTT'' 
	BEGIN
	---Kiểm tra khoá sổ
	IF EXISTS (SELECT TOP 1 1 FROM AT9999 WHERE TranMonth = @TranMonth and TranYear =@TranYear and Closing =1)
		BEGIN
		       SET @MessageID=''00ML000124''
		       SET @StatusID=1
		       SET @Params ='''+@VoucherID+'''
		END
		 ELSE
		SET @APKMaster =NULL 

	---Kiểm tra sử dụng
	Exec AP9000 '''+@DivisionID+''', @TranMonth, @TranYear, '''+@VoucherID+''', '''+@TableID+''', '', '''+@FormID+'''
		Begin
		IF (@Status = 1)
			Begin
			Set @MessageID = VieMessage
			Set @StatusID = Status
			Set @Params = '''+@VoucherID+'''
			End
		Else
			Set @Params = Null
		End 
	End


END
SET @DivisionID
SELECT @MessageID MessageID,@StatusID [Status],@Params Params, @APKMaster APKMaster
END
'
Exec (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
