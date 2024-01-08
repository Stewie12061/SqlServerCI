IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP1359]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP1359]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid  HF0359
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> HRM/Danh muc/
---- Lich su nhan vien
-- <History>
----Created by: Phuong Thao, Date: 29/12/2015
-- <Example>
---- 
/*-- <Example>
	
exec HP1359 'CTY', '007013', '%','2016-01-27','2016-01-27'
----*/
CREATE PROCEDURE [dbo].[HP1359] 
	@DivisionID nvarchar(20), 
	@EmployeeIDFrom nvarchar(50),
	@EmployeeIDTo nvarchar(50),
	@DateFrom DateTime,
	@DateTo DateTime
as


DECLARE @SQL NVarchar(4000)
SET @SQL = N'
SELECT	DISTINCT T1.EmployeeID, 		
		(SELECT TOP 1 Ltrim(RTrim(isnull(A.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(A.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(A.FirstName,''''))) As FullName
		FROM cdc.dbo_HT1400_CT A
		WHERE	T1.EmployeeID = A.EmployeeID AND T1.DivisionID = A.DivisionID 
		ORDER BY LastModifyDate desc) AS FullName,
		convert(datetime,left(convert(varchar(50),Convert(Datetime2(0),T1.LastModifyDate),20),22)) AS LastModifyDate,		
		CASE WHEN __$operation  = 1 THEN N''Xóa'' ELSE N''Sửa'' END AS ChangeContent
FROM (
SELECT	t1.EmployeeID, t1.DivisionID,
		t2.tran_end_time AS LastModifyDate, t1.__$operation
FROM	cdc.dbo_HT1400_CT t1 inner join cdc.lsn_time_mapping t2 on t1.__$start_lsn = t2.start_lsn
WHERE	1=1 '+ CASE WHEN @EmployeeIDFrom <> '%' AND @EmployeeIDTo <> '%' THEN  'AND (EmployeeID Between '''+@EmployeeIDFrom+''' and  '''+@EmployeeIDTo+''')
		' ELSE ' ' END+'
AND (Convert(Date,t2.tran_end_time) Between Convert(Date,'''+Convert(Varchar(20),@DateFrom,101)+''') and Convert(Date,'''+Convert(Varchar(20),@DateTo,101)+'''))
AND t1.__$operation In (1,4) AND DivisionID = '''+@DivisionID+'''
UNION ALL
SELECT	t1.EmployeeID, t1.DivisionID,
		t2.tran_end_time AS LastModifyDate, t1.__$operation
FROM	cdc.dbo_HT1401_CT t1 inner join cdc.lsn_time_mapping t2 on t1.__$start_lsn = t2.start_lsn
WHERE	1=1 '+ CASE WHEN @EmployeeIDFrom <> '%' AND @EmployeeIDTo <> '%' THEN  'AND (EmployeeID Between '''+@EmployeeIDFrom+''' and  '''+@EmployeeIDTo+''')
		' ELSE ' ' END+'
AND (Convert(Date,t2.tran_end_time) Between Convert(Date,'''+Convert(Varchar(20),@DateFrom,101)+''') and Convert(Date,'''+Convert(Varchar(20),@DateTo,101)+'''))
AND t1.__$operation In (1,4) AND DivisionID = '''+@DivisionID+'''
UNION ALL
SELECT	t1.EmployeeID, t1.DivisionID,
		t2.tran_end_time AS LastModifyDatee, t1.__$operation
FROM	cdc.dbo_HT1402_CT t1 inner join cdc.lsn_time_mapping t2 on t1.__$start_lsn = t2.start_lsn
WHERE	1=1 '+ CASE WHEN @EmployeeIDFrom <> '%' AND @EmployeeIDTo <> '%' THEN  'AND (EmployeeID Between '''+@EmployeeIDFrom+''' and  '''+@EmployeeIDTo+''')
		' ELSE ' ' END+'
AND (Convert(Date,t2.tran_end_time) Between Convert(Date,'''+Convert(Varchar(20),@DateFrom,101)+''') and Convert(Date,'''+Convert(Varchar(20),@DateTo,101)+'''))
AND t1.__$operation In (1,4) AND DivisionID = '''+@DivisionID+'''
UNION ALL
SELECT	t1.EmployeeID, t1.DivisionID,
		t2.tran_end_time AS LastModifyDate, t1.__$operation
FROM	cdc.dbo_HT1403_CT t1 inner join cdc.lsn_time_mapping t2 on t1.__$start_lsn = t2.start_lsn
WHERE	1=1 '+ CASE WHEN @EmployeeIDFrom <> '%' AND @EmployeeIDTo <> '%' THEN  'AND (EmployeeID Between '''+@EmployeeIDFrom+''' and  '''+@EmployeeIDTo+''')
		' ELSE ' ' END+'
AND (Convert(Date,t2.tran_end_time) Between Convert(Date,'''+Convert(Varchar(20),@DateFrom,101)+''') and Convert(Date,'''+Convert(Varchar(20),@DateTo,101)+'''))
AND t1.__$operation In (1,4) AND DivisionID = '''+@DivisionID+'''
) T1
LEFT JOIN HT1400 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.DivisionID = T2.DivisionID AND T1.__$operation <> 1

'
EXEC (@SQL)
--PRINT (@SQL)	



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

