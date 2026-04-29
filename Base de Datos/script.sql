
CREATE TABLE public.lugares (
                id_lugares INTEGER NOT NULL,
                nombre VARCHAR(200) NOT NULL,
                descripcion VARCHAR(500) NOT NULL,
                provincia VARCHAR(100) NOT NULL,
                municipio VARCHAR(100) NOT NULL,
                departamento VARCHAR(100) NOT NULL,
                ubicacion VARCHAR(300) NOT NULL,
                latitud NUMERIC(50) NOT NULL,
                longitud NUMERIC(50) NOT NULL,
                url VARCHAR(300) NOT NULL,
                CONSTRAINT lugares_pk PRIMARY KEY (id_lugares)
);


CREATE TABLE public.horarios (
                id_horarios INTEGER NOT NULL,
                id_lugares INTEGER NOT NULL,
                dia VARCHAR(50) NOT NULL,
                apertura TIME NOT NULL,
                cierre TIME NOT NULL,
                CONSTRAINT horarios_pk PRIMARY KEY (id_horarios)
);


CREATE SEQUENCE public.comentarios_id_comentario_seq_2;

CREATE TABLE public.comentarios (
                id_comentario INTEGER NOT NULL DEFAULT nextval('public.comentarios_id_comentario_seq_2'),
                comentario VARCHAR(500) NOT NULL,
                calificacion INTEGER NOT NULL,
                fecha DATE NOT NULL,
                id_personas INTEGER NOT NULL,
                id_lugares INTEGER NOT NULL,
                id_recomentario INTEGER NOT NULL,
                CONSTRAINT comentarios_pk PRIMARY KEY (id_comentario)
);


ALTER SEQUENCE public.comentarios_id_comentario_seq_2 OWNED BY public.comentarios.id_comentario;

CREATE TABLE public.fotos (
                id_fotos INTEGER NOT NULL,
                url VARCHAR(300) NOT NULL,
                descripcion VARCHAR(100) NOT NULL,
                id_lugares INTEGER NOT NULL,
                id_comentario INTEGER NOT NULL,
                CONSTRAINT fotos_pk PRIMARY KEY (id_fotos)
);


CREATE SEQUENCE public.funcionalidades_id_funcionalidad_seq;

CREATE TABLE public.funcionalidades (
                id_funcionalidad VARCHAR NOT NULL DEFAULT nextval('public.funcionalidades_id_funcionalidad_seq'),
                nombre VARCHAR NOT NULL,
                CONSTRAINT funcionalidad_pk PRIMARY KEY (id_funcionalidad)
);


ALTER SEQUENCE public.funcionalidades_id_funcionalidad_seq OWNED BY public.funcionalidades.id_funcionalidad;

CREATE TABLE public.roles (
                id_roles INTEGER NOT NULL,
                nombre VARCHAR(100) NOT NULL,
                CONSTRAINT rol_pk PRIMARY KEY (id_roles)
);


CREATE UNIQUE INDEX roles_idx
 ON public.roles
 ( id_roles );

CREATE TABLE public.privilegios (
                id_roles INTEGER NOT NULL,
                id_funcionalidad VARCHAR NOT NULL,
                CONSTRAINT privilegios_pk PRIMARY KEY (id_roles, id_funcionalidad)
);


CREATE SEQUENCE public.personas_id_personas_seq;

CREATE TABLE public.personas (
                id_personas INTEGER NOT NULL DEFAULT nextval('public.personas_id_personas_seq'),
                nombres VARCHAR(100) NOT NULL,
                primer_apellido VARCHAR(100) NOT NULL,
                ci VARCHAR(50) NOT NULL,
                fecha_nacimiento DATE NOT NULL,
                genero VARCHAR(50) NOT NULL,
                direccion VARCHAR(200) NOT NULL,
                telefono_fijo INTEGER NOT NULL,
                celular INTEGER NOT NULL,
                segundo_apellido VARCHAR(100) NOT NULL,
                complemento_ci VARCHAR NOT NULL,
                correo_electronico VARCHAR(100) NOT NULL,
                CONSTRAINT personas_pk PRIMARY KEY (id_personas)
);


ALTER SEQUENCE public.personas_id_personas_seq OWNED BY public.personas.id_personas;

CREATE TABLE public.usuarios (
                id_personas INTEGER NOT NULL,
                usuario VARCHAR(50) NOT NULL,
                id_comentario INTEGER NOT NULL,
                password VARCHAR(200) NOT NULL,
                CONSTRAINT usuarios_pk PRIMARY KEY (id_personas)
);


CREATE UNIQUE INDEX usuarios_idx
 ON public.usuarios
 ( usuario );

CREATE TABLE public.favoritos (
                id_personas INTEGER NOT NULL,
                id_lugares INTEGER NOT NULL,
                CONSTRAINT favoritos_pk PRIMARY KEY (id_personas, id_lugares)
);


CREATE TABLE public.cuentas (
                id_personas INTEGER NOT NULL,
                id_roles INTEGER NOT NULL,
                CONSTRAINT cuentas_pk PRIMARY KEY (id_personas, id_roles)
);


ALTER TABLE public.horarios ADD CONSTRAINT lugares_horarios_fk
FOREIGN KEY (id_lugares)
REFERENCES public.lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comentarios ADD CONSTRAINT lugares_comentarios_fk
FOREIGN KEY (id_lugares)
REFERENCES public.lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fotos ADD CONSTRAINT lugares_fotos_fk
FOREIGN KEY (id_lugares)
REFERENCES public.lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.favoritos ADD CONSTRAINT lugares_favoritos_fk
FOREIGN KEY (id_lugares)
REFERENCES public.lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.usuarios ADD CONSTRAINT comentarios_usuarios_fk
FOREIGN KEY (id_comentario)
REFERENCES public.comentarios (id_comentario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fotos ADD CONSTRAINT comentarios_fotos_fk
FOREIGN KEY (id_comentario)
REFERENCES public.comentarios (id_comentario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comentarios ADD CONSTRAINT comentarios_comentarios_fk
FOREIGN KEY (id_recomentario)
REFERENCES public.comentarios (id_comentario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.privilegios ADD CONSTRAINT funcionalidades_privilegios_fk
FOREIGN KEY (id_funcionalidad)
REFERENCES public.funcionalidades (id_funcionalidad)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cuentas ADD CONSTRAINT roles_cuentas_fk
FOREIGN KEY (id_roles)
REFERENCES public.roles (id_roles)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.privilegios ADD CONSTRAINT roles_privilegios_fk
FOREIGN KEY (id_roles)
REFERENCES public.roles (id_roles)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.usuarios ADD CONSTRAINT personas_usuarios_fk
FOREIGN KEY (id_personas)
REFERENCES public.personas (id_personas)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cuentas ADD CONSTRAINT usuarios_cuentas_fk
FOREIGN KEY (id_personas)
REFERENCES public.usuarios (id_personas)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.favoritos ADD CONSTRAINT usuarios_favoritos_fk
FOREIGN KEY (id_personas)
REFERENCES public.usuarios (id_personas)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
