IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'DBO.CMNP0004') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE DBO.CMNP0004
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Update 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Cao Thị Phượng, Date: 29/03/2017
----Modify by: Tấn Đạt, Date: 16/03/2018: Bỏ bảng CIT1204
-- <Example>
---- 
/*
  Exec CMNP0004 'CAN', 'USER01', 1, N'SO', 1, 'ff56d845-c720-449f-ac58-6eb6752cfeac','ASOFTSO'
*/
CREATE PROCEDURE CMNP0004
( 
	@DivisionID		VARCHAR(50),
	@UserID			VARCHAR(50),
	@RollLevel		VARCHAR(50), ---Cấp duyệt đăng nhập vào hiện tại
	@VoucherTypeID	VARCHAR(50),
	@Status			VARCHAR(50), --Trạng thái duyệt của người duyệt
	@APKMaster		VARCHAR(MAX),
	@ModuleID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = '',
		@Level NVARCHAR (50) = '',
        @sWhere NVARCHAR(MAX) = '',
		@ScreenID NVARCHAR(MAX),
        @TableID NVARCHAR(50)='',
		@ColumnID NVARCHAR(MAX)=''


set @TableID = (Select TableID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
set @ColumnID = (Select ConfirmColumnID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
set @Level = (Select [Level] From CIT1201 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
set @ScreenID = (Select ScreenID From CIT1200 Where DivisionID = @DivisionID and VoucherTypeID = @VoucherTypeID)
SET @sSQL ='
	
		IF '''+@RollLevel+''' = '''+@Level+'''
		Begin 
			Update CIT1203 SET Status = '+@Status+'	Where APKMaster = '''+@APKMaster+'''
			Update '+@TableID+' set '+@ColumnID+' = '+@Status+' Where APK = '''+@APKMaster+'''
		END
		--END 
'

EXEC (@sSQL)
--PRINT (@sSQL)
--PRINT (@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
