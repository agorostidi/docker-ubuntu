# ubuntu
Docker con Ubuntu personalizado (con Supervisord y SSHD).
Puede usarse como base para otras imagenes, y como ejemplo para ver como subir / funcionar con contenedores en Bluemix.

Para construir la imagen correr docker build -t="agorostidi/ubuntu" .

Se trata de un docker basado en la imagen de ubuntu,  pero se le ha añadido un deamon SSHD para poder conectarse con un cliente SSH.  De esta forma no hace falta un attach al docker.
Se ha seguido las guia en https://docs.docker.com/engine/examples/running_ssh_service/ para habilitar el SSHD.

Si se quiere entrar por SSH, añadir en el fichero autorized_keys tu clave publica SSH.

EL docker tambien tiene un ejemplo de uso del servicio SUPERVISOR.   A través del supervidord se corre tanto el deamon SSHD como el deamon CRON.  Esta es la forma ideal para correr varios servicios al arranque en un docker.
El supervidord viene explicado en https://docs.docker.com/engine/admin/multi-service_container/

Hay que recordar que si un docker en BLUEMIX termina automaticamente (se para) cuando termina de ejecutar lo que tiene en el ENTRYPOINT.  Por tanto, si el docker no esta corriendo un servicio (un apache, un asterisk, etc), se detendra automaticamente. Poniendo un servicio con el Supervisor, podremos evitarlo.
