IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load dữ liệu doanh thu của ca bán hàng (từ lúc mở ca đến khi đóng ca)-Master
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 11/06/2018
---- Modify by Tra Giang on 19/11/2018: Viết lại store load dữ liệu thống kê từ các phiếu lập trong ca bán hàng
---- Modify by Tra Giang on 11/09/2019: Bổ sung điều kiện loại trừ phiếu đã hủy, bỏ kết bảng detail lấy số tiền ghi nợ. 
---- Modify by Kiều Nga  on 04/05/2020: Fix lỗi không lên doanh thu phương thức chuyển khoản
-- <Example>
---- EXEC POSP2041 'AT','HCM.255PDP', 'CA01', 'ASOFTADMIN','2018-10-25 00:00:00.000'
CREATE PROCEDURE POSP2041
( 
		@DivisionID AS NVARCHAR(50),
		@ShopID NVARCHAR(50),
		@ShiftID NVARCHAR(50),
		@UserID NVARCHAR(50),
		@ShiftDate DATETIME
) 
AS 
DECLARE @sSQL   NVARCHAR(MAX),
		@sSQL2  NVARCHAR(MAX), 
		@sSQL3  NVARCHAR(MAX), 
		@OpenTime DATETIME,
		@CloseTime DATETIME
		
SET @OpenTime = (SELECT  TOP 1 CreateDate FROM POST2033 P33 WITH (NOLOCK)
                WHERE P33.DivisionID = @DivisionID AND P33.ShopID = @ShopID AND P33.ShiftID=@ShiftID  and  IsLockShift=0  )

--SET @CloseTime = (SELECT  TOP 1 CloseTime FROM POST2033 P33 WITH (NOLOCK)
--                WHERE P33.DivisionID = @DivisionID AND P33.ShopID = @ShopID AND P33.ShiftID=@ShiftID and  IsLockShift=0  )
				
		 
SET @sSQL= N'
SELECT  COUNT(P16.VoucherNo) AS SysInvoiceNumber,ISNULL(( C.SysAmount),0) AS SysAmount
		, ISNULL(( D.SysTransferAmount),0) AS SysTransferAmount
		, ISNULL(E.SysCreditAmount,0) AS SysCreditAmount,	 ISNULL(I.SysDebitAmount,0) AS SysDebitAmount  , ISNULL(F.SysDebitTransferAmount,0) AS SysDebitTransferAmount, 
		   ISNULL(G.SysBookAmount,0) AS SysBookAmount,	 ISNULL(H.SysBookTransferAmount,0) AS SysBookTransferAmount,K.BeginAmount
		    FROM  POST0016 P16 WITH (NOLOCK)
	-- tiền quỹ đầu ca
	 LEFT JOIN (
	select P33.DivisionID, IsNULL(BeginAmount,0)  as BeginAmount from POST2033  P33 WHERE 	 P33.DivisionID='''+@DivisionID+'''  and IsLockShift=0
					     AND P33.ShopID='''+@ShopID+''')K on K.DivisionID= P16.DivisionID
	-- dOANH THU TIEN MAT
			LEFT JOIN (
				SELECT P.DivisionID,Sum(Amount) as SysAmount
				FROM (
					SELECT P81.DivisionID,case when A05.PaymentID01 = ''TM'' AND P81.PaymentID is null AND P81.PaymentObjectAmount01 is not null then  P81.PaymentObjectAmount01
												when A05.PaymentID02 = ''TM'' AND P81.PaymentID is null AND P81.PaymentObjectAmount02 is not null then  P81.PaymentObjectAmount02
												when P81.PaymentID = ''TM'' AND P81.PaymentObjectAmount01 is null AND P81.PaymentObjectAmount02 is null then ISNULL(P82.Amount,0)									
												else 0 end  as Amount
					from POST00801 P81
					INNER JOIN POST00802 P82 WITH (NOLOCK) ON P81.APK=P82.APKMaster AND P81.DivisionID=P82.DivisionID
					LEFT JOIN POST0006 A05 WITH (NOLOCK) ON P81.APKPaymentID=A05.APK 
					WHERE 	 P81.DivisionID='''+@DivisionID+''' AND P81.DeleteFlg = 0  AND  P82.VoucherNoInherited IS NOT NULL
							AND CONVERT(VARCHAR,P81.CreateDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND '''+CONVERT(VARCHAR,getdate(),120)+'''
							 AND P81.ShopID='''+@ShopID+'''
				) P
				Group by DivisionID
			) C ON C.DivisionID=P16.DivisionID 
	-- Doanh thu chuyen khoan 
			LEFT JOIN (
				SELECT P.DivisionID,Sum(Amount) as SysTransferAmount
				FROM (
					SELECT P81.DivisionID,case when A05.PaymentID01 = ''CK'' AND P81.PaymentID is null AND P81.PaymentObjectAmount01 is not null then  P81.PaymentObjectAmount01
												when A05.PaymentID02 = ''CK'' AND P81.PaymentID is null AND P81.PaymentObjectAmount02 is not null then  P81.PaymentObjectAmount02
												when P81.PaymentID = ''CK'' AND P81.PaymentObjectAmount01 is null AND P81.PaymentObjectAmount02 is null then ISNULL(P82.Amount,0)									
												else 0 end  as Amount
					from POST00801 P81
					INNER JOIN POST00802 P82 WITH (NOLOCK) ON P81.APK=P82.APKMaster AND P81.DivisionID=P82.DivisionID
					LEFT JOIN POST0006 A05 WITH (NOLOCK) ON P81.APKPaymentID=A05.APK 
					WHERE 	 P81.DivisionID='''+@DivisionID+''' AND P81.DeleteFlg = 0  AND  P82.VoucherNoInherited IS NOT NULL
							AND CONVERT(VARCHAR,P81.CreateDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND '''+CONVERT(VARCHAR,getdate(),120)+'''
							 AND P81.ShopID='''+@ShopID+'''
				) P
				Group by DivisionID
			) D ON D.DivisionID=P16.DivisionID
	-- ghi nợ		
			LEFT JOIN (  
			SELECT P16.DivisionID, SUM(P16.Change) AS SysCreditAmount  
			FROM POST0016 P16 WITH (NOLOCK)
			LEFT JOIN AT1205 A05 WITH (NOLOCK) ON P16.APKPaymentID=A05.APK AND A05.PaymentID=''CK''
			 WHERE 	P16.DivisionID='''+@DivisionID+''' AND P16.DeleteFlg = 0  AND CONVERT(VARCHAR,P16.CreateDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND '''+CONVERT(VARCHAR,getdate(),120)+'''
		     AND P16.ShopID='''+@ShopID+''' GROUP BY P16.DivisionID
			 		) E ON E.DivisionID=P16.DivisionID'
	SET @sSQL2=N'
	--THU NỢ  TIỀN MẶT 
			LEFT JOIN (
			SELECT P81.DivisionID, ISNULL(SUM(P82.Amount),0) AS SysDebitAmount 
			FROM POST00801 P81 WITH (NOLOCK) INNER JOIN POST00802 P82 WITH (NOLOCK) ON P81.APK=P82.APKMaster AND P81.DivisionID=P82.DivisionID
			LEFT JOIN AT1205 A05 WITH (NOLOCK) ON P81.APKPaymentID=A05.APK --AND A05.PaymentID=N''TM''
						 WHERE 	 P81.DivisionID='''+@DivisionID+''' AND P81.DeleteFlg = 0  AND  P81.IsPayInvoice is null AND P81.PaymentID=N''TM''
			AND CONVERT(VARCHAR,P81.CreateDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND '''+CONVERT(VARCHAR,getdate(),120)+'''
		     AND P81.ShopID='''+@ShopID+'''			
			GROUP BY P81.DivisionID
			) I ON I.DivisionID=P16.DivisionID
		--Thu nợ chuyển khoản
			LEFT JOIN (
				SELECT P81.DivisionID, ISNULL(SUM(P82.Amount),0) AS SysDebitTransferAmount 
			FROM POST00801 P81 WITH (NOLOCK) INNER JOIN POST00802 P82 WITH (NOLOCK) ON P81.APK=P82.APKMaster AND P81.DivisionID=P82.DivisionID
			LEFT JOIN AT1205 A05 WITH (NOLOCK) ON P81.APKPaymentID=A05.APK --AND A05.PaymentID=N''CK'' 
			 WHERE 	 P81.DivisionID='''+@DivisionID+''' AND P81.DeleteFlg = 0  AND  P81.IsPayInvoice IS  NULL  AND P81.PaymentID=N''CK'' 
		    AND CONVERT(VARCHAR,P81.CreateDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND '''+CONVERT(VARCHAR,getdate(),120)+''' AND P81.ShopID='''+@ShopID+'''
			GROUP BY P81.DivisionID	) F ON F.DivisionID=P16.DivisionID
		--Ðat coc tien mat
			LEFT JOIN (
				SELECT P.DivisionID,Sum(Amount) as SysBookAmount
					FROM (
						SELECT P10.DivisionID,case when A05.PaymentID01 = ''TM'' then  P10.PaymentObjectAmount01
													when A05.PaymentID02 = ''TM''  then  P10.PaymentObjectAmount02
											  else 0 end  as Amount
						FROM POST2010 P10 WITH (NOLOCK) INNER JOIN POST2011 P11 WITH (NOLOCK) ON P10.APK=P11.APKMaster AND P10.DivisionID=P11.DivisionID
						INNER JOIN POST0006 A05 WITH (NOLOCK) ON P10.APKPaymentID=A05.APK 
						  WHERE 	 P10.DivisionID='''+@DivisionID+''' AND P10.DeleteFlg = 0 
					   AND CONVERT(VARCHAR,P10.CreateDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND '''+CONVERT(VARCHAR,getdate(),120)+'''  AND P10.ShopID='''+@ShopID+'''
				   ) P
				Group by DivisionID
			) G ON G.DivisionID=P16.DivisionID
		-- dat coc chuyen khoan
			LEFT JOIN (
				SELECT P.DivisionID,Sum(Amount) as SysBookTransferAmount
					FROM (
						SELECT P10.DivisionID,case when A05.PaymentID01 = ''CK'' then  P10.PaymentObjectAmount01
													when A05.PaymentID02 = ''CK''  then  P10.PaymentObjectAmount02
											  else 0 end  as Amount
						FROM POST2010 P10 WITH (NOLOCK) INNER JOIN POST2011 P11 WITH (NOLOCK) ON P10.APK=P11.APKMaster AND P10.DivisionID=P11.DivisionID
						INNER JOIN POST0006 A05 WITH (NOLOCK) ON P10.APKPaymentID=A05.APK 
						  WHERE 	 P10.DivisionID='''+@DivisionID+''' AND P10.DeleteFlg = 0 
					   AND CONVERT(VARCHAR,P10.CreateDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND '''+CONVERT(VARCHAR,getdate(),120)+'''  AND P10.ShopID='''+@ShopID+'''
				   ) P
				Group by DivisionID
			) H ON H.DivisionID=P16.DivisionID
			 where  P16.DivisionID='''+@DivisionID+''' AND P16.DeleteFlg = 0 
		  AND CONVERT(VARCHAR,P16.CreateDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND '''+CONVERT(VARCHAR,getdate(),120)+'''  AND P16.ShopID='''+@ShopID+'''
			GROUP BY  P16.DivisionID,I.SysDebitAmount,F.SysDebitTransferAmount,G.SysBookAmount,H.SysBookTransferAmount,E.SysCreditAmount
			 ,C.SysAmount,D.SysTransferAmount,K.BeginAmount

		'



PRINT (@sSQL)
PRINT (@sSQL2)
EXEC (@sSQL+@sSQL2)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
