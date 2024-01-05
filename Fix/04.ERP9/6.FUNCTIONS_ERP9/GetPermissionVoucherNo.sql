IF EXISTS (SELECT * FROM SYS.OBJECTS WHERE [NAME] = 'GetPermissionVoucherNo' AND [TYPE] = 'FN')
	DROP FUNCTION GetPermissionVoucherNo
GO
-- <Summary>
---- Lấy chuỗi chứa quyền sử dụng phiếu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Bảo Toàn on 07/08/2019 

-- <Example>
CREATE FUNCTION GetPermissionVoucherNo(
	@UserID varchar(50),
	@ColumnName varchar(50) -- Cot phieu
)
returns varchar(1000)
BEGIN
	Declare @result varchar(1000) = ''
	--Phan quyen theo nghiep vu
	--IF EXISTS (SELECT 1 FROM CRMT0001 WHERE '/'+PermissionUserID+'/' like '%/'+@UserID+'/%')
	--BEGIN
	--	DECLARE @stringPlit varchar(500) = ''
	--	set @stringPlit = (SELECT VoucherNo +';' FROM CRMT0001 WHERE '/'+PermissionUserID+'/' like '%/'+@UserID+'/%' FOR XML PATH (''))
	--	set @stringPlit = ';'+@stringPlit
	--	SET @result = @result + ' OR '''+@stringPlit+''' LIKE ''%;''+'+@ColumnName+'+'';%'''
	--END
	RETURN @result
END

