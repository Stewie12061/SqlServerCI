IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo đánh giá công việc
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 26/05/2021
-- <Example>
---- 
/*-- <Example>
	
----*/

CREATE PROCEDURE HRMP3025
( 
	 @DivisionID        NVARCHAR(50),
	 @DivisionIDList	NVARCHAR(MAX),
	 @IsDate INT, ---- 1: là ngày, 0: là kỳ
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @PeriodList        NVARCHAR(MAX), 
	 @DepartmentID		NVARCHAR(50),
	 @EmployeeID        NVARCHAR(50)
)
AS 
DECLARE @TotalRow VARCHAR(50),
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sJoin VARCHAR(MAX),
		@SubAmount INT,
		@sWhereHT1406 NVARCHAR(MAX)='',
		@sWhereHTT3400 NVARCHAR(MAX)='',
		@sWhereOOT2060 NVARCHAR(MAX)='',
		@sWhereHT2401_MK NVARCHAR(MAX)=''

SET @sWhere = ''
SET @sJoin = ''
SET @sSQL = ''

--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
IF Isnull(@DivisionIDList, '') != ''
	SET @sWhere = ' T1.DivisionID IN ('''+@DivisionIDList+''')'
ELSE 
	SET @sWhere = ' T1.DivisionID = N'''+@DivisionID+''''	

IF @IsDate = 0
	BEGIN
	IF ISNULL(@PeriodList,'') <> ''
		SET @sWhereHT1406 = @sWhereHT1406 + ' AND ((CASE WHEN Month(T3.RetributeDate) <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(Month(T3.RetributeDate))))+''/''+ltrim(Rtrim(str(Year(T3.RetributeDate)))) in ('''+@PeriodList +'''))'
		SET @sWhereHTT3400 = @sWhereHTT3400 + ' AND ((CASE WHEN T4.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(T4.TranMonth)))+''/''+ltrim(Rtrim(str(T4.TranYear))) in ('''+@PeriodList +'''))'
		SET @sWhereOOT2060 = @sWhereOOT2060 + ' AND ((CASE WHEN A.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(A.TranMonth)))+''/''+ltrim(Rtrim(str(A.TranYear))) in ('''+@PeriodList +'''))'
		SET @sWhereHT2401_MK = @sWhereHT2401_MK + ' AND ((CASE WHEN B.TranMonth <10 THEN ''0'' ELSE '''' END) + rtrim(ltrim(str(B.TranMonth)))+''/''+ltrim(Rtrim(str(B.TranYear))) in ('''+@PeriodList +'''))'
	END
ELSE
	BEGIN
	IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
		SET @sWhereHT1406 = @sWhereHT1406 + ' AND (Convert(varchar(20),T3.RetributeDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
		SET @sWhereHTT3400 = @sWhereHTT3400 + ' AND (Convert(varchar(20),T4.CreateDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
	    SET @sWhereOOT2060 = @sWhereOOT2060 + ' AND (Convert(varchar(20),A.WorkingDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
		SET @sWhereHT2401_MK = @sWhereHT2401_MK + ' AND (Convert(varchar(20),B.AbsentDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
	END

IF ISNULL(@DepartmentID,'') <> ''
	SET @sWhere = @sWhere + ' AND T1.DepartmentID ='''+@DepartmentID+''''

IF ISNULL(@EmployeeID,'') <> ''

	SET @sWhere = @sWhere + ' AND T1.EmployeeID IN ( '''+@EmployeeID+''')'

SET @SubAmount = (Select Count(*)from HT0005 WITH (NOLOCK) Where IsUsed=1 and DivisionID = @DivisionID) + 1

SET @sSQL = @sSQL+ '
SELECT T1.EmployeeID,CONCAT(T1.LastName +'' '', T1.MiddleName +'' '', T1.FirstName) as EmployeeName,T1.DepartmentID,T2.DepartmentName,SUM(ISNULL(T3.Times,0)) as Times, SUM(ISNULL(T3.Value,0)) as Value
,SUM(ISNULL(T4.SubAmount'+LTRIM(STR(@SubAmount))+',0)) as TotalAmount, COUNT(A.EmployeeID) as Total1, COUNT(B.EmployeeID) as Total2
FROM HT1400 T1 WITH (NOLOCK)
LEFT JOIN AT1102 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.DepartmentID = T2.DepartmentID AND T2.DepartmentID IN (''@@@'',T2.DepartmentID)
LEFT JOIN HT1406 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID '+@sWhereHT1406+'
LEFT JOIN HTT3400 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID '+@sWhereHTT3400+'
LEFT JOIN (SELECT DivisionID,EmployeeID,WorkingDate,TranMonth,TranYear FROM OOT2060 WHERE HandleMethodID=''DXP'' AND  Fact =''BT0003'' GROUP BY DivisionID,EmployeeID,WorkingDate,TranMonth,TranYear
		   UNION ALL SELECT DivisionID,EmployeeID,WorkingDate,TranMonth,TranYear FROM OOT2060 WHERE HandleMethodID=''DXP'' AND  Fact =''BT0002'') A
ON T1.DivisionID = A.DivisionID AND T1.EmployeeID = A.EmployeeID '+@sWhereOOT2060+'
LEFT JOIN (SELECT T1.DivisionID,T1.EmployeeID,T1.AbsentDate,T1.TranMonth,T1.TranYear  
		   FROM HT2401_MK T1 WITH (NOLOCK)
		   LEFT JOIN OOT9000 T2 WITH (NOLOCK) ON  T1.DivisionID = T2.DivisionID AND T1.APKMaster = T2.APK 
		   WHERE T2.[Type] =''DXP'') B
ON T1.DivisionID = B.DivisionID AND T1.EmployeeID = B.EmployeeID '+@sWhereHT2401_MK+'
WHERE '+@sWhere+'
GROUP BY T1.EmployeeID,T1.LastName,T1.MiddleName,T1.FirstName,T1.DepartmentID,T2.DepartmentName '

print @sSQL
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

