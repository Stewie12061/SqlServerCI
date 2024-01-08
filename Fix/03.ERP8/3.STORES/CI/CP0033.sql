IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0033]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CP0033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh mục đối tượng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 28/02/2014 by Lê Thị Thu Hien
---- 
---- Modified on 28/02/2014 by  hoàng vũ: bổ sung phân quyền dữ liệu kết hợp phân quyền xem dữ liệu người khác
---- Modified on 12/05/2017 by Tiểu Mai: Bổ sung with (nolock) và chỉnh sửa danh mục dùng chung
---- Modified on 31/01/2023 by Thanh Lượng:[2023/01/IS/0118] - Bổ sung ORDER BY sắp xếp theo mã đối tượng tăng dần
-- <Example>
---- EXEC CP0033 'AS', 'ADMIN', 0 , 'KH014.0445', '1=1'
CREATE PROCEDURE CP0033
( 
		@DivisionID AS VARCHAR(50),
		@UserID AS VARCHAR(50),
		@CheckDisabled AS TINYINT,
		@ConditionOB nvarchar(max), --Phân quyền dữ liệu người dùng
		@IsUsedConditionOB nvarchar(20)
) 
AS 
DECLARE @sSQL AS NVARCHAR(MAX),
		@sSQLPer AS NVARCHAR(MAX),
		@sWHERE AS NVARCHAR(MAX),
		@sWHERE1 AS NVARCHAR(MAX),
		@sWHEREPer AS NVARCHAR(MAX),
		@sGROUPBY AS NVARCHAR(MAX),
		@sORDERBY AS NVARCHAR(MAX)
		
SET @sWHERE1 = ''		
----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
SET @sSQLPer = ''
SET @sWHEREPer = ''		

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1 ) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
	BEGIN
		SET @sSQLPer = ' LEFT JOIN AT0010 ON AdminUserID = '''+@UserID+''' 
											AND AT0010.UserID = AT1202.CreateUserID '
		SET @sWHEREPer = ' AND (AT1202.CreateUserID = AT0010.UserID 
								OR AT1202.CreateUserID = '''+@UserID+''' ) '		
	END

-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác		

IF @CheckDisabled = 0
	BEGIN
		SET @sWHERE1 = N' AND AT1202.Disabled = 0'
	END
	
SET @sSQL = N'	
SELECT AT1202.DivisionID,
	ObjectID, ObjectName, 
	S1, AT1207_S1.Sname AS Sname1,
	S2, AT1207_S2.Sname AS Sname2,
	S3, AT1207_S3.Sname AS Sname3,
	AT1202.ObjectTypeID, ObjectTypeName,
	AT1202.Redays, AT1202.IsLockedOver,	
	IsSupplier, IsCustomer, IsUpdateName, 
	TradeName, LegalCapital, Address, 
	FieldID, CurrencyID, CountryID, CityID, PaymentID, FinanceStatusID, 
	AreaID, RePaymentTermID, PaPaymentTermID,  BrabNameID, EmployeeID, 
	PaAccountID, ReAccountID, Tel, Fax, Email, Website, Note, BankName, Contactor,
	BankAddress, BankAccountNo,	LicenseNo, LicenseOffice, 
	LicenseDate, Register, Potentility,
	AT1202.Disabled, AT1202.CreateDate, AT1202.CreateUserID, AT1202.LastModifyDate, AT1202.LastModifyUserID, 
	VATNo, ReCreditLimit, PaCreditLimit, ReDueDays, PaDueDays, 
	PaDiscountDays, PaDiscountPercent, 
	O01ID, AT1015_O01.AnaName AS AnaName1,
	O02ID, AT1015_O02.AnaName AS AnaName2,
	O03ID, AT1015_O03.AnaName AS AnaName3,
	O04ID, AT1015_O04.AnaName AS AnaName4,
	O05ID, AT1015_O05.AnaName AS AnaName5,
	DeAddress, ReAddress, Note1, AT1202.IsCommon   

FROM AT1202 WITH (NOLOCK)	
LEFT JOIN AT1201 WITH (NOLOCK) On AT1202.ObjectTypeID = AT1201.ObjectTypeID
LEFT JOIN AT1207 AT1207_S1 WITH (NOLOCK) On AT1202.S1= AT1207_S1.S and AT1207_S1.STypeID =''O01'' 
LEFT JOIN AT1207 AT1207_S2 WITH (NOLOCK) On AT1202.S2= AT1207_S2.S and AT1207_S2.STypeID =''O02'' 
LEFT JOIN AT1207 AT1207_S3 WITH (NOLOCK) On AT1202.S3= AT1207_S3.S and AT1207_S3.STypeID =''O03'' 
LEFT JOIN AT1015 AT1015_O01 WITH (NOLOCK) On AT1202.O01ID= AT1015_O01.AnaID and AT1015_O01.AnaTypeID =''O01'' 
LEFT JOIN AT1015 AT1015_O02 WITH (NOLOCK) On AT1202.O02ID= AT1015_O02.AnaID and AT1015_O02.AnaTypeID =''O02'' 
LEFT JOIN AT1015 AT1015_O03 WITH (NOLOCK) On AT1202.O03ID= AT1015_O03.AnaID and AT1015_O03.AnaTypeID =''O03'' 
LEFT JOIN AT1015 AT1015_O04 WITH (NOLOCK) On AT1202.O04ID= AT1015_O04.AnaID and AT1015_O04.AnaTypeID =''O04'' 
LEFT JOIN AT1015 AT1015_O05 WITH (NOLOCK) On AT1202.O05ID= AT1015_O05.AnaID and AT1015_O05.AnaTypeID =''O05'' 
'
SET @sWHERE = N'
WHERE AT1202.DivisionID IN ( '''+@DivisionID+''', ''@@@'') AND (ISNULL(AT1202.ObjectID, ''#'') IN (' + @ConditionOB + ') Or ' + @IsUsedConditionOB + ')
'
SET @sGROUPBY = N'
GROUP BY AT1202.DivisionID,
	ObjectID, ObjectName, 
	S1, AT1207_S1.Sname,
	S2, AT1207_S2.Sname,
	S3, AT1207_S3.Sname,
	AT1202.ObjectTypeID, ObjectTypeName,
	AT1202.Redays, AT1202.IsLockedOver,	
	IsSupplier, IsCustomer, IsUpdateName, 
	TradeName, LegalCapital, Address, 
	FieldID, CurrencyID, CountryID, CityID, PaymentID, FinanceStatusID, 
	AreaID, RePaymentTermID, PaPaymentTermID,  BrabNameID, EmployeeID, 
	PaAccountID, ReAccountID, Tel, Fax, Email, Website, Note, BankName, Contactor,
	BankAddress, BankAccountNo,	LicenseNo, LicenseOffice, 
	LicenseDate, Register, Potentility,
	AT1202.Disabled, AT1202.CreateDate, AT1202.CreateUserID, AT1202.LastModifyDate, AT1202.LastModifyUserID, 
	VATNo, ReCreditLimit, PaCreditLimit, ReDueDays, PaDueDays, 
	PaDiscountDays, PaDiscountPercent, 
	O01ID, AT1015_O01.AnaName,
	O02ID, AT1015_O02.AnaName,
	O03ID, AT1015_O03.AnaName,
	O04ID, AT1015_O04.AnaName,
	O05ID, AT1015_O05.AnaName,
	DeAddress, ReAddress, Note1, AT1202.IsCommon   
'

SET @sORDERBY = N'ORDER BY ObjectID'
EXEC (@sSQL+@sSQLPer+@sWHERE+@sWHERE1+@sWHEREPer+@sGROUPBY+@sORDERBY)

--PRINT (@sSQL)
--PRINT(@sSQLPer)
--PRINT(@sWHERE)
--PRINT(@sWHERE1)
--PRINT(@sWHEREPer)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

