IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MTP3022]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MTP3022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by:
-- <Example>
/*
	MTP3022 'EIS', '',1,2013,5,2014,0, '2014-02-19 00:00:00.000', '2014-02-19 00:00:00.000','%'
*/

 CREATE PROCEDURE MTP3022
(
    @DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@FromMonth INT,
	@FromYear INT,
	@ToMonth INT,
	@ToYear INT,
	@IsDate TINYINT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@BranchID VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(2000),
		@sWhere1 NVARCHAR(2000) = ''
SET @sWhere = ''
IF @BranchID <> '%'  SET @sWhere1 = @sWhere1+ '
	AND M40.BranchID = '''+@BranchID+'''  --CONVERT(INT,SUBSTRING(M10.ClassID,2,2)) = SUBSTRING('''+@BranchID+''',3,1)'
IF @IsDate = 0 SET @sWhere = @sWhere + ' 
	AND M10.TranYear * 100 + M10.TranMonth BETWEEN '+STR(@FromYear * 100 + @FromMonth)+' AND '+STR(@ToYear * 100 + @ToMonth)+' '
IF @IsDate = 1 SET @sWhere =  @sWhere +'
	AND CONVERT(VARCHAR,M10.CreateDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''' '

SET @sSQL = '	
SELECT ROW_NUMBER() OVER (ORDER BY B.ClassID) AS RowNum, B.ClassID, M40.ClassName, M20.SchoolTimeName, M00.BeginDate, M00.EndDate, ISNULL(A.TeacherName,'''') TeacherName,
COUNT(B.StudentID) SumStudent, SUM(Resign) AS Resign
--SUM(B.Resign) Resign, 
--CASE WHEN SUM(B.Resign) = 0 THEN 0 ELSE CONVERT(DECIMAL,SUM(B.Resign)) / CONVERT(DECIMAL,COUNT(B.StudentID)) * 100 END Repercent
FROM 
(
	SELECT M10.DivisionID, M10.StudentID, M10.ClassID, Resign 
	--M10.CreateDate, A.MaxCreateDate,
	--CASE WHEN M10.CreateDate < A.MaxCreateDate THEN 1 ELSE 0 END Resign
	FROM MTT2010 M10
	LEFT JOIN (SELECT StudentID, 1 Resign--, MAX(CreateDate) MaxCreateDate 
				FROM MTT2010 
				WHERE DeleteFlag = 0 
					AND TranYear * 100 + TranMonth BETWEEN '+STR(@FromYear * 100 + @FromMonth)+' AND '+STR((@ToYear - 1) * 100 + CASE WHEN @ToMonth = 1 THEN 12 ELSE @ToMonth END)+' 
				GROUP BY StudentID)A ON A.StudentID = M10.StudentID
	WHERE DivisionID = '''+@DivisionID+''' 
	AND DeleteFlag = 0  '+@sWhere+'
	
)B
LEFT JOIN MTT1040 M40 ON M40.ClassID = B.ClassID
LEFT JOIN MTT1020 M20 ON M20.SchoolTimeID = M40.SchoolTimeID
LEFT JOIN (SELECT A.*, M41.TeacherID, A02.ObjectName TeacherName FROM 
	(
	SELECT ClassID,  MAX(CreateDate) CreateDate FROM MTT1041
	GROUP BY ClassID
	)A 
	LEFT JOIN MTT1041 M41 ON M41.ClassID = A.ClassID AND M41.CreateDate = A.CreateDate
	LEFT JOIN AT1202 A02 ON M41.TeacherID = A02.ObjectID)A ON A.ClassID = M40.ClassID
	LEFT JOIN MTT1000 M00 ON M00.CourseID = M40.CourseID
WHERE B.DivisionID = '''+@DivisionID+'''
'+@sWhere1+'
GROUP BY B.ClassID, M40.ClassName, M20.SchoolTimeName, M00.BeginDate, M00.EndDate, A.TeacherName
ORDER BY B.ClassID '

EXEC (@sSQL)
PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
