IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2499_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2499_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Modify on 04/08/2013 by Bao Anh: BO sung DivisionID
--- Modify on 04/08/2013 by To Oanh: Bổ sung TeamID, TeamName cho report HR2490
--- Modify on 08/10/2013 by To Oanh: sửa lỗi bị trùng dữ liệu do teamName giống nhau (Report HR2490)

CREATE Procedure [dbo].[HP2499_MK] @DivisionID nvarchar(50),
						@FromDepartmentID nvarchar(50),
						@ToDepartmentID	nvarchar(50),
						@TeamID nvarchar(50),
						@EmployeeID nvarchar(50),
						@FromTranMonth int,
						@FromTranYear int,
						@ToTranMonth int,
						@ToTranYear int,
						@lstOfAbsent nvarchar(250),
						@ReportID nvarchar(50)

AS
						
Declare @SQL as nvarchar(MAX)

--Xu ly cho report HR2490						
Declare @FromDate as Datetime, 
		@ToDate as Datetime,
		@ProcessDate as Datetime,
		@D as tinyint,
		@TableHT2400 Varchar(50),
		@TableHT2401 Varchar(50),
		@TableHT2402 Varchar(50),
		@sTranMonth Varchar(2)
		
Select @FromDate = BeginDate, @ToDate = EndDate
From HT9999 Where DivisionID = @DivisionID And TranMonth = @FromTranMonth And TranYear = @FromTranYear 
Set @ProcessDate = @FromDate
Set @D = 1

SELECT @sTranMonth = CASE WHEN @FromTranMonth >9 THEN Convert(Varchar(2),@FromTranMonth) ELSE '0'+Convert(Varchar(1),@FromTranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	IF(@FromTranMonth = @ToTranMonth and @FromTranYear = @ToTranYear)
	BEGIN
		SELECT  @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@FromTranYear),
				@TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),@FromTranYear),
				@TableHT2402 = 'HT2402M'+@sTranMonth+Convert(Varchar(4),@FromTranYear)
	END
	ELSE
	IF(@FromTranMonth <> @ToTranMonth and @FromTranYear = @ToTranYear)
	BEGIN
		SELECT  @TableHT2400 = 'HT2400Y'+Convert(Varchar(4),@FromTranYear),
				@TableHT2401 = 'HT2401Y'+Convert(Varchar(4),@FromTranYear),
				@TableHT2402 = 'HT2402Y'+Convert(Varchar(4),@FromTranYear)
	END
	ELSE
		SELECT  @TableHT2400 = 'HT2400',
				@TableHT2401 = 'HT2401',
				@TableHT2402 = 'HT2402'
END
ELSE
BEGIN
		SELECT  @TableHT2400 = 'HT2400',
				@TableHT2401 = 'HT2401',
				@TableHT2402 = 'HT2402'
END


If @ReportID = 'HR2490'
Begin
	SET @SQL = 'Select H01.DivisionID, H01.DepartmentID, A02.DepartmentName, H01.TeamID, H11.TeamName, H01.EmployeeID, H00.LastName,  H00.MiddleName,  H00.FirstName, H01.AbsentTypeID, H13.Caption As AbsentName, '
	While @ProcessDate <= @ToDate
	Begin
		Set @SQL = @SQL + '''' + ltrim(day(@ProcessDate)) + '/' + ltrim(month(@ProcessDate)) + ''' As C' + LTRIM(@D) + ', 
		Sum((Case When H01.AbsentDate = ''' + ltrim(@ProcessDate) + ''' Then H01.AbsentAmount Else 0 End)) As D' + LTRIM(@D) + ',
		'
		Set @ProcessDate = DATEADD(D,1,@ProcessDate)
		Set @D = @D + 1
	End
	--Xu ly cac thang co 28,29,30 ngay
	While @D <= 31
	Begin
		Set @SQL = @SQL + '''Z'' As C' + LTRIM(@D) + ', 
		0 As D' + LTRIM(@D) + ','
		Set @D = @D + 1
	End

	SET @SQL = @SQL + ' Null As Notes
	From '+@TableHT2401+' H01 Inner Join HT1400 H00
			On H01.DivisionID = H00.DivisionID And H01.EmployeeID = H00.EmployeeID
	Left join AT1102 A02 
			On A02.DivisionID = H01.DivisionID and A02.DepartmentID = H01.DepartmentID
	Left join HT1013 H13
			On H01.AbsentTypeID = H13.AbsentTypeID And H13.IsMonth = 0
	Left join HT1101 H11  
			On H01.TeamID = H11.TeamID and H01.Departmentid = H11.DepartmentID    		  
	Where	H01.DivisionID = ''' + @DivisionID + '''  
			And H01.TranMonth + H01.TranYear*12 = ' + Ltrim(@FromTranMonth + @FromTranYear*12) + ' 
			And (H01.DepartmentID Between ''' + @FromDepartmentID + ''' And ''' + @ToDepartmentID + ''')  
			And (ISNULL(H01.TeamID,'''') Like ''' + @TeamID + ''') 
			And H01.EmployeeID Like ''' + @EmployeeID + '''' + 
			Case When @lstOfAbsent<>'%' Then '
			And H01.AbsentTypeID In (''' + Replace(@lstOfAbsent,',',''',''') + ''')' Else '' End + ' 
	Group By H01.DivisionID, H01.DepartmentID, A02.DepartmentName, H01.TeamID, H11.TeamName, H01.EmployeeID, H00.LastName,  H00.MiddleName,  H00.FirstName, H01.AbsentTypeID, H13.Caption'
	
	
	If exists (Select Top 1 1 From SysObjects Where id = OBJECT_ID('HV2495') And XTYPE='V')
	Drop View HV2495
	
	EXEC ('Create View HV2495 --Create By HP2499_MK
			As ' + @SQL)

End

--Xu ly cho report HR2497
Declare @curHR2497 as cursor,
		@AbsentTypeID as nvarchar(50)
If @ReportID = 'HR2497'
Begin
	SET @SQL = 'Select  H02.DepartmentID, A02.DepartmentName,  H02.EmployeeID, H00.LastName,  H00.MiddleName,  H00.FirstName, '
	
	Set @curHR2497 = cursor static for
	Select AbsentTypeID From HT1013 Where IsMonth=1 Order By AbsentTypeID
	
	Open @curHR2497
	Fetch Next From @curHR2497 Into @AbsentTypeID
	While @@FETCH_STATUS = 0
	Begin
		Set @SQL = @SQL + ' Sum((Case When H02.AbsentTypeID = ''' + @AbsentTypeID + ''' Then H02.AbsentAmount Else 0 End)) As [' + replace(@AbsentTypeID,'.','_') + '],
		'
		Fetch Next From @curHR2497 Into @AbsentTypeID
	End
	
	SET @SQL = @SQL + ' (Select Top 1 Notes01 From '+@TableHT2400+' HT24 
	Where HT24.DivisionID = H02.DivisionID 
	And HT24.DepartmentID = H02.DepartmentID 
	And HT24.EmployeeID = H02.EmployeeID 
	And HT24.TranMonth + 12*HT24.TranYear = ' + Ltrim(@FromTranMonth + @FromTranYear*12) + ') As Notes
	From '+@TableHT2402+' H02 Inner Join HT1400 H00
			On H02.DivisionID = H00.DivisionID And H02.EmployeeID = H00.EmployeeID
	Left join AT1102 A02 
			On A02.DivisionID = H02.DivisionID and A02.DepartmentID = H02.DepartmentID
	Where	H02.DivisionID = ''' + @DivisionID + '''  
			And H02.TranMonth + H02.TranYear*12 = ' + Ltrim(@FromTranMonth + @FromTranYear*12) + ' 
			And (H02.DepartmentID Between ''' + @FromDepartmentID + ''' And ''' + @ToDepartmentID + ''')  
			And (ISNULL(H02.TeamID,'''') Like ''' + @TeamID + ''') 
			And H02.EmployeeID Like ''' + @EmployeeID + '''
	Group By H02.DepartmentID, A02.DepartmentName, H02.EmployeeID, H00.LastName,  H00.MiddleName,  H00.FirstName '
	
	If exists (Select Top 1 1 From SysObjects Where id = OBJECT_ID('HV2497') And XTYPE='V')
	Drop View HV2497
	
	EXEC ('Create View HV2497 --Create By HP2497
			As ' + @SQL)

End


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
