IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV3035]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV3035]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--PP:Tao view de truy van chi phi mua hang (Detail)
---- Modified by Hải Long on 19/05/2017: Chỉnh sửa danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
--Au:Thuy Tuyen
--Dates:30/06/2008

CREATE VIEW [dbo].[AV3035]
as

SELECT 
AT1202.ObjectName,
AT9000.* 
From AT9000 
LEFT JOIN AT1202 ON AT1202.DivisionID IN (AT9000.DivisionID, '@@@') AND AT9000.ObjectID = AT1202.ObjectID 
WHERE AT9000.TransactionTypeID IN ('T23') AND AT9000.TableID ='AT9000'

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


