---Create by Thị Phượng, tạo Index on 24/04/2017

/****** Object:  Index [Index_Combo]    Script Date: 24/04/2017 11:16:25 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CRMT20301]') 
            AND name = N'Index_Combo')
CREATE NONCLUSTERED INDEX [Index_Combo] ON [dbo].[CRMT20301]
(
	[LeadID] ASC,
	[LeadStatusID] ASC,
	[LeadSourceID] ASC,
	[LeadTypeID] ASC,
	[AssignedToUserID] ASC
)
INCLUDE ( 	[APK],
	[DivisionID],
	[LeadName],
	[LeadTel],
	[LeadMobile],
	[Address],
	[Email],
	[JobID],
	[CompanyName],
	[TitleID],
	[Disabled],
	[IsCommon],
	[Description],
	[BirthDate],
	[Hobbies],
	[Website],
	[CreateUserID],
	[CreateDate],
	[LastModifyUserID],
	[LastModifyDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CRMT20301]')  AND name = N'Index_Search')
CREATE NONCLUSTERED INDEX [Index_Search] ON [dbo].[CRMT20301]
(
	[DivisionID] ASC
)
INCLUDE ( 	[LeadName],
	[LeadMobile],
	[LeadStatusID],
	[LeadTypeID],
	[AssignedToUserID],
	[Disabled],
	[IsCommon]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


