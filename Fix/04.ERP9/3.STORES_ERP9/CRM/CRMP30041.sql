IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
----In báo cáo Tổng hợp giá trị cơ hội theo giai đoạn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 27/06/2017
--- Modify by Thị Phượng, Date 04/07/2017: Bổ sung phân quyền
--- Modify by Anh Đô, Date 31/10/2022: Chỉnh sửa điều kiện lọc
-- <Example>
----    EXEC CRMP30041 'AS','',0,'2017-01-03 00:00:00','2017-06-30 00:00:00','06/2017','','','','', 'ASOFTADMIN', 'PHUONG'', ''QUI'', ''QUYNH'', ''VU'
CREATE PROCEDURE [dbo].[CRMP30041] ( 
        @DivisionID					VARCHAR(50),		--Biến môi trường
		@DivisionIDList				NVARCHAR(2000),		--Chọn trong DropdownChecklist DivisionID
		@IsDate						TINYINT,			--1: Theo ngày; 0: Theo kỳ
		@FromDate					DATETIME,
		@ToDate						DATETIME,
		@PeriodIDList				NVARCHAR(2000),
		@EmployeeID					NVARCHAR(MAX),
		@StageID					NVARCHAR(MAX),
		@UserID						VARCHAR(50),
		@ConditionOpportunityID		nvarchar(max),
		@FromStageID				NVarchar(50) = '',
		@ToStageID					NVarchar(50) = '',
		@FromEmployeeID				NVarchar(50) = '',
		@ToEmployeeID				NVarchar(50) = ''
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere2 Nvarchar(Max),
		@sWhere3 Nvarchar(Max),
		@Columns Nvarchar(Max),
@cols NVARCHAR(Max)

SET @sWhere2 = ''
SET @sWhere3 = ''
--Search theo điều điện thời gian
	IF @IsDate = 1	
	Begin
		SET @sWhere = ' AND (CONVERT(VARCHAR(10),CR01.CreateDate,112) BETWEEN'''+ CONVERT(VARCHAR(20),@FromDate,112)+''' AND''' + CONVERT(VARCHAR(20),@ToDate,112) +''')'
	End
	ELSE
	Begin
		SET @sWhere = ' AND (Case When  Month(CR01.CreateDate) <10 then ''0''+rtrim(ltrim(str(Month(CR01.CreateDate))))+''/''+ltrim(Rtrim(str(Year(CR01.CreateDate)))) 
										Else rtrim(ltrim(str(Month(CR01.CreateDate))))+''/''+ltrim(Rtrim(str(Year(CR01.CreateDate)))) End) IN ('''+@PeriodIDList+''')'
		End

--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere2 =@sWhere2+ ' (CR01.DivisionID = '''+ @DivisionID+''' Or CR01.IsCommon =1)'
	Else 
		SET @sWhere2 = @sWhere2+ ' (CR01.DivisionID IN ('''+@DivisionIDList+''') Or CR01.IsCommon =1)'

	IF ((Isnull(@FromStageID, '') !='')and (Isnull(@ToStageID, '') !=''))
		SET @sWhere3 = @sWhere3 +' AND (CR01.StageID between N'''+@FromStageID+''' and N'''+@ToStageID+''') '
	IF ((Isnull(@FromStageID, '') !='')and (Isnull(@ToStageID, '') =''))
		SET @sWhere3 = @sWhere3 +'AND cast(CR01.StageID as Nvarchar(50)) >= N'''+cast(@FromStageID as Nvarchar(50))+''''
	IF ((Isnull(@FromStageID, '') ='')and (Isnull(@ToStageID, '') !=''))
		SET @sWhere3 = @sWhere3 +'AND cast(CR01.StageID as Nvarchar(50)) <= N'''+cast(@ToStageID as Nvarchar(50))+'''' 
	IF ISNULL(@StageID, '') != ''
		SET @sWhere3 = @sWhere3 + ' AND ISNULL(CR01.StageID, '''') IN ('''+ @StageID +''')'
	
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND (CR01.AssignedToUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
	IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') =''))
		SET @sWhere2 = @sWhere2 +'AND cast(CR01.AssignedToUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
	IF ((Isnull(@FromEmployeeID, '') ='')and (Isnull(@ToEmployeeID, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND cast(CR01.AssignedToUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''
	IF ISNULL(@EmployeeID, '') != ''
		SET @sWhere2 = @sWhere2 + ' AND CAST(CR01.AssignedToUserID AS NVARCHAR(50)) IN (SELECT Value FROM [dbo].StringSplit('''+ @EmployeeID +''', '',''))'

	IF Isnull(@ConditionOpportunityID, '') != ''
		SET @sWhere2 = @sWhere2 + ' AND ISNULL(CR01.AssignedToUserID,CR01.CreateUserID) in (N'''+@ConditionOpportunityID+''' )'

---Load danh sách cơ hội theo giai đoạn	
SET @sSQL ='	Select CR01.DivisionID, AT01.DivisionName, CR01.AssignedToUserID as EmployeeID, AT03.FullName as EmployeeName
				, count(CR01.OpportunityID) Quantity
				, isnull(sum(CR01.ExpectAmount),0) as [Values]

				From CRMT20501 CR01 With (NOLOCK)
				Left join AT1103 AT03 With (NOLOCK) On CR01.AssignedToUserID = AT03.EmployeeID
				Left join CRMT10401 CR02 With (NOLOCK) On CR01.StageID = CR02.StageID
				Left join CRMT10801 CR03 With (NOLOCK) On CR01.NextActionID = CR03.NextActionID
				Left join AT1101 AT01 With (NOLOCK) On AT01.DivisionID = CR01.DivisionID
				Where   '+@sWhere2+ @swhere3+ @sWhere+'
				Group By CR01.DivisionID, AT01.DivisionName, CR01.AssignedToUserID, AT03.FullName 
				Order by CR01.AssignedToUserID	'
					

EXEC (@sSQL)
--print (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
