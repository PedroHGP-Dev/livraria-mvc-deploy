-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           12.2.2-MariaDB - MariaDB Server
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.16.0.7229
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para mer_livraria_pedroh_joaquim


USE `defaultdb`;

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.cliente
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `codCliente` int(11) NOT NULL AUTO_INCREMENT,
  `nomeCliente` varchar(150) NOT NULL,
  `cpfCliente` varchar(15) NOT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  `bairro` varchar(150) DEFAULT NULL,
  `cep` varchar(9) DEFAULT NULL,
  `cidade` varchar(150) DEFAULT NULL,
  `telefone` varchar(150) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `livraria_idLivraria` int(11) NOT NULL,
  PRIMARY KEY (`codCliente`) USING BTREE,
  KEY `fk_cliente_livraria` (`livraria_idLivraria`),
  CONSTRAINT `fk_cliente_livraria` FOREIGN KEY (`livraria_idLivraria`) REFERENCES `livraria` (`idLivraria`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.cliente: ~3 rows (aproximadamente)
INSERT INTO `cliente` (`codCliente`, `nomeCliente`, `cpfCliente`, `endereco`, `bairro`, `cep`, `cidade`, `telefone`, `email`, `livraria_idLivraria`) VALUES
	(2, 'Paulo', '169.909.734-32', 'Rua Papaia', 'Jardim das Rosas', '37750-000', 'Machado', '998554876', NULL, 1),
	(3, 'João Flávio', '282929292', 'Rua das Tulipas', 'Jardim Nova Alfenas', '21029102', 'Alfenas', '988453380', 'aaaaa@gmail.com', 2),
	(4, 'Breno', '2032203920', 'Rua Colombo', 'Centro', NULL, 'Machado', '998076533', NULL, 1);

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.editora
DROP TABLE IF EXISTS `editora`;
CREATE TABLE IF NOT EXISTS `editora` (
  `codEditora` int(11) NOT NULL AUTO_INCREMENT,
  `nomeEditora` varchar(300) NOT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `cnpj` varchar(100) DEFAULT NULL,
  `telefone` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`codEditora`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.editora: ~2 rows (aproximadamente)
INSERT INTO `editora` (`codEditora`, `nomeEditora`, `endereco`, `cnpj`, `telefone`, `email`) VALUES
	(1, 'ITATIAIA', 'aaaaa', '11111', '22222', 'aaa333@gmail.com'),
	(3, 'TUDOEHLIVRO', 'bbbbb', '22222', '444444', 'bbbb55555@gmail.com');

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.forma_pagamento
DROP TABLE IF EXISTS `forma_pagamento`;
CREATE TABLE IF NOT EXISTS `forma_pagamento` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRICAO` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.forma_pagamento: ~3 rows (aproximadamente)
INSERT INTO `forma_pagamento` (`ID`, `DESCRICAO`) VALUES
	(1, 'Cartão de Crédito'),
	(2, 'Pix'),
	(3, 'Boleto Bancário');

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.formapagamento
DROP TABLE IF EXISTS `formapagamento`;
CREATE TABLE IF NOT EXISTS `formapagamento` (
  `codFormaPagamento` int(11) NOT NULL AUTO_INCREMENT,
  `nomeFormaPagamento` varchar(150) NOT NULL,
  PRIMARY KEY (`codFormaPagamento`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.formapagamento: ~5 rows (aproximadamente)
INSERT INTO `formapagamento` (`codFormaPagamento`, `nomeFormaPagamento`) VALUES
	(1, 'Dinheiro'),
	(2, 'Pix'),
	(3, 'Débito'),
	(4, 'Crédito'),
	(8, 'Boleto');

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.formapagamentoporvenda
DROP TABLE IF EXISTS `formapagamentoporvenda`;
CREATE TABLE IF NOT EXISTS `formapagamentoporvenda` (
  `codFormaPagamentoPorVenda` int(11) NOT NULL AUTO_INCREMENT,
  `formaPagamento_codFormaPagamento` int(11) NOT NULL,
  `venda_codVenda` int(11) NOT NULL,
  `valor` double DEFAULT NULL,
  PRIMARY KEY (`codFormaPagamentoPorVenda`,`formaPagamento_codFormaPagamento`,`venda_codVenda`),
  KEY `fk_formaPagamento_has_venda_venda1_idx` (`venda_codVenda`),
  KEY `fk_formaPagamento_has_venda_formaPagamento1_idx` (`formaPagamento_codFormaPagamento`),
  CONSTRAINT `fk_formaPagamento_has_venda_formaPagamento1` FOREIGN KEY (`formaPagamento_codFormaPagamento`) REFERENCES `formapagamento` (`codFormaPagamento`),
  CONSTRAINT `fk_formaPagamento_has_venda_venda1` FOREIGN KEY (`venda_codVenda`) REFERENCES `venda` (`codVenda`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.formapagamentoporvenda: ~3 rows (aproximadamente)
INSERT INTO `formapagamentoporvenda` (`codFormaPagamentoPorVenda`, `formaPagamento_codFormaPagamento`, `venda_codVenda`, `valor`) VALUES
	(1, 3, 6, NULL),
	(2, 1, 6, NULL),
	(3, 2, 8, NULL);

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.funcionario
DROP TABLE IF EXISTS `funcionario`;
CREATE TABLE IF NOT EXISTS `funcionario` (
  `codFuncionario` int(11) NOT NULL AUTO_INCREMENT,
  `nomeFuncionario` varchar(150) NOT NULL,
  `cpfFuncionario` varchar(15) NOT NULL,
  `salario` double NOT NULL,
  `comissaoPorLivro` double DEFAULT NULL,
  `endereco` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  `carteiraTrabalho` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pis` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `livraria_idLivraria` int(11) DEFAULT NULL,
  PRIMARY KEY (`codFuncionario`),
  KEY `fk_funcionario_livraria` (`livraria_idLivraria`),
  CONSTRAINT `fk_funcionario_livraria` FOREIGN KEY (`livraria_idLivraria`) REFERENCES `livraria` (`idLivraria`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.funcionario: ~3 rows (aproximadamente)
INSERT INTO `funcionario` (`codFuncionario`, `nomeFuncionario`, `cpfFuncionario`, `salario`, `comissaoPorLivro`, `endereco`, `email`, `telefone`, `carteiraTrabalho`, `pis`, `livraria_idLivraria`) VALUES
	(1, 'Rogério Ceni', '10230596869', 900, 0, '99', 'oloco@gmail.com', '454545', '1', '1', 1),
	(5, 'Rogério Ceni', '10230596869', 900, 0, '99', 'oloco@gmail.com', '454545', '1', '1', 1),
	(6, 'OCARA', '9999999999', 3000, 100, '99', 'oloco@gmail.com', '454545', '1', '9', 2);

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.generolivro
DROP TABLE IF EXISTS `generolivro`;
CREATE TABLE IF NOT EXISTS `generolivro` (
  `codGeneroLivro` int(11) NOT NULL AUTO_INCREMENT,
  `nomeGeneroLivro` varchar(150) NOT NULL,
  PRIMARY KEY (`codGeneroLivro`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.generolivro: ~7 rows (aproximadamente)
INSERT INTO `generolivro` (`codGeneroLivro`, `nomeGeneroLivro`) VALUES
	(1, 'Romance'),
	(2, 'Ação'),
	(3, 'Comédia'),
	(4, 'Drama'),
	(5, 'Ficção'),
	(6, 'Suspense'),
	(7, 'Investigação');

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.livraria
DROP TABLE IF EXISTS `livraria`;
CREATE TABLE IF NOT EXISTS `livraria` (
  `idLivraria` int(11) NOT NULL AUTO_INCREMENT,
  `nomeLivraria` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enderecoLivraria` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `estadoLivraria` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cidadeLivraria` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `emailLivraria` varchar(50) NOT NULL,
  `telefoneLivraria` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`idLivraria`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.livraria: ~2 rows (aproximadamente)
INSERT INTO `livraria` (`idLivraria`, `nomeLivraria`, `enderecoLivraria`, `estadoLivraria`, `cidadeLivraria`, `emailLivraria`, `telefoneLivraria`) VALUES
	(1, 'TM Leituras', 'Rua Túlio Marcos', 'MG', 'Alfenas', 'filial01maisleitura@gmail.com', '3295-3722'),
	(2, 'BIG Livros', 'Rua Marcianos', 'MG', 'Pouso Alegre', 'filial02maisleitura@gmail.com', '3295-8990');

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.livro
DROP TABLE IF EXISTS `livro`;
CREATE TABLE IF NOT EXISTS `livro` (
  `codLivro` int(11) NOT NULL AUTO_INCREMENT,
  `nomeLivro` varchar(150) NOT NULL,
  `autorLivro` varchar(150) NOT NULL,
  `quantidadeLivro` int(11) NOT NULL,
  `precoVenda` double NOT NULL,
  `generoLivro_codGeneroLivro` int(11) NOT NULL,
  `editora_codEditora` int(11) NOT NULL,
  `precoCompra` double NOT NULL,
  `tombo` varchar(50) NOT NULL,
  `livraria_idLivraria` int(11) NOT NULL,
  PRIMARY KEY (`codLivro`,`generoLivro_codGeneroLivro`,`editora_codEditora`),
  KEY `fk_livro_generoLivro_idx` (`generoLivro_codGeneroLivro`),
  KEY `fk_livro_editora1_idx` (`editora_codEditora`),
  KEY `fk_livro_livraria` (`livraria_idLivraria`),
  CONSTRAINT `fk_livro_editora` FOREIGN KEY (`editora_codEditora`) REFERENCES `editora` (`codEditora`),
  CONSTRAINT `fk_livro_generoLivro` FOREIGN KEY (`generoLivro_codGeneroLivro`) REFERENCES `generolivro` (`codGeneroLivro`),
  CONSTRAINT `fk_livro_livraria` FOREIGN KEY (`livraria_idLivraria`) REFERENCES `livraria` (`idLivraria`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.livro: ~3 rows (aproximadamente)
INSERT INTO `livro` (`codLivro`, `nomeLivro`, `autorLivro`, `quantidadeLivro`, `precoVenda`, `generoLivro_codGeneroLivro`, `editora_codEditora`, `precoCompra`, `tombo`, `livraria_idLivraria`) VALUES
	(1, 'SENHORA', 'José de Alencar', 19, 34, 1, 1, 20, '1', 1),
	(5, 'DIVINA COMÉDIA', 'Dante Alighier', 15, 20, 3, 1, 20, '1', 1),
	(6, 'O GUARANI', 'José de Alencar', 8, 65, 1, 1, 20, '1', 1);

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.livroporvenda
DROP TABLE IF EXISTS `livroporvenda`;
CREATE TABLE IF NOT EXISTS `livroporvenda` (
  `codLivroPorVenda` int(11) NOT NULL AUTO_INCREMENT,
  `livro_codLivro` int(11) NOT NULL,
  `venda_codVenda` int(11) NOT NULL,
  `quantLivroPorVenda` int(11) NOT NULL,
  `valorVendaUnidade` double NOT NULL,
  PRIMARY KEY (`codLivroPorVenda`,`livro_codLivro`,`venda_codVenda`),
  KEY `fk_livro_has_venda_venda1_idx` (`venda_codVenda`),
  KEY `fk_livro_has_venda_livro1_idx` (`livro_codLivro`),
  CONSTRAINT `fk_livro_has_venda_livro` FOREIGN KEY (`livro_codLivro`) REFERENCES `livro` (`codLivro`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_livro_has_venda_venda` FOREIGN KEY (`venda_codVenda`) REFERENCES `venda` (`codVenda`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.livroporvenda: ~1 rows (aproximadamente)
INSERT INTO `livroporvenda` (`codLivroPorVenda`, `livro_codLivro`, `venda_codVenda`, `quantLivroPorVenda`, `valorVendaUnidade`) VALUES
	(1, 1, 6, 1, 1);

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_alteraCliente
DROP PROCEDURE IF EXISTS `procd_alteraCliente`;
DELIMITER //
CREATE PROCEDURE `procd_alteraCliente`(
	IN `codAltera` INT,
	IN `enderecoAltera` VARCHAR(150),
	IN `bairroAltera` VARCHAR(150),
	IN `cepAltera` VARCHAR(50),
	IN `cidadeAltera` VARCHAR(150),
	IN `telefoneAltera` VARCHAR(300)
)
BEGIN
SELECT COUNT(*) INTO @existe FROM cliente WHERE codCliente = codAltera;

if (@existe)
then
UPDATE cliente SET endereco = enderecoAltera, bairro = bairroAltera, cep = cepAltera, cidade = cidadeAltera, telefone = telefoneAltera WHERE codCliente = codAltera;
else
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cliente não disponível";
END if;
SELECT * FROM cliente;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_alteraEditora
DROP PROCEDURE IF EXISTS `procd_alteraEditora`;
DELIMITER //
CREATE PROCEDURE `procd_alteraEditora`(
	IN `codAltera` INT,
	IN `nomeAltera` VARCHAR(300)
)
BEGIN
SELECT COUNT(*) INTO @existe FROM editora WHERE codEditora = codAltera;

if (@existe)
then
UPDATE editora SET nomeEditora = nomeAltera WHERE codEditora = codAltera;
else
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Editora não disponível";
END if;
SELECT * FROM editora;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_alteraFormaPagamento
DROP PROCEDURE IF EXISTS `procd_alteraFormaPagamento`;
DELIMITER //
CREATE PROCEDURE `procd_alteraFormaPagamento`(
	IN `codAltera` INT,
	IN `nomeAltera` VARCHAR(150)
)
BEGIN
SELECT COUNT(*) INTO @existe FROM formapagamento WHERE codFormaPagamento = codAltera;

if (@existe)
then
UPDATE formapagamento SET nomeFormaPagamento = nomeAltera WHERE codFormaPagamento = codAltera;
else
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Forma de pagamento não disponível";
END if;
SELECT * FROM formapagamento;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_alteraFuncionario
DROP PROCEDURE IF EXISTS `procd_alteraFuncionario`;
DELIMITER //
CREATE PROCEDURE `procd_alteraFuncionario`(
	IN `codFuncionariof` INT,
	IN `comissaoPorLivrof` DOUBLE
)
BEGIN
SELECT COUNT(*) INTO @contador FROM funcionario WHERE codFuncionario = codFuncionariof;
if (@contador = 1)
then UPDATE funcionario SET comissaoPorLivro = comissaoPorLivrof
WHERE codFuncionario = codFuncionariof;
ELSE sIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Funcionario não encontrado";
END if;
SELECT * FROM funcionario;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_alteraGenero
DROP PROCEDURE IF EXISTS `procd_alteraGenero`;
DELIMITER //
CREATE PROCEDURE `procd_alteraGenero`(
IN `codGeneroLivrog` INT,
IN `nomeGeneroLivrog` VARCHAR(150)
)
BEGIN
SELECT COUNT(*) INTO @contador FROM generolivro WHERE codGeneroLivro = codGeneroLivrog;
if (@contador = 1)
then UPDATE generolivro SET nomeGeneroLivro = nomeGeneroLivrog
WHERE codGeneroLivro = codGeneroLivrog;

ELSE sIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Genero não encontrado";
END if;
SELECT * FROM generolivro;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_alteraLivro
DROP PROCEDURE IF EXISTS `procd_alteraLivro`;
DELIMITER //
CREATE PROCEDURE `procd_alteraLivro`(
	IN `codAlterar` INT,
	IN `precoAltera` DOUBLE
)
BEGIN
SELECT COUNT(*) INTO @existe FROM livro WHERE codLivro = codAlterar;

if (@existe)
then UPDATE livro SET precoVenda = precoAltera WHERE codLivro = codAlterar;
ELSE SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "livro não disponível";
END if;

SELECT * FROM livro;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_alteraVenda
DROP PROCEDURE IF EXISTS `procd_alteraVenda`;
DELIMITER //
CREATE PROCEDURE `procd_alteraVenda`(
	IN `codAltera` INT,
	IN `dataAltera` DATETIME
)
BEGIN
SELECT COUNT(*) INTO @existe FROM venda WHERE codVenda = codAltera;

if (@existe)
then
UPDATE venda SET dataHoraVenda = dataAltera WHERE codVenda = codAltera;
else
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Venda não disponível";
END if;
SELECT * FROM venda;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_apagaCliente
DROP PROCEDURE IF EXISTS `procd_apagaCliente`;
DELIMITER //
CREATE PROCEDURE `procd_apagaCliente`(
	IN `codApagar` INT
)
BEGIN
	SELECT COUNT(*) INTO @contador FROM cliente WHERE codCliente = codApagar;
	if (@contador = 1)
		then 
			DELETE FROM cliente WHERE codCliente = codApagar;
			SELECT "Cliente apagado com sucesso!" AS mensagem;
		else
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Cliente não encontrado";
	END if;
	SELECT * FROM cliente;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_apagaEditora
DROP PROCEDURE IF EXISTS `procd_apagaEditora`;
DELIMITER //
CREATE PROCEDURE `procd_apagaEditora`(
IN `codApagar` INT
)
BEGIN
SELECT COUNT(*) INTO @contador FROM editora WHERE codEditora = codApagar;
if (@contador = 1)
then
DELETE FROM editora WHERE codEditora = codApagar;
SELECT "Editora apagada com sucesso!" AS mensagem;
else
#SELECT "Editora não encontrada." AS ERRO;
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Editora não encontrada";
END if;
SELECT * FROM editora;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_apagaFormaPagamento
DROP PROCEDURE IF EXISTS `procd_apagaFormaPagamento`;
DELIMITER //
CREATE PROCEDURE `procd_apagaFormaPagamento`(
IN `codApagar` INT
)
BEGIN
SELECT COUNT(*) INTO @contador FROM formapagamento WHERE codFormaPagamento = codApagar;
if (@contador = 1)
then
DELETE FROM formapagamento WHERE codFormaPagamento = codApagar;
SELECT "Forma de pagamento apagada com sucesso!" AS mensagem;
else
#SELECT "Forma de pagamento não encontrada." AS ERRO;
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Forma de pagamento não encontrada";
END if;
SELECT * FROM formapagamento;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_apagaFuncionario
DROP PROCEDURE IF EXISTS `procd_apagaFuncionario`;
DELIMITER //
CREATE PROCEDURE `procd_apagaFuncionario`(
	IN `codApagar` INT
)
BEGIN
	SELECT COUNT(*) INTO @contador FROM funcionario WHERE codFuncionario = codApagar;
	if (@contador = 1)
		then 
			DELETE FROM funcionario WHERE codFuncionario = codApagar;
			SELECT "Funcionario apagado com sucesso!" AS mensagem;
		else
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Funcionario não encontrado";
	END if;
	SELECT * FROM funcionario;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_apagaGeneroLivro
DROP PROCEDURE IF EXISTS `procd_apagaGeneroLivro`;
DELIMITER //
CREATE PROCEDURE `procd_apagaGeneroLivro`(
	IN `codApagar` INT
)
BEGIN
SELECT COUNT(*) INTO @contador FROM generolivro WHERE codGeneroLivro = codApagar;
if (@contador = 1)
then
DELETE FROM generolivro WHERE codGeneroLivro = codApagar;
SELECT "Genero de livro apagado com sucesso!" AS mensagem;
else
#SELECT "Genero de livro não encontrado." AS ERRO;
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Gênero de livro não encontrado";
END if;
SELECT * FROM generolivro;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_apagaLivro
DROP PROCEDURE IF EXISTS `procd_apagaLivro`;
DELIMITER //
CREATE PROCEDURE `procd_apagaLivro`(
	IN `codApagar` INT
)
BEGIN
	SELECT COUNT(*) INTO @contador FROM livro WHERE codLivro = codApagar;
	if (@contador = 1)
		then 
			DELETE FROM livro WHERE codLivro = codApagar;
			SELECT "Livro apagado com sucesso!" AS mensagem;
		else
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Livro não encontrado";
	END if;
	SELECT * FROM livro;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_apagaVenda
DROP PROCEDURE IF EXISTS `procd_apagaVenda`;
DELIMITER //
CREATE PROCEDURE `procd_apagaVenda`(
IN `codApagar` INT
)
BEGIN
SELECT COUNT(*) INTO @contador FROM venda WHERE codVenda = codApagar;
if (@contador = 1)
then
DELETE FROM venda WHERE codVenda = codApagar;
SELECT "Venda apagada com sucesso!" AS mensagem;
else
#SELECT "Venda não encontrada." AS ERRO;
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Venda não encontrada";
END if;
SELECT * FROM venda;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_insereCliente
DROP PROCEDURE IF EXISTS `procd_insereCliente`;
DELIMITER //
CREATE PROCEDURE `procd_insereCliente`(
IN `nomeInserir` VARCHAR(150),
IN `cpfInserir` VARCHAR(15)
)
BEGIN
INSERT INTO cliente(nomeCliente, cpfCliente) VALUES (nomeInserir, cpfInserir);
SELECT * FROM cliente;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_insereEditora
DROP PROCEDURE IF EXISTS `procd_insereEditora`;
DELIMITER //
CREATE PROCEDURE `procd_insereEditora`(
	IN `nomeInserir` VARCHAR(300)
)
BEGIN
	INSERT INTO editora(nomeEditora) VALUES (nomeInserir);
	SELECT * FROM editora;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_insereFormaPagamento
DROP PROCEDURE IF EXISTS `procd_insereFormaPagamento`;
DELIMITER //
CREATE PROCEDURE `procd_insereFormaPagamento`(
IN `nomeInserir` VARCHAR(150)
)
BEGIN
INSERT INTO formaPagamento(nomeFormaPagamento) VALUES (nomeInserir);
SELECT * FROM formaPagamento;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_insereFuncionario
DROP PROCEDURE IF EXISTS `procd_insereFuncionario`;
DELIMITER //
CREATE PROCEDURE `procd_insereFuncionario`(
	IN `nomeInserir` VARCHAR(150),
	IN `cpfInserir` VARCHAR(15),
	IN `salarioInserir` DOUBLE
)
BEGIN
INSERT INTO funcionario(nomeFuncionario, cpfFuncionario, salario) VALUES (nomeInserir, cpfInserir, salarioInserir);
SELECT * FROM funcionario;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_insereGenero
DROP PROCEDURE IF EXISTS `procd_insereGenero`;
DELIMITER //
CREATE PROCEDURE `procd_insereGenero`(
IN `nomeInserir` CHAR(150)
)
BEGIN
INSERT INTO generoLivro(nomeGeneroLivro) VALUES (nomeInserir);
SELECT * FROM generoLivro;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_insereLivro
DROP PROCEDURE IF EXISTS `procd_insereLivro`;
DELIMITER //
CREATE PROCEDURE `procd_insereLivro`(
	IN `nomeInserir` VARCHAR(150),
	IN `autorInserir` VARCHAR(150),
	IN `quantidadeInserir` INT,
	IN `precoVendaInserir` DOUBLE,
	IN `codGenero` INT,
	IN `codEditora` INT
)
BEGIN
INSERT INTO livro(nomeLivro, autorLivro, quantidadeLivro, precoVenda, generoLivro_codGeneroLivro, editora_codEditora) VALUES (nomeInserir, autorInserir, quantidadeInserir, precoVendaInserir, codGenero, codEditora);
SELECT * FROM livro;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_insereVenda
DROP PROCEDURE IF EXISTS `procd_insereVenda`;
DELIMITER //
CREATE PROCEDURE `procd_insereVenda`(
	IN `dataHoraVendaInserir` DATETIME,
	IN `codClienteInserir` INT,
	IN `codFuncionarioInserir` INT
)
BEGIN
INSERT INTO venda(dataHoraVenda, cliente_codCliente, funcionario_codFuncionario) VALUES(dataHoraVendaInserir, codClienteInserir, codFuncionarioInserir);
SELECT * FROM venda;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_relatorioCliente
DROP PROCEDURE IF EXISTS `procd_relatorioCliente`;
DELIMITER //
CREATE PROCEDURE `procd_relatorioCliente`(
	IN `tipoRelatorio` INT
)
BEGIN
	if (tipoRelatorio = 1)
		then SELECT nomeCliente, cpfCliente FROM cliente ORDER BY nomeCliente;
		ELSE IF (tipoRelatorio = 2)
			then SELECT nomeCliente, cidade, cep FROM cliente;
			ELSE IF (tipoRelatorio = 3)
				then SELECT * FROM cliente WHERE cidade LIKE "Machado";
				ELSE SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Opção Indisponível";
			END if;
		END if;
	END if;
END//
DELIMITER ;

-- Copiando estrutura para procedure mer_livraria_pedroh_joaquim.procd_relatorioFuncionario
DROP PROCEDURE IF EXISTS `procd_relatorioFuncionario`;
DELIMITER //
CREATE PROCEDURE `procd_relatorioFuncionario`(
	IN `numeroRelatorio` INT
)
BEGIN
if (numeroRelatorio = 1)
then SELECT f.nomeFuncionario FROM funcionario AS f ;
ELSE if (numeroRelatorio = 2)
then SELECT f.nomeFuncionario, f.cpfFuncionario, f.salario FROM funcionario AS f;
ELSE if (numeroRelatorio = 3)
then SELECT f.nomeFuncionario, f.salario, f.comissaoPorLivro FROM funcionario AS f;
ELSE SIGNAL SQLSTATE '45000'SET MESSAGE_TEXT = "Relatório inexistente";
END if;
END if;
END if;
END//
DELIMITER ;

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.usuario
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomeusuario` varchar(255) NOT NULL,
  `senhahash` varchar(60) NOT NULL,
  `email` varchar(255) NOT NULL,
  `token_recuperacao` varchar(255) DEFAULT NULL,
  `token_expiracao` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nomeusuario` (`nomeusuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.usuario: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela mer_livraria_pedroh_joaquim.venda
DROP TABLE IF EXISTS `venda`;
CREATE TABLE IF NOT EXISTS `venda` (
  `codVenda` int(11) NOT NULL AUTO_INCREMENT,
  `dataHoraVenda` datetime NOT NULL DEFAULT current_timestamp(),
  `cliente_codCliente` int(11) NOT NULL,
  `funcionario_codFuncionario` int(11) NOT NULL,
  `livraria_idLivraria` int(11) DEFAULT NULL,
  PRIMARY KEY (`codVenda`,`cliente_codCliente`,`funcionario_codFuncionario`),
  KEY `fk_venda_cliente1_idx` (`cliente_codCliente`),
  KEY `fk_venda_funcionario1_idx` (`funcionario_codFuncionario`),
  KEY `fk_venda_livraria` (`livraria_idLivraria`),
  CONSTRAINT `fk_venda_cliente` FOREIGN KEY (`cliente_codCliente`) REFERENCES `cliente` (`codCliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_venda_funcionario` FOREIGN KEY (`funcionario_codFuncionario`) REFERENCES `funcionario` (`codFuncionario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_venda_livraria` FOREIGN KEY (`livraria_idLivraria`) REFERENCES `livraria` (`idLivraria`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela mer_livraria_pedroh_joaquim.venda: ~2 rows (aproximadamente)
INSERT INTO `venda` (`codVenda`, `dataHoraVenda`, `cliente_codCliente`, `funcionario_codFuncionario`, `livraria_idLivraria`) VALUES
	(6, '2025-08-02 02:02:02', 2, 1, 1),
	(8, '2025-09-07 02:02:02', 3, 1, 1);

-- Copiando estrutura para view mer_livraria_pedroh_joaquim.vi_detalhes_simplesvenda
DROP VIEW IF EXISTS `vi_detalhes_simplesvenda`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vi_detalhes_simplesvenda` (
	`codVenda` INT(11) NOT NULL,
	`nomeCliente` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`nomeFuncionario` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`nomeLivro` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`quantLivroPorVenda` INT(11) NOT NULL
);

-- Copiando estrutura para view mer_livraria_pedroh_joaquim.vi_mediaprecoporeditora
DROP VIEW IF EXISTS `vi_mediaprecoporeditora`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vi_mediaprecoporeditora` (
	`nomeEditora` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`mediaPrecoPorEditora` DOUBLE NULL
);

-- Copiando estrutura para view mer_livraria_pedroh_joaquim.vi_quantclientesporcidade
DROP VIEW IF EXISTS `vi_quantclientesporcidade`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vi_quantclientesporcidade` (
	`cidade` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`quantClientesPorCidade` BIGINT(21) NOT NULL
);

-- Copiando estrutura para view mer_livraria_pedroh_joaquim.vi_total_pagar
DROP VIEW IF EXISTS `vi_total_pagar`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vi_total_pagar` (
	`codVenda` INT(11) NOT NULL,
	`nomeCliente` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`nomeLivro` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`quantLivroPorVenda` INT(11) NOT NULL,
	`preco` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`total_a_pagar` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci'
);

-- Copiando estrutura para view mer_livraria_pedroh_joaquim.vi_tudosobrelivro
DROP VIEW IF EXISTS `vi_tudosobrelivro`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vi_tudosobrelivro` (
	`codLivro` INT(11) NOT NULL,
	`nomeLivro` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`nomeGeneroLivro` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`nomeEditora` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`precoVenda` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci'
);

-- Copiando estrutura para view mer_livraria_pedroh_joaquim.vi_vendas_setembro
DROP VIEW IF EXISTS `vi_vendas_setembro`;
-- Criando tabela temporária para evitar erros de dependência de VIEW
CREATE TABLE `vi_vendas_setembro` (
	`codVenda` INT(11) NOT NULL,
	`dataHora` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`nomeFuncionario` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_unicode_ci'
);

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vi_detalhes_simplesvenda`;
CREATE VIEW `vi_detalhes_simplesvenda` AS select `v`.`codVenda` AS `codVenda`,`c`.`nomeCliente` AS `nomeCliente`,`f`.`nomeFuncionario` AS `nomeFuncionario`,`l`.`nomeLivro` AS `nomeLivro`,`lpv`.`quantLivroPorVenda` AS `quantLivroPorVenda` from ((((`venda` `v` join `livroporvenda` `lpv` on((`lpv`.`venda_codVenda` = `v`.`codVenda`))) join `cliente` `c` on((`v`.`cliente_codCliente` = `c`.`codCliente`))) join `funcionario` `f` on((`v`.`funcionario_codFuncionario` = `f`.`codFuncionario`))) join `livro` `l` on((`lpv`.`livro_codLivro` = `l`.`codLivro`))) 
;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vi_mediaprecoporeditora`;
CREATE VIEW `vi_mediaprecoporeditora` AS select `e`.`nomeEditora` AS `nomeEditora`,avg(`l`.`precoVenda`) AS `mediaPrecoPorEditora` from (`livro` `l` join `editora` `e` on((`l`.`editora_codEditora` = `e`.`codEditora`))) group by `e`.`nomeEditora` 
;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vi_quantclientesporcidade`;
CREATE VIEW `vi_quantclientesporcidade` AS select `c`.`cidade` AS `cidade`,count(0) AS `quantClientesPorCidade` from `cliente` `c` group by `c`.`cidade` 
;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vi_total_pagar`;
CREATE VIEW `vi_total_pagar` AS select `v`.`codVenda` AS `codVenda`,`c`.`nomeCliente` AS `nomeCliente`,`l`.`nomeLivro` AS `nomeLivro`,`lpv`.`quantLivroPorVenda` AS `quantLivroPorVenda`,format(`l`.`precoVenda`,2) AS `preco`,format(sum((`lpv`.`quantLivroPorVenda` * `l`.`precoVenda`)),2) AS `total_a_pagar` from (((`venda` `v` join `livroporvenda` `lpv` on((`lpv`.`venda_codVenda` = `v`.`codVenda`))) join `cliente` `c` on((`v`.`cliente_codCliente` = `c`.`codCliente`))) join `livro` `l` on((`lpv`.`livro_codLivro` = `l`.`codLivro`))) group by `v`.`codVenda`,`c`.`nomeCliente`,`l`.`nomeLivro`,`lpv`.`quantLivroPorVenda`,`l`.`precoVenda` 
;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vi_tudosobrelivro`;
CREATE VIEW `vi_tudosobrelivro` AS select `l`.`codLivro` AS `codLivro`,`l`.`nomeLivro` AS `nomeLivro`,`g`.`nomeGeneroLivro` AS `nomeGeneroLivro`,`e`.`nomeEditora` AS `nomeEditora`,format(`l`.`precoVenda`,2) AS `precoVenda` from ((`livro` `l` join `generolivro` `g` on((`l`.`generoLivro_codGeneroLivro` = `g`.`codGeneroLivro`))) join `editora` `e` on((`l`.`editora_codEditora` = `e`.`codEditora`))) 
;

-- Removendo tabela temporária e criando a estrutura VIEW final
DROP TABLE IF EXISTS `vi_vendas_setembro`;
CREATE VIEW `vi_vendas_setembro` AS select `v`.`codVenda` AS `codVenda`,date_format(`v`.`dataHoraVenda`,'%d/%m/%Y %H:%i') AS `dataHora`,`f`.`nomeFuncionario` AS `nomeFuncionario` from (`venda` `v` join `funcionario` `f` on((`v`.`funcionario_codFuncionario` = `f`.`codFuncionario`))) where (`v`.`dataHoraVenda` like '2025-09%') 
;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

