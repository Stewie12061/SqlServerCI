------------------------------Thêm mới các nguồn đầu mối mặc định-----------------------------

--ZALO
IF NOT EXISTS(SELECT TOP 1 1 FROM CRMT10201 WHERE LeadTypeID = N'ZALO')
Insert into CRMT10201 (DivisionID, LeadTypeID, LeadTypeName, Description, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, RelatedToTypeID)
values ('@@@', 'ZALO', N'Zalo', 'Zalo', 0, 1, 'ASOFTADMIN', '2020-09-24 00:00:00.000', 'ASOFTADMIN', '2020-09-24 00:00:00.000', 21)	

--Facebook
IF NOT EXISTS(SELECT TOP 1 1 FROM CRMT10201 WHERE LeadTypeID = N'FACEBOOK')
Insert into CRMT10201 (DivisionID, LeadTypeID, LeadTypeName, Description, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, RelatedToTypeID)
values ('@@@', 'FACEBOOK', N'Facebook', 'Facebook', 0, 1, 'ASOFTADMIN', '2020-09-24 00:00:00.000', 'ASOFTADMIN', '2020-09-24 00:00:00.000', 21)	

--Website
IF NOT EXISTS(SELECT TOP 1 1 FROM CRMT10201 WHERE LeadTypeID = N'WEBSITE')
Insert into CRMT10201 (DivisionID, LeadTypeID, LeadTypeName, Description, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, RelatedToTypeID)
values ('@@@', 'WEBSITE', N'Website', 'Website', 0, 1, 'ASOFTADMIN', '2020-09-24 00:00:00.000', 'ASOFTADMIN', '2020-09-24 00:00:00.000', 21)	

-- Xóa dữ liệu sai
IF EXISTS(SELECT TOP 1 1 FROM CRMT10201 WHERE LeadTypeID = N'FACKBOOK')
DELETE CRMT10201 Where LeadTypeID = N'FACKBOOK'

--Nguồn Ladipage
IF NOT EXISTS(SELECT TOP 1 1 FROM CRMT10201 WHERE LeadTypeID = N'LADIPAGE')
Insert into CRMT10201 (DivisionID, LeadTypeID, LeadTypeName, Description, Disabled, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, RelatedToTypeID)
values ('@@@', 'LADIPAGE', N'Ladipage', 'Ladipage', 0, 1, 'ASOFTADMIN', '2023-02-09 00:00:00.000', 'ASOFTADMIN', '2023-02-09 00:00:00.000', 21)	
