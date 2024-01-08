IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP2022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP2022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Master đăng ký mua cổ phẩn (màn hình xem chi tiết/ màn hình cập nhật)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Xuân Minh on 28/09/2018
-- <Example> EXEC SHMP2022 @DivisionID = 'BS', @UserID = '', @APK = '5DA80878-B1E6-4E46-8E53-EA703DE45FDD'

CREATE PROCEDURE SHMP2022
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
		SELECT T1.APK, T1.DivisionID, T1.VoucherDate, T1.TranMonth, T1.TranYear, T1.VoucherTypeID, T1.VoucherNo
				, T1.SHPublishPeriodID, T1.ObjectID, T1.ShareHolderCategoryID, T1.IsPersonal, T1.ContactPrefix
				, T1.IdentificationNumber, T1.ContactIssueDate, T1.ContactIssueBy, T1.TotalQuantityBuyable
				, T1.TotalQuantityRegistered, T1.TotalQuantityApproved, T1.TotalAmountBought, T1.DeleteFlg
				, T1.CreateDate, T1.CreateUserID, T1.LastModifyDate, T1.LastModifyUserID
				, T3.SHPublishPeriodName, T3.SHPublishPeriodDate
				, T2.ObjectName, T2.Address, T2.Tel, T2.Email, T2.VATno, T2.Contactor, T2.Phonenumber
				, T4.Description as ContactPrefixName
				, T5.ShareHolderCategoryName
		FROM SHMT2020 T1  WITH (NOLOCK)
						LEFT JOIN AT1202 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,'@@@') AND T2.ObjectID=T1.ObjectID
						LEFT JOIN SHMT1020 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID,'@@@') AND T3.SHPublishPeriodID=T1.SHPublishPeriodID
						Left JOIN AT0099 T4 WITH (NOLOCK) ON T1.ContactPrefix = T4.ID and T4.Codemaster =  'AT00000036'
						Left join SHMT1000 T5  WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID,'@@@') AND T5.ShareHolderCategoryID=T1.ShareHolderCategoryID
		WHERE T1.APK = @APK and T1.DeleteFlg = 0
		

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
