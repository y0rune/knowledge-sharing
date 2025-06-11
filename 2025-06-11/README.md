# Knowledge Sharing ZjebanOS

# Table of contents

1. [Authors](#authors)

1. [How to run a docker container?](#docker)

1. [Informations](#informations)

1. [Main tasks](#tasks)

1. [Rules](#rules)

1. [List of tasks](#list-of-tasks)

   6.1. [Trying to use `ls` and got `Segmentation fault`](#task-1)

   6.2. [Trying to start the `nginx` - part 1](#task-2)

   6.3. [Trying to start the `nginx` - part 2](#task-3)

   6.4. [Localhost issue](#task-4)

   6.5. [Trying to start `apache2` - part 1](#task-5)

   6.6. [Trying to start `apache2` - part 2](#task-6)

   6.7. [Trying to start `apache2` - part 3](#task-7)

   6.8. [Trying to start `apache2` - part 4](#task-8)

   6.9. [Nginx and apache is working but the page returns `Forbidden`](#task-9)

   6.10. [PHP not showing a solution](#task-10)

## 1. Authors <a name="authors"></a>

Author of Knowledge Sharing: [Marcin Woźniak](https://yorune.pl)

Orginal Author: [Link to docker hub](https://hub.docker.com/r/unknow/zjebanos)

Video in polish with debugging: [YouTube Video](https://www.youtube.com/watch?v=-i72IF-Fsts)

## 2. How to run a docker container? <a name="docker"></a>

- Firstly, clone a repo using:

```bash
git clone https://github.com/wttech-private/wtpl-it-knowledge-sharing-zjebanos.git
```

- Secondly, install the docker into your system
- Thirdly, load the image using

```bash
docker load <chinczyk-knowledge-sharing.tar.gz
```

The output should looks like this:

```bash
docker images -a
REPOSITORY TAG IMAGE ID CREATED SIZE
chinczyk-knowledge-sharing-v2 latest eb3dff5d9809 3 days ago 65.3MB
```

- To run that container

```bash
docker run \
  --name "chinczyk-knowledge-sharing" \
  -d \
  -p "2201":22 \
  -p "8001":80 \
  chinczyk-knowledge-sharing-v2
```

- To go inside to that container

## 3. Information <a name="informations"></a>

- Server IP: `chinczyk.cloud`
- SSH: `chinczyk.cloud:26+(NUMBER-GROUP)` (chinczyk.cloud:2201)
- NGINX: `chinczyk.cloud:81+(NUMBER-GROUP)` (chinczyk.cloud:8001)
- PASSWORD: `Chinczyk-2022!`

## 4. Main tasks: <a name="tasks"></a>

- There is a corrupted nginx on the server forwards traffic to apache. You have to run it
- The server has an apache2 application that does not get up. It needs to be repaired.

## 5. Rules: <a name="rules"></a>

- Do not change the application code in PHP
- Try NOT to install additional applications on the system

```bash
docker exec -ti chinczyk-knowledge-sharing bash
```

# 6. List of tasks <a name="list-of-tasks"></a>

## 6.1. Trying to use `ls` and got `Segmentation fault` <a name="task-1"></a>

Checking the example command `ls`

```bash
zjebanOS:~# ls
segmentation fault
```

Checking where is the file `ls` using the command `whereis`

```bash
zjebanOS:~# whereis ls
ls: /bin/ls
```

It can be a `alias` for that command so we will check it using a command `alias`

```bash
zjebanOS:~# alias
alias cat='echo segmentation fault;#'
alias cd='echo segmentation fault;#'
alias ls='echo segmentation fault;#'
alias mc='echo segmentation fault;#'
```

### Solution

To resolve that issue you can use command `unalias <command>`

```bash
zjebanOS:~# unalias cat
zjebanOS:~# unalias cd
zjebanOS:~# unalias ls
zjebanOS:~# unalias mc
```

_Please test it using a `curl localhost` if check the nginx will work in the tasks 2,3,4_

## 6.2. Trying to start the `nginx` - part 1 <a name="task-2"></a>

Starting the `nginx`

```bash
zjebanOS:~# /etc/init.d/nginx start
* /run/nginx: creating directory
* /run/nginx: correcting owner
nginx: [emerg] unknown directive "listen 80" in /etc/nginx/conf.d/default.conf:5
nginx: configuration file /etc/nginx/nginx.conf test failed
* ERROR: nginx failed to start
```

After opening the file in 5th line using command `vim /etc/nginx/conf.d/default.conf +5`
The syntax in that case is all right.

The administation can rewrite the file using another operating system, so we can check it using:

```bash
zjebanOS:~# grep listen /etc/nginx/conf.d/default.conf | hexdump -c
0000000 \t l i s t e n 302 240 8 0 d e f a
0000010 u l t _ s e r v e r
\n
000001c
```

As far you see on the `l i s t e n 302 240 8 0`, for that case the output should look like this `l i s t e n 8 0`

### Solutions:

For remove that you can rewrite that line or word

## 6.3. Trying to start the `nginx` - part 2 <a name="task-3"></a>

Again we are trying to start `nginx`

```bash
zjebanOS:~#  /etc/init.d/nginx start
nginx: [emerg] open() "/var/log/nginx/serwisy/obliczenia.log" failed (2: No such file or directory)
nginx: configuration file /etc/nginx/nginx.conf test failed
 * ERROR: nginx failed to start
```

So we are trying to see if that file exist.

```bash
ls /var/log/nginx/serwisy/obliczenia.log
```

File is not exist. Now, we are going to check the folder. It is not exist too. So we have to create the folder and file.

### Solution

```bash
mkdir -p /var/log/nginx/serwisy
touch /var/log/nginx/serwisy/obliczenia.log
```

Now, we can run the `nginx`

```bash
zjebanOS:~# /etc/init.d/nginx start
```

## 6.4. Localhost issue <a name="task-4"></a>

Check the `curl localhost`

```bash
zjebanOS:~# curl -I localhost
HTTP/1.1 301 Moved Permanently
server: openresty
date: Sun, 18 Sep 2022 15:00:07 GMT
content-type: text/html
content-length: 166
location: http://www.pornhub.com/
strict-transport-security: max-age=63072000
includeSubDomains
preload
x-request-id: 63273277-42FE722900508F57-EDE8467
```

So it can be problem with local DNS. That file is `/etc/hosts`

### Solution

Edit that file (`/etc/hosts`) and change the ip `66.254.114.41` to `127.0.0.1`

## 6.5. Trying to start `apache2` - part 1 <a name="task-5"></a>

```bash
/etc/init.d/apache2 start
Can't load /lib/ld-musl-x86_64.so.2 (0x7f57f1c15000)
```

Maybe is avaliable the another version of that lib. Yeah it is avaliable.

```bash
ls /lib/ld-musl-x86_64.so.*
/lib/ld-musl-x86_64.so.1
```

### Solution

```bash
ln -s /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.2
```

## 6.6. Trying to start `apache2` - part 2 <a name="task-6"></a>

Restarting again the `apache2` service

```bash
zjebanOS:~#  /etc/init.d/apache2 start
 * WARNING: apache2 has already been started
zjebanOS:~#  /etc/init.d/apache2 restart
Can't load /lib/ld-musl-x86_64.so.2 (0x7f57f1c15000)
Can't load /lib/ld-musl-x86_64.so.2 (0x7f57f1c15000)
```

Let's debug that command. What is inside in that file `/etc/init.d/apache2`

```bash
cat /etc/init.d/apache2 | head -n6
zjebanOS:~# cat /etc/init.d/apache2 | head -n6
#!/sbin/openrc-run
echo "Can't load /lib/ld-musl-x86_64.so.2 (0x7f57f1c15000)"
exit

extra_commands="configdump configtest modules virtualhosts"
extra_started_commands="fullstatus graceful gracefulstop reload"
```

As you can see in the 1st line we have a `echo` with exit. That's why the `apache` is not working. Remove that line from the file.

## 6.7. Trying to start `apache2` - part 3 <a name="task-7"></a>

Restarting again the `apache2` service

```bash
zjebanOS:~#  /etc/init.d/apache2 restart
 * Caching service dependencies ...                                     [ ok ]
 * Stopping apache2 ...                                                 [ ok ]
 * apache2 has detected an error in your setup:
AH00526: Syntax error on line 1 of /etc/apache2/conf.d/security.conf:
can't write to /etc/sshd/sshd_config
 * ERROR: apache2 failed to start
```

Check the file `/etc/apache2/conf.d/security.conf`. In that file is not nessecry so you can remove it

### Solution

```bash
zjebanOS:~# rm -rf /etc/apache2/conf.d/security.conf
```

## 6.8. Trying to start `apache2` - part 4 <a name="task-8"></a>

Restarting again the `apache2` service

```bash
zjebanOS:~#  /etc/init.d/apache2 restart
 * Stopping apache2 ...                                                 [ ok ]
 * Starting apache2 ...
AH00557: httpd: apr_sockaddr_info_get() failed for d6809bd5afa3
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 127.0.0.1. Set the 'ServerName' directive globally to suppress this message [ ok ]
```

So check the `curl localhost`

```bash
zjebanOS:~# curl -I localhost
HTTP/1.1 301 Moved Permanently
server: openresty
date: Sun, 18 Sep 2022 15:00:07 GMT
content-type: text/html
content-length: 166
location: http://www.pornhub.com/
strict-transport-security: max-age=63072000
includeSubDomains
preload
x-request-id: 63273277-42FE722900508F57-EDE8467
```

Maybe it can be a cron or something:

```bash
zjebanOS:etc# grep -ir '66.254.114.41' .
./hosts:66.254.114.41 localhost
./init.d/bootmisc:echo "66.254.114.41   localhost" >/etc/hosts
```

### Solution

Remove line including that ip address and change the ip address in the
`/etc/hosts`

Edit that file (`/etc/hosts`) and change the ip `66.254.114.41` to `127.0.0.1`

## 6.9. Nginx and apache is working but the page returns `Forbidden` <a name="task-9"></a>

```bash
zjebanOS:etc# curl -I localhost
HTTP/1.1 403 Forbidden
Server: nginx
Date: Mon, 19 Sep 2022 06:18:52 GMT
Content-Type: text/html
charset=iso-8859-1
Connection: keep-alive
```

Let's check the apache logs

```bash
[Mon Sep 19 06:16:34.786763 2022] [autoindex:error] [pid 681] [client 127.0.0.1:50202] AH01276: Cannot serve directory /etc/strona/: No matching DirectoryIndex (index.html) found, and server-generated directory index forbidden by Options directive
```

### Solution

So check the apache file configuration `/etc/apache2/httpd.conf`
The line 278 should be change from `DirectoryIndex index.html ` to `DirectoryIndex index.html index.php`

## 6.10. PHP not showing a solution <a name="task-10"></a>

After checking the command `curl localhost`

```bash
zjebanOS:~# curl localhost

Rozpoczynamy skomplikowane obliczenia:

2 + 2 =
```

But it should looks

```bash
zjebanOS:~# curl localhost

Rozpoczynamy skomplikowane obliczenia:

2 + 2 = 4
```

So let's the website source:

```bash
cat /etc/strona/index.php
zjebanOS:~#  cat /etc/strona/index.php
<?php
$wynik_tymczasowy = 2+2;

file_put_contents('cache/obliczenia',$wynik_tymczasowy);

$wynik = file_get_contents('cache/obliczenia');

echo "\n\nRozpoczynamy skomplikowane obliczenia:\n\n";
echo "2 + 2 = ".$wynik."\n\n";
```

### Solution

```bash
zjebanOS:~# ls -la /etc/strona/cache/obliczenia
-rwxrwx--- 1 nginx nginx 1 Jun 1 2021 /etc/strona/cache/obliczenia
zjebanOS:~# chmod 777 /etc/strona/cache/obliczenia
zjebanOS:~# chown nginx: /etc/strona/cache/obliczenia
zjebanOS:~# /etc/init.d/nginx restart
```

Output:

```bash
zjebanOS:~# curl localhost

Rozpoczynamy skomplikowane obliczenia:

2 + 2 = 4
```
