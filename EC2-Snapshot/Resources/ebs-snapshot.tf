resource "aws_ebs_snapshot" "ebs-snapshot" {
  volume_id = aws_ebs_volume.volume.id

  tags = {
    Name = "ebs-snapshot"
  }
}