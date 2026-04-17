Empiezo por crear la BDD en el primer nodo con el esquema especificado, respetando las reglas de negocio y de integridad descriptas usando checks y triggers.

![[tp_2_1.png]]

```
-- Creacion de tablas en el nodo 1

create table localidad(
    id_local int primary key not null,
    codigo_postal int not null
);

create table cliente(
    id_cliente int primary key not null,
    nombre varchar(50) not null,
    id_local int not null,
    
    constraint fk_cliente_local foreign key (id_local)
    references localidad(id_local)
);

-- Generadores y triggers BEFORE INSERT asociados en el nodo 1

CREATE GENERATOR gen_local_id;
SET GENERATOR gen_local_id TO 0;

CREATE GENERATOR gen_cli_id;
SET GENERATOR gen_cli_id TO 0;

SET TERM ^;

CREATE TRIGGER trg_bi_local for localidad
active before insert position 0
as
begin
    new.ID_LOCAL = gen_id(gen_local_id, 1);
end^

SET TERM ;^

SET TERM ^;

CREATE TRIGGER trg_bi_cliente for cliente
active before insert position 0
as
begin
    new.ID_CLIENTE = gen_id(gen_cli_id, 1);
end^

SET TERM ;^
```

Con Oracle VirtualBox Manager y un archivo de imágen ISO Ubuntu instalados, inicializo una máquina virtual y en ella descargo Firebird 5.0 y FlameRobin 0.9.3. 

A continuación, genero un archivo de tipo .fbk sobre la BDD creada localmente para pasarselo a la máquina virtual a través de una carpeta compartida de VirtualBox, lo que me permitirá hacer un "Restore" en la VM y así crear correctamente en el segundo nodo las tablas, triggers y generadores necesarios (el esquema de la BDD).

![[tp_2_2.png]]

Desde la ventana de Oracle VirtualBox, gestiono las carpetas compartidas de la máquina virtual correspondiente para asegurar acceso por parte del 2do nodo al archivo .fbk:
![[tp_2_3.png]]

Instalo los "Guest Additions" oficiales de VirtualBox dentro de Linux. Los "Guest Additions" son controladores que se permiten la integración entre el sistema anfitrión (Windows) y el invitado "Ubuntu". Permite montar carpetas compartidas sobre el sistema invitado, compartir el portapapeles, sincronizar la resolución de pantalla, sincronizar los tiempos de la máquina host con la virtual, etc:
![[tp_2_4.png]]
![[tp_2_5.png]]
Se verifica el acceso al archivo .fbk desde la máquina virtual.

Instalo las utilidades de Firebird dentro de la máquina virtual usando el comando `sudo apt install firebird3.0-utils` y restauro en la BDD del 2do nodo la BDD original ejecutando este comando en la consola de Ubuntu:
```
sudo gbak -c -v -user SYSDBA -password masterkey /media/sf_TuCarpeta/respaldo_tp.fbk /var/lib/firebird/data/BDD_NODO_2.fdb
```

![[tp_2_6.png]]

Ejecuto `ip addr` para obtener la dirección IP del 2do nodo, que usaré para conectarme a su Firebird desde la máquina host (que utiliza el sistema operativo de Windows), registrando el servidor.

![[tp_2_7.png]]
![[tp_2_8.png]]

![[tp_2_9.png]]

- "ufw" quiere decir "uncomplicated firewall". Habilitamos el puerto 3050 en el nodo 2 para que Ubuntu no bloquee conexiones entrantes por default en aquel puerto. Esto habilita la conexión entre los nodos.

![[tp_2_10.png]]

- chown: Significa "change owner" (cambiar dueño), cambia quién es el dueño del archivo. Lo ejecuto en el 2do nodo para permitir al usuario del gestor de BDD en el 2do nodo escribir al directorio de FB. Cuando el nodo 1 manda un EXECUTE STATEMENT, se conecta usando un usuario de BDD. El motor del nodo 2 debe poder recibir esa orden, ingresar al archivo .fdb en el segundo nodo y escribir los datos ordenados por el 1er nodo a él.
  Fuera a no haber cambiado los permisos a priori, el archivo aún pertenecería a root y no al motor.

No me olvido de registrar la base de datos cómo BDD existente en el segundo nodo:
![[tp_2_11.png]]

Aseguro la conexión entre ambas BDD ejecutando la siguiente query en BDD_NODO_1:
```
SET TERM ^ ;

CREATE OR ALTER PROCEDURE INSERTAR_EN_BDD_EXTERNA (
    cod_post INT
)
AS
    DECLARE VARIABLE sentencia_sql VARCHAR(200);
BEGIN
    -- Armo la sentencia
    sentencia_sql = 'INSERT INTO LOCALIDAD (CODIGO_POSTAL) VALUES (' || :cod_post || ')';
    
    -- La envio al 2do nodo
    EXECUTE STATEMENT :sentencia_sql
    ON EXTERNAL '192.168.100.26/3050:/var/lib/firebird/data/BDD_NODO_2.fdb'
    AS USER 'SYSDBA' PASSWORD 'masterkey';
END^

SET TERM ; ^

EXECUTE PROCEDURE INSERTAR_EN_BDD_EXTERNA(1708);
COMMIT;
```

Al consultar BDD_NODO_2 en Ubuntu, puedo verificar que las dos bases de datos están conectadas.
![[tp_2_12.png]]

Ya con la conexión establecida entre ambos motores, procedo a escribir los procedimientos para la replicación en el nodo 1 con sus triggers asociados. No los escribo en la máquina virtual para asegurarme que permanezca como un receptor pasivo, según la consigna.

Todas las sentencias escritas se encuentran adjuntas en los archivos .sql asociadas a la entrega.

Pruebo el primer trigger asociado a la inserción de un local a las tablas. Al consultar tanto el motor en la BDD del nodo 1 en Windows y la BDD del nodo 2 en Ubuntu, puedo verificar que se ejecuta de manera exitosa.

```
SET TERM ^;

CREATE TRIGGER TRG_LOCAL_REPLICAR_INSERT_AI FOR LOCALIDAD
AFTER INSERT AS
begin
    EXECUTE PROCEDURE INSERTAR_EN_BDD_EXTERNA_LOCAL(NEW.CODIGO_POSTAL);
END^

SET TERM ;^
```

Ubuntu:
![[tp_2_13.png]] 

Windows:
![[tp_2_14.png]]

Verifico lo mismo en el trigger asociado a la inserción de un cliente. Ejecuto `INSERT INTO CLIENTE(nombre, id_local) VALUES ('Romina', 1);` en el 1er nodo:

Ubuntu:
![[BDD II/Unidad I/tp_2_15.png]]

Windows:
![[BDD II/Trabajos Prácticos/Imagenes/tp_2_15.png]]

Hago lo mismo con los demás procedimientos. Todas las sentencias están escritas en el documento .sql asociado a la entrega.