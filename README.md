# Set User Working TimeZone and WorkTime

1. Right click Powershell.exe Run as administrator

   ![Right Click run as Admin](https://na.cx/i/AUF89YN.webp)
2. Install Exchange online management

   ```powershell
   Install-Module -Name ExchangeOnlineManagement
   ```
3. Import Exchange module

   ```powershell
   Import-Module ExchangeOnlineManagement
   ```
4. Login your account

   ```
   yourAdminRightAcount@Contoso.com
   ```
5. Modification Single User

   ```
   Set-MailboxCalendarConfiguration -Identity targetuser@contoso.com -WorkingHoursTimeZone “China Standard Time” -WorkingHoursStartTime 09:00:00 -WorkingHoursEndTime 18:00:00
   ```
6. Modification Multiple User

   ```
   Get-Mailbox | Where {$_.RecipientTypeDetails -eq "UserMailbox"}  
   Set-MailboxCalendarConfiguration -WorkingHoursTimeZone “China Standard Time” -WorkingHoursStartTime 09:00:00 -WorkingHoursEndTime 18:00:00
   ```

   ---
7. Check Single User

```
Get-MailboxCalendarConfiguration -Identity targetuser@contoso.com 
```

9. Check Multiple User(Show as List by List)

```
Get-EXOMailbox | Where {$_.RecipientTypeDetails -eq "UserMailbox"} | Get-MailboxCalendarConfiguration | select Identity,  WorkingHoursStartTime, WorkingHoursEndTime,WorkingHoursTimeZone
```

| Identity                | WorkingHoursStartTime | WorkingHoursEndTime | WorkingHoursTimeZone |
| ----------------------- | --------------------- | ------------------- | -------------------- |
| targetuser@contoso.com  | 09:00:00              | 18:00:00            | China Standard Time  |
| targetuser1@contoso.com | 09:00:00              | 18:00:00            | China Standard Time  |

**A maximum of four search criteria, otherwise it will become item by item**

**you can change WorkingHoursTimeZone to WorkDays**


| col1                  | col2                   |
| --------------------- | ---------------------- |
| Identity              | targetuser@contoso.com |
| WorkDays              | Weekdays               |
| WorkingHoursStartTime | 09:00:00               |
| WorkingHoursEndTime   | 18:00:00               |
| WorkingHoursTimeZone  | China Standard Time    |


