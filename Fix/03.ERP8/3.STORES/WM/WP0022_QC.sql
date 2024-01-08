IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0022_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0022_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load Grid chi tiết màn hình điều chỉnh tăng giảm khi nhấn thực hiện tại màn hình WF0020
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tiểu Mai on 30/10/2015
---- Moified by ... on ...
---- Modified by TIểu Mai	on 24/05/2017 : Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử	on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Văn Tài	on 07/04/2021 : Format lại SQL, không ảnh hưởng code.
---- Modified by Hoài Bảo	on 23/11/2022 : Bổ sung load tên đơn vị tính, tài khoản nợ/tài khoản có
-- <Example>
/*
	exec WP0022 'SC','ASOFTADMIN','','',1
*/
CREATE PROCEDURE WP0022_QC
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@VoucherID VARCHAR(50),
	@ListInventoryID NVARCHAR (MAX),
	@IsType TINYINT=0 --1: Điều chỉnh tăng , 2: điều chỉnh giảm
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@SWhere NVARCHAR(MAX)
		
IF @IsType=1
	SET @SWhere='AND ISNULL(Quantity, 0) - ISNULL(AdjustQuantity, 0) < 0 '
ELSE 
	SET @SWhere='AND ISNULL(Quantity, 0) - ISNULL(AdjustQuantity, 0) > 0 '

SET @sSQL = '
SELECT A37.*
		, A02.InventoryName, A04.UnitName, A05.AccountID, A05.AccountName
		, (A37.AdjutsOriginalAmount - A37.OriginalAmount) / (A37.AdjustQuantity - A37.Quantity) AS Price
		, O99.S01ID
		, O99.S02ID
		, O99.S03ID
		, O99.S04ID
		, O99.S05ID
		, O99.S06ID
		, O99.S07ID
		, O99.S08ID
		, O99.S09ID
		, O99.S10ID
		, O99.S11ID
		, O99.S12ID
		, O99.S13ID
		, O99.S14ID
		, O99.S15ID
		, O99.S16ID
		, O99.S17ID
		, O99.S18ID
		, O99.S19ID
		, O99.S20ID
		, AT01.StandardName S01Name
		, AT02.StandardName S02Name
		, AT03.StandardName S03Name
		, AT04.StandardName S04Name
		, AT05.StandardName S05Name
		, AT06.StandardName S06Name
		, AT07.StandardName S07Name
		, AT08.StandardName S08Name
		, AT09.StandardName S09Name
		, AT10.StandardName S10Name
		, AT11.StandardName S11Name
		, AT12.StandardName S12Name
		, AT13.StandardName S13Name
		, AT14.StandardName S14Name
		, AT15.StandardName S15Name
		, AT16.StandardName S16Name
		, AT17.StandardName S17Name
		, AT18.StandardName S18Name
		, AT19.StandardName S19Name
		, AT20.StandardName S20Name
FROM AT2037 A37 WITH (NOLOCK)
	LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', A37.DivisionID) AND A02.InventoryID = A37.InventoryID
	LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.DivisionID IN (''@@@'', A37.DivisionID) AND A04.UnitID = A37.UnitID
	LEFT JOIN AT1005 A05 WITH (NOLOCK) ON A05.DivisionID IN (''@@@'', A37.DivisionID) AND A05.AccountID = A37.DebitAccountID
	LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = A37.DivisionID AND O99.TransactionID = A37.TransactionID AND O99.VoucherID = A37.VoucherID
	LEFT JOIN AT0128 AT01 WITH (NOLOCK) ON AT01.StandardTypeID = ''S01'' AND AT01.StandardID = O99.S01ID 
	LEFT JOIN AT0128 AT02 WITH (NOLOCK) ON AT02.StandardTypeID = ''S02'' AND AT02.StandardID = O99.S02ID 
	LEFT JOIN AT0128 AT03 WITH (NOLOCK) ON AT03.StandardTypeID = ''S03'' AND AT03.StandardID = O99.S03ID 
	LEFT JOIN AT0128 AT04 WITH (NOLOCK) ON AT04.StandardTypeID = ''S04'' AND AT04.StandardID = O99.S04ID 
	LEFT JOIN AT0128 AT05 WITH (NOLOCK) ON AT05.StandardTypeID = ''S05'' AND AT05.StandardID = O99.S05ID 
	LEFT JOIN AT0128 AT06 WITH (NOLOCK) ON AT06.StandardTypeID = ''S06'' AND AT06.StandardID = O99.S06ID 
	LEFT JOIN AT0128 AT07 WITH (NOLOCK) ON AT07.StandardTypeID = ''S07'' AND AT07.StandardID = O99.S07ID 
	LEFT JOIN AT0128 AT08 WITH (NOLOCK) ON AT08.StandardTypeID = ''S08'' AND AT08.StandardID = O99.S08ID 
	LEFT JOIN AT0128 AT09 WITH (NOLOCK) ON AT09.StandardTypeID = ''S09'' AND AT09.StandardID = O99.S09ID 
	LEFT JOIN AT0128 AT10 WITH (NOLOCK) ON AT10.StandardTypeID = ''S10'' AND AT10.StandardID = O99.S10ID 
	LEFT JOIN AT0128 AT11 WITH (NOLOCK) ON AT11.StandardTypeID = ''S11'' AND AT11.StandardID = O99.S11ID 
	LEFT JOIN AT0128 AT12 WITH (NOLOCK) ON AT12.StandardTypeID = ''S12'' AND AT12.StandardID = O99.S12ID 
	LEFT JOIN AT0128 AT13 WITH (NOLOCK) ON AT13.StandardTypeID = ''S13'' AND AT13.StandardID = O99.S13ID 
	LEFT JOIN AT0128 AT14 WITH (NOLOCK) ON AT14.StandardTypeID = ''S14'' AND AT14.StandardID = O99.S15ID 
	LEFT JOIN AT0128 AT15 WITH (NOLOCK) ON AT15.StandardTypeID = ''S15'' AND AT15.StandardID = O99.S15ID 
	LEFT JOIN AT0128 AT16 WITH (NOLOCK) ON AT16.StandardTypeID = ''S16'' AND AT16.StandardID = O99.S16ID 
	LEFT JOIN AT0128 AT17 WITH (NOLOCK) ON AT17.StandardTypeID = ''S17'' AND AT17.StandardID = O99.S17ID 
	LEFT JOIN AT0128 AT18 WITH (NOLOCK) ON AT18.StandardTypeID = ''S18'' AND AT18.StandardID = O99.S18ID 
	LEFT JOIN AT0128 AT19 WITH (NOLOCK) ON AT19.StandardTypeID = ''S19'' AND AT19.StandardID = O99.S19ID 
	LEFT JOIN AT0128 AT20 WITH (NOLOCK) ON AT20.StandardTypeID = ''S20'' AND AT20.StandardID = O99.S20ID 
WHERE A37.DivisionID = '''+@DivisionID+'''
AND A37.VoucherID = '''+@VoucherID+'''
AND ISNULL(ReTransactionID, '''') = ''''
'+@SWhere+'
AND IsAdjust = 0
AND A37.InventoryID IN ('''+@ListInventoryID+''')
'

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
