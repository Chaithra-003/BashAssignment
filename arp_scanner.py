import subprocess

result = subprocess.run(["arp", "-a"], capture_output=True, text=True)

print("IP Address\t\tMAC Address")
print("-------------------------------------")

for line in result.stdout.split("\n"):
    print(line)
