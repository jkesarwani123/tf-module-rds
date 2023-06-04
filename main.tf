# Create Security Group
resource "aws_security_group" "main" {
  name        = "${var.name}-${var.env}-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "RDS"
    from_port        = 27017
    to_port          = 27017
    protocol         = "tcp"
    cidr_blocks      = var.allow_db_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name}-${var.env}-sg"
  }
}

# Create RDS Subnet Grp
resource "aws_db_subnet_group" "main" {
  name       = "${var.name}-${var.env}-sg"
  subnet_ids = var.subnets

  tags = merge(var.tags, { Name = "${var.name}-${var.env}" })
}

# create parameter group
resource "aws_db_parameter_group" "main" {
  name   = "${var.name}-${var.env}-pg"
  family = "mysql5.6"
}
