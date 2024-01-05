IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra trùng thời gian định biên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 21/07/2017
/*-- <Example>
	HRMP1022 @DivisionID='MK',@UserID='000054', @XML = @XML
----*/

CREATE PROCEDURE HRMP1022
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@XML XML
)
AS 

CREATE TABLE #TBL_HRMP1022 (BoundaryID VARCHAR(50), DepartmentID VARCHAR(50), DutyID VARCHAR(50), FromDate DATETIME, ToDate DATETIME, Type INT)

INSERT INTO #TBL_HRMP1022 (BoundaryID, DepartmentID, DutyID, FromDate, ToDate)
SELECT X.Data.query('BoundaryID').value('.', 'NVARCHAR(50)') AS BoundaryID,
	   X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID,
	   X.Data.query('DutyID').value('.', 'NVARCHAR(50)') AS DutyID,
	  (CASE WHEN X.Data.query('FromDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('FromDate').value('.', 'DATETIME') END) AS FromDate,
	  (CASE WHEN X.Data.query('ToDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ToDate').value('.', 'DATETIME') END) AS ToDate
FROM @XML.nodes('//Data') AS X (Data)



DECLARE @Cur CURSOR,
		@BoundaryID VARCHAR(50),
		@DepartmentID VARCHAR(50),
		@DutyID VARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@i INT
		
SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT BoundaryID, DepartmentID, DutyID, FromDate, ToDate FROM #TBL_HRMP1022

OPEN @Cur
FETCH NEXT FROM @Cur INTO @BoundaryID,@DepartmentID,@DutyID,@FromDate,@ToDate
WHILE @@FETCH_STATUS = 0
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM HRMT1020 T1 WITH (NOLOCK)
				   LEFT JOIN HRMT1021 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.BoundaryID = T2.BoundaryID AND T1.DepartmentID = T2.DepartmentID
				   WHERE T1.DivisionID = @DivisionID
				   AND T1.BoundaryID <> @BoundaryID
				   AND T1.DepartmentID = @DepartmentID
				   AND T2.DutyID = @DutyID
				   AND (@FromDate Between T1.FromDate and T1.ToDate
						OR @ToDate Between T1.FromDate and T1.ToDate
						OR (@FromDate <= T1.FromDate AND @ToDate >= ToDate)) )
	BEGIN 
		DELETE #TBL_HRMP1022 
		WHERE BoundaryID = @BoundaryID
		AND DepartmentID = @DepartmentID
		AND DutyID = @DutyID
	END
FETCH NEXT FROM @Cur INTO @BoundaryID,@DepartmentID,@DutyID,@FromDate,@ToDate
END 
Close @Cur 


SELECT * FROM #TBL_HRMP1022


DROP TABLE #TBL_HRMP1022

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
