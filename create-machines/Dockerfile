# Dockerfile
FROM ubuntu:25.04
RUN apt-get update && apt-get install -y inetutils-ping net-tools openssh-server vim git nano iproute2
RUN echo 'root:ks2025@' | chpasswd
RUN echo -n 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDe5HaXO05h9W39ne8oG6Y65/iGV5pLo8tc9jKvU9RsfaNWviRu7ax7d/LrOPqotCrTOy4S3b+V4NaxB6CpJSr1Tq1tcCh5/5E5XIDfS61VUIO6VLTMlFKReS3xVuxeUQefsidy7OPdB0bcyxxxXMDzdcYtwu6VAvzrG8fyGVdvzkfZ08XswOi6AtXBZUF4ON2u+4mcvBGYpPBkmKireEHwyPYLiRBbGZQvWmiZnbPcnEXOZfZzBQLAGwMtNrHDmgVg1LxkjYB5ohpkWJyl1L17j23gA9+ORkaCqQTLc8SUkJKUbhCPGaYRsKn3WjZkHLGHXo1IAszFbRBQyF3wW7ZefnssFBMLma45XFbNzQvNAmmeM0hPAsOn8sw+VXBvFPnVGugGxvz1R4D+iu1WtUvTTPxfcAk+FNOdfujKHnZfM1oxcgM4Q9OVPf5FJDTtab2kBq6ciKDS4p2sKEZ+gpM6wWqwGwIcWmuJXg41bpMPH3MQLhxz0MajDZmSgs8Z2b8= yorune@Gentoo' > /root/.ssh/authorized_keys
RUN echo -n 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC5csgTgrjJuEkDneY9kE55NehmFrdHMW6DgJ8fHAp3414Kj8nU9ICNxe2SwtAppkvDmbw/22U8mbo3AqKSdrnP2vn9xdbxSlkqWTWogBZfFhapW1ruIph32ZtCUOEWfgBQQaGwPX+AVDq21eRlSnj/Uh4mZhJWHVpwCeYnu9Ps19MxN1Z1kIeHdQnR0UJHZDsROBLIaT+htw0Ut+jNEGr8bmp1rCPK+q7wWBA351oYP/teWgQSk1BT8lQacQ6Bn9tYHDCbmqPiScEupktsougfVPxOcBtdUtIOxOQKZOhYS01mSXlXb4h12mQ0e2zTReyrKdny+RHaBlTZdSb6rZ0L yorune@d9yc132.cognet.local' >> /root/.ssh/authorized_keys
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
