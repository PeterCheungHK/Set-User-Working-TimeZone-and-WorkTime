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

[!TIP]   A maximum of four search criteria, otherwise it will become item by item

you can change WorkingHoursTimeZone to WorkDays




9.Check Multiple User(Show as item)

`id                 : 12345-6789-1234-123 primarySmtpAddress : targetuser@contoso.com workDays           : Weekdays startTime          : 09:00:00 endTime            : 18:00:00 timeZone           : China Standard Time`

<details>
  <summary>Click to expand</summary>
---

```
$DefaultStart = [timespan]::new(9, 0, 0);
$DefaultEnd   = [timespan]::new(18, 0, 0);

# Fetch the working hours of any mailbox.
Get-EXOMailbox -ResultSize unlimited -PropertySets StatisticsSeed -Filter "RecipientTypeDetails -ne 'DiscoveryMailbox'" |
    ForEach-Object {
        $CalenderCfg = Get-MailboxCalendarConfiguration -Identity $_.ExchangeGuid -WarningAction:SilentlyContinue;
  
        if (
            ($CalenderCfg.IsWorkingHoursSectionEnabled) -and (
                ($CalenderCfg.WorkDays -eq "Weekdays") -or
                ($CalenderCfg.WorkingHoursStartTime -ne $DefaultStart) -or
                ($CalenderCfg.WorkingHoursEndTime -ne $DefaultEnd)
            )
        )
        {
            # Output 
            [PSCustomObject] @{
                id = $_.ExchangeGuid;
                primarySmtpAddress = $_.PrimarySmtpAddress;
                workDays = $CalenderCfg.WorkDays;
                startTime = $CalenderCfg.WorkingHoursStartTime;
                endTime = $CalenderCfg.WorkingHoursEndTime;
                timeZone = $CalenderCfg.WorkingHoursTimeZone;
            }
        }
    }
```

---

</details>
