IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





----- Created by Như Hàn
---- Created Date 06/11/2018
---- Purpose: Đổ nguồn Form truy vấn thiết lập xét duyệt
---- Modified on ... by ...
/*
EXEC SP0051 @DivisionID, @UserID, @TranMonth, @TranYear, @CreateUserID, @Type, @Status, @VoucherNo, @PageNumber, @PageSize
EXEC SP0051 'AS', '', 8, 2018, '44', 'KHTC', 0, '66', '0', '0'
*/

CREATE PROCEDURE [dbo].[SP0051] 	
				@DivisionID VARCHAR(50),
				@UserID VARCHAR(50),
				@TranMonth INT,
				@TranYear INT,
				@CreateUserID VARCHAR(50),
				@Type VARCHAR(50),
				@Status VARCHAR(50),
				@VoucherNo VARCHAR(50),
				@PageNumber INT,
				@PageSize INT

AS
DECLARE @WHERE varchar(max) = '', 
		@SQL varchar(max) = '',
		@SQL1 varchar(max) = '',
		@TotalRow VARCHAR(50),
		@OrderBy NVARCHAR(500)

SET @OrderBy = ' CreateDate'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@CreateUserID,'') <>''
SET @WHERE = @WHERE + '
	AND OOT90.CreateUserID LIKE ''%'+@CreateUserID+'%'''
IF ISNULL(@VoucherNo,'') <>''
SET @WHERE = @WHERE + '
	AND ISNULL(OOT90.ID,'''') LIKE ''%'+@VoucherNo+'%'' '
IF ISNULL(@Status,'') <> ''
SET @WHERE = @WHERE + '
	AND ISNULL(OOT91.Status,0) = '+@Status+' '
IF ISNULL(@Type,'')<> ''
SET @WHERE = @WHERE + '
	AND ISNULL(OOT90.Type,'''') LIKE ''%'+@Type+'%'' '

--EXEC (@SQL)

SET @SQL = @SQL +'
SELECT	OOT90.DivisionID, OOT911.APK As NextAPK, OOT91.APKMaster, OOT91.ApprovePersonID, OOT91.[Level], OOT91.Note,
			OOT91.[Status],OOT90.ID, OOT90.[Description], OOT90.[Type],
			OOT90.CreateUserID , 
			AT1405.UserName AS CreateUserName,
			OOT90.TranYear, OOT90.TranMonth,OOT99.Description As StatusName, OOT99.DescriptionE As StatusNameE,
			AT103.FullName As ApprovePersonName,AT113.FullName As NextApprovePersonName,
			OOT911.ApprovePersonID NextApprovePersonID,
			OOT991.Description TypeName,OOT90.CreateDate,0 IsColor, OOT91.APK, OOT91.APK As OOT9001APK
	INTO #SP0051_OOT90
	FROM OOT9000 OOT90
	INNER JOIN(
		SELECT MIN(Level) Level,DivisionID, ApprovePersonID, APKMaster
		FROM OOT9001
		GROUP BY DivisionID, ApprovePersonID, APKMaster
	)OOT9 ON OOT9.DivisionID = OOT90.DivisionID AND OOT9.APKMaster = OOT90.APK
	INNER JOIN OOT9001 OOT91 ON OOT91.DivisionID = OOT9.DivisionID AND OOT91.APKMaster = OOT9.APKMaster AND OOT91.Level=OOT9.Level
	LEFT JOIN OOT0099 OOT99 ON OOT99.ID1 = OOT91.[Status] AND OOT99.CodeMaster=''Status''
	LEFT JOIN OOT0099 OOT991 ON OOT991.ID = OOT90.Type AND OOT991.CodeMaster=''Applying''
	LEFT JOIN OOT9001 OOT911 ON OOT911.DivisionID = OOT91.DivisionID AND OOT911.APKMaster = OOT91.APKMaster AND OOT911.[Level] = OOT91.[Level]+1 AND OOT911.ApprovePersonID <> OOT91.ApprovePersonID
	LEFT JOIN OOT9001 OOT912 ON OOT912.DivisionID = OOT91.DivisionID AND OOT912.APKMaster = OOT91.APKMaster AND OOT912.[Level] = OOT91.[Level]-1
	LEFT JOIN AT1103 AT103 ON AT103.DivisionID = OOT91.DivisionID AND AT103.EmployeeID = OOT91.ApprovePersonID
	LEFT JOIN AT1103 AT113 ON AT113.DivisionID = OOT91.DivisionID AND AT113.EmployeeID = OOT911.ApprovePersonID
	LEFT JOIN AT1405 ON OOT90.DivisionID=AT1405.DivisionID AND OOT90.CreateUserID=AT1405.UserID
	WHERE OOT91.DivisionID ='''+@DivisionID+'''
	AND ISNULL(OOT90.DeleteFlag,0) = 0
	AND OOT91.ApprovePersonID = '''+@UserID+'''
	AND ISNULL(OOT912.[Status],3) NOT IN (0,2)
	'+@WHERE+'

	UPDATE T1
	SET	T1.APK = T2.APK
	FROM #SP0051_OOT90 T1
	INNER JOIN
	(
		SELECT OOT9.Level, OOT9.DivisionID, OOT9.ApprovePersonID, OOT9.APKMaster, OOT91.APK
		FROM(
			SELECT MAX(Level) Level,DivisionID, ApprovePersonID, APKMaster
			FROM OOT9001
			GROUP BY DivisionID, ApprovePersonID, APKMaster
		)OOT9 
		INNER JOIN OOT9001 OOT91 ON OOT91.DivisionID = OOT9.DivisionID AND OOT91.APKMaster = OOT9.APKMaster AND OOT91.Level=OOT9.Level
	) T2 ON T1.DivisionID = T2.DivisionID AND T1.APKMaster = T2.APKMaster  AND T1.ApprovePersonID= T2.ApprovePersonID
	WHERE '+STR(@Status)+'  = 1
'
SET @SQL1 ='	SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
				FROM #SP0051_OOT90	
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


EXEC (@SQL+@SQL1)
--PRINT @SQL
--PRINT @SQL1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

