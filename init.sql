CREATE SCHEMA IF NOT EXISTS `db_9solutions` DEFAULT CHARACTER SET utf8 ;
USE `db_9solutions`;

CREATE TABLE IF NOT EXISTS `db_9solutions`.`faixa_etaria` (
  `id_faixa_etaria` INT NOT NULL AUTO_INCREMENT,
  `faixa_nome` VARCHAR(45) NULL,
  `limite_inferior` INT NULL,
  `limite_superior` INT NULL,
  `condicao` TINYINT NOT NULL,
  PRIMARY KEY (`id_faixa_etaria`));


CREATE TABLE IF NOT EXISTS `db_9solutions`.`status_pedido` (
  `id_status_pedido` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`id_status_pedido`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_9solutions`.`doador` (
  `id_doador` INT NOT NULL AUTO_INCREMENT,
  `nome_completo` VARCHAR(255) NOT NULL,
  `identificador` CHAR(14) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `dt_cadastro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `permissao` VARCHAR(20) NOT NULL,
  `telefone` VARCHAR(20) NULL,
  `senha` VARCHAR(255) NULL,
  PRIMARY KEY (`id_doador`));


CREATE TABLE IF NOT EXISTS `db_9solutions`.`pedido` (
  `idpedido` INT NOT NULL auto_increment,
  `data_pedido` DATE NULL,
  `valor_total` DOUBLE NULL,
  `fk_status_pedido` INT NOT NULL,
  `fk_doador` INT NOT NULL,
  PRIMARY KEY (`idpedido`, `fk_status_pedido`, `fk_doador`),
  INDEX `fk_pedido_status_pedido1_idx` (`fk_status_pedido` ASC) VISIBLE,
  INDEX `fk_pedido_doador1_idx` (`fk_doador` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_status_pedido1`
    FOREIGN KEY (`fk_status_pedido`)
    REFERENCES `db_9solutions`.`status_pedido` (`id_status_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_doador1`
    FOREIGN KEY (`fk_doador`)
    REFERENCES `db_9solutions`.`doador` (`id_doador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_9solutions`.`caixa` (
  `id_caixa` INT NOT NULL AUTO_INCREMENT,
  `genero` CHAR(1) NOT NULL,
  `carta` TEXT NULL DEFAULT NULL,
  `url` VARCHAR(255) NULL DEFAULT NULL,
  `dt_criacao` DATE NULL,
  `dt_entrega` DATE NULL,
  `qtd` INT NULL,
  `fk_faixa_etaria` INT NOT NULL,
  `fk_pedido` INT NOT NULL,
  PRIMARY KEY (`id_caixa`),
  INDEX `fk_caixa_faixa_etaria1_idx` (`fk_faixa_etaria` ASC) VISIBLE,
  INDEX `fk_caixa_pedido1_idx` (`fk_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_caixa_faixa_etaria1`
    FOREIGN KEY (`fk_faixa_etaria`)
    REFERENCES `db_9solutions`.`faixa_etaria` (`id_faixa_etaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caixa_pedido1`
    FOREIGN KEY (`fk_pedido`)
    REFERENCES `db_9solutions`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    

CREATE TABLE IF NOT EXISTS `db_9solutions`.`categoria_produto` (
  `id_categoria_produto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(40) NOT NULL,
  `condicao` TINYINT NOT NULL,
  `qtde_produtos` INT NOT NULL,
  `estagio` tinyint NOT NULL ,
  PRIMARY KEY (`id_categoria_produto`));
  
  
  CREATE TABLE IF NOT EXISTS `db_9solutions`.`produto` (
  `id_produto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(40) NULL DEFAULT NULL,
  `valor` DECIMAL(5,2) NULL DEFAULT NULL,
  `genero` CHAR NULL,
  `condicao` TINYINT NOT NULL,
  `url_imagem` VARCHAR(256) NOT NULL, 
  `fk_categoria_produto` INT NOT NULL,
  `fk_faixa_etaria` INT NOT NULL,
  PRIMARY KEY (`id_produto`, `fk_categoria_produto`, `fk_faixa_etaria`),
  INDEX `fk_produto_categoria_produto1_idx` (`fk_categoria_produto` ASC) VISIBLE,
  INDEX `fk_produto_faixa_etaria1_idx` (`fk_faixa_etaria` ASC) VISIBLE,
  CONSTRAINT `fk_produto_categoria_produto1`
    FOREIGN KEY (`fk_categoria_produto`)
    REFERENCES `db_9solutions`.`categoria_produto` (`id_categoria_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_faixa_etaria1`
    FOREIGN KEY (`fk_faixa_etaria`)
    REFERENCES `db_9solutions`.`faixa_etaria` (`id_faixa_etaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
CREATE TABLE IF NOT EXISTS `db_9solutions`.`item_caixa` (
  `id_produto_caixa` INT NOT NULL AUTO_INCREMENT,
  `fk_caixa` INT NULL DEFAULT NULL,
  `fk_produto` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_produto_caixa`),
  INDEX `fk_tbItemCaixa_tbCaixa` (`fk_caixa` ASC) VISIBLE,
  INDEX `fk_tbItemCaixa_tbItem` (`fk_produto` ASC) VISIBLE,
  CONSTRAINT `fk_tbItemCaixa_tbCaixa`
    FOREIGN KEY (`fk_caixa`)
    REFERENCES `db_9solutions`.`caixa` (`id_caixa`),
  CONSTRAINT `fk_tbItemCaixa_tbItem`
    FOREIGN KEY (`fk_produto`)
    REFERENCES `db_9solutions`.`produto` (`id_produto`));
  
  
CREATE TABLE IF NOT EXISTS `db_9solutions`.`metodo_pagamento` (
  `id_metodo_pagamento` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`id_metodo_pagamento`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_9solutions`.`metodo_pagamento_pedido` (
  `fk_metodo_pagamento` INT NOT NULL,
  `fk_pedido` INT NOT NULL,
  `provedor` VARCHAR(45) NULL,
  `numero_conta` VARCHAR(45) NULL,
  `data_expiracao` DATE NULL,
  PRIMARY KEY (`fk_metodo_pagamento`, `fk_pedido`),
  INDEX `fk_doador_has_tipo_pagamento_tipo_pagamento1_idx` (`fk_metodo_pagamento` ASC) VISIBLE,
  INDEX `fk_metodo_pagamento_doador_pedido1_idx` (`fk_pedido` ASC) VISIBLE,
  CONSTRAINT `fk_doador_has_tipo_pagamento_tipo_pagamento1`
    FOREIGN KEY (`fk_metodo_pagamento`)
    REFERENCES `db_9solutions`.`metodo_pagamento` (`id_metodo_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metodo_pagamento_doador_pedido1`
    FOREIGN KEY (`fk_pedido`)
    REFERENCES `db_9solutions`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    
CREATE TABLE IF NOT EXISTS `db_9solutions`.`cupom` (
  `id_cupom` INT NOT NULL,
  `codigo` VARCHAR(45) NULL,
  `desconto_percentual` DECIMAL(5,2) NULL,
  `desconto_fixo` DECIMAL(10,2) NULL,
  `validade_inicio` DATE NULL,
  `validade_fim` DATE NULL,
  `limite_usos` INT NULL,
  `usos_atuais` INT NULL,
  `ativo` TINYINT NULL,
  PRIMARY KEY (`id_cupom`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_9solutions`.`cupom_pedido` (
  `id_cupom_pedido` INT NOT NULL,
  `cupom_id_cupom` INT NOT NULL,
  `pedido_idpedido` INT NOT NULL,
  PRIMARY KEY (`id_cupom_pedido`, `cupom_id_cupom`, `pedido_idpedido`),
  INDEX `fk_cupom_pedido_cupom1_idx` (`cupom_id_cupom` ASC) VISIBLE,
  INDEX `fk_cupom_pedido_pedido1_idx` (`pedido_idpedido` ASC) VISIBLE,
  CONSTRAINT `fk_cupom_pedido_cupom1`
    FOREIGN KEY (`cupom_id_cupom`)
    REFERENCES `db_9solutions`.`cupom` (`id_cupom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cupom_pedido_pedido1`
    FOREIGN KEY (`pedido_idpedido`)
    REFERENCES `db_9solutions`.`pedido` (`idpedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_9solutions`.`status_caixa` (
  `id_status_caixa` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`id_status_caixa`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `db_9solutions`.`etapa_caixa` (
  `id_etapa_caixa` int not null auto_increment,
  `fk_status` INT NOT NULL,
  `fk_id_caixa` INT NOT NULL,
  `update_at` DATE NULL,
  PRIMARY KEY (`id_etapa_caixa`),
  INDEX `fk_status_caixa_has_caixa_caixa1_idx` (`fk_id_caixa` ASC) VISIBLE,
  INDEX `fk_status_caixa_has_caixa_status_caixa1_idx` (`fk_status` ASC) VISIBLE,
  CONSTRAINT `fk_status_caixa_has_caixa_status_caixa1`
    FOREIGN KEY (`fk_status`)
    REFERENCES `db_9solutions`.`status_caixa` (`id_status_caixa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_status_caixa_has_caixa_caixa1`
    FOREIGN KEY (`fk_id_caixa`)
    REFERENCES `db_9solutions`.`caixa` (`id_caixa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- CRIAÇÃO DAS VIEWS
-- -----------------------------------------------------
USE `db_9solutions` ;
CREATE VIEW vw_caixas_em_montagem AS
SELECT 
    COUNT(c.id_caixa) AS quantidade_caixas_em_montagem
FROM 
    caixa c
    INNER JOIN pedido p ON c.fk_pedido = p.idpedido
    INNER JOIN status_pedido sp ON p.fk_status_pedido = sp.id_status_pedido
WHERE 
    sp.status = 'Em montagem';
    

CREATE VIEW vw_caixas_para_entregar AS
SELECT 
    COUNT(c.id_caixa) AS quantidade_caixas_para_entregar
FROM 
    caixa c
    INNER JOIN pedido p ON c.fk_pedido = p.idpedido
    INNER JOIN status_pedido sp ON p.fk_status_pedido = sp.id_status_pedido
WHERE 
    sp.status = 'Pronto para Entrega';
    
    
CREATE VIEW vw_caixas_atrasadas AS
SELECT 
    COUNT(c.id_caixa) AS quantidade_caixas_atrasadas
FROM 
    caixa c
    INNER JOIN pedido p ON c.fk_pedido = p.idpedido
    INNER JOIN status_pedido sp ON p.fk_status_pedido = sp.id_status_pedido
WHERE 
    p.data_pedido < NOW() - INTERVAL 2 WEEK
    AND sp.status != 'Entregue';


CREATE VIEW vw_qtd_pedidos_por_faixa_etaria AS
SELECT 
    YEAR(p.data_pedido) AS ano,
    MONTH(p.data_pedido) AS mes,
    fe.faixa_nome,
    COUNT(DISTINCT p.idpedido) AS quantidade_pedidos
FROM 
    pedido p
    INNER JOIN caixa c ON p.idpedido = c.fk_pedido
    INNER JOIN faixa_etaria fe ON c.fk_faixa_etaria = fe.id_faixa_etaria
GROUP BY 
    YEAR(p.data_pedido),
    MONTH(p.data_pedido),
    fe.faixa_nome
ORDER BY 
    ano, mes, fe.faixa_nome;
    
    
CREATE VIEW vw_pedidos_por_mes AS
SELECT 
    p.idpedido,
    p.data_pedido,
    p.valor_total,
    p.fk_status_pedido,
    p.fk_doador,
    DAY(p.data_pedido) AS dia,
    MONTH(p.data_pedido) AS mes,
    YEAR(p.data_pedido) AS ano
FROM 
    pedido p
ORDER BY 
    ano, mes, dia;
    
    
CREATE VIEW vw_qtd_produtos_por_categoria AS
SELECT 
    YEAR(p.data_pedido) AS ano,
    pr.nome AS produto,
    cp.nome AS categoria,
    COUNT(ic.id_produto_caixa) AS quantidade_produtos_doacao
FROM 
    pedido p
    INNER JOIN caixa c ON p.idpedido = c.fk_pedido
    INNER JOIN item_caixa ic ON c.id_caixa = ic.fk_caixa
    INNER JOIN produto pr ON ic.fk_produto = pr.id_produto
    INNER JOIN categoria_produto cp ON pr.fk_categoria_produto = cp.id_categoria_produto
WHERE 
    cp.nome = 'DOCES'
GROUP BY 
    YEAR(p.data_pedido),
    pr.nome,
    cp.nome
ORDER BY 
    ano, produto;
    

DROP TABLE IF EXISTS `db_9solutions`.`vw_filtros_pedidos`;
CREATE OR REPLACE VIEW `vw_filtros_pedidos` AS
SELECT * FROM pedido 
INNER JOIN status_pedido ON pedido.fk_status_pedido = status_pedido.id_status_pedido
INNER JOIn doador ON pedido.fk_doador = doador.id_doador;

-- -----------------------------------------------------
-- INSERINDO DADOS
-- -----------------------------------------------------
INSERT INTO `db_9solutions`.`faixa_etaria` (`faixa_nome`, `limite_inferior`, `limite_superior`, `condicao`)
VALUES
('Criança', 2, 5, 1),
('Pré-Adolescente', 6, 10, 1),
('Adolescente', 11, 15, 1);