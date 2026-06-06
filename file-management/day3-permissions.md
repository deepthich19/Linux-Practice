# Day 3 - File Permissions and User Management

## Understanding Permission String
```
- rw- r-- r--   1   deepthi  deepthi   1024   Jun 5   day2.md
↑  ↑   ↑   ↑   ↑      ↑        ↑        ↑      ↑       ↑
|  |   |   |   |      |        |        |      |       └── File name
|  |   |   |   |      |        |        |      └── Last modified date
|  |   |   |   |      |        |        └── File size in bytes
|  |   |   |   |      |        └── Group owner
|  |   |   |   |      └── User owner
|  |   |   |   └── Link count
|  |   |   └── Others permissions
|  |   └─────── Group permissions
|  └──────────── Owner permissions
└─────────────── File type
```

## File Types
```
- = regular file
d = directory
l = symbolic link
```

## Permission Values
```
r = read    = 4
w = write   = 2
x = execute = 1
- = none    = 0
```

## Permission Groups
```
Owner  = person who created the file
Group  = team sharing access to the file
Others = everyone else on the system
```

## How Linux Checks Permissions
```
Step 1: Are you the OWNER?  → Yes → apply owner permissions → stop
Step 2: Are you in GROUP?   → Yes → apply group permissions → stop
Step 3: You are OTHER       → apply others permissions
```

## Terminal Colors for ls
```
White = regular file
Green = executable file (has x permission)
Blue  = directory
Cyan  = symbolic link
```

---

## chmod - Change Permissions

### Symbolic Method
```
chmod u+x file.txt    # add execute to owner
chmod g+w file.txt    # add write to group
chmod o-r file.txt    # remove read from others
chmod a+r file.txt    # add read to all

u = user/owner
g = group
o = others
a = all (u+g+o)
+ = add permission
- = remove permission
```

### Numeric Method
```
chmod 755 file.txt
chmod 644 file.txt
chmod 600 file.txt
chmod 777 file.txt    # dangerous - avoid in production
chmod 444 file.txt    # read only for everyone
chmod 000 file.txt    # no permissions for anyone

How to calculate:
r = 4, w = 2, x = 1

chmod 755:
7 = rwx = 4+2+1 = owner full access
5 = r-x = 4+0+1 = group read+execute
5 = r-x = 4+0+1 = others read+execute

chmod 644:
6 = rw- = 4+2+0 = owner read+write
4 = r-- = 4+0+0 = group read only
4 = r-- = 4+0+0 = others read only
```

### Common Permission Sets
```
755 = scripts, directories
644 = normal files, configs
600 = private keys, passwords (owner only)
777 = never use in production
```

---

## chown - Change Ownership

### Full Form: Change Owner
```
chown deepthi file.txt              # change user owner only
chown deepthi:deepthi file.txt      # change user and group owner
chown -R deepthi:deepthi myfolder/  # recursive - folder + all contents
sudo chown root file.txt            # needs sudo to change ownership
```

### chown vs chmod
```
chown = change WHO owns the file
chmod = change WHAT they can do with the file
```

### Colon meaning in chown
```
chown user:group file.txt
         ↑
         colon separates user and group
left of colon  = user owner
right of colon = group owner
```

---

## User Management Commands

### id
```
id
# Shows: uid=1000(deepthi) gid=1000(deepthi) groups=...
# uid = user ID
# gid = primary group ID
# groups = all groups you belong to
```

### who
```
who
# Shows who is currently logged into the system
# deepthi  tty2  2026-06-05 16:11 (tty2)
```

### whoami
```
whoami
# Shows current logged in username
```

### groups
```
groups
# Quick way to see which groups you belong to
```

---

## sudo Commands

### Full Forms
```
sudo   = Super User Do
su     = Switch User
sudo su = Super User Do - Switch User (to root)
```

### Prompt Difference
```
deepthi@deepthi-VirtualBox:~$    = normal user ($)
root@deepthi-VirtualBox:/home/#  = root user (#)
```

### All sudo Commands
```
sudo command          # run ONE command as root
sudo apt install x    # install package as root
sudo nano /etc/hosts  # edit system file as root
sudo -l               # list your sudo permissions
sudo su               # switch to full root session
sudo su -             # switch to root + load root environment
sudo -i               # interactive root shell (same as sudo su -)
sudo -s               # root shell keeping your environment
su username           # switch to another user
exit                  # exit root and return to normal user
```

### Difference between sudo su and sudo su -
```
sudo su               # switch to root, stay in current directory
                      # pwd shows /home/deepthi

sudo su -             # switch to root, move to root home
                      # pwd shows /root
```

### sudo -l output explained
```
(ALL : ALL) ALL
  ↑     ↑    ↑
  |     |    └── can run ALL commands
  |     └─────── as ANY group
  └──────────── on ANY host
= full sudo access, no restrictions
```

---

## System Files

### /etc/passwd - All User Accounts
```
Format: username:x:UID:GID:description:home:shell

root:x:0:0:root:/root:/bin/bash
  ↑  ↑ ↑ ↑  ↑     ↑       ↑
  |  | | |  |     |       └── default shell
  |  | | |  |     └── home directory
  |  | | |  └── description
  |  | | └── Group ID
  |  | └── User ID
  |  └── password (x = stored in /etc/shadow)
  └── username

nologin = system account, cannot log in interactively
/bin/bash = real user, can log in and use terminal
```

### /etc/group - All Groups
```
Format: groupname:x:GID:members

sudo:x:27:deepthi
  ↑  ↑  ↑    ↑
  |  |  |    └── members (deepthi is in sudo group)
  |  |  └── Group ID
  |  └── password (x = rarely used)
  └── group name

adm:x:4:syslog,deepthi   # can read system logs
cdrom:x:24:deepthi        # can access CD/DVD
sudo:x:27:deepthi         # can run admin commands
dip:x:30:deepthi          # can manage VPN/dial-up
```

### /etc/shadow
```
# Stores encrypted passwords
# Only root can read this file
# More secure than storing in /etc/passwd
```

---

## Practice Commands Run Today
```
ls -l ~/Linux-Practice          # checked permissions
touch perm-test.txt             # created test file
chmod u+x file                  # added execute permission
chmod 444 file                  # made read only
echo "test" >> file             # tested write (failed on 444)
chmod 644 file                  # restored permissions
sudo chown root file            # changed owner to root
sudo chown deepthi:deepthi file # changed back to deepthi
id                              # checked user details
who                             # checked logged in users
sudo su                         # switched to root
exit                            # returned to normal user
sudo -l                         # checked sudo permissions
cat /etc/passwd                 # viewed all users
cat /etc/group                  # viewed all groups
```
