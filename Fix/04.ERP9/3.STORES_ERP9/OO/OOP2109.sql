IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2109]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2109]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
-- Kiểm tra trước khi xóa dữ liệu liên kết với Dự án/nhóm công việc
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Khâu Vĩnh Tâm, Date: 01/02/2021
/* Example:
	EXEC OOP2109 'DTI', 'ASOFTADMIN', '80c76c1b-298c-4dfa-a2bf-b0e30dac9ce4', '200140', 'OOT2100'
		, 'b7349d84-efad-4c9a-b291-0d517c8fa16c,1a8cc9a5-fabc-4a61-a2cc-defd10202aad,1d70ef67-cf2e-4869-82bc-a6b4d9770db6', 'VD/2021/02/0004,VD/2021/01/0007,VD/2021/01/0005', 'OOT2160'
 */

CREATE PROCEDURE OOP2109 (
	@DivisionID VARCHAR(50),			-- Mã đơn vị, biến môi trường
	@UserID VARCHAR(50),				-- User đăng nhập, biến môi trường
	@APKParent VARCHAR(50),				-- APK của nghiệp vụ cha, APK Dự án
	@BusinessParent VARCHAR(50),		-- Mã dự án
	@TableBusinessParent VARCHAR(50),	-- Tên bảng dự án: OOT2100
	@APKChild VARCHAR(MAX),				-- Danh sách APK của nghiệp vụ cần gỡ liên kết
	@BusinessChild VARCHAR(MAX),		-- Danh sách Mã chứng từ của nghiệp vụ cần gỡ liên kết
	@TableBusinessChild VARCHAR(50)		-- Bảng của nghiệp vụ cần gỡ liên kết
)
AS
BEGIN
	DECLARE @RefTable TABLE (BusinessID VARCHAR(50))

	-- Bảng chứa APK của các phiếu nghiệp vụ cần xóa
	SELECT Value AS APK
	INTO #OOP2109_APKChild
	FROM StringSplit(@APKChild, ',')

	-- Bảng chứa APK của các phiếu nghiệp vụ được liên kết hợp lệ
	SELECT O1.APK, O1.APKChild
	INTO #OOP2109_APKRef
	FROM OOT0088 O1 WITH (NOLOCK)
	WHERE APKParent = @APKParent AND BusinessParent = @BusinessParent AND TableBusinessParent = @TableBusinessParent
		AND TableBusinessChild = @TableBusinessChild AND APKChild IN (SELECT APK FROM #OOP2109_APKChild)
		
	-- Trường hợp dữ liệu xóa là hợp lệ thì thực hiện xóa theo các APK đã được đưa vào bảng tạm
	IF NOT EXISTS(SELECT TOP 1 1 FROM #OOP2109_APKChild T1
		WHERE T1.APK NOT IN (SELECT APKChild FROM #OOP2109_APKRef))
	BEGIN
		DELETE OOT0088
		WHERE APK IN (SELECT APK FROM #OOP2109_APKRef)
	END
	ELSE
	-- Trường hợp danh sách APK có giá trị không tồn tại trong bảng dữ liệu liên kết thì báo lỗi
	BEGIN
		-- Quản lý vấn đề
		IF (@TableBusinessChild = 'OOT2160')
		BEGIN
			INSERT INTO @RefTable
			SELECT O1.IssuesID FROM OOT2160 O1 WITH (NOLOCK)
			WHERE APK IN (SELECT APK FROM #OOP2109_APKChild T1 WHERE T1.APK NOT IN (SELECT APKChild FROM #OOP2109_APKRef))
			ORDER BY O1.IssuesID
		END
		ELSE
		-- Đầu mối
		IF (@TableBusinessChild = 'CRMT20301')
		BEGIN
			INSERT INTO @RefTable
			SELECT C1.LeadID FROM CRMT20301 C1 WITH (NOLOCK)
			WHERE APK IN (SELECT APK FROM #OOP2109_APKChild T1 WHERE T1.APK NOT IN (SELECT APKChild FROM #OOP2109_APKRef))
			ORDER BY C1.LeadID
		END
		-- Liên hệ
		IF (@TableBusinessChild = 'CRMT10001')
		BEGIN
			INSERT INTO @RefTable
			SELECT C1.ContactID FROM CRMT10001 C1 WITH (NOLOCK)
			WHERE APK IN (SELECT APK FROM #OOP2109_APKChild T1 WHERE T1.APK NOT IN (SELECT APKChild FROM #OOP2109_APKRef))
			ORDER BY C1.ContactID
		END
		-- Yêu cầu
		IF (@TableBusinessChild = 'CRMT20801')
		BEGIN
			INSERT INTO @RefTable
			SELECT C1.RequestCustomerID FROM CRMT20801 C1 WITH (NOLOCK)
			WHERE APK IN (SELECT APK FROM #OOP2109_APKChild T1 WHERE T1.APK NOT IN (SELECT APKChild FROM #OOP2109_APKRef))
			ORDER BY C1.RequestCustomerID
		END
	END

	SELECT *
	FROM @RefTable
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
