# Flag Finderz
---------------
find / "local.txt" 2>/dev/null | grep "local.txt"
find / "proof.txt" 2>/dev/null | grep "proof.txt"
dir C:\ /s /b | findstr "local.txt"
dir C:\ /s /b | findstr "proof.txt"
