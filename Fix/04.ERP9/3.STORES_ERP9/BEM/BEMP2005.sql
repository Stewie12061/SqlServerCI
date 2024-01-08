IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- Load Master cho màn hình Update - BEMF2001 (Cập nhật phiếu DNTT/DNTTTU/DNTU)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Create by Vĩnh Tâm on 15/06/2020
---- Modified by Vĩnh Tâm on 03/11/2020: Xử lý lỗi mở form khi có cùng người duyệt cho nhiều cấp
---- Modified by Trọng Kiên on 19/02/2021: Bổ sung load cột ConvertedAdvancePayment gốc (AdvancePayment)
/* <Example>
	-- Mở màn hình Cập nhật
	EXEC BEMP2005 @DivisionID = 'MK', @UserID = 'KT001', @APK = 'bc036ebf-ca37-4c31-9823-277f1516ec80', @APKMaster = '', @Type = ''
	-- Mở màn hình Xét duyệt
	EXEC BEMP2005 @DivisionID = 'MK', @UserID = 'KT001', @APK = '', @APKMaster = '7e34579a-edb2-408f-ac85-3fae20037cc4', @Type = 'PDN'
 */

CREATE PROCEDURE [dbo].[BEMP2005]
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APK VARCHAR(50),
	@APKMaster VARCHAR(50),
	@Type VARCHAR(50)
)
AS
BEGIN

	DECLARE @sSQL NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX) = '',
			@Level INT,
			@i INT = 1,
			@s VARCHAR(2),
			@sSQLSL NVARCHAR (MAX) = '',
			@sLevelApprove VARCHAR(50) = '',
			@sSQLJoin NVARCHAR (MAX) = '',
			@sSQLOrderBy NVARCHAR (MAX) = ''

	-- Lấy cấp độ duyệt của phiếu hiện tại
	SELECT @Level = MAX(Levels) FROM BEMT2000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND (CONVERT(VARCHAR(50), APK) = @APK OR CONVERT(VARCHAR(50), APKMaster_9000) IN (@APK, @APKMaster))

	SET @sWhere = ' B1.DivisionID = ''' + @DivisionID + ''''
	SET @APK = IIF(ISNULL(@APK, '') != '', @APK, @APKMaster)

	-- Trường hợp mở màn hình Xét duyệt
	IF ISNULL(@Type, '') = 'PDN'
	BEGIN
		--SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(50), B1.APKMaster_9000) = ''' + @APKMaster + ''''
		
		SET @sLevelApprove = ', O2.Level AS CurrentLevel'
		SET @sSQLSL = ' , O2.Status AS Status, O2.Note '
		SET @sSQLJoin = 'LEFT JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = B1.APKMaster_9000 AND O2.ApprovePersonID = ''' + @UserID + ''''
		-- Trường hợp mở từ màn hình Duyệt thì thực hiện sắp xếp theo Cấp duyệt giảm dần và lấy TOP 1 => Xử lý lỗi mở form khi có cùng người duyệt cho nhiều cấp
		SET @sSQLOrderBy = ' ORDER BY O2.Level DESC'
	END
	--ELSE
	-- Trường hợp mở màn hình cập nhật
	BEGIN
		SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(50), B1.APK) = ''' + @APK + ''' OR CONVERT(VARCHAR(50), B1.APKMaster_9000) = ''' + @APK + ''')'

		WHILE @i < = @Level
		BEGIN
			IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
			ELSE SET @s = CONVERT(VARCHAR, @i)

			SET @sSQLSL = @sSQLSL + ' , ApprovePerson' + @s + 'ID, ApprovePerson' + @s + 'Name'
		
			SET @sSQLJoin =  @sSQLJoin + '
							LEFT JOIN (
								SELECT ApprovePersonID ApprovePerson' + @s + 'ID, OOT1.APKMaster, OOT1.DivisionID, OOT1.Status AS Status' + @s + ',
									A1.FullName As ApprovePerson' + @s + 'Name
								FROM OOT9001 OOT1 WITH (NOLOCK)
									INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID = OOT1.DivisionID AND A1.EmployeeID = OOT1.ApprovePersonID
								WHERE OOT1.Level = ' + STR(@i) + '
							) APP' + @s + ' ON APP' + @s + '.DivisionID = O1.DivisionID AND APP' + @s + '.APKMaster = O1.APK'
			SET @i = @i + 1
		END
	END

	SET @sSQL = N'
		SELECT TOP 1 B1.APK, B1.DivisionID, B1.APKMaster_9000, ''' + ISNULL(@Type, '') + ''' AS Type, B1.Levels' + @sLevelApprove + '
			, B1.TranMonth, B1.TranYear, B1.VoucherNo, B1.VoucherDate, B1.TypeID
			, B1.DepartmentID, B1.PhoneNumber, B1.ApplicantID, A3.FullName AS ApplicantName, B1.MethodPay
			, B1.PaymentTermID, B1.FCT, B1.CurrencyID, B1.ExchangeRate, B1.DescriptionMaster
			, B1.AdvancePayment, B1.AdvanceUserID, A4.ObjectName AS AdvanceUserName, A4.Address AS ObjectAddress, B1.DueDate
			, B1.Deadline, B1.DeleteFlg, B1.APKInherited, B1.InheritVoucherNo, B1.InheritType
			, B1.ApprovingLevel, B1.ApproveLevel
			, B1.CreateUserID, B1.CreateDate, B1.LastModifyUserID, B1.LastModifyDate, B1.ConvertedAdvancePayment
			' + @sSQLSL + '
		FROM BEMT2000 B1 WITH (NOLOCK)
			LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON B1.APKMaster_9000 = O1.APK
			LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = B1.ApplicantID AND A3.DivisionID = B1.DivisionID
			LEFT JOIN AT1202 A4 WITH (NOLOCK) ON A4.ObjectID = B1.AdvanceUserID AND A4.DivisionID = B1.DivisionID
			' +  @sSQLJoin + '
		WHERE ' + @sWhere + '
		' + @sSQLOrderBy

	EXEC (@sSQL)
	--PRINT (@sSQL)

END








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
