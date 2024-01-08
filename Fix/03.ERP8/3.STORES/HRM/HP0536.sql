IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0536]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0536]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra trước khi xóa, sửa danh mục định mức lương sản phẩm (VIETFIRST)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 27/02/2018
/*-- <Example>
	HP0536 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @APK = ''

	HP0536 @DivisionID, @UserID, @APK
----*/

CREATE PROCEDURE HP0536
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APK VARCHAR(50)
)
AS 
DECLARE @Status AS TINYINT = 0,
		@Message  AS NVARCHAR(250)

---- Kiểm tra dữ liệu đã được sử dụng (chấm công nhân viên theo ngày)
IF EXISTS (SELECT TOP 1 1 FROM HT1126 WITH (NOLOCK) 
		   INNER JOIN HT1123 WITH (NOLOCK) ON HT1126.DivisionID = HT1123.DivisionID AND HT1126.NormID = HT1123.NormID WHERE HT1123.APK = @APK)
BEGIN
	SET @Status = 1
	SET @Message = N'HFML000210'
	GOTO EndMess
END 

EndMess:

SELECT @Status AS Status, @Message AS Message
WHERE ISNULL(@Message, '') <> ''



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
