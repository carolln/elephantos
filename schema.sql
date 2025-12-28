CREATE TABLE INGREDIENTE (
   id_ingrediente SERIAL PRIMARY KEY,
   nome TEXT NOT NULL,
   quantidade INT NOT NULL CHECK (quantidade >= 0),
   unidade TEXT NOT NULL
);

CREATE TABLE COMIDA (
   id_comida SERIAL PRIMARY KEY,
   nome TEXT NOT NULL,
   preco DECIMAL(10,2) NOT NULL CHECK (preco > 0),
   tipo TEXT
);

CREATE TABLE COMIDA_UTILIZA_INGREDIENTE (
   id_ingrediente INT NOT NULL,
   id_comida INT NOT NULL,
   quantidade_utilizada INT NOT NULL CHECK (quantidade_utilizada > 0),
   PRIMARY KEY (id_comida, id_ingrediente),
   FOREIGN KEY (id_ingrediente) REFERENCES INGREDIENTE(id_ingrediente),
   FOREIGN KEY (id_comida) REFERENCES COMIDA(id_comida)
);

CREATE TABLE ENDERECO (
   id_endereco SERIAL PRIMARY KEY,
   rua TEXT NOT NULL,
   numero INT NOT NULL,
   cep TEXT NOT NULL,
   complemento TEXT
);

CREATE TABLE CLIENTE (
   id_cliente SERIAL PRIMARY KEY,
   nome TEXT NOT NULL,
   telefone TEXT,
   id_endereco INT,
   FOREIGN KEY (id_endereco) REFERENCES ENDERECO(id_endereco)
);

CREATE TABLE COMANDA (
   id_comanda SERIAL PRIMARY KEY,
   total DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (total >= 0),
   id_cliente INT NOT NULL,
   FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE FUNCIONARIO (
   id_funcionario SERIAL PRIMARY KEY,
   nome TEXT NOT NULL,
   cpf TEXT UNIQUE NOT NULL,
   data_nascimento DATE
);

CREATE TABLE PEDIDO (
   id_pedido SERIAL PRIMARY KEY,
   horario TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
   id_comanda INT NOT NULL,
   id_funcionario INT NOT NULL,
   eh_delivery BOOLEAN NOT NULL,
   FOREIGN KEY (id_comanda) REFERENCES COMANDA(id_comanda),
   FOREIGN KEY (id_funcionario) REFERENCES FUNCIONARIO(id_funcionario)
);

CREATE TABLE PEDIDO_TEM_COMIDA (
   id_pedido INT NOT NULL,
   id_comida INT NOT NULL,
   quantidade INT NOT NULL CHECK (quantidade > 0),
   PRIMARY KEY (id_pedido, id_comida),
   FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
   FOREIGN KEY (id_comida) REFERENCES COMIDA(id_comida)
);

CREATE TABLE DELIVERY (
   id_pedido INT PRIMARY KEY,
   id_endereco INT NOT NULL,
   taxa_entrega DECIMAL(10,2) NOT NULL CHECK (taxa_entrega >= 0),
   FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
   FOREIGN KEY (id_endereco) REFERENCES ENDERECO(id_endereco)
);

CREATE TABLE PRESENCIAL (
   id_pedido INT PRIMARY KEY,
   num_mesa INT NOT NULL,
   num_pessoas INT NOT NULL CHECK (num_pessoas > 0),
   FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);