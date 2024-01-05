IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
----In báo cáo Tổng hợp đầu mối từ các nguồn đầu mối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng on 07/06/2017
--- Modify by Thị Phượng, Date 04/07/2017: Bổ sung phân quyền
--- Modify by Đình Hoà, Date 12/07/2021 : Bổ sung Division load các Nguồn đầu mối của đơn vị đó.
--- Modify by Văn Tài,  Date 19/07/2021 : Điều chỉnh kiểm tra trường hợp Mã nguồn không tồn tại.
--- Modify by Hoài Bảo,  Date 04/07/2022 : Điều chỉnh load dữ liệu theo danh sách nhân viên, nguồn đầu mối đã chọn
--- Modify by Hoài Bảo,  Date 08/07/2022 : Bổ sung kiểm tra không lấy nguồn đầu mối đã disabled
-- <Example>
  /*
   CRMP30011 'AS','AS'',''GS'',''GC',1,'2017-01-03 00:00:00','2017-06-30 00:00:00','01/2017'',''02/2017'',''03/2017'',''04/2017'',''05/2017'',''06/2017','','','',''
, 'ASOFTADMIN','DANH'', ''HOANG'', ''HUYEN'', ''LIEN'', ''LUAN'', ''PHUONG'', ''QUI'', ''QUYNH'', ''VU' 
*/
CREATE PROCEDURE [dbo].[CRMP30011] ( 
        @DivisionID     VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate       DATETIME,
		@ToDate         DATETIME,
		@PeriodIDList	NVARCHAR(2000),
		@EmployeeIDList NVARCHAR(MAX),
		@LeadTypeIDList   NVARCHAR(MAX),
		@UserID			VARCHAR(50),
		@ConditionLeadID NVARCHAR(MAX)
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere2 Nvarchar(Max),
		@sWhere3 Nvarchar(Max),
		@Columns Nvarchar(Max),
@cols NVARCHAR(Max)
Set @Columns =''
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
		SET @sWhere2 =@sWhere2+ ' (CR02.DivisionID = '''+ @DivisionID+''' Or CR02.IsCommon =1)'
	Else 
		SET @sWhere2 = @sWhere2+ ' (CR02.DivisionID IN ('''+@DivisionIDList+''') Or CR02.IsCommon =1)'

	--IF ((Isnull(@FromLeadTypeID, '') !='')and (Isnull(@ToLeadTypeID, '') !=''))
	--	SET @sWhere3 = @sWhere3 +' AND (CR01.LeadTypeID between N'''+@FromLeadTypeID+''' and N'''+@ToLeadTypeID+''') '
	--IF ((Isnull(@FromLeadTypeID, '') !='')and (Isnull(@ToLeadTypeID, '') =''))
	--	SET @sWhere3 = @sWhere3 +'AND cast(CR01.LeadTypeID as Nvarchar(50)) >= N'''+cast(@FromLeadTypeID as Nvarchar(50))+''' '
	--IF ((Isnull(@FromLeadTypeID, '') ='')and (Isnull(@ToLeadTypeID, '') !=''))
	--	SET @sWhere3 = @sWhere3 +'AND cast(CR01.LeadTypeID as Nvarchar(50)) <= N'''+cast(@ToLeadTypeID as Nvarchar(50))+'''' 
	IF ISNULL(@LeadTypeIDList, '') != ''
		SET @sWhere2 = @sWhere2 + ' AND CR01.LeadTypeID IN (SELECT Value FROM [dbo].StringSplit(''' +@LeadTypeIDList+ ''', '','')) '
	
	--IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') !=''))
	--	SET @sWhere2 = @sWhere2 +' AND (CR01.AssignedToUserID between N'''+@FromEmployeeID+''' and N'''+@ToEmployeeID+''')'
	--IF ((Isnull(@FromEmployeeID, '') !='')and (Isnull(@ToEmployeeID, '') =''))
	--	SET @sWhere2 = @sWhere2 +'AND cast(CR01.AssignedToUserID as Nvarchar(50)) >= N'''+cast(@FromEmployeeID as Nvarchar(50))+''''
	--IF ((Isnull(@FromEmployeeID, '') ='')and (Isnull(@ToEmployeeID, '') !=''))
	--	SET @sWhere2 = @sWhere2 +' AND cast(CR01.AssignedToUserID as Nvarchar(50)) <= N'''+cast(@ToEmployeeID as Nvarchar(50))+''''
	--IF Isnull(@ConditionLeadID,'')!=''
	--	SET @sWhere2 = @sWhere2 + ' AND ISNULL(CR01.AssignedToUserID,CR01.CreateUserID) in ('''+@ConditionLeadID+''' )'
	IF ISNULL(@EmployeeIDList, '') != ''
		SET @sWhere3 = @sWhere3 + ' AND CR01.AssignedToUserID IN (SELECT Value FROM [dbo].StringSplit(''' +@EmployeeIDList+ ''', '','')) '

----Chuyển dòng thành cột
	Declare @CRMT20301 table (
							LeadTypeName nvarchar(Max),
							TotalRow int)	
		
		SELECT  LeadTypeName, ROW_NUMBER() OVER (ORDER BY z.LeadTypeID) AS RowNum  Into #CRMT20301 
		FROM 		
		(SELECT case when isnull(CR01.LeadTypeID,'') != '' then CR01.LeadTypeID else 'Other' end LeadTypeID
		, case when isnull(CR01.LeadTypeID,'') != '' then CR02.LeadTypeName else 'Other' end LeadTypeName
		 FROM CRMT20301 CR01 WITH (NOLOCK)
		 Left join CRMT10201 CR02 With (NOLOCK) On CR01.LeadTypeID = CR02.LeadTypeID
		 WHERE ISNULL(CR02.Disabled, 0) = 0 AND (CR02.DivisionID IN (@DivisionIDList) OR ISNULL(CR02.IsCommon, 0) = 1)
		GROUP BY CR02.LeadTypeName, CR01.LeadTypeID)z
		GROUP BY z.LeadTypeID, LeadTypeName
		ORDER BY z.LeadTypeID
		
		INSERT INTO @CRMT20301
		(
			LeadTypeName,
			TotalRow
		)	
	SELECT LeadTypeName,  RowNum
      FROM #CRMT20301 
	ORDER BY RowNum
      	
SELECT @cols= 
STUFF((select  ','+ QUOTENAME(LeadTypeName)
FROM @CRMT20301 AS a
       ORDER BY a.TotalRow
 FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)')  ,1,1,'')
---Load danh sách đầu mối theo nguồn
SET @sSQL =
	'Select * from 
	(
			Select x.DivisionID, x.DivisionName, x.EmployeeID, x.EmployeeName, x.LeadTypeName,  Count(LeadID) as Quantity From
			(
				Select CR01.DivisionID, AT01.DivisionName, CR01.LeadID, CR01.LeadName
				, CR01.AssignedToUserID as EmployeeID,  AT03.FullName as EmployeeName
				, case when isnull(CR02.LeadTypeID,'''') != '''' then CR01.LeadTypeID else ''Other'' end LeadTypeID
				, case when isnull(CR02.LeadTypeID,'''') != '''' then CR02.LeadTypeName else ''Other'' end LeadTypeName
				From CRMT20301 CR01 With (NOLOCK)
				Left join AT1103 AT03 With (NOLOCK) On CR01.AssignedToUserID = AT03.EmployeeID
				Left join CRMT10201 CR02 With (NOLOCK) On CR01.LeadTypeID = CR02.LeadTypeID AND ISNULL(CR02.Disabled, 0) = 0
				Left join AT1101 AT01 With (NOLOCK) On AT01.DivisionID = CR01.DivisionID
				Where   '+@sWhere2+ @swhere3+ @sWhere+'
			)x
				Group by x.DivisionID, x.DivisionName, x.EmployeeID, x.EmployeeName, x.LeadTypeName
		)D	
		Pivot (sum(D.Quantity) for D.LeadTypeName in ('+@cols+')) AS PivotedOrder
		'

EXEC (@sSQL)
print (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
