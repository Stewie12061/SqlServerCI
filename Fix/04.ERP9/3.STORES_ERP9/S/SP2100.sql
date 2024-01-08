IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load grid màn hình thiết lập biến môi trường - SF2101
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Thành, Date 20/01/2021

CREATE PROCEDURE SP2100 
( 
	@DivisionIDList VARCHAR(MAX),
	@TypeSearch VARCHAR(MAX),
	@GroupSearch VARCHAR(MAX),
	@DataTypeSearch VARCHAR(MAX),
	@KeySearch NVARCHAR(MAX),
	@LanguageID VARCHAR(50)
)	
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@All NVARCHAR(50)
        
SET @sWhere = ''
SET @TotalRow = ''
IF(@LanguageID = 'vi-VN')
	SET @All = N'Tất cả'
IF(@LanguageID = 'en-US')
	SET @All = N'All'

IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' AND S1.DivisionID IN (''' + @DivisionIDList + ''') '

IF ISNULL(@TypeSearch, '') != ''
	SET @sWhere = @sWhere + ' AND S1.TypeID IN (''' + @TypeSearch + ''') '

IF ISNULL(@GroupSearch, '') != ''
	SET @sWhere = @sWhere + ' AND S1.GroupID IN (''' + @GroupSearch + ''') '

IF ISNULL(@DataTypeSearch, '') != ''
	SET @sWhere = @sWhere + ' AND S1.ValueDataType IN (''' + @DataTypeSearch + ''') '

IF ISNULL(@KeySearch, '') != ''
	SET @sWhere = @sWhere + ' AND (ISNULL(S1.KeyName, '''') LIKE ''%' + @KeySearch +'%'' OR ISNULL(S1.KeyValue, '''') LIKE ''%' + @KeySearch +'%'')'

SET @sSQL ='
SELECT S1.APK, S1.TypeID, A3.Description AS GroupName, S1.DivisionID, S1.GroupID, S1.KeyName, S1.KeyValue, S1.ValueDataType, S1.DefaultValue, S1.ModuleID, S1.IsEnvironment, S1.Description, S1.CreateUserID, S1.CreateDate, S1.LastModifyUserID, S1.LastModifyDate
		, A1.Description AS DataTypeName, A2.Description AS DesDefaultValue, A3.OrderNo, A4.Description AS TypeName, A3.OrderNo, S1.OrderNo,
		CASE
			WHEN S1.DivisionID = ''@@@'' THEN N''' + @All + '''
			ELSE A5.DivisionName
		END AS DivisionName

FROM ST2101 S1 WITH (NOLOCK)
	LEFT JOIN AT0099 A1 WITH(NOLOCK) ON CONVERT(VARCHAR, S1.ValueDataType) = A1.ID AND ISNULL(A1.Disabled, 0) = 0 AND A1.CodeMaster = ''DataType''
	LEFT JOIN AT0099 A2 WITH(NOLOCK) ON CONVERT(VARCHAR, S1.DefaultValue) = A2.ID AND ISNULL(A2.Disabled, 0) = 0 AND A2.CodeMaster = ''DataClassification''
	LEFT JOIN AT0099 A3 WITH(NOLOCK) ON CONVERT(VARCHAR, S1.GroupID) = A3.ID	AND ISNULL(A3.Disabled, 0) = 0 AND A3.CodeMaster = ''GroupConfig''
	LEFT JOIN AT0099 A4 WITH(NOLOCK) ON CONVERT(VARCHAR, S1.TypeID) = A4.ID	AND ISNULL(A4.Disabled, 0) = 0 AND A4.CodeMaster = ''ConfigType''
	LEFT JOIN AT1101 A5 WITH(NOLOCK) ON CONVERT(VARCHAR, S1.DivisionID) = A5.DivisionID AND ISNULL(A5.Disabled,0) = 0
WHERE 1 = 1' + @sWhere +
'GROUP BY S1.APK, S1.TypeID, S1.DivisionID, S1.GroupID, S1.KeyName, S1.KeyValue, S1.ValueDataType, S1.DefaultValue, S1.ModuleID, S1.IsEnvironment, S1.Description, S1.CreateUserID, S1.CreateDate, S1.LastModifyUserID, S1.LastModifyDate
	, A1.Description, A2.Description , A3.Description, A4.Description, A3.OrderNo, S1.OrderNo, A5.DivisionName
ORDER BY A3.OrderNo, S1.OrderNo'

EXEC (@sSQL)
PRINT (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
