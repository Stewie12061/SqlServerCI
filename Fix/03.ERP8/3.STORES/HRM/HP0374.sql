IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0374]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0374]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by: Tiểu Mai
---- Date: 08/03/2016
---- Purpose: Load dữ liệu màn hình truy vấn đề nghị ký hợp đồng (Angel)

--- EXEC HP0374 'TH', 3, 2016, 3, 2016, '03/01/2016', '03/30/2016', 0, 1, '%'

CREATE PROCEDURE [dbo].[HP0374]    
					@DivisionID nvarchar(50),
				    @FromMonth int,
	  			    @FromYear int,
				    @ToMonth int,
				    @ToYear int,  
				    @FromDate as datetime,
				    @ToDate as Datetime,
				    @IsDate as tinyint, ----0 theo kỳ, 1 theo ngày
				    @StatusSuggestID INT,
				    @EmployeeID NVARCHAR(50)
	
AS
Declare
 @sSQL as varchar(max),
 @sWhere  as nvarchar(4000)
 
IF @IsDate = 0
	Set  @sWhere = 'AND (HT0374.TranMonth + HT0374.TranYear*100 BETWEEN ' + cast(@FromMonth + @FromYear*100 as nvarchar(50)) + ' AND ' +  cast(@ToMonth + @ToYear*100 as nvarchar(50))  + ')'
else
	Set  @sWhere = 'AND (HT0374.SuggestDate BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''')'


Set  @sSQL = '
		SELECT HT0374.*, HT0375.EmployeeID AS EmployeeID1,
		Ltrim(RTrim(isnull(HT01.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT01.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT01.FirstName,''''))) AS EmployeeName,
		Ltrim(RTrim(isnull(HT02.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT02.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT02.FirstName,''''))) AS EmployeeName1
		FROM HT0374 WITH (NOLOCK)
		LEFT JOIN HT0375 WITH (NOLOCK) ON HT0375.DivisionID = HT0374.DivisionID AND HT0374.SuggestID = HT0375.SuggestID
		LEFT JOIN HT1400 HT01 WITH (NOLOCK) ON HT01.DivisionID = HT0374.DivisionID AND HT0374.EmployeeID = HT01.EmployeeID
		LEFT JOIN HT1400 HT02 WITH (NOLOCK) ON HT02.DivisionID = HT0375.DivisionID AND HT0375.EmployeeID = HT02.EmployeeID
		WHERE HT0374.DivisionID = '''+@DivisionID+'''
			AND HT0375.StatusSuggest = '+CONVERT(NVARCHAR(5),@StatusSuggestID)+'
			AND HT0374.EmployeeID LIKE '''+@EmployeeID+'''
		'+@sWhere
		
PRINT @sSQL	
EXEC(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
