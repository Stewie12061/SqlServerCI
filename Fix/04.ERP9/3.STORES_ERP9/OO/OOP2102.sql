IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2102]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











-- <Summary>
---- Load dữ liệu cho màn hình popup OOF2101 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
-- Create on 30/10/2019 by Đắc Luân

CREATE PROCEDURE [dbo].[OOP2102]
(
	@DivisionID NVARCHAR(250),
	@APK NVARCHAR(250),
	@APK2150 NVARCHAR(250),
	@UserID NVARCHAR(250),
	@Mode INT = 0		-- 0: Cập nhật dự án; 1: Đánh giá dự án
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR (MAX),
			@sWhere2150 NVARCHAR (MAX) = ''

	-- Màn hình Cập nhật dự án
	IF @Mode = 0
	BEGIN
		DECLARE @ListGroup NVARCHAR(MAX) = '',
				@ListFieldId NVARCHAR(MAX) = '',
				@ListFieldName NVARCHAR(MAX) = '',
				@ListColumn NVARCHAR(MAX) = '',
				@JoinString NVARCHAR(MAX) = '',
				@TableName NVARCHAR(20) = '',
				@ListField NVARCHAR(MAX) = '',
				@JoinAssess NVARCHAR(MAX) = ''
		
		-- Tên Alias của bảng lấy dữ liệu Người đánh giá
		SET @TableName = 'O10'

		-- Mode = 0: Lấy tên Nhóm chỉ tiêu từ bảng Đánh giá dự án
		EXEC OOP21501 @DivisionID = @DivisionID, @APK = @APK, @TableName = @TableName, @UserID = @UserID, @Mode = 0, @ListGroup = @ListGroup OUTPUT
			, @ListFieldId = @ListFieldId OUTPUT, @ListFieldName = @ListFieldName OUTPUT, @ListColumn = @ListColumn OUTPUT, @JoinString = @JoinString OUTPUT

		IF ISNULL(@ListFieldId, '') != '' AND ISNULL(@ListFieldName, '') != ''
		BEGIN
			SET @ListField = CONCAT(', ', @ListFieldId, ', ', @ListFieldName)
			SET @JoinAssess = '
					LEFT JOIN (
						SELECT T2.APKMaster, T2.ProjectID, ' + @ListGroup + '
						FROM (
							SELECT APKMaster, ProjectID, REPLACE(TargetsGroupID, ''.'', '''') AS TargetsGroupID, AssessUserID
							FROM OOT2150
							WHERE APKMaster = ''' + @APK + '''
						) AS T1
						PIVOT (
							MAX(AssessUserID)
							FOR TargetsGroupID IN (' + @ListGroup + ')
						) AS T2
					) AS ' + @TableName + ' ON  O.APK = ' + @TableName + '.APKMaster
					' + @JoinString
		END

		SET @sSQL = N'
SELECT O.APK, O.DivisionID, O.ProjectID, O.ProjectName, O.ProjectType, O.ProjectSampleID, O.ProjectDescription
    , O.StartDate, O.EndDate, O.CheckingDate, O.DepartmentID
    , STUFF((
            SELECT '','' + A1.DepartmentName
            FROM OOT2101 O1
			LEFT JOIN AT1102 A1 ON A1.DepartmentID = O1.DepartmentID
			WHERE O1.RelatedToID = O.ProjectID
            FOR XML PATH('''')
      ), 1, 1, '''') AS DepartmentName
    , O.LeaderID, O.AssignedToUserID, O.ContractID, O.StatusID, O2.StatusName
    , O.RelatedToTypeID, O.DeleteFlg, O.CreateDate, O.CreateUserID, O.LastModifyDate, O.LastModifyUserID, O.OpportunityID
    , O.NetSales, O.CommissionCost, O.GuestCost, O.BonusSales, A1.FullName AS LeaderName, A3.ContractName
    , STUFF((
            SELECT '','' + A1.FullName
            FROM OOT2103 O1
			LEFT JOIN AT1103 A1 ON A1.EmployeeID = O1.UserID
			WHERE O1.RelatedToID = O.ProjectID
            FOR XML PATH('''')
      ), 1, 1, '''') AS AssignedToUserName
	  , O.DiscountFactorNC, O.DiscountFactorKHCU, O.DiscountFactorKHCUService
		' + @ListField + '
	FROM OOT2100 O WITH (NOLOCK)
		LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O.LeaderID
		LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = O.AssignedToUserID
		LEFT JOIN OOT1040 O2 WITH (NOLOCK) ON O2.StatusID = O.StatusID
		LEFT JOIN AT1020 A3 WITH (NOLOCK) ON A3.ContractID = O.ContractID
		' + @JoinAssess + '
	WHERE  O.APK = ''' + @APK + ''' AND  O.DivisionID = N''' + @DivisionID + ''' AND ISNULL( O.DeleteFlg, 0) = 0'
	END

	-- Đánh giá dự án
	IF @Mode = 1
	BEGIN
		
		IF ISNULL(@APK2150, '') != ''
			SET @sWhere2150 =  'WHERE'+' '+'APK = '''+ ISNULL(@APK2150, '00000000-0000-0000-0000-000000000000') + ''
		SET @sSQL = N'
	SELECT O.APK, O.DivisionID, O.ProjectID, O.ProjectName, O.ProjectType, O.ProjectSampleID, O.ProjectDescription
    , O.StartDate, O.EndDate, O.CheckingDate, O.DepartmentID
    , STUFF((
            SELECT '','' + A1.DepartmentName
            FROM OOT2101 O1
			LEFT JOIN AT1102 A1 ON A1.DepartmentID = O1.DepartmentID
			WHERE O1.RelatedToID = O.ProjectID
            FOR XML PATH('''')
            ), 1, 1, '''') AS DepartmentName
    , O.LeaderID, O.AssignedToUserID, O.ContractID, O.StatusID , O2.StatusName
    , O.RelatedToTypeID, O.DeleteFlg, O.CreateDate, O.CreateUserID, O.LastModifyDate, O.LastModifyUserID, O.OpportunityID
    , O.NetSales, O.CommissionCost, O.GuestCost, O.BonusSales, A1.FullName AS LeaderName, A3.ContractName
    , STUFF((
            SELECT '','' + A1.FullName
            FROM OOT2103 O1
			LEFT JOIN AT1103 A1 ON A1.EmployeeID = O1.UserID
			where O1.RelatedToID = O.ProjectID
            FOR XML PATH('''')
            ), 1, 1, '''') AS AssignedToUserName
	, O11.Mark AS Mark
	, O11.Note AS Note
	, O11.StatusID AS StatusAssessor
	, O.DiscountFactorNC, O.DiscountFactorKHCU, O.DiscountFactorKHCUService
					
	FROM OOT2100 O WITH (NOLOCK)
		LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = O.LeaderID
		LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = O.AssignedToUserID
		LEFT JOIN OOT1040 O2 WITH (NOLOCK) ON O2.StatusID = O.StatusID
		LEFT JOIN AT1020 A3 WITH (NOLOCK) ON A3.ContractID = O.ContractID
		LEFT JOIN (SELECT * FROM OOT2150 WITH (NOLOCK) ' + @sWhere2150 + ''') O11 ON  O.APK = O11.APKMaster 

	WHERE  O.APK = ''' + @APK + ''' AND  O.DivisionID = N''' + @DivisionID + ''' AND ISNULL( O.DeleteFlg, 0) = 0'
	END

	
	EXEC (@sSQL)
	--PRINT (@sSQL)
END








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
