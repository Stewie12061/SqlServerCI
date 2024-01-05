IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Tính số lượng bán trung bình theo khoảng thời gian đã chọn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 16/07/2018
-- <Example>
---- exec POP2023 'AT', 'ASOFTADMIN', '06/2018', '06/2020', '0000000002'
CREATE PROCEDURE POP2023
( 
		@DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@FromPeriod NVARCHAR(50),
		@ToPeriod NVARCHAR(50),
		@InventoryID	NVARCHAR(50)
) 
AS 

DECLARE @FromMonth INT,
		@FromYear INT,
		@ToMonth INT,
		@ToYear INT,
		@NumberMonth INT = 0,
		@Years INT

SET @FromMonth = LEFT(@FromPeriod,2)
SET @FromYear = RIGHT(@FromPeriod,4)
SET @ToMonth = LEFT(@ToPeriod,2)
SET @ToYear = RIGHT(@ToPeriod,4)

SET @Years = @FromYear

WHILE @Years < @ToYear
BEGIN
	IF @Years <> @FromYear
		SET @NumberMonth = @NumberMonth + (( 12 + @Years *100) - (1 + @Years *100 ) + 1)
	ELSE
		SET @NumberMonth = @NumberMonth + (( 12 + @Years *100) - (@FromMonth + @Years *100 ) + 1)
	SET @Years = @Years + 1
END

IF @Years = @ToYear AND @FromYear <> @ToYear
	SET @NumberMonth = @NumberMonth + (@ToMonth + @ToYear *100) - (1 + @ToYear *100 ) + 1
ELSE
	SET @NumberMonth = @NumberMonth + (@ToMonth + @ToYear *100) - (@FromMonth + @FromYear *100 ) + 1


SELECT A.InventoryID, (ISNULL(A.SellQuantity,0) - ISNULL(B.ReturnQuantity,0) )/@NumberMonth AS AVGQuantity FROM 
(

SELECT P61.InventoryID, SUM(P61.ActualQuantity) AS SellQuantity
  FROM POST0016 P16 WITH (NOLOCK)
LEFT JOIN POST00161 P61 WITH (NOLOCK) ON P61.DivisionID = P16.DivisionID AND P16.APK = P61.APKMaster
WHERE P61.DivisionID = @DivisionID AND P61.InventoryID = @InventoryID
	AND P16.TranMonth + P16.TranYear * 100 BETWEEN @FromMonth + @FromYear*100 AND @ToMonth + @ToYear*100
	AND P61.IsKindVoucherID = 2
GROUP BY P61.InventoryID
) A
LEFT JOIN (
SELECT P61.InventoryID, SUM(P61.ActualQuantity) AS ReturnQuantity
  FROM POST0016 P16 WITH (NOLOCK)
LEFT JOIN POST00161 P61 WITH (NOLOCK) ON P61.DivisionID = P16.DivisionID AND P16.APK = P61.APKMaster
WHERE P61.DivisionID = @DivisionID AND P61.InventoryID = @InventoryID
	AND P16.TranMonth + P16.TranYear * 100 BETWEEN @FromMonth + @FromYear*100 AND @ToMonth + @ToYear*100
	AND P61.IsKindVoucherID = 1
GROUP BY P61.InventoryID
) B ON A.InventoryID = B.InventoryID

	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
