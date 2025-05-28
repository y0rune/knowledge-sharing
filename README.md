# Knowledge Sharing

## Planned Topics and Dates

- **21st May 2025** – *Basic Linux commands*
  Perfect for beginners or anyone in need of a refresher.

- **28th May 2025** – *Introduction to Git*
  What it is, how it works, and how we can use it effectively.

- **11th June 2025** – *Fixing a broken Linux system*
  Practical steps for diagnosing and repairing common issues.

- **18th June 2025** – *Using SSH and remote access*
  Learn how to securely connect to and manage remote systems.

- **25th June 2025** – *Writing simple Bash scripts*
  Automate tasks and boost productivity with basic scripting skills.

## How to Connect to the KS Docker Machines

This guide explains how to connect to your assigned server machine via SSH.

## Credentials

- **Username:** `root`
- **Password:** `ks2025@`

## Server Address Format

To connect to a specific machine, use the following format:

```bash
ssh root@chinczyk.cloud -p 25XX
```

Replace `XX` with the number of your assigned machine. For example:

- For **Machine 01**:

  ```bash
  ssh root@chinczyk.cloud -p 2501
  ```

- For **Machine 25**:

  ```bash
  ssh root@chinczyk.cloud -p 2525
  ```

## Example Connection

```bash
ssh root@chinczyk.cloud -p 2503
```

When prompted, enter the password: `ks2025@`

## Notes

- Make sure port **25XX** is open and not blocked by your local firewall.
- If you see a warning about authenticity of the host, type `yes` to continue.
- After login, you’ll be in a Linux environment. Start with `ls`, `pwd`, or check your assigned tasks!

Happy learning! 🐧
