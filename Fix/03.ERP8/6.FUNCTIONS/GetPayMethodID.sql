IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'GetPayMethodID') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION GetPayMethodID
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

-- <Summary>
---- Lấy  ID ra để phát hành hóa đơn điện tử
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
---- Created by Hoài Phong on 08/12/2020  
---- SELECT TOP 10 (dbo.GetPayMethodID(PaymentID,'',0)) as PayMethodID FROM AT9000 where PaymentID is not null
---- Modified on 09/04/2021 by Văn Tài: Bổ sung danh sách mã PTTM mới từ 19.
-- <Example>
CREATE FUNCTION [dbo].[GetPayMethodID](	
	@PaymentID NVARCHAR(80),
	@EInvoice NVARCHAR(80),
	@CustomerIndex INT
)
RETURNS VARCHAR(80)
BEGIN
--SET @CustomerIndex = (SELECT CustomerName FROM dbo.CustomerIndex)
--SET @EInvoice =(SELECT EInvoicePartner FROM dbo.AT0000)
--IF @EInvoice ='BAKV'
	RETURN CASE WHEN @PaymentID = 'TM' THEN '1'
				WHEN @PaymentID = 'CK' THEN '2'
				WHEN @PaymentID = 'TM/CK' THEN '3'
				WHEN @PaymentID = 'XHCCN' THEN '4'
				WHEN @PaymentID = 'HBT' THEN '5'
				WHEN @PaymentID = 'CTCN' THEN '6'
				WHEN @PaymentID = 'TH' THEN '7'
			    WHEN @PaymentID = 'KMKTT' THEN '8'
			    WHEN @PaymentID = 'XSD' THEN '9'
				WHEN @PaymentID = 'KTT' THEN '10'
				WHEN @PaymentID = 'D/A' THEN '11'
				WHEN @PaymentID = 'D/P' THEN '12'
				WHEN @PaymentID = 'TT' THEN '13'
				WHEN @PaymentID = 'L/C' THEN '14'
				WHEN @PaymentID = 'CN' THEN '15'
				WHEN @PaymentID = 'NT' THEN '16'
				WHEN @PaymentID = 'TM/CK/B' THEN '17'
				WHEN @PaymentID = 'TTD' THEN '18'
				WHEN @PaymentID = 'CK/CTCN' THEN '19' -- CK/Cấn trừ công nợ
				WHEN @PaymentID = 'HH' THEN '20' -- Hàng hóa
				WHEN @PaymentID = 'HM' THEN '21' -- Hàng mẫu
				WHEN @PaymentID = 'THE' THEN '22' -- Thẻ
				WHEN @PaymentID = 'BT' THEN '23' -- Bù trừ công nộ
				WHEN @PaymentID = 'LAZADA' THEN '24' -- Qua Lazada
				WHEN @PaymentID = 'TIKI' THEN '25' -- Qua Tiki
				WHEN @PaymentID = 'XHDNB' THEN '26' -- Xuất hóa đơn nội bộ
				WHEN @PaymentID = 'T/T' THEN '27' -- T/T
				WHEN @PaymentID = 'TTR' THEN '28' -- TTR
				WHEN @PaymentID = 'TM/CK/LAZADA' THEN '29' -- TM/CK/Qua LAZADA
				WHEN @PaymentID = 'TM/CK/Qua TIKI' THEN '30' -- TM/CK/Qua TIKI
				WHEN @PaymentID = 'TM/The' THEN '31' -- TM/THE
				WHEN @PaymentID = 'CK/The' THEN '32' -- CK/Cấn trừ công nợ
				WHEN @PaymentID = 'TM/CK/The' THEN '33' -- TM/CK/The
				WHEN @PaymentID = 'CK/LC' THEN '34' -- CK/LC
				WHEN @PaymentID = 'LCAS' THEN '35' -- L/C at sight - Thư tín dụng trả ngay
				WHEN @PaymentID = 'XHHTL' THEN '36' -- Xuất hàng hoá, dịch vụ trả thay lương

				ELSE NULL
			END
END

GO



