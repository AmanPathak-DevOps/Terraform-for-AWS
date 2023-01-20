resource "aws_volume_attachment" "volume-attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.volume.id
  instance_id = aws_instance.EC2.id
}


