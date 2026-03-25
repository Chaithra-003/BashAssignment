import subprocess

ip = input("Enter IP address: ")

print("\n1. Host Discovery")
subprocess.run(["nmap", "-sn", ip])

print("\n2. Port Scan")
subprocess.run(["nmap", ip])

print("\n3. Service Detection")
subprocess.run(["nmap", "-sV", ip])

print("\n4. OS Detection (may require sudo)")
subprocess.run(["sudo", "nmap", "-O", ip])

