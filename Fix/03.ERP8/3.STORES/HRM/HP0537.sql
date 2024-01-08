IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0537]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0537]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra trùng thời gian từ ngày, đến ngày cho bảng giá (VIETFIRST)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 27/02/2018
/*-- <Example>
	HP0537 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @XML = @XML

	HP0537 @DivisionID, @UserID, @XML
----*/

CREATE PROCEDURE HP0537
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@XML XML
)
AS 

CREATE TABLE #TBL_HP0537 (PriceSheetID VARCHAR(50), FromDate DATETIME, ToDate DATETIME)

INSERT INTO #TBL_HP0537
SELECT X.Data.query('PriceSheetID').value('.', 'VARCHAR(50)') AS PriceSheetID,
	  (CASE WHEN X.Data.query('FromDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('FromDate').value('.', 'DATETIME') END) AS FromDate,
	  (CASE WHEN X.Data.query('ToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ToDate').value('.', 'DATETIME') END) AS ToDate
FROM @XML.nodes('//Data') AS X (Data)



DECLARE @Cur CURSOR,
		@PriceSheetID VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME
		
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT PriceSheetID, FromDate, ToDate FROM #TBL_HP0537

OPEN @Cur
FETCH NEXT FROM @Cur INTO @PriceSheetID, @FromDate, @ToDate
WHILE @@FETCH_STATUS = 0
BEGIN
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM HT1902 WITH (NOLOCK)
				   WHERE DivisionID = @DivisionID AND PriceSheetID <> @PriceSheetID
				   AND (@FromDate BETWEEN FromDate AND ToDate OR @ToDate BETWEEN FromDate AND ToDate OR (@FromDate <= FromDate AND @ToDate >= ToDate)) )
	BEGIN 
		DELETE #TBL_HP0537 
		WHERE PriceSheetID = @PriceSheetID
	END

FETCH NEXT FROM @Cur INTO @PriceSheetID, @FromDate, @ToDate
END 
Close @Cur 

SELECT * FROM #TBL_HP0537

DROP TABLE #TBL_HP0537

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
