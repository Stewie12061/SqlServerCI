IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP2440_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2440_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--Create by: Dang Le Bao Quynh; Date: 03/11/2006
--Purpose: Cap nhat he so tham nien vao ho so luong
--- Modify on 04/12/2013 by Bảo Anh: Cập nhật hệ số thâm niên cho phụ cấp công trình
--- Modify on 06/01/2014 by Bảo Anh: Cập nhật hệ số thâm niên = 0 nếu chức vụ khác CN (customize Unicare)
/********************************************
'* Edited by: [GS] [Thành Nguyên] [02/08/2010]
'********************************************/
--- Modify on 02/03/2016 by Phương Thảo: Bổ sung tách bảng nghiệp vụ

CREATE PROCEDURE [dbo].[HP2440_MK]
		@MethodID		nvarchar(50),
		@DivisionID 		nvarchar(50),
		@DepartmentID 	nvarchar(50),
		@TeamID		nvarchar(50),
		@EmployeeID		nvarchar(50),
		@TranMonth		int,
		@TranYear		int
AS

DECLARE	@Cur			Cursor,
		@EmployeeIDcur	nvarchar(50),
		@SeniorityOfDate 	int,
		@SeniorityOfMonth	int,
		@CalDate 		Datetime,
		@sSQL AS nvarchar(4000),
		@TableHT2400 Varchar(50),
		@sTranMonth Varchar(2)

---- Tách bảng
SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END
IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT @TableHT2400 = 'HT2400'
END

Set @CalDate = (Select Top 1 EndDate From HT9999 Where TranMonth = @TranMonth and TranYear = @TranYear and DivisionID=@DivisionID)
-- Neu du lieu rong thi gan = ngay cuoi thang
If @Caldate is null
Begin
	Set @Caldate = 	Case  
			When @TranMonth In (1,3,5,7,8,10,12) then ltrim(@TranMonth) + '/31/' + ltrim(@TranYear)
			When @TranMonth In (4,6,9,11) then ltrim(@TranMonth) + '/30/' + ltrim(@TranYear)
			When @TranMonth = 2 And @TranYear%4=0 then ltrim(@TranMonth) + '/29/' + ltrim(@TranYear)
			Else ltrim(@TranMonth) + '/28/' + ltrim(@TranYear) End
		
End
	
SELECT @Caldate = CASE WHEN Convert(Date,@Caldate) =  Convert(Date,DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@Caldate)+1,0))) THEN @Caldate + 1 ELSE @Caldate END
	

if exists (Select Top 1 MethodID From HT1140 Where DivisionID = @DivisionID) And @MethodID is not null And Len(@MethodID)>0
begin 			
	SET @sSQL = N'
	Update T24 Set  
	TimeCoefficient = 
	(Case When Not Exists
				(Select * From HT1141 Where FromMonth <= TotalMonths and ToMonth > TotalMonths And MethodID = '''+@MethodID+''' and DivisionID = '''+@DivisionID+''')
						Then 
							isnull((Select Top 1 Coefficient 
									From HT1141 
									Where DivisionID = '''+@DivisionID+''' 
									and FromMonth <= TotalMonths and Tomonth=-1 And MethodID = '''+@MethodID+''' and DivisionID = '''+@DivisionID+'''),0)
						Else
							isnull((Select Top 1 Coefficient 
									From HT1141 
									Where DivisionID = '''+@DivisionID+''' and FromMonth <= TotalMonths and ToMonth > TotalMonths 
									And MethodID = '''+@MethodID+''' and DivisionID = '''+@DivisionID+'''),0)
						End)
	From '+@TableHT2400+'  T24
	Inner join (
	SELECT	DivisionID, EmployeeID, 
			case when DATEPART(D,'''+Convert(Varchar(20),@Caldate,101)+''') >=DATEPART(D,Workdate) 
			THEN ( case when DATEPART(M,'''+Convert(Varchar(20),@Caldate,101)+''') = DATEPART(M,Workdate) AND DATEPART(YYYY,'''+Convert(Varchar(20),@Caldate,101)+''') = DATEPART(YYYY,Workdate) 
					THEN 0 ELSE DATEDIFF(M,Workdate,'''+Convert(Varchar(20),@Caldate,101)+''')END )
			ELSE DATEDIFF(M,Workdate,'''+Convert(Varchar(20),@Caldate,101)+''')-1 END AS TotalMonths
	FROM	HT1403 
	WHERE	WorkDate is not null AND DepartmentID like '''+@DepartmentID+''' And IsNull(TeamID,'''') like IsNull('''+@TeamID+''','''')
	) T14 ON T24.EmployeeID = T14.EmployeeID and T24.DivisionID = T14.DivisionID 
	Where T24.DivisionID = '''+@DivisionID+''' 	
	And TranMonth = '+STR(@TranMonth)+' And TranYear = '+STR(@TranYear)+' 
	And T24.DepartmentID like '''+@DepartmentID+''' And IsNull(T24.TeamID,'''') like IsNull('''+@TeamID+''','''')
	And T24.EmployeeID like '''+@EmployeeID+'''
	'
	--Print @sSQL
	EXEC(@sSQL)
end
--- cập nhật cho phụ cấp công trình
Declare @AP4444 Table(CustomerName Int, Export Int)
Declare @CustomerName AS Int
Insert Into @AP4444(CustomerName,Export) EXEC('AP4444')
Select @CustomerName=CustomerName From @AP4444
	
IF @CustomerName in (21,39) --- Unicare
	Update T24 Set  TimeCoefficient = case when T14.DutyID <> 'CN' then 0 else (Case When Not Exists(Select * From HT1141 Where FromMonth <= Round(Datediff(d,T14.Workdate,@Caldate)/30,0) and ToMonth >= Round(Datediff(d,T14.Workdate,@Caldate)/30,0) And MethodID = @MethodID and DivisionID=@DivisionID)
						Then 
							isnull((Select Top 1 Coefficient From HT1141 Where DivisionID=@DivisionID and FromMonth < Round(Datediff(d,T14.Workdate,@Caldate)/30,0) and Tomonth=-1),0)
						Else
							isnull((Select Top 1 Coefficient From HT1141 Where DivisionID=@DivisionID and FromMonth < Round(Datediff(d,T14.Workdate,@Caldate)/30,0) and ToMonth >= Round(Datediff(d,T14.Workdate,@Caldate)/30,0)),0)
						End) end
	From HT2430 T24, HT1403 T14
	Where T24.DivisionID=@DivisionID and T24.EmployeeID = T14.EmployeeID and T24.DivisionID = T14.DivisionID 
	And T24.DepartmentID = T14.DepartmentID And IsNull(T24.TeamID,'') = IsNull(T14.TeamID,'')	
	And TranMonth = @TranMonth And TranYear = @TranYear And T14.WorkDate is not null
	And T24.DepartmentID like @DepartmentID And IsNull(T24.TeamID,'') like IsNull(@TeamID,'')
	And T24.EmployeeID like @EmployeeID
ELSE
		
	Update T24 Set TimeCoefficient = (Case When Not Exists(Select * From HT1141 Where FromMonth <= TotalMonths and ToMonth > TotalMonths And MethodID = @MethodID and DivisionID=@DivisionID)
					Then 
						isnull((Select Top 1 Coefficient From HT1141 Where DivisionID=@DivisionID and FromMonth <= TotalMonths and Tomonth=-1 And MethodID = @MethodID and DivisionID=@DivisionID),0 )
					Else
						isnull((Select Top 1 Coefficient From HT1141 Where DivisionID=@DivisionID and FromMonth <= TotalMonths and ToMonth > TotalMonths And MethodID = @MethodID and DivisionID=@DivisionID),0)
					End)
	From HT2430 T24
	Inner join (
	SELECT	DivisionID, EmployeeID, 
			case when DATEPART(D,@Caldate) >=DATEPART(D,Workdate) 
			THEN ( case when DATEPART(M,@Caldate) = DATEPART(M,Workdate) AND DATEPART(YYYY,@Caldate) = DATEPART(YYYY,Workdate) 
					THEN 0 ELSE DATEDIFF(M,Workdate,@Caldate)END )
			ELSE DATEDIFF(M,Workdate,@Caldate)-1 END AS TotalMonths
	FROM	HT1403 
	WHERE	WorkDate is not null AND DepartmentID like @DepartmentID And IsNull(TeamID,'') like IsNull(@TeamID,'')
	) T14 ON T24.EmployeeID = T14.EmployeeID and T24.DivisionID = T14.DivisionID 
	Where T24.DivisionID=@DivisionID 	
	And TranMonth = @TranMonth And TranYear = @TranYear 
	And T24.DepartmentID like @DepartmentID And IsNull(T24.TeamID,'') like IsNull(@TeamID,'')
	And T24.EmployeeID like @EmployeeID
	
/*Select T24.EmployeeID,Round(Datediff(d,Workdate,@Caldate)/30,0) as SeniorityOfMonth, 
	(Case When Not Exists(Select * From HT1141 Where FromMonth <= Round(Datediff(d,Workdate,@Caldate)/30,0) and ToMonth >= Round(Datediff(d,Workdate,@Caldate)/30,0) And MethodID = @MethodID)
	Then 
		isnull((Select Top 1 Coefficient From HT1141 Where FromMonth < Round(Datediff(d,Workdate,@Caldate)/30,0) and Tomonth=-1),0)
	Else
		isnull((Select Top 1 Coefficient From HT1141 Where FromMonth < Round(Datediff(d,Workdate,@Caldate)/30,0) and ToMonth >= Round(Datediff(d,Workdate,@Caldate)/30,0)),0)
	End) as Coefficient
	From HT2400 T24, HT1403 T14
	Where T24.EmployeeID = T14.EmployeeID And TranMonth = @TranMonth And TranYear = @TranYear And WorkDate is not null
*/




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

