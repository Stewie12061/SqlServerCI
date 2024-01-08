IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HV1117]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HV1117]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------Create Date: 01/05/2017
------Purpose: View chết load combo số liệu (thiết lập báo cáo lương)
------Modified on 27/11/2018 by Bảo Anh: Sửa giá trị Code và Type cho các khoản bảo hiểm cty đóng
------Edit Date: 

CREATE VIEW [dbo].[HV1117] 
AS  

SELECT DivisionID, IncomeID AS CodeID, Caption AS Caption,
      'IO'  AS Type, N'Thu nhập' as Description
      FROM HT0002
      WHERE IsUsed = 1
      UNION
      SELECT DivisionID, CoefficientID  as CodeID,    Caption ,
      'CO'  AS Type, N'Hệ số' as Description
      FROM HV1111
      UNION
      SELECT DivisionID, GeneralAbsentID    AS CodeID,   Description AS Caption,
      'GA'  AS Type, N'Ngày công tổng hợp' as Description
      FROM HT5002
      UNION
      SELECT DivisionID, AbsentTypeID as CodeID, AbsentName as Caption,
      'MA' AS Type, N'Ngày công tháng' as Description
      FROM HT1013
      WHERE IsMonth = 1
      UNION
      SELECT DivisionID, AbsentTypeID as CodeID, AbsentName as Caption,
      'DA' AS Type, N'Ngày công ngày' as Description
      FROM HT1013
      WHERE IsMonth <> 1 
      UNION
      SELECT DivisionID, FieldID AS CodeID, Description AS Caption,
      'SA'  AS Type, N'Mức lương' as Description
      FROM HV1112
      WHERE FOrders < 5 
      UNION  
      SELECT DivisionID, SubID AS CodeID, Caption,   
       'SU'  AS Type, N'Giảm trừ' as Description  
      FROM HT0005  
      WHERE IsUsed = 1  
      UNION  
      SELECT AT1101.DivisionID, 'S00' AS Code, N'Thuế thu nhập' AS Caption, 'SU' AS Type, N'Giảm trừ' AS Description 
      FROM AT1101 WITH (NOLOCK)
      UNION  
      SELECT AT1101.DivisionID, '' AS CodeID, N'Thuế thu nhập' AS Caption,   
       'TA'  AS Type, N'Thuế thu nhập' as Description 
      FROM AT1101 WITH (NOLOCK)    
      UNION
      SELECT AT1101.DivisionID, 'T01' AS CodeID, N'Tổng thu nhập' AS Caption,  
       'TA'  AS Type, N'Tổng thu nhập' as Description  
      FROM AT1101 WITH (NOLOCK)      
      UNION  
      SELECT AT1101.DivisionID, 'T02' AS CodeID, N'Thu nhập chịu thuế' AS Caption,  
       'TA'  AS Type, N'Thu nhập chịu thuế' as Description 
      FROM AT1101 WITH (NOLOCK)           
      UNION  
      SELECT AT1101.DivisionID, 'T03' AS CodeID, N'Giảm trừ gia cảnh' AS Caption,  
       'TA'  AS Type, N'Giảm trừ gia cảnh' as Description 
      FROM AT1101 WITH (NOLOCK)          
      UNION  
      SELECT AT1101.DivisionID, 'T04' AS CodeID, N'Số tiền phải đóng' AS Caption,  
       'TA'  AS Type, N'Số tiền phải đóng' as Description  
      FROM AT1101 WITH (NOLOCK)         
      UNION   
      Select AT1101.DivisionID, '' as Code, '' as Caption,  
       'OT' as Type, N'Khác' as Description  
      FROM AT1101 WITH (NOLOCK)          
       
      UNION   
      Select AT1101.DivisionID, 'C01' as Code, N'BHXH (công ty đóng)' as Caption, 'SC' as Type, N'Công ty đóng' as Description 
      FROM AT1101 WITH (NOLOCK)         
      UNION   
      Select AT1101.DivisionID, 'C02' as Code, N'BHYT (công ty đóng)' as Caption, 'SC' as Type, N'Công ty đóng' as Description    
      FROM AT1101 WITH (NOLOCK)          
      UNION   
      Select AT1101.DivisionID, 'C03' as Code, N'BHTN (công ty đóng)' as Caption, 'SC' as Type, N'Công ty đóng' as Description     
      FROM AT1101 WITH (NOLOCK)                         
       
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON