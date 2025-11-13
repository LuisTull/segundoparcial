# Imagen base de Ubuntu
FROM ubuntu:latest

# Instalar SSH, Nginx y utilidades básicas
RUN apt update && \
    apt install -y openssh-server nginx sudo curl && \
    mkdir /var/run/sshd

# Crear usuario ansible con contraseña 'ansible' y permisos sudo sin password
RUN useradd -m -s /bin/bash ansible && echo "ansible:ansible" | chpasswd && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Habilitar Nginx para servir una página simple
RUN echo "<h1>Servidor Web Activo desde Docker</h1>" > /var/www/html/index.html

# Exponer puertos: 22 (SSH) y 80 (HTTP)
EXPOSE 22 80

# Comando para iniciar tanto SSH como Nginx
CMD service ssh start && nginx -g "daemon off;"

