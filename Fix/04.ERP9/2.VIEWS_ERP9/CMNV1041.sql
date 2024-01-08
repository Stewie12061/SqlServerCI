IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNV1041]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[CMNV1041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Bảo Thy on 21/09/2017: view chết load combo danh sách nghiệp vụ

CREATE VIEW [dbo].[CMNV1041]
AS
SELECT 'APPROVE' AS TransactionTypeID, N'Duyệt đề nghị' AS TransactionTypeName, N'Approve suggestion' AS TransactionTypeNameE, 'ASOFTHRM' AS ModuleID
UNION ALL
SELECT 'SUGGEST' AS TransactionTypeID, N'Phụ trách đề nghị cần duyệt' AS TransactionTypeName, N'Suggest' AS TransactionTypeNameE, 'ASOFTHRM' AS ModuleID
UNION ALL
SELECT 'LPV' AS TransactionTypeID, N'Lịch phỏng vấn' AS TransactionTypeName, N'Interview schedule' AS TransactionTypeNameE, 'ASOFTHRM' AS ModuleID
UNION ALL
SELECT 'KQTD' AS TransactionTypeID, N'Kết quả tuyển dụng' AS TransactionTypeName, N'Interview result' AS TransactionTypeNameE, 'ASOFTHRM' AS ModuleID
UNION ALL
SELECT 'QDTD' AS TransactionTypeID, N'Quyết định tuyển dụng' AS TransactionTypeName, N'Recruitment decision' AS TransactionTypeNameE, 'ASOFTHRM' AS ModuleID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
