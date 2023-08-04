resource "aws_db_instance" "mysql" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.6.17"
  instance_class       = "db.t2.micro"
  db_name              = "mydb"
  username             = "foo"
  password             = "bar"
  db_subnet_group_name = "my_database_subnet_group"
  parameter_group_name = "default.mysql5.6"
}

# Creates subnet group
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "roboshop-mysql-${var.ENV}-subnetgroup"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-mysql-${var.ENV}-subnetgroup"
  }
}




# # Creates compute machines needed for Documnet DB and these has to be attached to the cluster
# resource "aws_docdb_cluster_instance" "cluster_instances" {
#   count              = 1
#   identifier         = "roboshop-docdb-${var.ENV}-instance"
#   cluster_identifier = aws_docdb_cluster.docdb.id       # This argumnet attaches the nodes created here to the docdb cluster
#   instance_class     = "db.t3.medium"

#   depends_on         = [aws_docdb_cluster.docdb]
# }