resource "aws_db_instance" "db-instance" {
  allocated_storage    = 10
  db_name              = "rdsone"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "username1"
  password             = "username123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}