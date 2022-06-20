-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SigThe
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema SigThe
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SigThe` ;
USE `SigThe` ;

-- -----------------------------------------------------
-- Table `SigThe`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(45) NULL,
  `senha` VARCHAR(45) NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`endereco` (
  `idendereco` INT NOT NULL AUTO_INCREMENT,
  `rua` VARCHAR(45) NULL,
  `bairro` VARCHAR(45) NULL,
  `cidade` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `cep` VARCHAR(45) NULL,
  PRIMARY KEY (`idendereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`pessoa` (
  `idpessoa` INT NOT NULL AUTO_INCREMENT,
  `idendereco` INT NULL,
  `nome` VARCHAR(45) NULL,
  `cpf` VARCHAR(45) NULL,
  `dataNasc` DATE NULL,
  `nomeMae` VARCHAR(45) NULL,
  `genero` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telefone` INT NULL,
  PRIMARY KEY (`idpessoa`),
  INDEX `idendereco_idx` (`idendereco` ASC) VISIBLE,
  CONSTRAINT `idendereco`
    FOREIGN KEY (`idendereco`)
    REFERENCES `SigThe`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`funcionario` (
  `idfuncionario` INT NOT NULL AUTO_INCREMENT,
  `idpessoa` INT NULL,
  `idusuario` INT NULL,
  `departamento` VARCHAR(45) NULL,
  `funcao` VARCHAR(45) NULL,
  `registro` VARCHAR(45) NULL,
  PRIMARY KEY (`idfuncionario`),
  INDEX `idpessoa_idx` (`idpessoa` ASC) VISIBLE,
  INDEX `idusuario_idx` (`idusuario` ASC) VISIBLE,
  CONSTRAINT `idpessoa`
    FOREIGN KEY (`idpessoa`)
    REFERENCES `SigThe`.`pessoa` (`idpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idusuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `SigThe`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`consulta` (
  `idconsulta` INT NOT NULL AUTO_INCREMENT,
  `idpaciente` INT NULL,
  `idfuncionario` INT NULL,
  `data` DATE NULL,
  `observacoes` VARCHAR(45) NULL,
  PRIMARY KEY (`idconsulta`),
  INDEX `idpaciente_idx` (`idpaciente` ASC) VISIBLE,
  INDEX `idfuncionario_idx` (`idfuncionario` ASC) VISIBLE,
  CONSTRAINT `idpaciente`
    FOREIGN KEY (`idpaciente`)
    REFERENCES `SigThe`.`pessoa` (`idpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idfuncionario`
    FOREIGN KEY (`idfuncionario`)
    REFERENCES `SigThe`.`funcionario` (`idfuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`hemodialise`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`hemodialise` (
  `idhemodialise` INT NOT NULL AUTO_INCREMENT,
  `idpessoa` INT NULL,
  `idfuncionario` INT NULL,
  `data` DATE NULL,
  `duracao` INT NULL,
  `volumeGanho` INT NULL,
  `volumePerdido` INT NULL,
  `ultrafiltracao` INT NULL,
  `pressaoInicio` INT NULL,
  `pressaoFim` INT NULL,
  `pesoInicio` INT NULL,
  `pesoFim` INT NULL,
  PRIMARY KEY (`idhemodialise`),
  INDEX `idpaciente_idx` (`idpessoa` ASC) VISIBLE,
  CONSTRAINT `idpacientehemo`
    FOREIGN KEY (`idpessoa`)
    REFERENCES `SigThe`.`pessoa` (`idpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`evolucao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`evolucao` (
  `idevolucao` INT NOT NULL AUTO_INCREMENT,
  `idpaciente` INT NULL,
  `idfuncionario` INT NULL,
  `data` DATE NULL,
  PRIMARY KEY (`idevolucao`),
  INDEX `idpaciente_idx` (`idpaciente` ASC) VISIBLE,
  CONSTRAINT `idpacienteEvolu`
    FOREIGN KEY (`idpaciente`)
    REFERENCES `SigThe`.`pessoa` (`idpessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`exame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`exame` (
  `idexame` INT NOT NULL AUTO_INCREMENT,
  `idconsulta` INT NULL,
  `data` DATE NULL,
  `tipo` VARCHAR(45) NULL,
  `resultado` VARCHAR(45) NULL,
  PRIMARY KEY (`idexame`),
  INDEX `idconsulta_idx` (`idconsulta` ASC) VISIBLE,
  CONSTRAINT `idconsulta`
    FOREIGN KEY (`idconsulta`)
    REFERENCES `SigThe`.`consulta` (`idconsulta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`receita`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`receita` (
  `idreceita` INT NOT NULL AUTO_INCREMENT,
  `idconsulta` INT NULL,
  `data` DATE NULL,
  PRIMARY KEY (`idreceita`),
  INDEX `idconsulta_idx` (`idconsulta` ASC) VISIBLE,
  CONSTRAINT `idconsulta1`
    FOREIGN KEY (`idconsulta`)
    REFERENCES `SigThe`.`consulta` (`idconsulta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`anamnease`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`anamnease` (
  `idanamnease` INT NOT NULL AUTO_INCREMENT,
  `idconsulta` INT NULL,
  `data` DATE NULL,
  PRIMARY KEY (`idanamnease`),
  INDEX `idconsulta_idx` (`idconsulta` ASC) VISIBLE,
  CONSTRAINT `idconsulta2`
    FOREIGN KEY (`idconsulta`)
    REFERENCES `SigThe`.`consulta` (`idconsulta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`respLongaAna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`respLongaAna` (
  `idrespostaLonga` INT NOT NULL AUTO_INCREMENT,
  `respostaLonga` VARCHAR(124) NULL,
  PRIMARY KEY (`idrespostaLonga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`questAnamnease`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`questAnamnease` (
  `idquestAnamnease` INT NOT NULL AUTO_INCREMENT,
  `idanamnease` INT NULL,
  `pergunta` VARCHAR(45) NULL,
  `resposta` VARCHAR(45) NULL,
  `idrespostaLonga` INT NULL,
  PRIMARY KEY (`idquestAnamnease`),
  INDEX `idrespostaLonga_idx` (`idrespostaLonga` ASC) VISIBLE,
  INDEX `idanamnease_idx` (`idanamnease` ASC) VISIBLE,
  CONSTRAINT `idrespostaLonga1`
    FOREIGN KEY (`idrespostaLonga`)
    REFERENCES `SigThe`.`respLongaAna` (`idrespostaLonga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idanamnease`
    FOREIGN KEY (`idanamnease`)
    REFERENCES `SigThe`.`anamnease` (`idanamnease`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`medicamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`medicamento` (
  `idmedicamento` INT NOT NULL AUTO_INCREMENT,
  `idreceita` INT NULL,
  `medicamento` VARCHAR(45) NULL,
  `posologia` VARCHAR(45) NULL,
  PRIMARY KEY (`idmedicamento`),
  INDEX `idreceita1_idx` (`idreceita` ASC) VISIBLE,
  CONSTRAINT `idreceita1`
    FOREIGN KEY (`idreceita`)
    REFERENCES `SigThe`.`receita` (`idreceita`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`respLongaEvolucao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`respLongaEvolucao` (
  `idrespevolucao` INT NOT NULL AUTO_INCREMENT,
  `respostaLonga` VARCHAR(124) NULL,
  PRIMARY KEY (`idrespevolucao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`questEvolucao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`questEvolucao` (
  `idquestEvolucao` INT NOT NULL AUTO_INCREMENT,
  `idevolucao` INT NULL,
  `pergunta` VARCHAR(45) NULL,
  `resposta` VARCHAR(45) NULL,
  `idrespostaLonga` INT NULL,
  PRIMARY KEY (`idquestEvolucao`),
  INDEX `idevolucao_idx` (`idevolucao` ASC) VISIBLE,
  INDEX `idrespLongEvolucao_idx` (`idrespostaLonga` ASC) VISIBLE,
  CONSTRAINT `idrespLongEvolucao`
    FOREIGN KEY (`idrespostaLonga`)
    REFERENCES `SigThe`.`respLongaEvolucao` (`idrespevolucao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idevolucao`
    FOREIGN KEY (`idevolucao`)
    REFERENCES `SigThe`.`evolucao` (`idevolucao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`respLongaHemo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`respLongaHemo` (
  `idresphemo` INT NOT NULL AUTO_INCREMENT,
  `respostaLonga` VARCHAR(124) NULL,
  PRIMARY KEY (`idresphemo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SigThe`.`questHemo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SigThe`.`questHemo` (
  `idquestHemo` INT NOT NULL AUTO_INCREMENT,
  `idhemodialise` INT NULL,
  `pergunta` VARCHAR(45) NULL,
  `resposta` VARCHAR(45) NULL,
  `idrespostaLonga` INT NULL,
  PRIMARY KEY (`idquestHemo`),
  INDEX `idrespLongHemo_idx` (`idrespostaLonga` ASC) VISIBLE,
  INDEX `idhemodialise_idx` (`idhemodialise` ASC) VISIBLE,
  CONSTRAINT `idrespLongHemo`
    FOREIGN KEY (`idrespostaLonga`)
    REFERENCES `SigThe`.`respLongaHemo` (`idresphemo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idhemodialise`
    FOREIGN KEY (`idhemodialise`)
    REFERENCES `SigThe`.`hemodialise` (`idhemodialise`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
