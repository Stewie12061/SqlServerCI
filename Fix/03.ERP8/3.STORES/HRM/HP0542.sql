IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0542]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0542]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra sửa, xóa chấm công nhân viên theo sản phẩm (VIETFIRST)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 27/02/2018
/*-- <Example>
	HP0542 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @ProductID = '', @TranMonth = '', @TranYear

	HP0542 @DivisionID, @UserID, @ProductID, @TranMonth, @TranYear
----*/

CREATE PROCEDURE HP0542
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@ProductID VARCHAR(50), 
	@TranMonth INT, 
	@TranYear INT
)
AS 
DECLARE @Status AS TINYINT = 0,
		@Message  AS NVARCHAR(250)
---- Kiểm tra dữ liệu đã được tính lương trong kỳ 
IF EXISTS (SELECT TOP 1 1 FROM HT1126 WITH (NOLOCK) 
		   WHERE DivisionID = @DivisionID AND ProductID = @ProductID AND TranMonth + TranYear * 100 = (@TranMonth + @TranYear * 100)
		   AND (ISNULL(HT1126.PercentAmount, 0) <> 0 OR ISNULL(HT1126.Amount, 0) <> 0 ) )
BEGIN 
	SET @Status = 1
	SET @Message = N'HFML000560'
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
