IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP2001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP2001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Master định nghĩa tiêu chuẩn (màn hình xem chi tiết/ màn hình cập nhật)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Thanh Thi on 15/10/2020
----Modified by: Đình Ly on 03/03/2021: load dữ liệu cho các Bảng nghiệp vụ và Phiếu kế thừa.
----Modified by Lê Hoàng on 27/05/2021 : Trả thông tin CreateUserID, LastModifyUserID là tên người dùng
----Modified by Thanh Lượng on 05/04/2023 : Bổ sung load thêm dữ liệu theo chuẩn người duyệt và số cột
---- Modified on 19/04/2023 by Nhat Thanh: Load phiếu tạm
----Modified by ... on ... :

-- <Example> EXEC QCP2001 @DivisionID = 'VNP', @UserID = '', @APK = 'C69E5AE4-6FE1-4829-B99A-78D1AB7D89D3'

CREATE PROCEDURE [dbo].[QCP2001]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @APKMaster_9000 VARCHAR(50) = '',
	 @Type VARCHAR(50) = ''
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
@sSQL1 NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@PageNumber int = 1,
			@sSQLSL NVARCHAR (MAX) = '',
			@sSQLJon NVARCHAR(MAX) = '',
			@sWhere  NVARCHAR(max) = '',
			@Level INT,
			@i INT = 1, @s VARCHAR(2)

			IF ISNULL(@Type, '') = 'QLCLC' 
BEGIN
SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(50),T1.APKMaster_9000)= '''+@APKMaster_9000+''''
SELECT  @Level = MAX(Levels) FROM QCT2000 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster_9000 AND DivisionID = @DivisionID
END
ELSE
BEGIN
SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(50),T1.APK)= '''+@APK+'''OR CONVERT(VARCHAR(50),T1.APKMaster_9000) = ''' + @APK + ''')'
SELECT  @Level = MAX(Levels) FROM QCT2000 WITH (NOLOCK) WHERE @APK = @APK AND DivisionID = @DivisionID
END

    WHILE @i <= @Level
    BEGIN
        IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
        ELSE SET @s = CONVERT(VARCHAR, @i)

        SET @sSQLSL=@sSQLSL+' ,ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, O99.[Description] AS ApprovePerson'+@s+'Status , ApprovePerson'+@s+'Note' 

        SET @sSQLJon =@sSQLJon+ '
                        LEFT JOIN (
                                  SELECT ApprovePersonID ApprovePerson'+@s+'ID, OOT1.APKMaster, OOT1.DivisionID,
                                         A1.FullName As ApprovePerson'+@s+'Name,OOT1.Note AS ApprovePerson'+@s+'Note
                                  FROM OOT9001 OOT1 WITH (NOLOCK)
                                  INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID=OOT1.DivisionID AND A1.EmployeeID=OOT1.ApprovePersonID
                                  WHERE OOT1.Level='+STR(@i)+'
                                  ) APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'

        SET @i = @i + 1	
    END

	SET @sSQL =N'	SELECT T1.APK, T1.DivisionID, T1.VoucherTypeID, T1.VoucherNo, T1.VoucherDate, T1.TranMonth, T1.TranYear, 
			T1.ShiftID, T2.ShiftName, 
			T10.DepartmentID, T10.DepartmentName,
			T3.MachineID, T3.MachineName, T3.MachineNameE,T1.SourceNo,
			T1.ObjectID,A12.ObjectName AS ObjectName,
			T1.Ana04ID, A11.AnaName AS Ana04Name,
			T1.EmployeeID01, T4.FullName AS EmployeeName01,
			T1.EmployeeID02, T5.FullName AS EmployeeName02,
			T1.EmployeeID03, T6.FullName AS EmployeeName03,
			T1.EmployeeID04, T7.FullName AS EmployeeName04,
			T1.EmployeeID05, T8.FullName AS EmployeeName05,
			T1.EmployeeID06, T9.FullName AS EmployeeName06,
			T1.EmployeeID07, T9.FullName AS EmployeeName07,
			T1.Description, T1.Notes01, T1.Notes02, T1.Notes03, T1.StatusSS, T1.Levels, T1.ApproveLevel, T1.ApprovingLevel, T1.DeleteFlg, T1.APKMaster_9000	,ApprovalNotes,
			T1.CreateDate, A09.FullName AS CreateUserID, T1.LastModifyDate, A10.FullName AS LastModifyUserID,
			T1.InheritTable, T1.InheritVoucher
			'+@sSQLSL+'
		FROM QCT2000 T1  WITH (NOLOCK)
			LEFT JOIN HT1020 T2 WITH (NOLOCK) ON T1.ShiftID = T2.ShiftID
			LEFT JOIN CIT1150 T3 WITH (NOLOCK) ON T1.MachineID = T3.MachineID
			LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T1.EmployeeID01 = T4.EmployeeID
			LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T1.EmployeeID02 = T5.EmployeeID
			LEFT JOIN AT1103 T6 WITH (NOLOCK) ON T1.EmployeeID03 = T6.EmployeeID
			LEFT JOIN AT1103 T7 WITH (NOLOCK) ON T1.EmployeeID04 = T7.EmployeeID
			LEFT JOIN AT1103 T8 WITH (NOLOCK) ON T1.EmployeeID05 = T8.EmployeeID
			LEFT JOIN AT1103 T9 WITH (NOLOCK) ON T1.EmployeeID06 = T9.EmployeeID
			LEFT JOIN AT1102 T10 WITH (NOLOCK) ON T10.DivisionID IN (T1.DivisionID,''@@@'') AND T10.DepartmentID = T1.DepartmentID
			LEFT JOIN AT1103 A09 WITH (NOLOCK) ON A09.EmployeeID = T1.CreateUserID
			LEFT JOIN AT1103 A10 WITH (NOLOCK) ON A10.EmployeeID = T1.LastModifyUserID
			LEFT JOIN AT1011 A11 WITH (NOLOCK) ON A11.AnaID = T1.Ana04ID and A11.DivisionID IN (T1.DivisionID,''@@@'') 
			LEFT JOIN AT1202 A12 WITH (NOLOCK) ON A12.ObjectID = T1.ObjectID and A12.DivisionID IN (T1.DivisionID,''@@@'') 
			LEFT JOIN OOT0099 O99 WITH(NOLOCK) ON O99.CodeMaster = ''Status'' AND T1.StatusSS = O99.ID
			LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON T1.APKMaster_9000 = OOT90.APK           
		 '+@sSQLJon+'
		 WHERE T1.DivisionID = '''+@DivisionID+''' '+@sWhere+''

		 IF EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 151)
		 SET @sSQL1 =N'	SELECT T1.APK, T1.DivisionID, T1.VoucherTypeID, T1.VoucherNo, T1.VoucherDate, T1.TranMonth, T1.TranYear, 
			T1.ShiftID, T2.ShiftName, 
			T10.DepartmentID, T10.DepartmentName,
			T3.MachineID, T3.MachineName, T3.MachineNameE,T1.SourceNo,
			T1.ObjectID,A12.ObjectName AS ObjectName,
			T1.Ana04ID, A11.AnaName AS Ana04Name,
			T1.EmployeeID01, T4.FullName AS EmployeeName01,
			T1.EmployeeID02, T5.FullName AS EmployeeName02,
			T1.EmployeeID03, T6.FullName AS EmployeeName03,
			T1.EmployeeID04, T7.FullName AS EmployeeName04,
			T1.EmployeeID05, T8.FullName AS EmployeeName05,
			T1.EmployeeID06, T9.FullName AS EmployeeName06,
			T1.EmployeeID07, T9.FullName AS EmployeeName07,
			T1.Description, T1.Notes01, T1.Notes02, T1.Notes03, T1.StatusSS, T1.Levels, T1.ApproveLevel, T1.ApprovingLevel, T1.DeleteFlg, T1.APKMaster_9000	,ApprovalNotes,
			T1.CreateDate, A09.FullName AS CreateUserID, T1.LastModifyDate, A10.FullName AS LastModifyUserID,
			T1.InheritTable, T1.InheritVoucher
			'+@sSQLSL+'
		FROM QCT2000_TEMP T1  WITH (NOLOCK)
			LEFT JOIN HT1020 T2 WITH (NOLOCK) ON T1.ShiftID = T2.ShiftID
			LEFT JOIN CIT1150 T3 WITH (NOLOCK) ON T1.MachineID = T3.MachineID
			LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T1.EmployeeID01 = T4.EmployeeID
			LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T1.EmployeeID02 = T5.EmployeeID
			LEFT JOIN AT1103 T6 WITH (NOLOCK) ON T1.EmployeeID03 = T6.EmployeeID
			LEFT JOIN AT1103 T7 WITH (NOLOCK) ON T1.EmployeeID04 = T7.EmployeeID
			LEFT JOIN AT1103 T8 WITH (NOLOCK) ON T1.EmployeeID05 = T8.EmployeeID
			LEFT JOIN AT1103 T9 WITH (NOLOCK) ON T1.EmployeeID06 = T9.EmployeeID
			LEFT JOIN AT1102 T10 WITH (NOLOCK) ON T10.DivisionID IN (T1.DivisionID,''@@@'') AND T10.DepartmentID = T1.DepartmentID
			LEFT JOIN AT1103 A09 WITH (NOLOCK) ON A09.EmployeeID = T1.CreateUserID
			LEFT JOIN AT1103 A10 WITH (NOLOCK) ON A10.EmployeeID = T1.LastModifyUserID
			LEFT JOIN AT1011 A11 WITH (NOLOCK) ON A11.AnaID = T1.Ana04ID and A11.DivisionID IN (T1.DivisionID,''@@@'') 
			LEFT JOIN AT1202 A12 WITH (NOLOCK) ON A12.ObjectID = T1.ObjectID and A12.DivisionID IN (T1.DivisionID,''@@@'') 
			LEFT JOIN OOT0099 O99 WITH(NOLOCK) ON O99.CodeMaster = ''Status'' AND T1.StatusSS = O99.ID
			LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON T1.APKMaster_9000 = OOT90.APK           
		 '+@sSQLJon+'
		 UNION ALL'
		EXEC (@sSQL1+@sSQL)
		PRINT (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO