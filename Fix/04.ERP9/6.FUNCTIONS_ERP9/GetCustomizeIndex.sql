--Lấy CustomizeIndex hiện tại
--[Bảo Toàn] Ngày tạo [22/07/2019]

if exists (select * from sys.objects where  [name] = 'GetCustomizeIndex' AND [type] = 'FN')
	DROP FUNCTION GetCustomizeIndex
go
create function GetCustomizeIndex()
returns int
as
begin
	DECLARE @CustomerName INT = -1, --Nhập CustomerName tương ứng
		@ImportExcel INT = 0	--Nhập ImportExcel tương ứng

	IF EXISTS (SELECT TOP 1 1 FROM CustomerIndex)
	BEGIN
		select top 1 @CustomerName = CustomerName from CustomerIndex
	END	
	return @CustomerName
end