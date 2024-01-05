IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Tính % đặt hàng cho từng mặt hàng (Customize ATTOM)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 16/07/2018
-- <Example>
---- exec POP2024 'AT', 'ASOFTADMIN', '06/2018', '06/2020'
CREATE PROCEDURE POP2024
( 
		@DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@FromPeriod NVARCHAR(50),
		@ToPeriod NVARCHAR(50)
) 
AS 

DECLARE @FromMonth INT,
		@FromYear INT,
		@ToMonth INT,
		@ToYear INT,
		@TotalRow FLOAT,
		@Row25 FLOAT,
		@Row30 FLOAT,
		@Row35 FLOAT,
		@TotalQuantity DECIMAL(28,8),
		@Total25 DECIMAL(28,8),
		@Total30 DECIMAL(28,8),
		@Total35 DECIMAL(28,8)

SET @FromMonth = LEFT(@FromPeriod,2)
SET @FromYear = RIGHT(@FromPeriod,4)
SET @ToMonth = LEFT(@ToPeriod,2)
SET @ToYear = RIGHT(@ToPeriod,4)

SELECT ROW_NUMBER() OVER (ORDER BY ActualQuantity DESC) AS RowNum, * , 0 AS RateDecimal
INTO #Temp 
FROM (
	SELECT A.InventoryID, (ISNULL(A.SellQuantity,0) - ISNULL(B.ReturnQuantity,0) ) AS ActualQuantity 
	FROM 
	(
		SELECT P61.InventoryID, SUM(P61.ActualQuantity) AS SellQuantity
		  FROM POST0016 P16 WITH (NOLOCK)
		LEFT JOIN POST00161 P61 WITH (NOLOCK) ON P61.DivisionID = P16.DivisionID AND P16.APK = P61.APKMaster
		WHERE P61.DivisionID = @DivisionID
			AND P16.TranMonth + P16.TranYear * 100 BETWEEN @FromMonth + @FromYear*100 AND @ToMonth + @ToYear*100
			AND P61.IsKindVoucherID = 2
		GROUP BY P61.InventoryID
	) A
	LEFT JOIN (
		SELECT P61.InventoryID, SUM(P61.ActualQuantity) AS ReturnQuantity
		  FROM POST0016 P16 WITH (NOLOCK)
		LEFT JOIN POST00161 P61 WITH (NOLOCK) ON P61.DivisionID = P16.DivisionID AND P16.APK = P61.APKMaster
		WHERE P61.DivisionID = @DivisionID 
			AND P16.TranMonth + P16.TranYear * 100 BETWEEN @FromMonth + @FromYear*100 AND @ToMonth + @ToYear*100
			AND P61.IsKindVoucherID = 1
		GROUP BY P61.InventoryID
	) B ON A.InventoryID = B.InventoryID
) C
ORDER BY ActualQuantity desc

SELECT @TotalQuantity = SUM(ActualQuantity) FROM #Temp
SELECT @TotalRow = COUNT(*) FROM #Temp

SET @Row25 = CEILING(25*@TotalRow/100)
SET @Row30 = CEILING(30*@TotalRow/100)
SET @Row35 = CEILING(35*@TotalRow/100)


SELECT @Total25 = SUM(ActualQuantity) FROM #Temp
WHERE RowNum <= @Row25

SELECT @Total30 = SUM(ActualQuantity) FROM #Temp
WHERE RowNum <= @Row30

SELECT @Total35 = SUM(ActualQuantity) FROM #Temp
WHERE RowNum <= @Row35

IF @Total30 = @TotalQuantity*70/100
	BEGIN
		UPDATE #Temp
		SET RateDecimal = 120
		WHERE RowNum <= CEILING(33*@Row30/100)
	
		UPDATE #Temp
		SET RateDecimal = 110
		WHERE RowNum > CEILING(33*@Row30/100) AND RowNum <= CEILING(66*@Row30/100)
	
		UPDATE #Temp
		SET RateDecimal = 100
		WHERE RowNum <= CEILING(33*@Row30/100) AND ISNULL(RateDecimal,0) = 0
	END
ELSE
	BEGIN
		IF (@Total30 - @Total25) = (@Total35 - @Total30)
			BEGIN
				UPDATE #Temp
				SET RateDecimal = 120
				WHERE RowNum <= CEILING(33*@Row35/100)
	
				UPDATE #Temp
				SET RateDecimal = 110
				WHERE RowNum > CEILING(33*@Row35/100) AND RowNum <= CEILING(66*@Row35/100)
	
				UPDATE #Temp
				SET RateDecimal = 100
				WHERE RowNum <= CEILING(33*@Row35/100) AND ISNULL(RateDecimal,0) = 0
			END
		ELSE
			BEGIN
				UPDATE #Temp
				SET RateDecimal = 120
				WHERE RowNum <= CEILING(33*@Row30/100)
	
				UPDATE #Temp
				SET RateDecimal = 110
				WHERE RowNum > CEILING(33*@Row30/100) AND RowNum <= CEILING(66*@Row30/100)
	
				UPDATE #Temp
				SET RateDecimal = 100
				WHERE RowNum <= CEILING(33*@Row30/100) AND ISNULL(RateDecimal,0) = 0
			END
	END

SELECT * FROM #Temp

--SELECT @Row25, @Row30, @Row35, @TotalQuantity, @Total25, @Total30, @Total35

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
