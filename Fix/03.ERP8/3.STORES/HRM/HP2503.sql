IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2503]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2503]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Kiểm tra trước khi xóa chấm công ngày
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> HRM \ Nghiệp vụ \ Chấm công \ Chấm công ngày \ Xóa, Xóa tất cả
----	
-- <History>
---- Created on 07/12/2017 Bảo Thy
---- Modified on 
-- <Example>
/*
	EXEC HP2503 @DivisionID='MK',@UserID='ASOFTADMIN',@TranMonth=10,@TranYear=2017,@FromDepartmentID='A000000',@ToDepartmentID='A000000',
	@TeamID='%',@SectionID='%',@ProcessID='%',@EmployeeID='000199',@AbsentDate='2017-10-02',@AbsentTypeID='',@EmployeeList=NULL,@IsDeleteAll=2
*/
CREATE PROCEDURE [dbo].[HP2503]   
    @DivisionID NVARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,   
    @TranYear INT,  
    @FromDepartmentID VARCHAR(50),   
	@ToDepartmentID VARCHAR(50),   
    @TeamID VARCHAR(50),
	@SectionID VARCHAR(50),
	@ProcessID VARCHAR(50),
    @EmployeeID VARCHAR(50),      
    @AbsentDate DATETIME, 
    @AbsentTypeID VARCHAR(50), 
    @EmployeeList XML,
	@IsDeleteAll TINYINT --0: xóa từng dòng, 1: xóa tất cả, 2: xóa nhiều dòng
AS  
DECLARE	@TableHT2400 VARCHAR(50),
		@TableHT2401 VARCHAR(50),
		@TableHT2402 VARCHAR(50),
		@sTranMonth VARCHAR(2),
		@sSQL VARCHAR(MAX) = '',
		@sWhere VARCHAR(1000) = '',
		@sWhere1 VARCHAR(1000) = '',
		@sWhere2 VARCHAR(1000) = ''

SELECT  X.Data.query('EmployeeID').value('.', 'VARCHAR(50)') AS EmployeeID,
		X.Data.query('AbsentDate').value('.', 'DATETIME') AS AbsentDate
INTO #EmployeeList_HP2503
FROM @EmployeeList.nodes('//Data') AS X (Data)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
	SELECT  @TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),@TranYear)
	SELECT  @TableHT2402 = 'HT2402M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2400 = 'HT2400',
			@TableHT2401 = 'HT2401',
			@TableHT2402 = 'HT2402'
END

IF ISNULL(@IsDeleteAll,0) = 0
BEGIN
	SET @sWhere = 'AND T1.EmployeeID = '''+@EmployeeID+''' '
	SET @sWhere1 = 'AND T1.AbsentDate = '''+CONVERT(VARCHAR(10),@AbsentDate,120)+''''
	SET @sWhere2 = 'AND T3.EmployeeID = '''+@EmployeeID+''' '
END
IF ISNULL(@IsDeleteAll,0) = 1
BEGIN
	SET @sWhere = 'AND EXISTS (SELECT TOP 1 1 FROM #EmployeeList_HP2503 Temp WHERE T1.EmployeeID = Temp.EmployeeID) '
	SET @sWhere2 = 'AND EXISTS (SELECT TOP 1 1 FROM #EmployeeList_HP2503 Temp WHERE T3.EmployeeID = Temp.EmployeeID) '
END
IF ISNULL(@IsDeleteAll,0) = 2
BEGIN
	SET @sWhere = 'AND EXISTS (SELECT TOP 1 1 FROM #EmployeeList_HP2503 Temp WHERE T1.EmployeeID = Temp.EmployeeID AND T1.AbsentDate = Temp.AbsentDate) '
	SET @sWhere2 = 'AND EXISTS (SELECT TOP 1 1 FROM #EmployeeList_HP2503 Temp WHERE T3.EmployeeID = Temp.EmployeeID) '
END

SET @sSQL = 'SELECT TOP 1 1
      FROM '+@TableHT2401+' T1 WITH (NOLOCK)
	  INNER JOIN '+@TableHT2400+' T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID 
	  AND T1.TranMonth+T1.Tranyear*100 = T2.TranMonth+T2.Tranyear*100
      WHERE T1.TranMonth= '+STR(@TranMonth)+'
      AND T1.TranYear= '+STR(@TranYear)+'
      AND T1.DivisionID = '''+@DivisionID+'''
      AND T1.DepartmentID BETWEEN '''+ISNULL(@FromDepartmentID,'')+''' AND '''+ISNULL(@ToDepartmentID,'')+'''
	  AND ISNULL(T1.TeamID,'''') LIKE '''+ISNULL(@TeamID,'%')+'''
	  AND ISNULL(T2.Ana04ID,'''') LIKE '''+ISNULL(@SectionID,'%')+'''
	  AND ISNULL(T2.Ana05ID,'''') LIKE '''+ISNULL(@ProcessID,'%')+'''
      AND EXISTS (SELECT TOP 1 1 FROM '+@TableHT2402+' T3 WITH (NOLOCK) inner join HT1013 WITH (NOLOCK) on T3.AbsentTypeID = HT1013.ParentID
				  where T3.TranMonth= '+STR(@TranMonth)+' And T3.TranYear = '+STR(@TranYear)+'
				  And HT1013.DivisionID = '''+@DivisionID+'''
				  And T3.DepartmentID BETWEEN '''+ISNULL(@FromDepartmentID,'')+''' AND '''+ISNULL(@ToDepartmentID,'')+'''
				  AND ISNULL(T3.TeamID,'''') LIKE '''+ISNULL(@TeamID,'%')+'''
				  '+@sWhere2+') 
	  '+@sWhere+'
	  '+@sWhere1+''

--PRINT(@sSQL)
EXEC(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
