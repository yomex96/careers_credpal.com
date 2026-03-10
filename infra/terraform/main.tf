resource "aws_vpc" "credpal_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "credpal-vpc"
  }
}

resource "aws_subnet" "credpal_subnet" {
  vpc_id            = aws_vpc.credpal_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "credpal-subnet"
  }
}

resource "aws_security_group" "credpal_sg" {
  name   = "credpal-security-group"
  vpc_id = aws_vpc.credpal_vpc.id

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "credpal_server" {
  ami           = "ami-0c02fb55956c7d316" # still hardcoded free tier Ubuntu AMI
  instance_type = var.instance_type

  subnet_id              = aws_subnet.credpal_subnet.id
  vpc_security_group_ids = [aws_security_group.credpal_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "credpal-devops-server"
  }
}