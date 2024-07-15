resource "aws_iam_role" "Amazon_EC2_apache" {
  assume_role_policy    = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}"
  description           = "Allows EC2 instances to call AWS services on your behalf."
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  max_session_duration  = 3600
  name                  = "AmazonEC2apache"
  name_prefix           = null
  path                  = "/"
  permissions_boundary  = null
}

resource "aws_iam_instance_profile" "EC2_apache" {
  name = "AmazonEC2apache"
  role = aws_iam_role.Amazon_EC2_apache.id
}