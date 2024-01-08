IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0196]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CP0196]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Cập nhật thông tin hợp đồng  CF0211
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga o on 24/03/2022
----Modify by Kiều Nga on 14/04/2022    Bổ sung thông tin chỉ số đăng ký định mức ở hợp đồng
----Modify by Kiều Nga on 22/04/2022    Load thông tin tình trạng hợp đồng 
----Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 
/*-- <Example>
	CP0196 @DivisionID = 'CBD', @UserID = '', @APK = '897F86B9-DE12-4FF3-AFDD-9E906EE85611'

	EXEC CP0196 @DivisionID, @UserID, @APK
----*/

CREATE PROCEDURE CP0196
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''

SET @sSQL = @sSQL + N'
SELECT T1.APK,T1.DivisionID,T1.ContractNo,T1.VoucherTypeID,T1.ContractName,T1.ContractType,T1.SignDate,T1.ObjectID,T2.ObjectName,
T2.Address,T2.VATNo,T2.Contactor,T2.Tel,T2.Fax,T1.BeginDate,T1.EndDate,T1.CurrencyID,T1.ExchangeRate,T1.Description,
T1.OriginalAmount,T1.ConvertedAmount,T1.AdministrativeExpenses,T1.ConvertedAmountLandLease,T1.ConvertedAmountBrokerage,
T1.CreateUserID,T1.CreateDate,T1.LastModifyUserID,T1.LastModifyDate,
T1.IsInheritMemorandum,T1.InheritMemorandumID,T1.IsInheritOriginalContract,T1.InheritOriginalContractID,T1.IsInheritLandLease,T1.InheritLandLeaseID,
T1.RegistrationWater,T1.RegistrationElectricity,T1.RegistrationEnvironmentalFees,T1.StatusID,T3.Description as StatusName,T1.HandOverDate,T1.AdministrativeExpensesDate
FROM CT0155 T1 WITH (NOLOCK) 
LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T2.ObjectID = T1.ObjectID
LEFT JOIN AT0099 T3 WITH (NOLOCK) ON T3.ID = T1.StatusID AND T3.Disabled = 0 AND T3.CodeMaster =''StatusPlot''
WHERE T1.DivisionID = '''+@DivisionID +''' AND T1.APK ='''+@APK+'''
'
PRINT(@sSQL)
EXEC (@sSQL)
   


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
