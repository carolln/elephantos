-- Qual foi o faturamento total do restaurante em um determinado período?
SELECT SUM(c.total) AS faturamento
FROM COMANDA c
JOIN PEDIDO p ON c.id_comanda = p.id_comanda
WHERE p.horario BETWEEN  '2025-01-01' AND '2025-01-31';

-- Quais são os produtos mais vendidos do mês?
SELECT
   c.nome AS produto,
   SUM(pc.quantidade) AS qtd_vendida
FROM PEDIDO_TEM_COMIDA pc
JOIN PEDIDO p ON p.id_pedido = pc.id_pedido
JOIN COMIDA c ON c.id_comida = pc.id_comida
WHERE DATE_TRUNC('month', p.horario) = DATE '2025-12-01'
GROUP BY c.nome
ORDER BY qtd_vendida DESC;

-- Quais são os produtos menos vendidos do mês?
SELECT
   c.nome AS produto,
   SUM(pc.quantidade) AS qtd_vendida
FROM PEDIDO_TEM_COMIDA pc
JOIN PEDIDO p ON p.id_pedido = pc.id_pedido
JOIN COMIDA c ON c.id_comida = pc.id_comida
WHERE DATE_TRUNC('month', p.horario) = DATE '2025-12-01'
GROUP BY c.nome
ORDER BY qtd_vendida ASC;

-- Quais ingredientes estão com estoque abaixo de X unidade?
SELECT *
FROM INGREDIENTE
WHERE quantidade < 10;

-- Quais produtos utilizam X ingrediente?
SELECT c.nome, i.nome
FROM COMIDA_UTILIZA_INGREDIENTE ci
JOIN COMIDA c ON c.id_comida = ci.id_comida
JOIN INGREDIENTE i ON i.id_ingrediente = ci.id_ingrediente
WHERE i.nome = 'Coca Cola';


-- Quais os produtos mais caros?
SELECT nome, preco, tipo
FROM COMIDA
ORDER BY preco DESC;

-- Quais os produtos mais baratos?
SELECT nome, preco, tipo
FROM COMIDA
ORDER BY preco ASC;

-- Qual a idade média dos trabalhadores?
SELECT
   AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nascimento))) AS idade_media
FROM FUNCIONARIO;

-- Qual funcionário mais atendeu pedidos?
SELECT f.nome, COUNT(p.id_pedido) AS quantidade
FROM FUNCIONARIO f
JOIN PEDIDO p ON p.id_funcionario = f.id_funcionario
GROUP BY f.nome
ORDER BY quantidade DESC;

-- Qual o valor médio gasto por pedido?
SELECT 	AVG(total) AS valor_medio
FROM COMANDA;

-- Qual rua recebe mais pedidos?
SELECT e.rua, COUNT(*) AS qtd
FROM DELIVERY d
JOIN ENDERECO e ON e.id_endereco = d.id_endereco
GROUP BY e.rua
ORDER BY qtd DESC;

-- Quem são os clientes que mais gastaram acima de X valor?
SELECT c.nome , SUM(co.total) AS total_gasto
FROM CLIENTE c
JOIN COMANDA co ON co.id_cliente = c.id_cliente
GROUP BY c.id_cliente
HAVING SUM(co.total) > 20
ORDER BY total_gasto DESC;

-- Qual comanda gastou mais?
SELECT co.id_comanda, c.id_cliente, co.total
FROM COMANDA co
JOIN CLIENTE c ON c.id_cliente = co.id_cliente
ORDER BY co.total DESC;