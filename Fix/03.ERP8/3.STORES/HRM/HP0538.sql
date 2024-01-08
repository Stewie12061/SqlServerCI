IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0538]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0538]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra xóa, sửa bảng giá (VIETFIRST)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 28/02/2018
/*-- <Example>
	HP0538 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @APK = '83f4e6b3-e5a8-4665-8dd1-441cbcebb382', @FormID = 'HF0527'

	HP0538 @DivisionID, @UserID, @APK, @FormID
----*/

CREATE PROCEDURE HP0538
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APK VARCHAR(50), 
	@FormID VARCHAR(50)
)
AS 

DECLARE @Status AS TINYINT = 0,
		@Message  AS NVARCHAR(250)

IF @FormID = 'HF0527'
BEGIN
	---- Kiểm tra dữ liệu đã được sử dụng (chấm công nhân viên theo ngày) - Detail  
	IF EXISTS (SELECT TOP 1 1 FROM HT1126 WITH (NOLOCK) 
			   INNER JOIN HT1902 WITH (NOLOCK) ON HT1126.DivisionID = HT1902.DivisionID AND HT1126.PriceSheetID = HT1902.PriceSheetID
			   INNER JOIN HT1125 WITH (NOLOCK) ON HT1902.APK = HT1125.APKMaster WHERE HT1125.APKMaster = @APK)
	BEGIN
		SET @Status = 1
		SET @Message = N'HFML000583'
		GOTO EndMess
	END 
END 
ELSE IF @FormID = 'HF0112'
BEGIN
	---- Kiểm tra dữ liệu đã được sử dụng (chấm công nhân viên theo ngày) - Master 
	IF EXISTS (SELECT TOP 1 1 FROM HT1126 WITH (NOLOCK) 
			   INNER JOIN HT1902 WITH (NOLOCK) ON HT1126.DivisionID = HT1902.DivisionID AND HT1126.PriceSheetID = HT1902.PriceSheetID WHERE HT1902.APK = @APK)
	BEGIN
		SET @Status = 1
		SET @Message = N'HFML000210'
		GOTO EndMess
	END 
END 



EndMess:

SELECT @Status AS Status, @Message AS Message
WHERE ISNULL(@Message, '') <> ''



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
