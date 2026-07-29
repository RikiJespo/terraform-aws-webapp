# Mengambil data sistem operasi Ubuntu terbaru secara otomatis
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # ID Resmi Canonical (Pembuat Ubuntu)
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Membangun Server Virtual (EC2)
resource "aws_instance" "web_server" {
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro" # Spesifikasi ini masuk dalam kategori Gratis (Free Tier)
  subnet_id               = aws_subnet.public_subnet_1.id
  vpc_security_group_ids  = [aws_security_group.web_sg.id]
  tags = {
    Name = "riki-web-server"
  }
}
