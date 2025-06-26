# Secure Remote Access with SSH

## 🔐 1. What is SSH?

- SSH = Secure Shell Protocol
- Encrypts communication over untrusted networks (TCP port 22)
- Replaces older, insecure tools like Telnet, RSH, FTP

______________________________________________________________________

## 🧠 2. How SSH Works

- **Client–server model** (Client initiates connection)
- Uses asymmetric cryptography (Private/Public keys)
- Auth steps:
  - Key exchange
  - Authentication (password or key)
  - Optional 2FA (e.g., TOTP via Google Authenticator)

______________________________________________________________________

## ⚙️ 3. Key SSH Commands

| Action | Command Example |
| ------------------ | ------------------------------------- |
| Connect to host | `ssh user@host` |
| Use specific port | `ssh -p 2222 user@host` |
| With key file | `ssh -i ~/.ssh/my_key user@host` |
| Copy file to host | `scp local.txt user@host:/home/user/` |
| Copy folder | `scp -r folder user@host:/home/user/` |
| Remote command | `ssh user@host "df -h"` |
| Tunnel local port | `ssh -L 8080:localhost:80 user@host` |
| Tunnel remote port | `ssh -R 9000:localhost:22 user@host` |

______________________________________________________________________

## 🗂️ 4. Managing SSH Keys

- Generate key:
  ```bash
  ssh-keygen -t ed25519 -C "you@example.com"
  ```
- Copy key:
  ```bash
  ssh-copy-id user@host
  ```
- Manual setup:
  - Place public key in `~/.ssh/authorized_keys`
- Permissions:
  ```bash
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/authorized_keys
  ```

______________________________________________________________________

## ⚙️ 5. Using `~/.ssh/config`

Simplify connections:

```ini
Host dev-server
  HostName 192.168.1.50
  User ubuntu
  Port 22
  IdentityFile ~/.ssh/id_ed25519
```

Benefits:

- Aliases (`ssh dev-server`)
- Save multiple identities
- Apply defaults for all hosts with `Host *`

______________________________________________________________________

## 🛡️ 6. Hardening SSH Security

- `/etc/ssh/sshd_config` settings:
  ```ini
  PermitRootLogin no
  PasswordAuthentication no
  AllowUsers youruser
  AllowGroups sshusers
  MaxAuthTries 3
  ```
- Restart SSH:
  ```bash
  sudo systemctl restart sshd
  ```
- Enable UFW:
  ```bash
  sudo ufw allow OpenSSH
  sudo ufw enable
  ```

______________________________________________________________________

## 🔐 7. Two-Factor Authentication (2FA)

- Install Google Authenticator:
  ```bash
  sudo apt install libpam-google-authenticator
  ```
- Configure PAM: Edit `/etc/pam.d/sshd`:
  ```text
  auth required pam_google_authenticator.so
  ```
- Edit `/etc/ssh/sshd_config`:
  ```ini
  ChallengeResponseAuthentication yes
  ```

______________________________________________________________________

## 🔀 8. Advanced Features

### a. Agent Forwarding

Use local keys from remote:

```bash
ssh -A user@jumpbox
```

### b. ProxyJump (Bastion Host Access)

```ini
Host internal
  HostName 10.0.1.10
  User ec2-user
  ProxyJump bastion@bastion-host.com
```

### c. Reverse Tunnelling

```bash
ssh -R 2222:localhost:22 user@remotehost
```

### d. Multiplexing

```ini
Host *
  ControlMaster auto
  ControlPath ~/.ssh/cm_socket_%r@%h:%p
  ControlPersist 10m
```

______________________________________________________________________

## 📦 9. Use Cases

- Connect to cloud VMs (AWS, Azure, GCP)
- Secure file transfer and backup scripts:
  ```bash
  ssh user@host 'bash /home/user/backup.sh'
  ```
- Git over SSH (GitHub, GitLab)
- Rsync with SSH:
  ```bash
  rsync -avz -e ssh /local/dir user@host:/remote/dir
  ```

______________________________________________________________________

## ⚠️ 10. Common Issues & Troubleshooting

| Issue | Solution |
| ----------------------------- | ------------------------------------------ |
| Permission denied (publickey) | Check file permissions, restart SSH agent |
| Cannot connect | Check IP, port, firewall |
| Host key changed | Remove old entry from `~/.ssh/known_hosts` |

______________________________________________________________________

## ✅ 11. Summary

- SSH = Essential for secure system management
- Key-based auth + config improves productivity
- Follow best practices to avoid security risks
