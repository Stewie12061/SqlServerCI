IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30151]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30151]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
----Báo cáo Thống kê hoạt động khách hàng có phát sinh cơ hội
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga on 30/03/2020
--- Modify by Trọng Kiên, Date 06/10/2020: Fix lỗi liên quan đến Email vì thay đổi cấu trúc (Invalid column RelatedToID)
-- <Example>
----    EXEC CRMP30151 'DTI','DTI',1,'2017-01-01 00:00:00','2017-12-30 00:00:00','07/2017', 'ASOFTADMIN'
CREATE PROCEDURE [dbo].[CRMP30151] ( 
        @DivisionID       VARCHAR(50),  --Biến môi trường
		@DivisionIDList    NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate       DATETIME,
		@ToDate         DATETIME,
		@PeriodIDList	NVARCHAR(2000),
		@UserID  VARCHAR(50),
		@ObjectIDList VARCHAR(MAX) =''
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere2 Nvarchar(Max),
		@Columns Nvarchar(Max)

SET @sWhere2 = ''
--Search theo điều điện thời gian
	IF @IsDate = 1	
	Begin
		SET @sWhere = ' AND (CONVERT(VARCHAR(10),P011.CreateDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
	End
	ELSE
	Begin
		SET @sWhere = ' AND (Case When  Month(P011.CreateDate) <10 then ''0''+rtrim(ltrim(str(Month(P011.CreateDate))))+''/''+ltrim(Rtrim(str(Year(P011.CreateDate)))) 
										Else rtrim(ltrim(str(Month(P011.CreateDate))))+''/''+ltrim(Rtrim(str(Year(P011.CreateDate)))) End) IN ('''+@PeriodIDList+''')'
	End

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere2 =@sWhere2+ ' AND (P011.DivisionID = '''+ @DivisionID+''' Or P011.IsCommon =1)'
	Else 
		SET @sWhere2 = @sWhere2+ ' AND (P011.DivisionID IN ('''+@DivisionIDList+''') Or P011.IsCommon =1)'

 	IF ISNULL(@ObjectIDList,'') <> ''
	    SET @sWhere = @sWhere+ ' AND P011.MemberID IN ('''+@ObjectIDList+''')'

SET @sSQL ='select P011.MemberID, P011.MemberName, D4.FullName as AssignedToUserName
FROM POST0011 P011 with (nolock)
LEFT JOIN AT1103 D4 With (NOLOCK) on P011.AssignedToUserID = D4.EmployeeID and D4.DivisionID = N'''+ @DivisionID+'''
where (--P011.APK IN(select RelatedToID from CMNT90051_REL with (nolock) where RelatedToTypeID_REL = 3)
P011.APK IN(select RelatedToID from CRMT90051_REL with (nolock) where RelatedToTypeID_REL = 3)
OR P011.APK IN(select RelatedToID from CRMT90031_REL with (nolock) where RelatedToTypeID_REL = 3)
OR P011.APK IN(select AccountID from CRMT20501_CRMT10101_REL with (nolock))
OR P011.MemberID IN(select AccountID from CRMT20501 with (nolock) where AccountID is not null))
' +@sWhere2 + @sWhere

--print (@sSQL)
EXEC (@sSQL)
GO
