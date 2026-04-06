resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = aws_subnet.private_db[*].id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

resource "aws_db_instance" "postgres" {
  identifier               = "${var.project_name}-postgres"
  engine                   = "postgres"
  engine_version           = "16.13"
  instance_class           = var.db_instance_class
  allocated_storage        = 20
  storage_type             = "gp3"
  db_name                  = var.db_name
  username                 = var.db_username
  password                 = var.db_password
  db_subnet_group_name     = aws_db_subnet_group.main.name
  vpc_security_group_ids   = [aws_security_group.rds.id]
  publicly_accessible      = false
  multi_az                 = false
  storage_encrypted        = true
  backup_retention_period  = 1
  skip_final_snapshot      = true
  deletion_protection      = false

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-postgres"
  })
}