IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP9003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP9003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Cập nhật kích thước các cột Col01, Col02, Col03 của bút toán mẫu DebitNote (Song Bình)
-- <Param>

---- Modified by Kim Thư on 25/6/2019: Bổ sung isnull khi update

--- EXEC OP9003 @DivisionID = 'SB', @TemplateVoucherID='EV00000000002226'

CREATE PROCEDURE [dbo].[OP9003]
(
    @DivisionID NVARCHAR(50),
    @TemplateVoucherID NVARCHAR(50)
) 
AS

DECLARE @cur CURSOR, @TemplateTransactionID VARCHAR(50), @Dimension VARCHAR(50), @Col01 VARCHAR(50), @Col02 VARCHAR(50), @Col03 VARCHAR(50)

SET @Cur  = Cursor Scroll KeySet FOR 
	SELECT TemplateTransactionID, Dimension FROM ET2002 WITH(NOLOCK) WHERE TemplateVoucherID=@TemplateVoucherID AND Dimension LIKE '%cm'
OPEN @Cur
FETCH NEXT FROM @Cur INTO @TemplateTransactionID, @Dimension
WHILE @@Fetch_Status = 0
BEGIN 
	--'55*50*12cm'
	SET @Dimension = (SELECT LEFT(@Dimension, LEN(@Dimension)-2)) -- ='55*50*12'
	SET @Col01 = (SELECT SUBSTRING(@Dimension, 1, CHARINDEX('*',@Dimension)-1)) --= '55'
	SET @Dimension = (SELECT RIGHT(@Dimension, LEN(@Dimension)-(LEN(@Col01)+1))) -- ='50*12'
	SET @Col02 = (SELECT SUBSTRING(@Dimension, 1, CHARINDEX('*',@Dimension)-1)) -- ='50'
	SET @Dimension = (SELECT RIGHT(@Dimension, LEN(@Dimension)-(LEN(@Col02)+1))) -- =12
	SET @Col03 = @Dimension
	--SELECT @Col01, @Col02, @Col03

	UPDATE ET2002
	SET Col01=ISNULL(CAST(@Col01 AS DECIMAL(28,2)),0), Col02=ISNULL(CAST(@Col02 AS DECIMAL(28,2)),0), Col03=ISNULL(CAST(@Col03 AS DECIMAL(28,2)),0)
	WHERE TemplateVoucherID=@TemplateVoucherID AND TemplateTransactionID=@TemplateTransactionID

FETCH NEXT FROM @Cur INTO @TemplateTransactionID, @Dimension
END            
CLOSE @Cur
DEALLOCATE @Cur