IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP3016]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP3016]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
----In báo cáo Thống kê ReOpen HeplDesk
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Đạt on 05/03/2018
-- <Example>
----    EXEC CRMP3016 'AS','',1,'2018-03-05 11:13:38.527','2018-03-05 11:13:38.527','03/2018', '',''

Create PROCEDURE [dbo].[CRMP3016] ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate	TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@PeriodIDList NVARCHAR(2000),
		@FromEmployeeID NVarchar(50),
		@ToEmployeeID NVarchar(50)	
)
AS

DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere Nvarchar(Max),
		@sWhere2  Nvarchar(Max)
		,@sWhere3  Nvarchar(Max)
SET @sWhere = ''
SET @sWhere2 = ''
SET @sWhere3 = 'AND B.Description like N''%Đang thực hiện <br/>'''
IF @IsDate = 1	
	Begin
		SET @sWhere = ' AND (CONVERT(VARCHAR(10),M.CreateDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
	End
	ELSE
	Begin
		SET @sWhere = ' AND (Case When  Month(M.CreateDate) <10 then ''0''+rtrim(ltrim(str(Month(M.CreateDate))))+''/''+ltrim(Rtrim(str(Year(M.CreateDate)))) 
										Else rtrim(ltrim(str(Month(M.CreateDate))))+''/''+ltrim(Rtrim(str(Year(M.CreateDate)))) End) IN ('''+@PeriodIDList+''')'
	End


--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere2 =@sWhere2+ ' (M.DivisionID = '''+ @DivisionID+''' or A.IsCommon =1) '
	Else 
		SET @sWhere2 = @sWhere2+ ' (M.DivisionID IN ('''+@DivisionIDList+''') or A.IsCommon =1)'
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND (M.AssignedToUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') =''))
		SET @sWhere2 = @sWhere2 +'AND cast(M.AssignedToUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
	IF ((Isnull(@FromEmployeeID, '') ='')and (Isnull(@ToEmployeeID, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND cast(M.AssignedToUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''


---Load danh sách 
SET @sSQL =
	'
	Select M.APK, M.DivisionID
, M.RequestID, M.RequestSubject, M.RelatedToTypeID
, M.DeadlineRequest, M.AssignedToUserID, A.FullName as AssignedToUserName
, stuff(isnull((Select '','' +  D.AccountID From CRMT10101 B WITH (NOLOCK) 
      Left join CRMT20801_CRMT10101_REL D WITH (NOLOCK)  ON D.AccountID = B.APK 
      where D.RequestID = M.RequestID
      Group by D.AccountID
      FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as APKAccountID
, stuff(isnull((Select '','' +  B.AccountID From CRMT10101 B WITH (NOLOCK) 
      Left join CRMT20801_CRMT10101_REL D WITH (NOLOCK)  ON D.AccountID = B.APK 
      where D.RequestID = M.RequestID
      Group by B.AccountID
      FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as AccountID
, stuff(isnull((Select '','' + B.AccountName From CRMT10101 B WITH (NOLOCK) 
 Left join CRMT20801_CRMT10101_REL D WITH (NOLOCK)  ON D.AccountID = B.APK 
 where D.RequestID = M.RequestID
 Group by B.AccountID, B.AccountName
 FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as AccountName
, M.CreateDate, M.RealTime, M.FeedbackDescription, Count(B.APK)-1 as TimeReOpen
From CRMT20801 M With (Nolock)
Left join AT1103 A With (Nolock) On A.EmployeeID = M.AssignedToUserID
Left join CRMT00003 B With (Nolock) On B.RelatedtoID = M.APk
Where   '+@sWhere2+@sWhere+@sWhere3+' 
Group by 
M.APK, M.DivisionID
, M.RequestID, M.RequestSubject, M.RelatedToTypeID
, M.DeadlineRequest, M.AssignedToUserID, A.FullName
, M.CreateDate, M.RealTime, M.FeedbackDescription 
	'
EXEC (@sSQL)
GO
