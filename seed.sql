-- Ingredientes
INSERT INTO INGREDIENTE (id_ingrediente, nome, quantidade, unidade) VALUES
(1, 'Hamburguer de carne', 20, 'un'),
(2, 'Queijo', 3000, 'g'),
(3, 'Bacon', 2000, 'g'),
(4, 'Ovo', 30, 'un'),
(5, 'Tomate', 15, 'un'),
(6, 'Massa', 15, 'un'),
(7, 'Pão de hambúrguer', 25, 'un'),
(8, 'Alface', 10, 'un'),
(9, 'Molho especial', 2000, 'ml'),
(10, 'Frango desfiado', 1500, 'g'),
(11, 'Calabresa', 1800, 'g'),
(12, 'Molho de tomate', 2500, 'ml'),
(13, 'Sorvete de creme', 2000, 'ml'),
(14, 'Brownie', 10, 'un'),
(15, 'Coca Cola', 1, 'un'),
(16, 'Laranja', 40, 'un');

-- Comidas
INSERT INTO COMIDA (id_comida, nome, preco, tipo) VALUES
(1, 'Hamburguer Artesanal', 25.00, 'Lanche'),
(2, 'Pizza de Queijo', 30.00, 'Pizza'),
(3, 'Carbonara', 45.00, 'Jantar'),
(4, 'Hamburguer de Frango', 22.00, 'Lanche'),
(5, 'Pizza de Calabresa', 32.00, 'Pizza'),
(6, 'Salada Premium', 18.00, 'Salada'),
(7, 'Brownie com Sorvete', 15.00, 'Sobremesa'),
(8, 'Coca Cola', 7.00, 'Bebida'),
(9, 'Suco de Laranja', 10.0, 'Bebida');

-- Ficha Técnica
INSERT INTO COMIDA_UTILIZA_INGREDIENTE (id_ingrediente, id_comida, quantidade_utilizada) VALUES
(1, 1, 1), (2, 1, 100), (3, 1, 50),
(6, 2, 1), (2, 2, 100), (5, 2, 2),
(6, 3, 1), (3, 3, 100), (4, 3, 3),
(7, 4, 1), (10, 4, 120), (2, 4, 80), (8, 4, 1), (9, 4, 20),
(6, 5, 1), (11, 5, 150), (2, 5, 100), (12, 5, 120),
(8, 6, 2), (5, 6, 1), (4, 6, 1), (9, 6, 10),
(14, 7, 1), (13, 7, 200),
(15, 8, 1),
(16, 9, 2);

-- Endereços
INSERT INTO ENDERECO (id_endereco, rua, numero, cep, complemento) VALUES
(1, 'Av. Salgado Filho', 100, '59145-875', 'Ap 902'),
(2, 'Rua Missionário Gunnar Vingren', 1932, '59082-080', 'Casa 2'),
(3, 'Av. Hermes da Fonseca', 350, '59873-654', ''),
(4, 'Alameda dos Bosques', 795, '59165-155', 'Casa 10'),
(5, 'Av. Prudente de Morais', 120, '59012-111', 'Ap 501'),
(6, 'Av. Engenheiro Roberto Freire', 2200, '59090-300', 'Bloco B'),
(7, 'Rua Alexandre Câmara', 1773, '59082-200', ''),
(8, 'Rua Monsenhor Honório', 218, '59020-290', '');

-- Clientes
INSERT INTO CLIENTE (id_cliente, nome, telefone, id_endereco) VALUES
(1, 'Caio Santos', '84994270101', 1),
(2, 'João Pereira', '8499658745',  2),
(3, 'Mariana Costa', '8499328754',  3),
(4, 'Fernanda Lima', '84991020300', 4),
(5, 'Paulo Araújo', '84999771234', 5),
(6, 'Roberta Silva', '84994005511', 6),
(7, 'Thiago Fernandes', '84998124566', 7);

-- Comandas
INSERT INTO COMANDA (id_comanda, total, id_cliente) VALUES
(1, 0, 1), (2, 0, 2), (3, 0, 3), (4, 0, 4), (5, 0, 5), (6, 0, 6), (7, 0, 7);

-- Funcionários
INSERT INTO FUNCIONARIO (id_funcionario, nome, cpf, data_nascimento) VALUES
(1, 'Carlos Souza', '12345678900', '1990-04-10'),
(2, 'Bruna Rocha', '98765432100', '1988-09-15'),
(3, 'Felipe Martins', '11223344556', '1995-01-20'),
(4, 'Ana Beatriz', '55443322100', '1992-11-08');

-- Pedidos
INSERT INTO PEDIDO(id_pedido, horario, id_comanda, id_funcionario, eh_delivery) VALUES
(1, NOW(), 1, 2, FALSE),
(2, NOW(), 3, 1, FALSE),
(3, NOW(), 2, 2, TRUE),
(4, NOW(), 4, 3, TRUE),
(5, NOW(), 5, 4, FALSE),
(6, NOW(), 6, 2, TRUE),
(7, NOW(), 7, 1, FALSE);

-- Itens do pedido
INSERT INTO PEDIDO_TEM_COMIDA (id_pedido, id_comida, quantidade) VALUES
(1, 2, 1),
(3, 3, 1),
(2, 1, 1),
(2, 8, 1),
(4, 4, 1),
(4, 1, 1),
(4, 9, 2),
(5, 2, 1),
(6, 5, 1),
(7, 6, 1),
(7, 1, 1),
(7, 8, 2),
(7, 7, 1);

-- Delivery
INSERT INTO DELIVERY (id_pedido, id_endereco, taxa_entrega) VALUES
(3, 2, 3.5),
(4, 5, 4.0),
(6, 6, 5.0);

-- Presencial
INSERT INTO PRESENCIAL(id_pedido, num_mesa, num_pessoas) VALUES
(1, 4, 3),
(2, 2, 7),
(5, 3, 2),
(7, 1, 4);

-- 4. CALCULA TOTAIS
UPDATE COMANDA c
SET total = (
    SELECT COALESCE(SUM(co.preco * ptc.quantidade), 0)
    FROM PEDIDO p
    JOIN PEDIDO_TEM_COMIDA ptc ON p.id_pedido = ptc.id_pedido
    JOIN COMIDA co ON ptc.id_comida = co.id_comida
    WHERE p.id_comanda = c.id_comanda
);