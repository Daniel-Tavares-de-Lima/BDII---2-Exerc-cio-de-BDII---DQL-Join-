-- -----------------RELATORIO 1-----------------

SELECT e.nome AS "Nome Empregado", e.cpf AS "CPF Empregado",
    e.dataAdm AS "Data Admissão",
    e.salario AS "Salário",
    d.nome AS "Departamento",
    t.numero AS "Número de Telefone"
FROM 
    Empregado e
JOIN 
    Departamento d ON idDepartamento = idDepartamento
LEFT JOIN 
    Telefone t ON Empregado_cpf = Empregado_cpf
WHERE 
    dataAdm BETWEEN '2019-01-01' AND '2022-03-31'
ORDER BY 
    dataAdm DESC;
-- -----------------RELATORIO 1-----------------


-- -----------------RELATORIO 2-----------------
SELECT e.nome AS "Nome Empregado", e.cpf AS "CPF Empregado",
    e.dataAdm AS "Data Admissão",
    FORMAT(e.salario,2) AS "Salário",
    d.nome AS "Departamento",
    t.numero AS "Número de Telefone"
FROM 
    Empregado e
JOIN 
    Departamento d ON idDepartamento = idDepartamento
LEFT JOIN 
    Telefone t ON Empregado_cpf = Empregado_cpf
WHERE 
    e.salario < (SELECT AVG(salario) FROM Empregado)
ORDER BY 
    e.nome ASC;
-- -----------------RELATORIO 2-----------------


-- -----------------RELATORIO 3-----------------
SELECT d.nome AS "Departamento", COUNT(e.Departamento_idDepartamento) AS "Quantidade de Empregados",
    FORMAT(AVG(e.salario), 2) AS "Média Salarial",
    FORMAT(AVG(e.comissao), 2) AS "Média da Comissão"
FROM 
    Departamento d
LEFT JOIN 
    Empregado e ON d.idDepartamento = e.Departamento_idDepartamento
GROUP BY 
    d.nome
ORDER BY 
    d.nome ASC;
-- -----------------RELATORIO 3-----------------


-- -----------------RELATORIO 4-----------------
SELECT e.nome AS "Nome Empregado", e.cpf AS "CPF Empregado",
    e.sexo AS "Sexo",
    FORMAT(e.salario, 2) AS "Salário",
    COUNT(v.idVenda) AS "Quantidade Vendas",
    FORMAT(SUM(v.valor), 2) AS "Total Valor Vendido",
    FORMAT(SUM(v.comissao), 2) AS "Total Comissão das Vendas"
FROM 
    Empregado e
LEFT JOIN 
    Venda v ON e.cpf = v.Empregado_cpf
GROUP BY 
     e.nome, e.cpf, e.sexo, e.salario
ORDER BY 
    "Quantidade Vendas" DESC;
-- -----------------RELATORIO 4-----------------


-- -----------------RELATORIO 5-----------------
SELECT e.nome AS "Nome Empregado", e.cpf AS "CPF Empregado",
    e.sexo AS "Sexo",
    FORMAT(e.salario, 2) AS "Salário",
    COUNT(v.idVenda) AS "Quantidade Vendas com Serviço",
    FORMAT(SUM(v.valor), 2) AS "Total Valor Vendido com Serviço",
    FORMAT(SUM(v.comissao), 2) AS "Total Comissão das Vendas com Serviço"
FROM 
    Empregado e
LEFT JOIN 
    Venda v ON e.cpf = v.Empregado_cpf
JOIN 
    Servico s ON v.idVenda = s.valorVenda
GROUP BY 
    e.cpf, e.nome, e.cpf, e.sexo, e.salario
ORDER BY 
    "Quantidade Vendas com Serviço" DESC;
-- -----------------RELATORIO 5-----------------


-- -----------------RELATORIO 6-----------------
SELECT p.nome AS "Nome do Pet", v.data AS "Data do Serviço",
    s.nome AS "Nome do Serviço",
    i.quantidade AS "Quantidade",
    FORMAT(i.valor, 2) AS "Valor",
    e.nome AS "Empregado que realizou o Serviço"
FROM 
    itensServico i
JOIN 
    PET p ON i.PET_idPET = p.idPET
JOIN 
    Servico s ON i.Servico_idServico = s.idServico
JOIN 
    Venda v ON i.Venda_idVenda = v.idVenda
JOIN 
    Empregado e ON i.Empregado_cpf = e.cpf
ORDER BY 
    v.data DESC;
-- -----------------RELATORIO 6-----------------


-- -----------------RELATORIO 7-----------------
SELECT v.data AS "Data da Venda", FORMAT(v.valor, 2) AS "Valor",
    FORMAT(v.desconto, 2) AS "Desconto",
    FORMAT(v.valor - COALESCE(v.desconto, 0), 2) AS "Valor Final",
    e.nome AS "Empregado que realizou a Venda"
FROM 
    Venda v
JOIN 
    Empregado e ON v.Empregado_cpf = e.cpf
ORDER BY 
    v.data DESC;
-- -----------------RELATORIO 7-----------------


-- -----------------RELATORIO 8-----------------
SELECT s.nome AS "Nome do Serviço", SUM(i.quantidade) AS "Quantidade Vendas",
    FORMAT(SUM(i.valor * i.quantidade), 2) AS "Total Valor Vendido"
FROM 
    itensServico i
JOIN 
    Servico s ON i.Servico_idServico = s.idServico
GROUP BY 
    s.nome
ORDER BY 
    "Quantidade Vendas" DESC
LIMIT 10;

-- -----------------RELATORIO 8-----------------


-- -----------------RELATORIO 9-----------------
SELECT f.tipo AS "Tipo Forma Pagamento", COUNT(v.idVenda) AS "Quantidade Vendas",
    FORMAT(SUM(v.valor),2) AS "Total Valor Vendido"
FROM 
    FormaPagCompra f
JOIN 
    Compras c ON f.Compras_idCompra = c.idCompra
JOIN 
    Venda v ON c.idCompra = v.idVenda
GROUP BY 
    f.tipo
ORDER BY 
    "Quantidade Vendas" DESC;
-- -----------------RELATORIO 9-----------------


-- -----------------RELATORIO 10-----------------
SELECT DATE(v.data) AS "Data Venda", COUNT(v.idVenda) AS "Quantidade de Vendas",
    SUM(v.valor) AS "Valor Total Venda"
FROM 
    Venda v
GROUP BY 
    DATE(v.data)
ORDER BY 
    "Data Venda" DESC;
-- -----------------RELATORIO 10-----------------


-- -----------------RELATORIO 11-----------------
SELECT p.nome AS "Nome Produto", FORMAT(p.valorVenda,2) AS "Valor Produto",
    p.marca AS "Categoria do Produto",
    f.nome AS "Nome Fornecedor",
    f.email AS "Email Fornecedor",
    t.numero AS "Telefone Fornecedor"
FROM 
    Produtos p
JOIN 
    ItensCompra ic ON p.idProduto = ic.Produtos_idProduto
JOIN 
    Compras c ON ic.Compras_idCompra = c.idCompra
JOIN 
    Fornecedor f ON c.Fornecedor_cpf_cnpj = f.cpf_cnpj
LEFT JOIN 
    Telefone t ON f.cpf_cnpj = t.Fornecedor_cpf_cnpj
ORDER BY 
    p.nome;

-- -----------------RELATORIO 11-----------------


-- -----------------RELATORIO 12-----------------
SELECT p.nome AS "Nome Produto", COUNT(iv.Produto_idProduto) AS "Quantidade (Total) Vendas",
    SUM(iv.valor) AS "Valor Total Recebido pela Venda do Produto"
FROM 
    Produtos p
JOIN 
    ItensVendaProd iv ON p.idProduto = iv.Produto_idProduto
GROUP BY 
    p.nome
ORDER BY 
    "Quantidade (Total) Vendas" DESC;

-- -----------------RELATORIO 12-----------------






