resource "aws_iam_user" "adminuser1" {
  name = "user_name_for_s3readonlyacess"
}



resource "aws_iam_user" "adminuser2" {
  name = "user_name_for_s3fullacess"
}



resource "aws_iam_policy" "policy1" {
  name        = "test_policy1"
  path        = "/"
  description = "My test policy1"



 # Terraform's "jsonencode" function converts a
  # s3 read only access.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
       {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "*"
        }
    ]
  })
}



resource "aws_iam_policy" "policy2" {
  name        = "test_policy2"
  path        = "/"
  description = "My test policy2"



 # Terraform's "jsonencode" function converts a
  # s3 full access.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
       {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*",
                "s3-object-lambda:Get*",
                "s3-object-lambda:List*"
            ]
            "Resource": "*"
        }
    ]
  })
}



#Roles to access the AWS ec2_admin_access
resource "aws_iam_role" "ec2_admin_access" {
  name               = "ec2_admin_access"
  assume_role_policy = jsonencode({



 "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
})
}





resource "aws_iam_policy_attachment" "test-attach1" {  
  name       = "test-attachment1"  
  users      = [aws_iam_user.adminuser1.name]
  policy_arn = aws_iam_policy.policy1.arn
}



resource "aws_iam_policy_attachment" "test-attach2" {  
  name       = "test-attachment2"  
  users      = [aws_iam_user.adminuser2.name]
  policy_arn = aws_iam_policy.policy2.arn
}



resource "aws_iam_instance_profile" "test_profile" {  
  name = "test_profile"
  role = aws_iam_role.ec2_admin_access.name
}



resource "aws_instance" "web" {
  ami           = "ami_id"
  instance_type = "type"
  iam_instance_profile = aws_iam_instance_profile.test_profile.name



 tags = {
    Name = "HelloWorld"
  }
}


