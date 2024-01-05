IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP3014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP3014]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
----So sánh cơ hội giữa các kỳ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Đạt on 01/03/2018
-- <Example>
----    EXEC CRMP3014 'AS','','08/2017'

Create PROCEDURE [dbo].[CRMP3014] ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID		
		@PeriodIDList	NVARCHAR(2000)
)
AS

DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere Nvarchar(Max),
		@sWhere2  Nvarchar(Max)
SET @sWhere = ''
SET @sWhere2 = ''

	Begin
		SET @sWhere = ' AND (Case When  Month(A.CreateDate) <10 then ''0''+rtrim(ltrim(str(Month(A.CreateDate))))+''/''+ltrim(Rtrim(str(Year(A.CreateDate)))) 
										Else rtrim(ltrim(str(Month(A.CreateDate))))+''/''+ltrim(Rtrim(str(Year(A.CreateDate)))) End) IN ('''+@PeriodIDList+''')'
	End


--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere2 =@sWhere2+ ' (A.DivisionID = '''+ @DivisionID+''' or A.IsCommon =1) '
	Else 
		SET @sWhere2 = @sWhere2+ ' (A.DivisionID IN ('''+@DivisionIDList+''') or A.IsCommon =1)'
	
---Load danh sách 
SET @sSQL =
	' 
Select Sum(A.TotalOpportunity)as TotalOpportunity , SUM(A.TotalExpectAmount)as TotalExpectAmount, SUM(A.TotalOpportunityWin)as TotalOpportunityWin, SUM(A.TotalExpectAmountWin)as TotalExpectAmountWin,  A.DivisionID,A.AssignedToUserID, A1.FullName
From(
	Select Count(OpportunityID) as TotalOpportunity , 0 as TotalExpectAmount, 0 as TotalOpportunityWin, 0 as TotalExpectAmountWin, CreateDate, AssignedToUserID, DivisionID, isCommon
	From CRMT20501 
	Group by CreateDate, AssignedToUserID, DivisionID, isCommon
	Union all
	Select 0 as TotalOpportunity , Sum(ExpectAmount) as TotalExpectAmount, 0 as TotalOpportunityWin, 0 as TotalExpectAmountWin, CreateDate, AssignedToUserID, DivisionID, isCommon
	From CRMT20501 
	Group by CreateDate, AssignedToUserID, DivisionID, isCommon
	Union all
	Select 0 as TotalOpportunity , 0 as TotalExpectAmount, Count(OpportunityID) as TotalOpportunityWin, 0 as TotalExpectAmountWin, CreateDate, AssignedToUserID, DivisionID, isCommon
	From CRMT20501 
	Where StageID like ''Win''
	Group by CreateDate, AssignedToUserID, DivisionID, isCommon
	Union all
	Select 0 as TotalOpportunity , 0 as TotalExpectAmount, 0 as TotalOpportunityWin, Sum(ExpectAmount) as TotalExpectAmountWin, CreateDate, AssignedToUserID, DivisionID, isCommon
	From CRMT20501 
	Where StageID like ''Win''
	Group by CreateDate, AssignedToUserID, DivisionID, isCommon)A
Left join AT1103 A1 on A1.EmployeeID = A.AssignedToUserID
Where   '+@sWhere2+ @swhere+'
Group by A.AssignedToUserID, A.DivisionID, A1.FullName
	'
EXEC (@sSQL)
GO
