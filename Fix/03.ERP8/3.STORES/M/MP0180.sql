IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0180]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0180]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load danh sách đề nghị định mức lên màn hình duyệt MF0179
-- <History>
---- Created by Tiểu Mai on 20/08/2016
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>

/*
 * exec MP0180 'PC', '2016-08-01', '2016-08-31', 0, '%', 0
 */

CREATE PROCEDURE [dbo].[MP0180] 	
	@DivisionID NVARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@ApportionTypeID INT,
	@ObjectID NVARCHAR(50),
	@Status TINYINT,
	@Type TINYINT    --- 0: Chưa duyệt, 1: Đã duyệt
AS
DECLARE @sSQL NVARCHAR(MAX) = '', @sWhere NVARCHAR(MAX) = ''

IF @ApportionTypeID IS NOT NULL
	SET @sWhere = @sWhere + ' AND MT0135.ApportionTypeID  = '+CONVERT(NVARCHAR(2), @ApportionTypeID)

IF @Status IS NOT NULL 
	SET @sWhere = @sWhere + ' AND MT0176.[Status]  = '+CONVERT(NVARCHAR(2), @Status)


SET @sSQL = N'
SELECT DISTINCT MT0176.DivisionID, VoucherNo, MT0176.[Description], VoucherID, VoucherDate, MT0176.CreateUserID,
MT0135.ApportionID, MT0135.[Description] AS ApportionName, MT0135.ObjectID, AT1202.ObjectName,
MT0135.ApportionTypeID, CASE WHEN ISNULL(MT0135.ApportionTypeID,0) = 0 THEN N''Định mức khách hàng'' ELSE 
	CASE WHEN ISNULL(MT0135.ApportionTypeID,0) = 0 THEN N''Định mức kế hoạch'' ELSE
		CASE WHEN ISNULL(MT0135.ApportionTypeID,0) = 0 THEN N''Định mức sản xuất'' ELSE N''Định mức gia công'' END END END AS ApportionTypeName,
MT0176.[Status], CASE WHEN Isnull(MT0176.[Status],0) = 0 THEN N''Chưa chấp nhận'' ELSE CASE WHEN ISNULL(MT0176.[Status],1) = 1 THEN N''Chấp nhận'' ELSE N''Từ chối'' END END AS StatusName,
Isnull(MT0176.IsConfirm01,0) as IsConfirm01,
CASE WHEN Isnull(MT0176.IsConfirm01,0) = 0 THEN N''Chưa chấp nhận'' ELSE CASE WHEN Isnull(MT0176.IsConfirm01,0) = 1 THEN N''Xác nhận'' ELSE N''Từ chối'' END END AS IsConfirm01Name,
MT0176.ConfDescription01,
Isnull(MT0176.IsConfirm02,0) as IsConfirm02,
CASE WHEN Isnull(MT0176.IsConfirm02,0) = 0 THEN N''Chưa chấp nhận'' ELSE CASE WHEN Isnull(MT0176.IsConfirm02,0) = 1 THEN N''Xác nhận'' ELSE N''Từ chối'' END END AS IsConfirm02Name,
MT0176.ConfDescription02
FROM MT0176 WITH (NOLOCK)
LEFT JOIN MT0135 WITH (NOLOCK) ON MT0135.DivisionID = MT0176.DivisionID AND MT0135.ApportionID = MT0176.InheritApportionID
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = MT0135.ObjectID
WHERE MT0176.DivisionID = '''+@DivisionID+'''
	AND Convert(Nvarchar(10), MT0176.VoucherDate,112) BETWEEN '+Convert(Nvarchar(10), @FromDate,112)+' AND '+Convert(Nvarchar(10), @ToDate,112)+'
	'+ CASE WHEN ISNULL(@Type,0) = 0 THEN 'AND Isnull(MT0176.IsConfirm01,0) = 0 ' ELSE ' AND Isnull(MT0176.IsConfirm01,0) IN (1,2) ' END +'
	AND MT0135.ObjectID LIKE '''+@ObjectID+''''
+ @sWhere + '
Order by MT0176.VoucherDate
'
EXEC (@sSQL)
PRINT @sSQL




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
