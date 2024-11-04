--desativar todas as constraints e depoix excluir as tabelas

--desativar todas as constraints
BEGIN
  FOR c IN (SELECT constraint_name, table_name
              FROM user_constraints
             WHERE constraint_type = 'R'
             ORDER BY table_name, constraint_name) LOOP
    EXECUTE IMMEDIATE 'ALTER TABLE ' || c.table_name || ' DISABLE CONSTRAINT ' || c.constraint_name;
  END LOOP;
END;

--excluir todas as tabelas
BEGIN
  FOR c IN (SELECT table_name
              FROM user_tables
             ORDER BY table_name) LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || c.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;
