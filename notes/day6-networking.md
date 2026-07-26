# Day 6 - Networking Commands

## What is a Network Interface
```
Network interface = a connection point between your machine and a network
Every machine has at least 2 interfaces:
lo      = loopback (talks to itself)
enp0s3  = actual network card (talks to internet)
```

---

## ip addr show - View Network Interfaces

### Command
```
ip addr show
ip a          # shorthand
```

### Output Explained
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536
   inet 127.0.0.1/8 scope host lo

2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
   inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic

lo     = loopback interface - talks to yourself
enp0s3 = actual network card - talks to internet/network
```

### Interface Flags
```
UP         = interface is active
LOWER_UP   = physical/virtual cable is connected
BROADCAST  = can send to all devices on network
MULTICAST  = can send to multiple specific devices
```

### IP Address Fields
```
inet   = IPv4 address
inet6  = IPv6 address
/24    = subnet mask (addresses in same network range)
brd    = broadcast address
scope global  = can reach beyond this machine
scope host    = only valid on this machine (loopback)
dynamic       = IP assigned automatically via DHCP
```

### lo vs enp0s3
```
lo (loopback):
Address = 127.0.0.1
Purpose = programs talking to each other on SAME machine
Never leaves your machine
state = UNKNOWN (normal for loopback)

enp0s3 (network card):
Address = 10.0.2.15
Purpose = talking to internet and other machines
state = UP (active and working)
08:00:27 in MAC = VirtualBox's manufacturer ID (virtual NIC)
```

### IPv6 - 3 addresses explained
```
global temporary  = privacy address, changes periodically
global dynamic    = stable address for incoming connections
link-local fe80:: = only valid on local network, never routed
```

---

## ip route show - Routing Table

### Command
```
ip route show
route -n      # older command, same purpose
```

### What is Routing Table
```
Rules that tell your machine WHERE to send network traffic
Like a map with directions
```

### Output Explained
```
default via 10.0.2.2 dev enp0s3 proto dhcp metric 100
10.0.2.0/24 dev enp0s3 proto kernel scope link src 10.0.2.15 metric 100
169.254.0.0/16 dev enp0s3 scope link metric 1000
```

### Line by Line
```
default via 10.0.2.2
= for ANY destination not listed below
= send traffic to gateway 10.0.2.2 (VirtualBox router)
= this router forwards it to internet

10.0.2.0/24 dev enp0s3
= for addresses in range 10.0.2.0 to 10.0.2.255
= talk directly, no need for gateway
= these are local network devices

169.254.0.0/16
= APIPA range - automatic fallback IP range
= used when DHCP fails to assign an IP
= safety net, not actively used
```

### Metric Numbers
```
metric 100  = higher priority, used first
metric 1000 = lower priority, used as last resort
Lower number = higher priority
```

### How Traffic Flows
```
You ping google.com (8.8.8.8)
↓
Is 8.8.8.8 in 10.0.2.0/24?    No
Is 8.8.8.8 in 169.254.0.0/16? No
Use default route              Yes → send via 10.0.2.2
↓
VirtualBox router → Windows host → Internet → Google
```

---

## ping - Test Connectivity

### Commands
```
ping google.com          # ping forever until Ctrl+C
ping -c 4 google.com     # send exactly 4 packets then stop
```

### Output Explained
```
PING google.com (142.250.182.78) 56(84) bytes of data.
64 bytes from maa05s20-in-f14.1e100.net: icmp_seq=1 ttl=64 time=43.4 ms

google.com (142.250.182.78) = IP that domain resolved to
56(84) bytes = 56 data + 28 header = 84 total packet size
icmp_seq=1   = sequence number of this ping
ttl=64       = Time To Live - max hops before packet dropped
time=43.4 ms = round trip time
```

### TTL Values
```
Linux   = starts at 64
Windows = starts at 128
Routers = starts at 255
```

### Final Statistics
```
14 packets transmitted, 14 received, 0% packet loss

min  = fastest reply
avg  = average reply time
max  = slowest reply
mdev = variation between replies

0% packet loss = healthy connection
high mdev      = inconsistent connection (spikes)
```

### Google Shows Different IPs Each Time
```
Google has thousands of servers worldwide
DNS gives you closest server at that moment
Different requests go to different servers = load balancing
```

---

## traceroute - Show Path to Destination

### Command
```
traceroute google.com
```

### What it Does
```
Shows every router (hop) your packet passes through
on its way to destination
Like tracking a package delivery step by step
```

### Output Explained
```
traceroute to google.com, 30 hops max, 60 byte packets
1  _gateway (10.0.2.2)  2.661ms  2.432ms  2.310ms
2  * * *
3  * * *

1 = hop number
_gateway (10.0.2.2) = VirtualBox virtual router - responded
2.661ms 2.432ms 2.310ms = 3 packets sent, all replied
* * * = no reply received (router blocked traceroute)
```

### Why * * * Shows
```
Most internet routers block traceroute for security
They ARE forwarding your packets
But they ignore/block traceroute probe packets
Like knocking on a door - they're home but don't answer
This is normal - not an error
```

### ping vs traceroute
```
ping       = did it arrive? how fast?
traceroute = which path did it take? where is it slow?

ping works even when traceroute shows * * *
because they use different probe methods
```

---

## nslookup - DNS Lookup

### Command
```
nslookup google.com
```

### What DNS Does
```
DNS = Domain Name System
Computers understand IP addresses, not domain names
DNS lookup = asking "what is the IP for google.com?"
Like a phone book - name to number translation
```

### Output Explained
```
Server:  127.0.0.53
Address: 127.0.0.53#53

Non-authoritative answer:
Name:    google.com
Address: 142.250.182.78      ← IPv4
Address: 2404:6800:4007::200e ← IPv6

Server 127.0.0.53 = your local DNS resolver (Ubuntu's systemd-resolved)
#53 = port 53 (DNS always uses port 53)
Non-authoritative = answer came from cache, not Google's own DNS server
```

### Authoritative vs Non-authoritative
```
Authoritative     = answer came directly from Google's own DNS servers
Non-authoritative = answer came from cache (normal and accurate)
```

---

## dig - Detailed DNS Lookup

### Command
```
dig google.com
```

### Output Explained
```
status: NOERROR           = lookup succeeded
QUERY: 1, ANSWER: 1       = 1 question asked, 1 answer received

QUESTION SECTION:
google.com.   IN   A      = asking for IPv4 address (A record)

ANSWER SECTION:
google.com.  126  IN  A  142.250.66.14
             ↑            ↑
             TTL=126sec   IP address answer

Query time: 6 msec        = lookup took 6 milliseconds
SERVER: 127.0.0.53#53     = local DNS resolver answered
```

### DNS Record Types
```
A    = IPv4 address
AAAA = IPv6 address
MX   = mail server
CNAME= alias pointing to another domain
```

### nslookup vs dig
```
nslookup = simple, beginner friendly, quick checks
dig      = detailed, technical, used by network engineers
Both do the same thing - DNS lookup
dig just shows more technical detail
```

---

## ss - Check Active Connections and Ports

### Commands
```
ss -tuln        # show both TCP and UDP listening ports
ss -tln         # show TCP listening ports only
ss -uln         # show UDP listening ports only
sudo ss -tulnp  # show TCP+UDP with process names
```

### Flags Explained
```
t = TCP connections
u = UDP connections
l = listening ports only
n = numeric (show port numbers not service names)
p = show process name using the port
```

### Output Explained
```
Netid  State   Local Address:Port   Peer Address:Port
tcp    LISTEN  127.0.0.53:53        0.0.0.0:*
udp    UNCONN  0.0.0.0:5353         0.0.0.0:*

Netid          = protocol (tcp/udp)
State          = LISTEN (tcp) or UNCONN (udp)
Local Address  = which IP is listening
:Port          = which port number
0.0.0.0:*      = accepting from any address
```

### TCP vs UDP States
```
TCP LISTEN = actively waiting for connections
             like a receptionist waiting for visitors

UDP UNCONN = open but connectionless
             like an open letterbox - anyone can drop a letter
             UNCONN is normal for ALL UDP ports - not an error
```

### Difference between ss -tuln, ss -tln, ss -uln
```
ss -tuln = shows BOTH tcp and udp (t+u flags)
ss -tln  = shows TCP ONLY (no u flag)
ss -uln  = shows UDP ONLY (no t flag)
```

### Common Ports Seen
```
Port 53  = DNS service (tcp + udp)
Port 631 = CUPS printing service (tcp)
Port 5353 = mDNS local network resolution (udp)
```

### 0.0.0.0 vs 127.0.0.1
```
0.0.0.0  = listening on ALL interfaces, accessible from anywhere
127.0.0.1 = listening on localhost ONLY, not accessible from outside
```

---

## wget - Download Files

### Commands
```
wget https://example.com/file.txt           # download to current folder
wget -P ~/Downloads/ https://example.com/file.txt  # save to specific folder
wget -O myfile.txt https://example.com/file.txt    # save with different name
```

### Output Explained
```
Resolving www.w3schools.com... 23.211.142.10
= DNS lookup to find server IP

Connecting to 23.211.142.10|:443... connected
= connected to server on port 443 (HTTPS)

HTTP request sent, awaiting response... 200 OK
= server responded with 200 = success

209.99K in 0.1s (1.42 MB/s)
= downloaded 209KB at 1.42MB/s speed

'python_syntax.asp' saved [215027]
= file saved, size 215027 bytes
```

### wget vs curl
```
wget = designed for downloading files
       saves file automatically
       good for batch downloads

curl = more flexible, can send/receive any HTTP request
       shows output in terminal by default
       used for testing APIs
```

---

## curl - HTTP Requests

### Commands
```
curl https://google.com           # show full response in terminal
curl -I https://google.com        # show headers only
curl -O https://example.com/file  # download and save file
curl ifconfig.me                  # show your public IP address
curl ipinfo.io                    # show IP + location info
```

---

## hostname Commands

### Commands
```
hostname      # show machine name
hostname -I   # show IP address only
```

---

## /etc/resolv.conf - DNS Configuration

### Command
```
cat /etc/resolv.conf
```

### What it Shows
```
nameserver 127.0.0.53
= DNS server your machine uses for lookups
= 127.0.0.53 = local systemd-resolved service
```

---

## Key Concepts Summary

### What is Gateway
```
Gateway = your router - first hop to reach internet
Your gateway = 10.0.2.2 (VirtualBox virtual router)
All internet traffic goes through gateway first
```

### What is DHCP
```
DHCP = Dynamic Host Configuration Protocol
Automatically assigns IP address to your machine
Without DHCP = you must manually set IP address
dynamic in ip addr show = IP assigned by DHCP
```

### What is Port
```
Port = a numbered door on your machine
Each service uses a specific port number
Port 53  = DNS
Port 80  = HTTP (websites)
Port 443 = HTTPS (secure websites)
Port 22  = SSH (remote login)
Port 631 = Printing
```

---

## Commands Practiced Today
```
ip addr show
ip a
ip route show
hostname
hostname -I
ping google.com
ping -c 4 google.com
traceroute google.com
nslookup google.com
dig google.com
ss -tuln
ss -tln
ss -uln
sudo ss -tulnp
wget https://www.w3schools.com/python/python_syntax.asp
curl ifconfig.me
cat /etc/resolv.conf
```
