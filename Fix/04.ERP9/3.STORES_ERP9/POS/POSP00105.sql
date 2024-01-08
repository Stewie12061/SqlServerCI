IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00105]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP00105]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
-- Kiểm tra trước khi thêm 1 người dùng vào danh sách quản lý
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Thị Phượng, Date: 15/03/2017
-- Modify by Thị Phượng on 03/05/2017: trường hợp Disaled/ Enable Trả ra APK thay vì trả mã để lưu bảng Lịch sử
---- Modified by Thị Phượng, Date 23/06/2017 Bổ sung set lại giá trị @Status khi chạy con trỏ
-- <Example> EXEC POSP00105 'KY', 'HOANG', '2017-09-25', '2017-09-25'

CREATE PROCEDURE POSP00105 ( 
	@DivisionID varchar(50),
	@UserID		varchar(50),
	@FromDate	 DateTime,
	@ToDate		DateTime	
	) 
AS 
BEGIN
DECLARE @sSQL NVARCHAR(MAX)
SET @sSQL=N'
	DECLARE @Status TINYINT,
			@Message NVARCHAR(1000),
			@Cur CURSOR,
			@EmployeeID VARCHAR(50),
			@DelDivisionID VARCHAR(50),
			@ShopID VARCHAR(50),
			@APK NVARCHAR(250),
			@DFromDate DateTime,
			@DToDate DateTime
	Declare @POST00101temp table (
			Status tinyint,
			MessageID varchar(100),
			Params varchar(4000))
	SET @Status = 0
	SET @Message = ''''
	Insert into @POST00101temp (	Status, MessageID, Params) 
								Select 2 as Status, ''POSFML000087'' as MessageID, Null as Params

	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT EmployeeID, APK, ShopID, DivisionID, FromDate, ToDate FROM POST00101 WITH (NOLOCK) 
	WHERE DivisionID ='''+@DivisionID+''' and EmployeeID = '''+@UserID+''' and Isnull(DeleteFlg, 0) =0
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @EmployeeID, @APK, @ShopID, @DelDivisionID,@DFromDate, @DToDate
	WHILE @@FETCH_STATUS = 0
	BEGIN
	If exists (Select Top 1 1  From POST00101 WITH (NOLOCK)
				where APK =@APK and ('''+CONVERT(varchar,@FromDate,112)+''' Between CONVERT(varchar,FromDate,112)  and  CONVERT(varchar,ToDate,112) 
				
				or '''+CONVERT(varchar,@ToDate,112) +''' Between CONVERT(varchar,FromDate,112)  and  CONVERT(varchar,ToDate,112)))
		Set @Status =1 
	
	 IF (Select @Status) = 1
			update @POST00101temp set Params = ISNULL(Params,'''') + @EmployeeID+'',''  where MessageID = ''POSFML000087''
	
	FETCH NEXT FROM @Cur INTO @EmployeeID, @APK, @ShopID, @DelDivisionID,@DFromDate, @DToDate
	END
	CLOSE @Cur
	--print @EmployeeID 
	SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params From  @POST00101temp where Params is not null
	'
EXEC(@sSQL)
--Print(@sSQL)

			
END
