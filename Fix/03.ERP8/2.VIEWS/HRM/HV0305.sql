IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HV0305]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HV0305]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Bảo Thy on 07/06/2017: Load danh mục loại Tăng/giảm tham gia BHXH
---- Modified by on 18/08/2020 by Huỳnh Thử: Merge Code: MEKIO và MTE

CREATE  View [dbo].[HV0305]
AS
SELECT 'TM' AS ProjectID, N'Tăng mới' AS ProjectName, 0 AS IsUpDown
UNION ALL
SELECT 'TC' AS ProjectID, N'Tăng mới do chuyển từ tỉnh khác đến' AS ProjectName, 0 AS IsUpDown
UNION ALL
SELECT 'TD' AS ProjectID, N'Tăng mới do chuyển từ đơn vị khác đến' AS ProjectName, 0 AS IsUpDown
UNION ALL
SELECT 'ON' AS ProjectID, N'Tăng sau khi nghỉ thai sản, nghỉ ốm đau hoặc nghỉ không lương dài ngày' AS ProjectName, 0 AS IsUpDown
UNION ALL
SELECT 'AD' AS ProjectID, N'Điều chỉnh Bổ sung tăng nguyên lương' AS ProjectName, 0 AS IsUpDown
UNION ALL
SELECT 'DC1' AS ProjectID, N'Điều chỉnh tăng mức lương tham gia' AS ProjectName, 0 AS IsUpDown
UNION ALL
SELECT 'TT' AS ProjectID, N'Điều chỉnh Bổ sung tăng số phải thu BHYT' AS ProjectName, 0 AS IsUpDown
UNION ALL
SELECT 'TN' AS ProjectID, N'Tăng BHTN' AS ProjectName, 0 AS IsUpDown
UNION ALL
SELECT 'CD' AS ProjectID, N'Điều chỉnh chức danh' AS ProjectName, 0 AS IsUpDown
UNION ALL
SELECT 'GH1' AS ProjectID, N'Giảm hẳn (Chấm dứt HĐLĐ/Chuyển công tác)' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'GH2' AS ProjectID, N'Giảm hẳn (Nghỉ hưu)' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'GH3' AS ProjectID, N'Giảm hẳn (Nghỉ thai sản, ốm, không lương)' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'GH4' AS ProjectID, N'Giảm hẳn (Bị chết)' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'GC' AS ProjectID, N'Giảm do chuyển đơn vị khác tỉnh' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'GD' AS ProjectID, N'Giảm đến nơi khác cùng tỉnh' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'DC2' AS ProjectID, N'Điều chỉnh giảm mức lương tham gia' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'KL' AS ProjectID, N'Giảm do nghỉ không lương' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'TS' AS ProjectID, N'Giảm do nghỉ thai sản' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'OF1' AS ProjectID, N'Giảm do nghỉ ốm ngắn ngày' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'OF2' AS ProjectID, N'Giảm do nghỉ ốm dài ngày' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'SB' AS ProjectID, N'Điều chỉnh bổ sung giảm nguyên lương' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'TU' AS ProjectID, N'Điều chỉnh bổ sung giảm số phải thu BHYT' AS ProjectName, 1 AS IsUpDown
UNION ALL
SELECT 'GN' AS ProjectID, N'Điều chỉnh bổ sung giảm số phải thu BHTN' AS ProjectName, 1 AS IsUpDown

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
