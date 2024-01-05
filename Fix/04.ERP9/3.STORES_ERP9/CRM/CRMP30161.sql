IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP30161]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP30161]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
----In báo cáo Tổng hợp đầu mối chi tiết từ các nguồn đầu mối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga on 04/04/2020
----Modified by:	Văn Tài	ON	06/06/2022: [CSG] xử lý in tên đầu mối thay vì mã.
-- <Example>
  /*
*/
CREATE PROCEDURE [dbo].[CRMP30161] ( 
        @DivisionID     VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@IsDate			TINYINT,		--1: Theo ngày; 0: Theo kỳ
		@FromDate       DATETIME,
		@ToDate         DATETIME,
		@PeriodIDList	NVARCHAR(2000),
		@EmployeeIDList NVarchar(MAX),
		@UserID			VARCHAR(50),
		@ConditionLeadID nvarchar(MAX)
)
AS
DECLARE
		@sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere2 Nvarchar(Max),
		@sWhere3 Nvarchar(Max),
		@Columns Nvarchar(Max),
@cols NVARCHAR(Max)

DECLARE @CustomerIndex INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))

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
		SET @sWhere2 =@sWhere2+ ' (CR01.DivisionID = '''+ @DivisionID+''' Or CR01.IsCommon =1)'
	Else 
		SET @sWhere2 = @sWhere2+ ' (CR01.DivisionID IN ('''+@DivisionIDList+''') Or CR01.IsCommon =1)'

	IF ((Isnull(@EmployeeIDList, '') !=''))
		SET @sWhere2 = @sWhere2 +' AND CR01.AssignedToUserID IN ('''+@EmployeeIDList+''')'

	IF Isnull(@ConditionLeadID,'')!=''
		SET @sWhere2 = @sWhere2 + ' AND ISNULL(CR01.AssignedToUserID,CR01.CreateUserID) in ('''+@ConditionLeadID+''' )'
----Chuyển dòng thành cột
	Declare @CRMT20301 table (
							LeadTypeName nvarchar(Max),
							TotalRow int)	
		
		SELECT  LeadTypeName, ROW_NUMBER() OVER (ORDER BY z.LeadTypeID) AS RowNum  Into #CRMT20301 
		FROM 		
		(SELECT case when isnull(CR01.LeadTypeID,'') != '' then CR01.LeadTypeID else '' end LeadTypeID
		, case when isnull(CR02.LeadTypeName,'') != '' then CR02.LeadTypeName else '' end LeadTypeName
			FROM CRMT20301 CR01 WITH (NOLOCK)
			Left join CRMT10201 CR02 With (NOLOCK) On CR01.LeadTypeID = CR02.LeadTypeID
		GROUP BY CR02.LeadTypeName, CR01.LeadTypeID) z
		GROUP BY z.LeadTypeID, LeadTypeName
		ORDER BY z.LeadTypeID
		
		INSERT INTO @CRMT20301
		(
			LeadTypeName,
			TotalRow
		)	
	SELECT LeadTypeName,  RowNum
    FROM #CRMT20301 
	WHERE isnull(LeadTypeName,'') !=''
	ORDER BY RowNum
      	
SELECT @cols= 
STUFF((select  ','+ QUOTENAME(LeadTypeName +'_1') +',' + QUOTENAME(LeadTypeName +'_0') 
FROM @CRMT20301 AS a
       ORDER BY a.TotalRow
 FOR XML PATH(''), TYPE ).value('.', 'NVARCHAR(MAX)')  ,1,1,'')

 set @cols= @cols +',Other_1,Other_0'

IF (@CustomerIndex = 152) -- Khách hàng Cảng Sài Gòn: Lấy tên thay gì ID.
BEGIN

---Load danh sách đầu mối theo nguồn
SET @sSQL =
	'
	SELECT LeadTypeName,  RowNum
    FROM #CRMT20301 
	WHERE isnull(LeadTypeName,'''') !=''''
	ORDER BY RowNum

	Select APK, DivisionID, DivisionName, EmployeeID, EmployeeName,'+@cols+',IsRef_0,IsRef_1 from 
	(
			Select x.APK, x.DivisionID, x.DivisionName, x.EmployeeID, x.EmployeeName, x.LeadTypeName, x.LeadID, x.LeadName,x.IsRef,
			CASE WHEN x.IsRef = 0 THEN 1 END IsRef_0, CASE WHEN x.IsRef = 1 THEN 1 END IsRef_1
			From
			(
				Select CR01.APK, CR01.DivisionID, AT01.DivisionName, CR01.LeadID, CR01.LeadName
				, CR01.AssignedToUserID as EmployeeID,  AT03.FullName as EmployeeName
				, case when isnull(CR01.LeadTypeID,'''') != '''' then CR01.LeadTypeID else ''Other'' end LeadTypeID
				, case when isnull(CR02.LeadTypeName,'''') != '''' and A.LeadID is not null then CR02.LeadTypeName +''_1''
					   when isnull(CR02.LeadTypeName,'''') != '''' and B.LeadID is not null then CR02.LeadTypeName +''_0'' 
					   when isnull(CR02.LeadTypeName,'''') = '''' and A.LeadID is not null then ''Other_1'' 
					   when isnull(CR02.LeadTypeName,'''') = '''' and B.LeadID is not null then ''Other_0'' 
				 end LeadTypeName
				, (case when A.LeadID is not null then 1 when B.LeadID is not null then 0 else null end) as IsRef
				From CRMT20301 CR01 With (NOLOCK)
				Left join AT1103 AT03 With (NOLOCK) On CR01.AssignedToUserID = AT03.EmployeeID
				Left join CRMT10201 CR02 With (NOLOCK) On CR01.LeadTypeID = CR02.LeadTypeID
				Left join AT1101 AT01 With (NOLOCK) On AT01.DivisionID = CR01.DivisionID
				Left join (
					select * from CRMT20301
					where APK in( select APKRel from OOT2110 with (nolock) where DeleteFlg = 0 and APKRel is not null) -- công việc
					or CONVERT(nvarchar(50), APK) in(select RelatedToID from CRMT00002_REL with (nolock) where RelatedToTypeID_REL = 1 and RelatedToID is not null) -- đính kèm
					or CONVERT(nvarchar(50), APK) in (select RelatedToID from CRMT90031_REL with (nolock) where RelatedToTypeID_REL = 1 and RelatedToID is not null) -- ghi chú
				) as A on A.APK = CR01.APK
				Left join (
					select * from CRMT20301
					where APK not in( select APKRel from OOT2110 with (nolock) where DeleteFlg = 0 and APKRel is not null) -- công việc
					and CONVERT(nvarchar(50), APK) not in(select RelatedToID from CRMT00002_REL with (nolock) where RelatedToTypeID_REL = 1 and RelatedToID is not null) -- đính kèm
					and CONVERT(nvarchar(50), APK) not in (select RelatedToID from CRMT90031_REL with (nolock) where RelatedToTypeID_REL = 1 and RelatedToID is not null) -- ghi chú
				) as B on B.APK = CR01.APK

				Where   '+@sWhere2+ @swhere3+ @sWhere+'
			)x
				Group by x.APK,x.DivisionID, x.DivisionName, x.EmployeeID, x.EmployeeName, x.LeadTypeName, x.LeadID, x.LeadName, x.IsRef
		)D	
		Pivot (Max(LeadName) for D.LeadTypeName in ('+@cols+')) AS PivotedOrder
		'

END
ELSE
BEGIN
	
---Load danh sách đầu mối theo nguồn
SET @sSQL =
	'
	SELECT LeadTypeName,  RowNum
    FROM #CRMT20301 
	WHERE isnull(LeadTypeName,'''') !=''''
	ORDER BY RowNum

	Select APK, DivisionID, DivisionName, EmployeeID, EmployeeName,'+@cols+',IsRef_0,IsRef_1 from 
	(
			Select x.APK, x.DivisionID, x.DivisionName, x.EmployeeID, x.EmployeeName, x.LeadTypeName, x.LeadID,x.IsRef,
			CASE WHEN x.IsRef = 0 THEN 1 END IsRef_0, CASE WHEN x.IsRef = 1 THEN 1 END IsRef_1
			From
			(
				Select CR01.APK, CR01.DivisionID, AT01.DivisionName, CR01.LeadID, CR01.LeadName
				, CR01.AssignedToUserID as EmployeeID,  AT03.FullName as EmployeeName
				, case when isnull(CR01.LeadTypeID,'''') != '''' then CR01.LeadTypeID else ''Other'' end LeadTypeID
				, case when isnull(CR02.LeadTypeName,'''') != '''' and A.LeadID is not null then CR02.LeadTypeName +''_1''
					   when isnull(CR02.LeadTypeName,'''') != '''' and B.LeadID is not null then CR02.LeadTypeName +''_0'' 
					   when isnull(CR02.LeadTypeName,'''') = '''' and A.LeadID is not null then ''Other_1'' 
					   when isnull(CR02.LeadTypeName,'''') = '''' and B.LeadID is not null then ''Other_0'' 
				 end LeadTypeName
				, (case when A.LeadID is not null then 1 when B.LeadID is not null then 0 else null end) as IsRef
				From CRMT20301 CR01 With (NOLOCK)
				Left join AT1103 AT03 With (NOLOCK) On CR01.AssignedToUserID = AT03.EmployeeID
				Left join CRMT10201 CR02 With (NOLOCK) On CR01.LeadTypeID = CR02.LeadTypeID
				Left join AT1101 AT01 With (NOLOCK) On AT01.DivisionID = CR01.DivisionID
				Left join (
					select * from CRMT20301
					where APK in( select APKRel from OOT2110 with (nolock) where DeleteFlg = 0 and APKRel is not null) -- công việc
					or CONVERT(nvarchar(50), APK) in(select RelatedToID from CRMT00002_REL with (nolock) where RelatedToTypeID_REL = 1 and RelatedToID is not null) -- đính kèm
					or CONVERT(nvarchar(50), APK) in (select RelatedToID from CRMT90031_REL with (nolock) where RelatedToTypeID_REL = 1 and RelatedToID is not null) -- ghi chú
				) as A on A.APK = CR01.APK
				Left join (
					select * from CRMT20301
					where APK not in( select APKRel from OOT2110 with (nolock) where DeleteFlg = 0 and APKRel is not null) -- công việc
					and CONVERT(nvarchar(50), APK) not in(select RelatedToID from CRMT00002_REL with (nolock) where RelatedToTypeID_REL = 1 and RelatedToID is not null) -- đính kèm
					and CONVERT(nvarchar(50), APK) not in (select RelatedToID from CRMT90031_REL with (nolock) where RelatedToTypeID_REL = 1 and RelatedToID is not null) -- ghi chú
				) as B on B.APK = CR01.APK

				Where   '+@sWhere2+ @swhere3+ @sWhere+'
			)x
				Group by x.APK,x.DivisionID, x.DivisionName, x.EmployeeID, x.EmployeeName, x.LeadTypeName, x.LeadID,x.IsRef
		)D	
		Pivot (Max(LeadID) for D.LeadTypeName in ('+@cols+')) AS PivotedOrder
		'

END

EXEC (@sSQL)
print (@sSQL)
GO
