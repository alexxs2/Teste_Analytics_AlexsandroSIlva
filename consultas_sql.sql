--- Vizualizando se a importação deu certo
SELECT  * FROM data_clean;

--- Todas as colunas do dataset foram importadasd como Varchar 50 (para facilitar a importação e evitar problemas)
--- o formato Date do SQL segue o formato americano de YYYY-MM-DD e a nossa coluna da data está no formato brasileiro de DD-MM-YYYY, para fazer as consultas precisamos que a coluna da data esteja no formato DATE
--- Vamos começar alterando a tabela data_clean adicionando a coluna Data_temp já em formato DATE como um metodo de segurança caso de problemas para converter
ALTER TABLE data_clean ADD Data_Temp DATE;
--- Atualizando a tabela data_clean com a conversão dos valores Varchar da coluna Data para a coluna Data_temp
UPDATE data_clean SET Data_Temp = CONVERT(DATE, Data, 103);

--- Agora vamos altera novamente a tabela data_clean adicionando a coluna Quantidade_Temp já no formato INT
ALTER TABLE data_clean ADD Quantidade_Temp INT;

--- Agora vamos altera novamente a tabela data_clean adicionando a coluna Preço_Temp já no formato FLOAT
ALTER TABLE data_clean ADD Preço_Temp FLOAT;

--- Atualizando a tabela data_clean com a conversão dos valores Varchar da coluna Quantidade para a coluna Quantidade_Temp e a conversão dos valores Varchar da coluna Preço para a coluna Preço_Temp
UPDATE data_clean
SET Quantidade_Temp = CAST(Quantidade AS INT),
    Preço_Temp = CAST(Preço AS FLOAT);

--- Vizualizando se tudo ocorreu sem erros 
SELECT  * FROM data_clean;

--- Listando os nome dos produtos, suas devidas categoria e a soma total de vendas (Quantidade * Preço) para cada produto. Ordenando o resultado pelo valor total de vendas em ordem decrescente.
SELECT 
    Produto,
    Categoria,
    SUM(Quantidade_Temp * Preço_Temp) AS Total_Vendas
FROM 
    data_clean
GROUP BY 
    Produto, Categoria
ORDER BY 
    Total_Vendas DESC;

 --- Identificando os produtos que venderam menos no mês de junho de 2023, em ordem crescente
SELECT 
    Produto,
    Categoria,
    SUM(Quantidade_Temp) AS Total_Quantidade,
    SUM(Quantidade_Temp * Preço_Temp) AS Total_Vendas
FROM 
    data_clean
WHERE 
    MONTH(Data_Temp) = 6
GROUP BY 
    Produto, Categoria
ORDER BY 
    Total_Quantidade ASC