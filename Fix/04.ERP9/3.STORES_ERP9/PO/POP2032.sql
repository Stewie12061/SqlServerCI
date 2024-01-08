IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2032]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2032]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Master phiếu yêu cầu mua hàng 9.0
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Như Hàn on: 06/12/2018
---- Modified by Như Hàn on 04/04/2019: Bổ sung thông tin duyệt
---- Modified by Trọng Kiên on 21/10/2020: Bổ sung load tên người tạo và người sửa
---- Modified by Trọng Kiên on 13/11/2020: Fix lỗi load độ ưu tiên
---- Modified by:Hoàng Long on 15/08/2023 - [2023/08/TA/0034] - Gree-Bổ sung trường phòng ban màn hình YCMH
---- Modified by:Hoàng Long on 30/08/2023 - [2023/08/IS/0324] - Fix lỗi hiển thị sai tên phòng ban
-- <Example>
/*
	EXEC POP2032 'HD', '','HDVNS-H1506023', '', 'YCMH'
	EXEC POP2032 @DivisionID, @UserID, @ROrderID
*/

CREATE PROCEDURE POP2032
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@ROrderID VARCHAR(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @Ssql Nvarchar(max), 
		@Swhere  Nvarchar(max) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = ''



IF ISNULL(@Type, '') = 'YCMH' 
BEGIN
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),O01.APKMaster_9000)= '''+@APKMaster+''''
SELECT @Level = MAX(ApproveLevel) FROM OT3102 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster AND DivisionID = @DivisionID
END
ELSE 
BEGIN
SET @Swhere = @Swhere + 'AND (O01.ROrderID = '''+@ROrderID+'''' + 'OR CONVERT(VARCHAR(50), O01.APK) = '''+@ROrderID+''')'
SELECT @Level = MAX(ApproveLevel) 
	FROM OT3102 WITH (NOLOCK) LEFT JOIN OT3101 ON OT3102.ROrderID = OT3101.ROrderID 
	WHERE OT3102.DivisionID = @DivisionID AND (OT3102.ROrderID = @ROrderID OR CONVERT(VARCHAR(50),OT3101.APK) = @ROrderID) 
END


	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, ApprovePerson'+@s+'Status, ApprovePerson'+@s+'StatusName, ApprovePerson'+@s+'Note'
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
						 HT14.FullName As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
						OOT1.Note ApprovePerson'+@s+'Note
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON HT14.DivisionID=OOT1.DivisionID AND HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END	




SET @Ssql = N'
	SELECT Top 1
	O01.APK,
	O01.APKMaster_9000 APKMaster,
	O01.DivisionID,
	T01.DivisionName,
	O01.ROrderID,
	O01.VoucherTypeID,
	T07.VoucherTypeName,
	O01.VoucherNo,
	O01.OrderDate,
	O01.InventoryTypeID,
	CASE WHEN ISNULL(O01.InventoryTypeID,'''') = ''%'' THEN N''Tất cả'' ELSE T03.InventoryTypeName END InventoryTypeName,
	O01.CurrencyID,
	T04.CurrencyName,
	O01.ExchangeRate,
	O01.ReceivedAddress,
	O01.Description,
	O01.Disabled,
	O01.OrderStatus,
	T99.Description As OrderStatusName,
	O01.CreateUserID +''_''+ A12.FullName as CreateUserID,
	O01.CreateDate,
	O01.LastModifyUserID +''_''+ A13.FullName as LastModifyUserID,
	O01.LastModifyDate,
	O01.TranMonth,
	O01.TranYear,
	O01.EmployeeID,
	A2.DepartmentName,
	T13.FullName As EmployeeName,
	O01.Transport,
	O01.PaymentID,
	T05.PaymentName,
	O01.ShipDate,
	O01.ContractNo,
	O01.ContractDate,
	O01.DueDate,
	O01.PriorityID,
	O99.Description As PriorityName,
	O01.Status,
	TO9.Description As StatusName,
	O02.ApproveLevel,
	O01.RequestID,
	CR01.RequestSubject As RequestName,
	CR01.OpportunityID,
	CR02.OpportunityName,O01.TaskID,O01.TaskID +''_''+D24.TaskName as TaskName,O01.Ana06ID,AT11.AnaName as Ana06Name
	'+@sSQLSL+'
	FROM OT3101 O01 WITH (NOLOCK)
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON O01.APKMaster_9000 = OOT90.APK
	LEFT JOIN (SELECT DISTINCT ROrderID, ApproveLevel FROM OT3102 O02 WITH (NOLOCK)) O02 ON O01.ROrderID = O02.ROrderID
	LEFT JOIN AT1101 T01 WITH (NOLOCK) ON O01.DivisionID = T01.DivisionID
	LEFT JOIN AT1007 T07 WITH (NOLOCK) ON O01.VoucherTypeID = T07.VoucherTypeID
	LEFT JOIN AT1301 T03 WITH (NOLOCK) ON O01.InventoryTypeID = T03.InventoryTypeID
	LEFT JOIN AT1004 T04 WITH (NOLOCK) ON O01.CurrencyID = T04.CurrencyID
	LEFT JOIN AT0099 T99 WITH (NOLOCK) ON O01.OrderStatus = T99.ID AND T99.CodeMaster = ''AT00000003''
	LEFT JOIN AT1103 T13 WITH (NOLOCK) ON O01.EmployeeID = T13.EmployeeID
	LEFT JOIN AT1205 T05 WITH (NOLOCK) ON O01.PaymentID = T05.PaymentID
	LEFT JOIN OT0099 O99 WITH (NOLOCK) ON O01.PriorityID = O99.ID AND O99.CodeMaster = ''PriorityID''
	LEFT JOIN OOT0099 TO9 WITH (NOLOCK) ON O01.Status = TO9.ID AND TO9.CodeMaster = ''Status''
	LEFT JOIN CRMT20801 CR01 WITH(NOLOCK) ON O01.RequestID = CR01.APK
	LEFT JOIN CRMT20501 CR02 WITH(NOLOCK) ON CR01.OpportunityID = CR02.OpportunityID AND CR01.DivisionID = CR02.DivisionID
	LEFT JOIN OOT2110 D24 With (NOLOCK) on O01.TaskID = D24.TaskID and O01.DivisionID = D24.DivisionID
	LEFT JOIN AT1011 AT11 WITH (NOLOCK) ON AT11.AnaID = O01.Ana06ID AND AT11.AnaTypeID = ''A06''
	LEFT JOIN AT1103 A12 WITH (NOLOCK) ON A12.EmployeeID = O01.CreateUserID
    LEFT JOIN AT1103 A13 WITH (NOLOCK) ON A13.EmployeeID = O01.LastModifyUserID
	LEFT JOIN AT1102 A2 WITH (NOLOCK) ON A2.DepartmentID = T13.DepartmentID
	'+@sSQLJon+'
	WHERE O01.DivisionID = '''+@DivisionID+''' '+@Swhere+''
SET @Ssql = @Ssql + '
	ORDER BY O01.ROrderID'

EXEC (@Ssql)
PRINT @Ssql



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
