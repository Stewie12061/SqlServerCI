IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP1000]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP1000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created on 22/06/2017 by Bảo Anh
---- Kiểm tra xóa danh mục
---- LMP1000 'AS','LMT1030','VTD', ''
----Modify on 07/01/2019 by Như Hàn: Bổ sung kiểm tra xóa danh mục nguồn thanh toán

CREATE PROCEDURE [dbo].[LMP1000] 
@DivisionID nvarchar(50), 
@TableID nvarchar(50), 
@KeyValues as nvarchar(50),
@ListKeyValues XML = ''
  AS


CREATE TABLE #LMP1000 (APK VARCHAR(50))
INSERT INTO #LMP1000 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @ListKeyValues.nodes('//Data') AS X (Data)
CREATE TABLE #LMP1000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

Declare @Status as tinyint
	
Select @Status =0

If @TableID ='LMT1001' ---  Hình thức tín dụng
Begin
  If exists (Select top 1 1  From LMT1011 Where CreditFormID = @KeyValues)
	Begin
		 Set @Status =1
		GOTO RETURN_VALUES
	End

  If exists (Select top 1 1  From LMT2001 Where CreditFormID = @KeyValues)
	Begin
		 Set @Status =1
		GOTO RETURN_VALUES
	End

End

If @TableID ='LMT1020' ---  Tài sản thế chấp
Begin
  If exists (Select top 1 1  From LMT2003 T1 inner join LMT1020 T2 on T1.AssetID = T2.AssetID Where T2.APK = @KeyValues)
	Begin
		 Set @Status =1
		GOTO RETURN_VALUES
	End

End

IF @TableID ='LMT1030' 
BEGIN

	INSERT INTO #LMP1000_Errors (Status, Params, MessageID, APK)
	SELECT 1 As Status, T30.Paymentsource, '00ML000165' As MessageID, T30.APK
	---- INNER JOIN với bảng nghiệp vụ để lấy các nguồn thanh toán đã sử dụng rồi
	FROM LMT1030 T30 WITH (NOLOCK)
	INNER JOIN LMT2031 T31 WITH (NOLOCK) ON T31.Paymentsource = T30.Paymentsource
	WHERE T30.APK IN (SELECT APK FROM #LMP1000)

	DELETE T1
	FROM LMT1030 T1
	INNER JOIN #LMP1000 T2 ON T1.APK = T2.APK
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #LMP1000_Errors T3 WHERE T1.APK = T3.APK)

END

SELECT * FROM #LMP1000_Errors

---- Tra ra gia tri
RETURN_VALUES:
Select @Status as Status



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

