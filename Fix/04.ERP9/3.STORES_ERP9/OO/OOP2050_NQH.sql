IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2050_NQH]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2050_NQH]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form OOF2050: Đơn xin phép
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Quốc Tuấn, Date: 07/12/2015
----Modify by: Quốc Tuấn, date: 18/05/2016 : không hiển thị đơn khi chưa tới cấp duyệt
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
---- Modified by Phương Thảo on 21/07/2017
---- Modified by Bảo Anh	 on 02/01/2019: Sửa lại cách lấy dữ liệu do thay đổi cách lưu thông tin duyệt
---- Modified by Bảo Toàn	 on 06/04/2020: Bổ sung thông tin mô tả với loại đơn xin phép
---- Modified by Bảo Toàn	 on 07/04/2020: Bổ sung thông tin mô tả với loại đơn xin phép - Bổ sung kiểm tra giá trị NULL
---- Modified by Bảo Toàn	 on 22/04/2020: Kết bảng OT2101 xử lý dữ liệu hiển thị sai. 
---- Modified by Bích Thảo   on 05/05/2020: Sửa lại lấy Reason từ bảng OOT2010 để hiển thị đi kèm Description.
---- Modified by Bảo Toàn	 on 21/05/2020: Bổ dung các lý do/ ghi chú của từng loại phép.
---- Modified by Trọng Kiên  on 30/06/2020: Set lại điều kiện load cho module BEM khi có combobox Loại đề nghị
---- Modified by Văn Tài	 on 26/10/2020: Format SQL, không thay đổi về code.
---- Modified by Vĩnh Tâm	 on 11/12/2020: Fix lỗi không load được các Phiếu đề nghị theo điều kiện lọc.
---- Modified by Hoài Phong	 on 19/02/2020:Lấy thêm Tên Phòng ban và công đoạn cho NQH
---- Modified by Nhật Thanh	 on 04/10/2022:Bổ sung top 1 cho các sup query
/*-- <Example>
	exec OOP2050_NQH @DivisionID=N'MK',@UserID=N'000199',@TranMonth=8,@TranYear=2016,@PageNumber=1,@PageSize=50,@IsSearch=1,@ID=NULL,
	@CreateUserID=NULL,@DepartmentID=NULL,@SectionID=NULL,@SubsectionID=NULL,@ProcessID=NULL,@Status=NULL,@Type=NULL,@NextApprovePersonID=NULL
----*/

CREATE PROCEDURE OOP2050_NQH
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@PageNumber INT,
	@PageSize INT,
	@IsSearch TINYINT,
	@ID VARCHAR(50),
	@CreateUserID VARCHAR(50),
	@DepartmentID VARCHAR(50),
	@SectionID VARCHAR(50),
	@SubsectionID VARCHAR(50),
	@ProcessID VARCHAR(50),
	@Status NVARCHAR(50),
	@Type VARCHAR(50),
	@NextApprovePersonID VARCHAR(50),
	@TypeProposalID VARCHAR(50) = NULL
)
AS 
DECLARE @sSQL VARCHAR (MAX) = '',
		@sSQL1 VARCHAR (MAX) = '',
        @sWhere VARCHAR(MAX) = '',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = '',
		@LanguageID VARCHAR(50),
		@sSQLLanguage1 VARCHAR(100)='',
		@sSQLLanguage2 VARCHAR(100)='',
		@sSQL_AddSelect VARCHAR(MAX) = '',
		@sSQL_AddJoin VARCHAR(MAX) = '',
		@sSQL_AddGroup VARCHAR(MAX) = ''

IF EXISTS (SELECT TOP 1 LanguageID FROM AT14051 WHERE UserID=@UserID)
	SELECT TOP 1 @LanguageID=LanguageID FROM AT14051 WHERE UserID=@UserID
ELSE 
	SET @LanguageID = 'vi-VN' 

IF @LanguageID='vi-VN' 
BEGIN
	SET @sSQLLanguage1='OOT99.Description'
	SET @sSQLLanguage2 ='OOT991.Description'
END
ELSE 
BEGIN
	SET @sSQLLanguage1='OOT99.DescriptionE'
	SET @sSQLLanguage2 ='OOT991.DescriptionE'
END		
		
SET @OrderBy = ' CreateDate DESC'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @IsSearch = 1
BEGIN
	IF @ID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.ID,'''') LIKE ''%'+@ID+'%'' '

	IF @CreateUserID IS NOT NULL SET @sWhere = @sWhere + '
	AND OOT90.CreateUserID LIKE ''%'+@CreateUserID+'%'' '

	IF @DepartmentID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.DepartmentID,'''') LIKE ''%'+@DepartmentID+'%'' '

	IF @SectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.SectionID,'''') LIKE ''%'+@SectionID+'%'' '

	IF @SubsectionID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.SubsectionID,'''') LIKE ''%'+@SubsectionID+'%'' 
	'
	IF @ProcessID IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.ProcessID,'''') LIKE ''%'+@ProcessID+'%'' '

	IF @Status IS NOT NULL AND @Status <>'%' SET @sWhere = @sWhere + '
	AND ISNULL(OOT91.Status,0) = '+@Status+' '

	--IF @NextApprovePersonID IS NOT NULL SET @sWhere = @sWhere + '
	--AND ISNULL(OOT911.ApprovePersonID,'''') LIKE ''%'+@NextApprovePersonID+'%'' '

	IF @Type IS NOT NULL SET @sWhere = @sWhere + '
	AND ISNULL(OOT90.Type,'''') LIKE ''%'+@Type+'%'' '

	-- Kiểm tra Loại đề nghị khác rỗng , CustomerIndex là MEIKO và Loại phiếu là PDN
	IF @TypeProposalID IS NOT NULL AND (SELECT CustomerName FROM CustomerIndex) = 50 AND @Type = 'PDN'
	    BEGIN
		    -- Lấy toàn bộ các phiếu có ID chứa PDN và giá trị cột TypeID ở BEMT2000 bằng với @TypeProposalID truyền vào
		    SET @sWhere = @sWhere + ' AND B1.TypeID = '''+@TypeProposalID+''' '
		END
	-- Kiểm tra Loại đề nghị khác rỗng , CustomerIndex là MEIKO và Loại phiếu không phải PDN
	IF @TypeProposalID IS NOT NULL AND (SELECT CustomerName FROM CustomerIndex) = 50 AND @Type <> 'PDN'
        BEGIN
		   -- Set câu lệnh where về bằng rỗng và set lại Status bằng 3 vì mặc định là màn hình xét duyệt thì sẽ lọc theo Status nên phải set lại Status để không trả record nào
		    SET @sWhere = ''
	        SET @sWhere = @sWhere + ' AND OOT91.Status = ''3'' '
		END
END
IF (select top 1 CustomerName from CustomerIndex) = 115 -- Customer MTE
BEGIN
	SET @sSQL_AddSelect = '
		+ CASE WHEN (
						ISNULL(OOT2010.[Reason],'''')
						+ ISNULL(OOT2040.[Reason],'''')
						+ ISNULL(OOT2020.[Reason],'''')
						+ ISNULL(OOT2070.[Note],'''')
						+ ISNULL(OOT2030.[Reason],'''')
						) = '''' 
					THEN '''' 
				ELSE  CHAR(13)+ N''''''OOF2050.Reason.HRM'''': ''
					
					+ ( 
					ISNULL(OOT2010.[Reason],'''')
					+ISNULL(OOT2040.[Reason],'''')
					+ISNULL(OOT2020.[Reason],'''')
					+ISNULL(OOT2070.[Note],'''')
					+ISNULL(OOT2030.[Reason],'''')
					)
				END
	'
	SET @sSQL_AddJoin = '
		OUTER APPLY
			(
			-- Đơn xin phép
			SELECT  TOP 1 OOT2010.[Reason]
			FROM    OOT2010
			WHERE   APKMaster = OOT90.APK
			) OOT2010
		OUTER APPLY
			(
			-- Đơn xin bổ sung quẹt thẻ
			SELECT  TOP 1 OOT2040.[Reason]
			FROM    OOT2040
			WHERE   APKMaster = OOT90.APK
			) OOT2040
		OUTER APPLY
			(
			-- Đơn xin ra ngoài
			SELECT  TOP 1 OOT2020.[Reason]
			FROM    OOT2020
			WHERE   APKMaster = OOT90.APK
			ORDER BY OOT2020.APK DESC
			) OOT2020
		OUTER APPLY
			(
			-- Đơn xin đổi ca: Diễn giải + Ghi chú 
			SELECT  TOP 1 OOT2070.[Note]
			FROM    OOT2070
			WHERE   APKMaster = OOT90.APK
			ORDER BY OOT2070.APK DESC
			) OOT2070 
		OUTER APPLY
			(
			-- Đơn xin phép làm thêm giờ
			SELECT  TOP 1 OOT2030.[Reason]
			FROM    OOT2030
			WHERE   APKMaster = OOT90.APK
			ORDER BY OOT2030.APK DESC
			) OOT2030
	'
	SET @sSQL_AddGroup = '
		,OOT2010.Reason
		,OOT2040.Reason
		,OOT2020.Reason
		,OOT2070.Note
		,OOT2030.Reason
	'
END

SET @sSQL = '
	SELECT	OOT90.DivisionID
			, NULL AS NextAPK
			, OOT91.APKMaster
			, OOT91.ApprovePersonID
			, NULL AS [Level]
			, NULL AS Note
			, MIN(OOT91.[Status]) AS Status
			, ISNULL(OT2101.QuotationNo, OOT90.ID) ID
			, ISNULL(OOT90.[Description], '''')
			'+@sSQL_AddSelect+
			' AS Description 
			, OOT90.[Type]
			, OOT90.DepartmentID
			, OOT90.SectionID
			,(select top 1 TeamName from HT1101 where TeamID=OOT90.SectionID )as SectionName
			, OOT90.SubsectionID
			,(select top 1 AnaName from AT1011 where AnaID= OOT90.SubsectionID) as SubsectionName			
			, OOT90.ProcessID
			,(select top 1 AnaName from AT1011 where AnaTypeID= OOT90.ProcessID) as ProcessName		
			, OOT90.CreateUserID
			, AT1405.UserName AS CreateUserName
			--, OOT90.description +'',''+ OOT2010.Reason as description,
			, OOT90.TranYear
			, OOT90.TranMonth
			, '+@sSQLLanguage1+' StatusName
			, OOT99.DescriptionE StatusNameE
			, HV14.FullName ApprovePersonName
			, NULL AS NextApprovePersonName
			, NULL AS NextApprovePersonID
			, MAX(OOT91.Note) AS ApprovalNotes
			, A11.DepartmentName
			--, A12.TeamName SectionName,A13.AnaName SubsectionName,A14.AnaName ProcessName,
			, '+@sSQLLanguage2+' TypeName
			, OOT90.CreateDate
			, 0 IsColor---, OOT91.APK, 

	INTO #OP2050_OOT90
	FROM OOT9000 OOT90 WITH (NOLOCK)
	INNER JOIN
	(
				SELECT MIN(Level) Level,DivisionID, ApprovePersonID, APKMaster, APKDetail
				FROM OOT9001 WITH (NOLOCK)
				GROUP BY DivisionID, ApprovePersonID, APKMaster, APKDetail
	) OOT9 ON OOT9.DivisionID = OOT90.DivisionID 
				AND OOT9.APKMaster = OOT90.APK
	INNER JOIN OOT9001 OOT91 WITH (NOLOCK) 
				ON OOT91.DivisionID = OOT9.DivisionID 
				   AND OOT91.APKMaster = OOT9.APKMaster 
				   AND ISNULL(OOT91.APKDetail, ''00000000-0000-0000-0000-000000000000'') = ISNULL(OOT9.APKDetail,''00000000-0000-0000-0000-000000000000'') 
				   AND OOT91.Level=OOT9.Level
	LEFT JOIN OOT0099 OOT99 WITH (NOLOCK) 
				ON OOT99.ID1 = OOT91.[Status] 
				   AND OOT99.CodeMaster=''Status''
	LEFT JOIN OOT0099 OOT991 WITH (NOLOCK) 
				ON OOT991.ID = OOT90.Type 
				   AND OOT991.CodeMaster=''Applying''

	--LEFT JOIN OOT9001 OOT911 
				--ON OOT911.DivisionID = OOT91.DivisionID 
				--   AND OOT911.APKMaster = OOT91.APKMaster 
				--   AND OOT911.[Level] = OOT91.[Level] + 1 
				--   AND OOT911.ApprovePersonID <> OOT91.ApprovePersonID

	LEFT JOIN OOT9001 OOT912 WITH (NOLOCK) 
				ON OOT912.DivisionID = OOT91.DivisionID 
				   AND OOT912.APKMaster = OOT91.APKMaster 
				   AND ISNULL(OOT912.APKDetail, ''00000000-0000-0000-0000-000000000000'') = ISNULL(OOT91.APKDetail, ''00000000-0000-0000-0000-000000000000'') 
				   AND OOT912.[Level] = OOT91.[Level] - 1
	LEFT JOIN HV1400 HV14 
				ON HV14.DivisionID = OOT91.DivisionID 
				   AND HV14.EmployeeID = OOT91.ApprovePersonID
	--LEFT JOIN HV1400 HV141 
				--ON HV141.DivisionID = OOT91.DivisionID 
				--   AND HV141.EmployeeID = OOT911.ApprovePersonID
	LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID = OOT90.DepartmentID 
	'+@sSQL_AddJoin+'
	LEFT JOIN AT1405 WITH (NOLOCK) 
				ON OOT90.DivisionID = AT1405.DivisionID 
				   AND OOT90.CreateUserID=AT1405.UserID
	LEFT JOIN OT2101 WITH (NOLOCK) 
				ON OT2101.APKMaster_9000 = OOT90.APK
	LEFT JOIN BEMT2000 AS B1 WITH (NOLOCK) 
				ON B1.APKMaster_9000 = OOT90.APK

	WHERE OOT91.DivisionID = '''+@DivisionID+'''
			AND ISNULL(OOT90.DeleteFlag, 0) = 0
			AND OOT91.ApprovePersonID = ''' + @UserID + '''
			AND ISNULL(OOT912.[Status], 3) NOT IN (0, 2)
	'+@sWhere+'
	GROUP BY OOT90.DivisionID
			, OOT91.APKMaster
			, OOT91.ApprovePersonID
			, ISNULL(OT2101.QuotationNo,OOT90.ID)
			, OOT90.[Description]
			, OOT90.[Type]
			, OOT90.DepartmentID
			, OOT90.SectionID
			, OOT90.SubsectionID
			, OOT90.ProcessID
			, OOT90.CreateUserID
			, AT1405.UserName
			, OOT90.TranYear
			, OOT90.TranMonth
			, ' + @sSQLLanguage1 + '
			, OOT99.DescriptionE
			, HV14.FullName
			, A11.DepartmentName
			, ' + @sSQLLanguage2 + '
			,OOT90.CreateDate
			' + @sSQL_AddGroup + '

'

SET @sSQL1 ='	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
				FROM #OP2050_OOT90	
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL + @sSQL1)
--PRINT(@sSQL)
--PRINT(@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
