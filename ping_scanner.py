import subprocess

host = input("Enter IP or Host: ")

result = subprocess.run(["ping", "-c", "4", host], capture_output=True, text=True)

if "0% packet loss" in result.stdout:
    print("Host is reachable")
else:
    print("Host is NOT reachable")

print(result.stdout)
