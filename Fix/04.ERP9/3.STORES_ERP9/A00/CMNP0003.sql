IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'DBO.CMNP0003') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE DBO.CMNP0003
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- @Summary>
---- Load Form CMNP0003: Duyệt hàng loạt
-- @Param>
---- 
-- @Return>
---- 
-- @Reference>
---- 
-- @History>
----Created by: Cao Thị Phượng, Date: 29/03/2017
----Modify by: Tấn Đạt, Date: 16/03/2018: bỏ bảng CIT1204
-- @Example>
---- 
/*
  Exec CMNP0003 'CAN', 'USER01', 1 , N'SO', 1, N'DUYỆT', '1AC179CE-A659-4604-BADD-EF6B745D8E54'',''F1BAEEF0-E43C-4048-BC05-C3C2E7AA4D1B', 'ASOFTSO'
*/
CREATE PROCEDURE CMNP0003
( 
	@DivisionID		VARCHAR(50),
	@UserID			VARCHAR(50),
	@RollLevel		VARCHAR(50), 
	@VoucherTypeID	VARCHAR(50),
	@IsConfirm		NVARCHAR(MAX),
	@Description	NVARCHAR(Max),
	@APKList		VARCHAR(MAX),
	@ModuleID		VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
		@Level NVARCHAR (MAX) = '',
        @sWhere NVARCHAR(MAX) = '',
		@ScreenID NVARCHAR(MAX),
        @TableID NVARCHAR(MAX)='',
		@ColumnID NVARCHAR(MAX)=''

set @TableID = (Select TableID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
set @ColumnID = (Select ConfirmColumnID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
set @Level = (Select [Level] From CIT1201 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
set @ScreenID = (Select ScreenID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)

SET @sSQL ='
SELECT CONVERT(VARCHAR(50),'''') MessageID,CONVERT(TINYINT,0) [Status],CONVERT(VARCHAR(50),'''') Params,CONVERT(VARCHAR(50),'''') APKMaster
INTO #Message
--xóa dòng rỗng
DELETE #Message
DECLARE @Cur CURSOR,
		@APK VARCHAR(50)
		SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT APK FROM '+@TableID+' WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
		OPEN @Cur
		FETCH NEXT FROM @Cur INTO @APK
		WHILE @@FETCH_STATUS = 0
		BEGIN
		INSERT INTO #Message(MessageID,Status,Params,APKMaster) EXEC CMNP0005 '''+@DivisionID+''','''+@UserID+''','''+@VoucherTypeID+''', @APK, '+@IsConfirm+'
		IF EXISTS (SELECT TOP 1 1 FROM #Message WHERE APKMaster=@APK)
		BEGIN
			FETCH NEXT FROM @Cur INTO @APK
			CONTINUE
		END
					IF NOT EXISTS (SELECT TOP 1 1 FROM CIT1203 WHERE APKMaster = @APK)
						Insert Into CIT1203
						    ([APK], [DivisionID],[APKMaster],[ApproveLevel]
							,[Status],[VoucherTypeID] ,[Notes],[DeleteFlg]
							,[ConfirmUserID01], [ConfirmDate01], [Status01])
						VALUES
							(NewID(), '''+@DivisionID+''', @APK, '+@RollLevel+'
							, 0, '''+@VoucherTypeID+''', '''+@Description+''', 0
							,'''+@UserID+''', GETDATE(), '+@IsConfirm+')
					ELSE
						UPDATE CIT1203 
						SET ApproveLevel = '+@RollLevel+',
						Notes = '''+@Description+''',
						'+Case When @RollLevel =1 then 'ConfirmUserID01'
						       When @RollLevel =2 Then 'ConfirmUserID02'
							   When @RollLevel =3 Then 'ConfirmUserID03'
							   When @RollLevel =4 Then 'ConfirmUserID04'
							   When @RollLevel =5 Then 'ConfirmUserID05' end +' =  '''+@UserID+''',
						'+Case When @RollLevel =1 then 'ConfirmDate01'
						       When @RollLevel =2 Then 'ConfirmDate02'
							   When @RollLevel =3 Then 'ConfirmDate03'
							   When @RollLevel =4 Then 'ConfirmDate04'
							   When @RollLevel =5 Then 'ConfirmDate05' end +' = GETDATE(),
						'+Case When @RollLevel =1 then 'Status01'
						       When @RollLevel =2 Then 'Status02'
							   When @RollLevel =3 Then 'Status03'
							   When @RollLevel =4 Then 'Status04'
							   When @RollLevel =5 Then 'Status05' end +' =  '+@IsConfirm+'
						WHERE APKMaster = @APK 
		
		IF '''+@RollLevel+''' = '''+@Level+'''
		Begin 
			Update CIT1203 SET Status = '+@IsConfirm+'	Where APKMaster = @APK
			Update '+@TableID+' set '+@ColumnID+' = '+@IsConfirm+' Where APK = @APK
		End

	FETCH NEXT FROM @Cur INTO @APK
	END
	CLOSE @Cur
	SELECT TOP 1 [MessageID],[Status],
	(SUBSTRING((SELECT '',''+Params FROM #Message   FOR XML PATH ('''')), 2, 1000)) Params,
	(SUBSTRING((SELECT '',''+APKMaster FROM #Message   FOR XML PATH ('''')),2, 1000)) APKMasterList
FROM #Message 
'

EXEC (@sSQL)
PRINT (@sSQL)
--PRINT (@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
