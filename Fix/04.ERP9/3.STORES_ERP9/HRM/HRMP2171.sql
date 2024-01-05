IF EXISTS
(
    SELECT TOP 1
           1
    FROM dbo.sysobjects
    WHERE id = OBJECT_ID(N'[DBO].[HRMP2171]')
          AND OBJECTPROPERTY(id, N'IsProcedure') = 1
)
    DROP PROCEDURE [dbo].[HRMP2171];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO


-- <Summary>
---- Load Master/Details Điều chỉnh tạm thời.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tài, Date: 24/12/2020
----Modified by: Văn Tài	on	Date: 24/12/2020 - Bổ load trường hợp Edit.
----Modified by: Hoài Phong	on	Date: 13/01/2021 - Lấy cột cần thiết không lấy all , edit báo lỗi.
----Modified by: Văn Tài	on	Date: 17/05/2021 - Điều chỉnh các câu lệnh JOIN bảng DivisionID phải theo từng bảng JOIN.
-- <Example>
---- 
/*-- <Example>
	HRMP2171 @DivisionID='ANG', @UserID='ASOFTADMIN', @APK=''
----*/

CREATE PROCEDURE [HRMP2171]
(
    @DivisionID NVARCHAR(50), --Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa	
    @UserID NVARCHAR(50),
    @APK VARCHAR(50),
    @PageNumber INT,
    @PageSize INT,
    @Mode INT                 -- 0: Master, 1: Details
)
AS
BEGIN

    IF (@Mode = 0)
    BEGIN
        SELECT ISNULL(AT02.DepartmentName, '') AS DepartmentName,
               ISNULL(AT11.AnaName, '') AS SectionName,
               ISNULL(AT12.AnaName, '') AS SubsectionName,
               CASE
                   WHEN (HT70.Status = 0) THEN
                       N'Chờ duyệt'
                   WHEN (HT70.Status = 1) THEN
                       N'Duyệt'
                   WHEN (HT70.Status = 2) THEN
                       N'Từ chối'
               END AS StatusName,
               OT9001.ApprovePersonID,
               OT9001.ApprovePersonID AS ApprovePerson01ID,
               OT9001.ApprovePersonID AS ApproveListDefault,
               A051.UserName AS ApprovePersonName,
               OT9001.Note AS ApprovePersonNote,
               HT70.*
        FROM HRMT2170 HT70 WITH (NOLOCK)
            LEFT JOIN AT1102 AT02 WITH (NOLOCK)
                ON AT02.DivisionID IN ( HT70.DivisionID, N'@@@' )
                   AND AT02.DepartmentID = HT70.DepartmentID
            LEFT JOIN dbo.OOT9000 OT9000 WITH (NOLOCK)
                ON OT9000.DivisionID IN ( HT70.DivisionID, N'@@@' )
                   AND OT9000.APK = HT70.APKMaster_9000
            LEFT JOIN dbo.OOT9001 OT9001 WITH (NOLOCK)
                ON OT9001.DivisionID IN ( HT70.DivisionID, N'@@@' )
                   AND OT9001.APKMaster = OT9000.APK
            LEFT JOIN AT1405 A051 WITH (NOLOCK)
                ON A051.DivisionID IN ( HT70.DivisionID, N'@@@' )
					AND A051.UserID = OT9001.ApprovePersonID
            LEFT JOIN AT1011 AT11 WITH (NOLOCK)
                ON AT11.DivisionID IN ( HT70.DivisionID, N'@@@' )
                   AND AT11.AnaID = HT70.SectionID
            LEFT JOIN AT1011 AT12 WITH (NOLOCK)
                ON AT12.DivisionID IN ( HT70.DivisionID, N'@@@' )
                   AND AT12.AnaID = HT70.SubsectionID
        WHERE HT70.DivisionID = @DivisionID
              AND HT70.APK = @APK;
    END;
    ELSE IF (@Mode = 1)
    BEGIN
        SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY HT71.Orders)) AS RowNum,
               COUNT(*) OVER () AS TotalRow,
               ISNULL(AT02.DepartmentName, '') AS DepartmentName,
               ISNULL(AT11.AnaName, '') AS SectionName,
               ISNULL(AT12.AnaName, '') AS SubSectionName,
               ISNULL(HV14.FullName, '') AS EmployeeName,
               HT71.DepartmentID,
			   HT71.EmployeeID,
			   HT71.SectionID,
			   HT71.SubsectionID,
			   HT71.Note,
			   HT71.Description
        FROM HRMT2171 HT71 WITH (NOLOCK)
            LEFT JOIN HV1400 HV14
                ON HV14.DivisionID IN ( HT71.DivisionID, N'@@@' )
                   AND HV14.EmployeeID = HT71.EmployeeID
            LEFT JOIN AT1102 AT02 WITH (NOLOCK)
                ON AT02.DivisionID IN ( HT71.DivisionID, N'@@@' )
                   AND AT02.DepartmentID = HT71.DepartmentID
            LEFT JOIN AT1011 AT11 WITH (NOLOCK)
                ON AT11.DivisionID IN ( HT71.DivisionID, N'@@@' )
                   AND AT11.AnaID = HT71.SectionID
            LEFT JOIN AT1011 AT12 WITH (NOLOCK)
                ON AT12.DivisionID IN ( HT71.DivisionID, N'@@@' )
                   AND AT12.AnaID = HT71.SubsectionID
        WHERE HT71.DivisionID = @DivisionID
              AND HT71.APKMaster = @APK
        ORDER BY HT71.Orders OFFSET (@PageNumber - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;
    END;
    ELSE IF (@Mode = 2)
    BEGIN
        SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY HT71.Orders)) AS RowNum,
               COUNT(*) OVER () AS TotalRow,
               ISNULL(AT02.DepartmentName, '') AS DepartmentName,
               ISNULL(AT11.AnaName, '') AS SectionName,
               ISNULL(AT12.AnaName, '') AS SubSectionName,
               ISNULL(HV14.FullName, '') AS EmployeeName,
               HT71.*
        FROM HRMT2171 HT71 WITH (NOLOCK)
            LEFT JOIN HV1400 HV14
                ON HV14.DivisionID IN ( HT71.DivisionID, N'@@@' )
                   AND HV14.EmployeeID = HT71.EmployeeID
            LEFT JOIN AT1102 AT02 WITH (NOLOCK)
                ON AT02.DivisionID IN ( HT71.DivisionID, N'@@@' )
                   AND AT02.DepartmentID = HT71.DepartmentID
            LEFT JOIN AT1011 AT11 WITH (NOLOCK)
                ON AT11.DivisionID IN ( HT71.DivisionID, N'@@@' )
                   AND AT11.AnaID = HT71.SectionID
            LEFT JOIN AT1011 AT12 WITH (NOLOCK)
                ON AT12.DivisionID IN ( HT71.DivisionID, N'@@@' )
                   AND AT12.AnaID = HT71.SubsectionID
        WHERE HT71.DivisionID = @DivisionID
              AND HT71.APKMaster = @APK
        ORDER BY HT71.Orders;
    END;

    ELSE IF (@Mode = 3)
    BEGIN
        SELECT ISNULL(AT02.DepartmentName, '') AS DepartmentName,
               ISNULL(AT11.AnaName, '') AS SectionName,
               ISNULL(AT12.AnaName, '') AS SubsectionName,
               CASE
                   WHEN (HT70.Status = 0) THEN
                       N'Chờ duyệt'
                   WHEN (HT70.Status = 1) THEN
                       N'Duyệt'
                   WHEN (HT70.Status = 2) THEN
                       N'Từ chối'
               END AS StatusName,
               OT9001.ApprovePersonID,
               OT9001.ApprovePersonID AS ApprovePerson01ID,
               A051.UserName AS ApprovePersonName,
               OT9001.Note AS ApprovePersonNote,
               HT70.VoucherNo AS ID,
               HT70.ApproveLevel AS Level,
               HT70.Status AS StatusOOT9001,
			   HT70.APK,
               OT9001.APK AS APKOOT9001,
               HT70.Note AS Description,
               HT70.DepartmentID,
               HT70.OrderDate,
               HT70.SectionID,
               HT70.SubsectionID,
               HT70.WorkToDate,
               HT70.WorkFromDate,
			   HT70.TranMonth,
			   HT70.TranYear,
			   HT70.CreateUserID			   
        FROM HRMT2170 HT70 WITH (NOLOCK)
            LEFT JOIN AT1102 AT02 WITH (NOLOCK)
                ON AT02.DivisionID IN ( HT70.DivisionID, N'@@@' )
                   AND AT02.DepartmentID = HT70.DepartmentID
            LEFT JOIN dbo.OOT9000 OT9000 WITH (NOLOCK)
                ON OT9000.DivisionID IN ( HT70.DivisionID, N'@@@' )
                   AND OT9000.APK = HT70.APK
            LEFT JOIN dbo.OOT9001 OT9001 WITH (NOLOCK)
                ON OT9001.DivisionID IN ( HT70.DivisionID, N'@@@' )
                   AND OT9001.APKMaster = OT9000.APK
            LEFT JOIN AT1405 A051 WITH (NOLOCK)
                ON A051.DivisionID IN ( HT70.DivisionID, N'@@@' )
					AND A051.UserID = OT9001.ApprovePersonID
            LEFT JOIN AT1011 AT11 WITH (NOLOCK)
                ON AT11.DivisionID IN ( HT70.DivisionID, N'@@@' )
                   AND AT11.AnaID = HT70.SectionID
            LEFT JOIN AT1011 AT12 WITH (NOLOCK)
                ON AT12.DivisionID IN ( HT70.DivisionID, N'@@@' )
                   AND AT12.AnaID = HT70.SubsectionID
        WHERE HT70.DivisionID = @DivisionID
              AND HT70.APK = @APK;
    END;

END;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO
