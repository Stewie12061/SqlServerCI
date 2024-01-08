IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP3013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP3013]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
----In báo cáo Thời gian xử lý yêu cầu theo nhân viên		
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Đạt on 01/03/2018
-- <Example>
----    EXEC CRMP3013 'AS','',1,'2017-01-03 00:00:00','2018-03-01 00:00:00','', '','','001'

Create PROCEDURE [dbo].[CRMP3013] ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate	TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@PeriodIDList NVARCHAR(2000),
		@FromEmployeeID NVarchar(50),
		@ToEmployeeID NVarchar(50),
		@ProjectID NVarchar(50)
)
AS

DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere Nvarchar(Max),
		@sWhere2  Nvarchar(Max)
SET @sWhere = ''
SET @sWhere2 = ''
IF @IsDate = 1	
	Begin
		SET @sWhere = ' AND (CONVERT(VARCHAR(10),C.CreateDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
	End
	ELSE
	Begin
		SET @sWhere = ' AND (Case When  Month(C.CreateDate) <10 then ''0''+rtrim(ltrim(str(Month(C.CreateDate))))+''/''+ltrim(Rtrim(str(Year(C.CreateDate)))) 
										Else rtrim(ltrim(str(Month(C.CreateDate))))+''/''+ltrim(Rtrim(str(Year(C.CreateDate)))) End) IN ('''+@PeriodIDList+''')'
	End


--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere2 =@sWhere2+ ' (C.DivisionID = '''+ @DivisionID+''' or A.IsCommon =1) '
	Else 
		SET @sWhere2 = @sWhere2+ ' (C.DivisionID IN ('''+@DivisionIDList+''') or A.IsCommon =1)'
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND (C.AssignedToUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') =''))
		SET @sWhere2 = @sWhere2 +'AND cast(C.AssignedToUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
	IF ((Isnull(@FromEmployeeID, '') ='')and (Isnull(@ToEmployeeID, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND cast(C.AssignedToUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''
	IF Isnull(@ProjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(C.ProjectID,'''') LIKE N''%'+@ProjectID+'%'' '

---Load danh sách 
SET @sSQL =
	' 
	  Select C.RequestID ,C.RequestSubject
			, C.AssignedToUserID as EmployeeID, A.FullName as EmployeeName
			, C2.AccountID, C2.AccountName
			, C.DeadlineRequest, C.CompleteDate, C.DurationTime, C.RealTime
			, C.ProjectID, A1.AnaName as ProjectName
	  From CRMT20801 C With (NOLOCK)
	  Inner Join CRMT20801_CRMT10101_REL C1 With (NOLOCK) on C.RequestID = C1.RequestID
	  Left Join CRMT10101 C2 With (NOLOCK) On C2.AccountID = C1.AccountID		  
	  Left Join AT1103 A With (NOLOCK) On A.EmployeeID = C.AssignedToUserID 
	  Left join AT1015 A1 With (Nolock) On A1.AnaID = C.ProjectID   	  
	  Where   '+@sWhere2+@sWhere+'
	  Group by C.RequestID ,C.RequestSubject
			, C.AssignedToUserID, A.FullName
			, C2.AccountID, C2.AccountName
			, C.DeadlineRequest, C.CompleteDate, C.DurationTime, C.RealTime
			, C.ProjectID, A1.AnaName
		
	'
EXEC (@sSQL)
GO
