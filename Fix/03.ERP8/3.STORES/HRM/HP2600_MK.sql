IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2600_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2600_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----Modified by Bảo Thy on 05/06/2017: Sửa hiển thị dữ liệu cho những loại công có Disabled = 0
----Modified by Nhựt Trường on 05/07/2023: Điều chỉnh lại cách lấy dữ liệu dựa theo chuẩn.

create PROCEDURE [dbo].[HP2600_MK]  @DivisionID nvarchar(50),  
    @DepartmentID  NVARCHAR(50), 
    @ToDepartmentID nvarchar(50), 
    @TeamID  NVARCHAR(50),  
    @EmployeeID  NVARCHAR(50),  
    @TranMonth int,  
    @TranYear int,  
    @PeriodID  NVARCHAR(50)=Null  
AS  

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

Declare @sSQL nvarchar(max) = '', 
 @sSQL1 nvarchar(max) = '',
 @sSQL2 nvarchar(max) = '',
 @sSQL3 nvarchar(max) = '',
 @sSQL4 nvarchar(max) = '',
 @sSQL5 nvarchar(max) = '',
 @cur cursor,  
 @Column int,
 @Index INT,
 @TextCol VARCHAR(50),
 @AbsentTypeID  NVARCHAR(50),
 @TableHT2400 Varchar(50),
 @TableHT2402 Varchar(50),
 @sTranMonth Varchar(2)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END
  
IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear),
			@TableHT2402 = 'HT2402M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2400 = 'HT2400',
			@TableHT2402 = 'HT2402'
END

Select @Column = 1, @Index = 1, @sSQL = ''   
Set @sSQL = 'Select HT.DivisionID, HT.DepartmentID, HT.TeamID, HT.EmployeeID, FullName, HT.TranMonth, HT.TranYear,(Case When  HT.TranMOnth <10 then ''0''+rtrim(ltrim(str(HT.TranMonth)))+''/''+ltrim(Rtrim(str(HT.TranYear)))   
 Else rtrim(ltrim(str(HT.TranMonth)))+''/''+ltrim(Rtrim(str(HT.TranYear))) End) as MonthYear, Notes, HV.Orders'    

Set @cur = Cursor scroll keyset for  
  Select AbsentTypeID From HT1013 Where IsMonth = 1  and DivisionID = @DivisionID
  and Disabled = 0
  Order by Orders, AbsentTypeID  
Open @cur  
Fetch next from @cur into @AbsentTypeID  
  
While @@Fetch_Status = 0  
Begin 
 
 IF(LEN(@sSQL) < 3500)
 BEGIN
	IF(@Index = @Column)
	BEGIN
		IF(@Column < 10)
			SET @TextCol = right('0' + CONVERT(VARCHAR(50), @Column),2)
		ELSE
			SET @TextCol = CONVERT(VARCHAR(50), @Column)
		SET @sSQL = @sSQL + N'
		, sum(case when AbsentTypeID = ''' + @AbsentTypeID +  
		  ''' then AbsentAmount else NULL end) as C' + @TextCol
	
		SET @Index = @Index + 1
	END
 END
IF (LEN(@sSQL) > 3500 AND LEN(@sSQL1) < 3500)
 BEGIN
	IF(@Index = @Column)
	BEGIN
		IF(@Column < 10)
			SET @TextCol = right('0' + CONVERT(VARCHAR(50), @Column),2)
		ELSE
			SET @TextCol = CONVERT(VARCHAR(50), @Column)
		SET @sSQL1 = @sSQL1 + N'
		, sum(case when AbsentTypeID = ''' + @AbsentTypeID +  
		  ''' then AbsentAmount else NULL end) as C' + @TextCol
	
		SET @Index = @Index + 1
	END
 END
IF (LEN(@sSQL) > 3500 AND LEN(@sSQL1) > 3500 AND LEN(@sSQL2) < 3500)
 BEGIN
	IF(@Index = @Column)
	BEGIN
		IF(@Column < 10)
			SET @TextCol = right('0' + CONVERT(VARCHAR(50), @Column),2)
		ELSE
			SET @TextCol = CONVERT(VARCHAR(50), @Column)
		SET @sSQL2 = @sSQL2 + N'
		, sum(case when AbsentTypeID = ''' + @AbsentTypeID +  
		  ''' then AbsentAmount else NULL end) as C' + @TextCol
	
		SET @Index = @Index + 1
	END
 END
IF (LEN(@sSQL) > 3500 AND LEN(@sSQL1) > 3500 AND LEN(@sSQL2) > 3500 AND LEN(@sSQL3) < 3500)
 BEGIN
	IF(@Index = @Column)
	BEGIN
		IF(@Column < 10)
			SET @TextCol = right('0' + CONVERT(VARCHAR(50), @Column),2)
		ELSE
			SET @TextCol = CONVERT(VARCHAR(50), @Column)
		SET @sSQL3 = @sSQL3 + N'
		, sum(case when AbsentTypeID = ''' + @AbsentTypeID +  
		  ''' then AbsentAmount else NULL end) as C' + @TextCol
	
		SET @Index = @Index + 1
	END
 END
IF (LEN(@sSQL) > 3500 AND LEN(@sSQL1) > 3500 AND LEN(@sSQL2) > 3500 AND LEN(@sSQL3) > 3500 AND LEN(@sSQL4) < 3500)
 BEGIN
	IF(@Index = @Column)
	BEGIN
		IF(@Column < 10)
			SET @TextCol = right('0' + CONVERT(VARCHAR(50), @Column),2)
		ELSE
			SET @TextCol = CONVERT(VARCHAR(50), @Column)
		SET @sSQL4 = @sSQL4 + N'
		, sum(case when AbsentTypeID = ''' + @AbsentTypeID +  
		  ''' then AbsentAmount else NULL end) as C' + @TextCol
	
		SET @Index = @Index + 1
	END
 END
IF (LEN(@sSQL) > 3500 AND LEN(@sSQL1) > 3500 AND LEN(@sSQL2) > 3500 AND LEN(@sSQL3) > 3500 AND LEN(@sSQL4) > 3500 AND LEN(@sSQL5) < 3500)
 BEGIN
	IF(@Index = @Column)
	BEGIN
		IF(@Column < 10)
			SET @TextCol = right('0' + CONVERT(VARCHAR(50), @Column),2)
		ELSE
			SET @TextCol = CONVERT(VARCHAR(50), @Column)
		SET @sSQL5 = @sSQL5 + N'
		, sum(case when AbsentTypeID = ''' + @AbsentTypeID +  
		  ''' then AbsentAmount else NULL end) as C' + @TextCol
	
		SET @Index = @Index + 1
	END
 END

 Set @Column = @Column + 1  
 
 Fetch next from @cur into @AbsentTypeID  
End

IF @PeriodID is Null 
BEGIN
 Set @sSQL5 = @sSQL5 + N'
   From '+@TableHT2400+' HT
   LEFT JOIN '+@TableHT2402+' HT02 ON HT.EmployeeID=HT02.EmployeeID  
      and HT.DivisionID=HT02.DivisionID and HT.DepartmentID=HT02.DepartmentID  
      and IsNull(HT.TeamID,'''')=ISNull(HT02.TeamID,'''') and HT.EmployeeID=HT02.EmployeeID and  
      HT.TranMonth=HT02.TranMonth and HT.TranYear=HT02.TranYear  
      left join HV1400 HV on HT.EmployeeID = HV.EmployeeID and HT.DivisionID=HV.DivisionID  
   Where HT.DivisionID = ''' + @DivisionID + ''' and  
    HT.DepartmentID between ''' + @DepartmentID + ''' and  ''' + @ToDepartmentID + ''' and   
    isnull(HT.TeamID, '''') like isnull(''' + @TeamID + ''', '''')  and   
    HT.EmployeeID like ''' + @EmployeeID + '''  and  
    HT.TranMonth = ' + cast(@TranMonth as nvarchar(2)) + ' and  
    HT.TranYear = ' + cast(@TranYear as nvarchar(40)) + ' and
    HT02.PeriodID like ''' + @PeriodID + '''  
   Group by  HT.DivisionID, HT.DepartmentID, HT.TeamID, HT.EmployeeID, FullName, HT.TranMonth, HT.TranYear, Notes, HV.Orders'  
END
ELSE
BEGIN
 Set @sSQL5 = @sSQL5 + N'
   From '+@TableHT2400+' HT
   LEFT JOIN '+@TableHT2402+' HT02 ON HT.EmployeeID=HT02.EmployeeID  
      and HT.DivisionID=HT02.DivisionID and HT.DepartmentID=HT02.DepartmentID  
      and IsNull(HT.TeamID,'''')=ISNull(HT02.TeamID,'''') and HT.EmployeeID=HT02.EmployeeID and  
      HT.TranMonth=HT02.TranMonth and HT.TranYear=HT02.TranYear  
      left join HV1400 HV on HT.EmployeeID = HV.EmployeeID and HT.DivisionID=HV.DivisionID  
   Where HT.DivisionID = ''' + @DivisionID + ''' and   
    HT.DepartmentID between ''' + @DepartmentID + ''' and  ''' + @ToDepartmentID + ''' and     
    isnull(HT.TeamID, '''') like isnull(''' + @TeamID + ''', '''')  and   
    HT.EmployeeID like ''' + @EmployeeID + '''  and   
    HT.TranMonth = ' + cast(@TranMonth as nvarchar(2)) + ' and   
    HT.TranYear = ' + cast(@TranYear as nvarchar(40)) + ' and   
    HT02.PeriodID like ''' + @PeriodID + '''   
   Group by  HT.DivisionID, HT.DepartmentID, HT.TeamID, HT.EmployeeID, FullName, HT.TranMonth, HT.TranYear, Notes, HV.Orders'  
END

PRINT @sSQL 
PRINT @sSQL1 
PRINT @sSQL2 
PRINT @sSQL3
PRINT @sSQL4
PRINT @sSQL5
IF not  exists(Select  1 From sysObjects Where XType = 'V' and Name = 'HV2600')   
 EXEC('Create view HV2600 ---tao boi HP2600_MK  
  as ' + @sSQL + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sSQL5)  
ELSE  
 EXEC('Alter view HV2600 ---tao boi HP2600_MK  
  as ' + @sSQL + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sSQL5)  
    
Close @cur

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
