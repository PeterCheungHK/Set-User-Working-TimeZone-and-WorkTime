# Set User Working TimeZone and WorkTime

# 1. Right-click Powershell.exe and Run as Administrator
# (Include image link in comments if needed)
# ![Right Click run as Admin](https://na.cx/i/AUF89YN.webp)

# 2. Install Exchange Online Management Module
Install-Module -Name ExchangeOnlineManagement

# 3. Import Exchange Module
Import-Module ExchangeOnlineManagement

# 4. Login to Your Account
Connect-ExchangeOnline -UserPrincipalName yourAdminRightAcount@Contoso.com

# 5. Modify Single User's Calendar Configuration
Set-MailboxCalendarConfiguration -Identity targetuser@contoso.com -WorkingHoursTimeZone "China Standard Time" -WorkingHoursStartTime 09:00:00 -WorkingHoursEndTime 18:00:00

# 6. Modify Multiple Users' Calendar Configuration
Get-Mailbox | Where-Object {$_.RecipientTypeDetails -eq "UserMailbox"} | Set-MailboxCalendarConfiguration -WorkingHoursTimeZone "China Standard Time" -WorkingHoursStartTime 09:00:00 -WorkingHoursEndTime 18:00:00

# 7. Check Single User's Calendar Configuration
Get-MailboxCalendarConfiguration -Identity targetuser@contoso.com

# 8. Check Multiple Users' Calendar Configuration
Get-EXOMailbox | Where-Object {$_.RecipientTypeDetails -eq "UserMailbox"} | Get-MailboxCalendarConfiguration | Select-Object Identity, WorkingHoursStartTime, WorkingHoursEndTime, WorkingHoursTimeZone

# Example Output
# Identity                | WorkingHoursStartTime | WorkingHoursEndTime | WorkingHoursTimeZone
# ----------------------- | --------------------- | ------------------- | ---------------------
# targetuser@contoso.com  | 09:00:00              | 18:00:00            | China Standard Time
# targetuser1@contoso.com | 09:00:00              | 18:00:00            | China Standard Time

# Note: A maximum of four search criteria can be used, otherwise it will become item by item.
# You can change the WorkingHoursTimeZone to WorkDays

# Alternate View with WorkDays
# Column                 | Value
# ---------------------- | ----------------------
# Identity               | targetuser@contoso.com
# WorkDays               | Weekdays
# WorkingHoursStartTime  | 09:00:00
# WorkingHoursEndTime    | 18:00:00
# WorkingHoursTimeZone   | China Standard Time
